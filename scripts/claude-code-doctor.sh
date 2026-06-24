#!/usr/bin/env bash
# claude-code-doctor.sh — 自愈 claude CLI 入口
#
# 检测并修复 npm 安装 @anthropic-ai/claude-code 时的常见损坏:
#
# 故障模式 1: /opt/homebrew/bin/claude symlink 丢失
#   → 修复: 重建 symlink 到正确位置
#
# 故障模式 2: postinstall 失败导致 bin/claude.exe 是 ASCII 占位脚本
#   (因为 darwin-arm64/package.json 缺失, require.resolve 失败)
#   → 修复: 手动 cp native binary 覆盖占位
#
# 故障模式 3: native binary 未签名 / 签名失效
#   → kernel 直接 SIGKILL,表现为 `zsh: killed`
#   → 修复: 提示用户重装(我们没法签名)
#
# 故障模式 4: 整个包不存在
#   → 提示用户安装
#
# 设计:
# - 健康路径 <5ms (3 个文件状态检查)
# - 修复操作幂等
# - 损坏严重时打印警告 + 解决步骤到 stderr,不自动重装(避免黑箱)
# - 详细日志在 ~/.claude/doctor.log

set -e

LINK="/opt/homebrew/bin/claude"
NPM_BIN_EXE="/opt/homebrew/lib/node_modules/@anthropic-ai/claude-code/bin/claude.exe"
NATIVE_BIN="/opt/homebrew/lib/node_modules/@anthropic-ai/claude-code/node_modules/@anthropic-ai/claude-code-darwin-arm64/claude"
LOG="$HOME/.claude/doctor.log"

mkdir -p "$(dirname "$LOG")"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG"
}

warn_user() {
  echo "⚠️  claude CLI: $*" >&2
}

# 快速路径: link 存在 + 指向 Mach-O 大文件 + 有签名,秒过
if [ -L "$LINK" ] || [ -e "$LINK" ]; then
  # 找到 link 最终指向的文件
  target=$(realpath "$LINK" 2>/dev/null || echo "")
  if [ -n "$target" ] && [ -x "$target" ]; then
    target_size=$(stat -f%z "$target" 2>/dev/null || echo 0)
    # native binary 至少 100MB; 占位脚本只有 500 字节
    if [ "$target_size" -gt 100000000 ]; then
      # 健康
      exit 0
    fi
  fi
fi

# 慢速路径: 诊断 + 修复
log "Health check failed, diagnosing..."

# Case 4: 包根本没装
if [ ! -d "/opt/homebrew/lib/node_modules/@anthropic-ai/claude-code" ]; then
  log "FAIL: package @anthropic-ai/claude-code not installed"
  warn_user "未安装. 跑: npm install -g @anthropic-ai/claude-code"
  exit 1
fi

# Case 3: native binary 不存在
if [ ! -f "$NATIVE_BIN" ]; then
  log "FAIL: native binary missing at $NATIVE_BIN"
  warn_user "native binary 缺失. 跑: npm install -g @anthropic-ai/claude-code --force"
  exit 1
fi

# Case 3b: native binary 损坏 (太小或无签名)
native_size=$(stat -f%z "$NATIVE_BIN")
if [ "$native_size" -lt 100000000 ]; then
  log "FAIL: native binary corrupted (size=$native_size, expected >100MB)"
  warn_user "native binary 损坏 (size=$native_size). 跑: npm install -g @anthropic-ai/claude-code --force"
  exit 1
fi

# 检查签名 (未签名会被 macOS kill -9)
if ! codesign --verify "$NATIVE_BIN" 2>/dev/null; then
  log "FAIL: native binary unsigned or signature invalid (will be killed by macOS)"
  warn_user "binary 无签名,macOS 会 SIGKILL. 跑: npm install -g @anthropic-ai/claude-code --force"
  exit 1
fi

# 到此说明 native binary 没问题. 问题只在 link 或 claude.exe 占位

# Case 2: bin/claude.exe 是 ASCII 占位
if [ -f "$NPM_BIN_EXE" ]; then
  exe_size=$(stat -f%z "$NPM_BIN_EXE")
  if [ "$exe_size" -lt 100000000 ]; then
    log "Fixing: claude.exe is placeholder (size=$exe_size), copying native binary"
    cp "$NATIVE_BIN" "$NPM_BIN_EXE"
    chmod +x "$NPM_BIN_EXE"
    log "  copied native -> claude.exe"
  fi
fi

# Case 1: symlink 不存在或指向错误地方
if [ ! -L "$LINK" ] && [ ! -e "$LINK" ]; then
  ln -sf "../lib/node_modules/@anthropic-ai/claude-code/bin/claude.exe" "$LINK"
  log "Created symlink $LINK -> claude.exe"
elif [ -L "$LINK" ]; then
  target=$(realpath "$LINK" 2>/dev/null || echo "")
  target_size=$(stat -f%z "$target" 2>/dev/null || echo 0)
  if [ "$target_size" -lt 100000000 ]; then
    log "Symlink $LINK still points to bad target after fix, recreating"
    rm -f "$LINK"
    ln -sf "../lib/node_modules/@anthropic-ai/claude-code/bin/claude.exe" "$LINK"
  fi
fi

# 最终验证
final_target=$(realpath "$LINK" 2>/dev/null || echo "")
final_size=$(stat -f%z "$final_target" 2>/dev/null || echo 0)
if [ "$final_size" -gt 100000000 ]; then
  log "✓ Repaired successfully ($LINK -> $final_target, $final_size bytes)"
  exit 0
else
  log "FAIL: could not repair, final size=$final_size"
  warn_user "自愈失败. 手动跑: npm install -g @anthropic-ai/claude-code --force"
  exit 1
fi
