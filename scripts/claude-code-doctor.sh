#!/usr/bin/env bash
# claude-code-doctor.sh — Claude CLI 自愈守卫 v4
#
# 历史故障 (按时间顺序):
# v1 (2026-06-24 15:37): 修 symlink 丢失
# v2 (2026-06-24 15:48): 修 v1 没覆盖的 zsh:killed (无签名)
# v3 (2026-06-25 00:47): 修 v2 没覆盖的 permission denied (执行位丢失 + 占位)
# v4 (2026-06-25 00:50): 加离线 binary 备份, 损坏时不需要联网重装
#
# 5 个故障模式 + 自愈策略 (按"破坏程度"递增):
# Case 1: symlink 不存在            → 重建
# Case 2: claude.exe 是占位脚本     → 从 native binary hardlink
# Case 3: 执行位丢失                → chmod +x
# Case 4: native binary 损坏        → 从本地备份恢复 (新!)
# Case 5: 包整个不存在 或 备份也丢  → 提示用户跑 npm install
#
# 备份: ~/.claude/binary-backup/claude-darwin-arm64.bin (207MB)
# 触发: ~/.zshrc 自动调用. 健康路径 <10ms.

set -e

LINK="/opt/homebrew/bin/claude"
NPM_BIN_EXE="/opt/homebrew/lib/node_modules/@anthropic-ai/claude-code/bin/claude.exe"
NATIVE_BIN="/opt/homebrew/lib/node_modules/@anthropic-ai/claude-code/node_modules/@anthropic-ai/claude-code-darwin-arm64/claude"
BACKUP="$HOME/.claude/binary-backup/claude-darwin-arm64.bin"
LOG="$HOME/.claude/doctor.log"
MIN_BIN_SIZE=$((100 * 1024 * 1024))  # 100MB; native ~200MB

mkdir -p "$(dirname "$LOG")"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG"
}

warn_user() {
  echo "⚠️  claude CLI: $*" >&2
}

check_healthy() {
  [ -L "$LINK" ] || return 1
  local target=$(realpath "$LINK" 2>/dev/null) || return 1
  [ -n "$target" ] && [ -f "$target" ] && [ -x "$target" ] || return 1
  local size=$(stat -f%z "$target" 2>/dev/null || echo 0)
  [ "$size" -gt "$MIN_BIN_SIZE" ] || return 1
  return 0
}

# ============ 健康时秒过 ============
if check_healthy; then
  exit 0
fi

log "Health check failed, diagnosing..."

# ============ 决定 binary 源: native 或 backup ============
binary_source=""
if [ -f "$NATIVE_BIN" ]; then
  native_size=$(stat -f%z "$NATIVE_BIN")
  if [ "$native_size" -gt "$MIN_BIN_SIZE" ] && codesign --verify "$NATIVE_BIN" 2>/dev/null; then
    binary_source="$NATIVE_BIN"
  fi
fi

if [ -z "$binary_source" ] && [ -f "$BACKUP" ]; then
  backup_size=$(stat -f%z "$BACKUP")
  if [ "$backup_size" -gt "$MIN_BIN_SIZE" ]; then
    binary_source="$BACKUP"
    log "  using backup binary: $BACKUP ($backup_size bytes)"
  fi
fi

# Case 5: 啥都没有
if [ -z "$binary_source" ]; then
  if [ ! -d "/opt/homebrew/lib/node_modules/@anthropic-ai/claude-code" ]; then
    warn_user "Claude Code 未安装. 跑: HTTPS_PROXY=http://127.0.0.1:7897 npm install -g @anthropic-ai/claude-code"
  else
    warn_user "binary 全部损坏(native + 备份). 跑: HTTPS_PROXY=http://127.0.0.1:7897 npm install -g @anthropic-ai/claude-code --force"
  fi
  log "FAIL: no usable binary source"
  exit 1
fi

# ============ 修复 ============

# Case 4: native binary 损坏 → 从备份恢复
if [ "$binary_source" = "$BACKUP" ]; then
  # 确保 darwin-arm64 目录存在
  arm64_dir=$(dirname "$NATIVE_BIN")
  mkdir -p "$arm64_dir"
  cp "$BACKUP" "$NATIVE_BIN"
  chmod +x "$NATIVE_BIN"
  log "  ✓ native binary restored from backup"
  binary_source="$NATIVE_BIN"  # 现在 native 也修好了
fi

# Case 2: claude.exe 缺失或是占位 → hardlink from native
if [ ! -f "$NPM_BIN_EXE" ] || [ "$(stat -f%z "$NPM_BIN_EXE" 2>/dev/null || echo 0)" -lt "$MIN_BIN_SIZE" ]; then
  rm -f "$NPM_BIN_EXE"
  ln "$NATIVE_BIN" "$NPM_BIN_EXE" 2>/dev/null || cp "$NATIVE_BIN" "$NPM_BIN_EXE"
  log "  ✓ claude.exe rebuilt from native"
fi

# Case 3: 确保 claude.exe 可执行
chmod +x "$NPM_BIN_EXE" 2>/dev/null || true

# Case 1: symlink 丢失 / 指向错地方
if [ ! -L "$LINK" ]; then
  [ -e "$LINK" ] && rm -f "$LINK"
  ln -sf "../lib/node_modules/@anthropic-ai/claude-code/bin/claude.exe" "$LINK"
  log "  ✓ symlink created"
else
  current_target=$(realpath "$LINK" 2>/dev/null || echo "")
  current_size=$(stat -f%z "$current_target" 2>/dev/null || echo 0)
  if [ "$current_size" -lt "$MIN_BIN_SIZE" ]; then
    rm -f "$LINK"
    ln -sf "../lib/node_modules/@anthropic-ai/claude-code/bin/claude.exe" "$LINK"
    log "  ✓ symlink redirected"
  fi
fi

# ============ 最终验证 ============
if check_healthy; then
  final_size=$(stat -f%z "$(realpath "$LINK")")
  log "✓ Repaired successfully ($final_size bytes, source: $binary_source)"
  # 如果 backup 不存在, 顺便建一份 (机会主义)
  if [ ! -f "$BACKUP" ] && [ -f "$NATIVE_BIN" ]; then
    mkdir -p "$(dirname "$BACKUP")"
    cp "$NATIVE_BIN" "$BACKUP"
    chmod +x "$BACKUP"
    log "  ✓ backup created"
  fi
  exit 0
else
  warn_user "自愈失败. 手动: HTTPS_PROXY=http://127.0.0.1:7897 npm install -g @anthropic-ai/claude-code --force"
  log "FAIL: post-repair health check failed"
  exit 1
fi
