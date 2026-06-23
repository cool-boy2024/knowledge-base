# 安装指南 (Setup Guide)

<p align="right">
  <strong>🌐 语言 / Language:</strong>
  <a href="SETUP.zh.md"><img src="https://img.shields.io/badge/%E4%B8%AD%E6%96%87-current-blue?style=for-the-badge" alt="中文 (current)"></a>
  <a href="SETUP.md"><img src="https://img.shields.io/badge/English-switch-lightgrey?style=for-the-badge" alt="English"></a>
</p>

agentic vault 的详细安装说明，按依赖层级（Tier）组织。快速上手请见 [README](README.md)。

> **onboarding skill（`/onboarding`）会检查哪些工具已安装，并引导你处理还缺什么。** 你不需要预先全部装好——从 Tier 0 开始，按需添加能力即可。

---

## Tier 0 — 必需 (Essential, required)

这些是不可妥协的。没有它们，vault 无法运行。

### Homebrew (macOS 包管理器)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Git
```bash
brew install git
```

### Claude Code

Claude Code 是 Anthropic 的 agentic coding 工具——它就是在这个 vault 内运作的 agent。它读取你的文件、创建笔记、运行 skills、管理 knowledge graph。你需要两样东西：

**1. 一个具有 API 访问权限的 Anthropic 账号**

在 https://console.anthropic.com 注册。你需要付费计划（Pro 或 Team）——Claude Code 使用 API，需要计费。Max 计划（$100/月）直接包含 Claude Code 使用额度；否则按 token 通过 API 付费。

**2. 安装 Claude Code**

推荐方式是 CLI：

```bash
# macOS / Linux
curl -fsSL https://claude.ai/install.sh | bash

# 验证
claude --version
```

完整安装文档请见 https://claude.com/product/claude-code 。

Claude Code 还提供以下形态：
- **VS Code 扩展** — 在扩展市场搜索 "Claude Code"
- **JetBrains 扩展** — 在插件市场搜索 "Claude Code"
- **桌面应用**（macOS/Windows）— 从 https://claude.ai/download 下载
- **Web 应用** — https://claude.ai/code

本 vault 推荐使用 CLI，因为 skills（`/encode`、`/onboarding` 等）在终端中表现最佳。

**3. 认证**

```bash
claude
# 按提示用 Anthropic 账号登录
```

认证后，Claude Code 会把凭证保存在本地。你在这台机器上无需再次登录。

### Obsidian
```bash
brew install --cask obsidian
```

安装完成后，把当前这个文件夹作为 vault 在 Obsidian 中打开。

---

## Tier 1 — 核心 CLI 工具 (Core CLI Tools, 强烈推荐)

这些会让 Claude Code 显著更高效。一次装齐：

```bash
brew install ripgrep gh jq bat pandoc
brew install --cask quarto
```

| 工具 | 作用 | 为什么重要 |
|------|-------------|----------------|
| **ripgrep** (`rg`) | 快速正则搜索 | Claude Code 的 Grep 工具底层就用它 |
| **gh** | GitHub CLI | 从终端创建 repos、PRs、issues |
| **jq** | JSON 处理器 | 查询和转换 JSON（KG pipeline、API 响应都会用） |
| **bat** | 带语法高亮的 cat | 终端中更好的文件查看体验 |
| **Quarto** | 文档渲染（PDF、HTML、幻灯片、DOCX） | `/quarto` skill 用它从 vault 内容产生出版级输出。免费开源。 |
| **Pandoc** | 文档格式转换 | Quarto 所依托的底层转换器。单独使用也能做快速格式转换。 |

---

## Tier 2 — Knowledge Graph 流水线 (推荐)

让你能对 vault 的 knowledge graph 执行 SPARQL 查询——多跳概念遍历、orphan 检测、hub 分析，以及通过 `/audit` skill 的 Check F（Branching Factor / Fano Bound）**自动强制执行 vault 的结构性原则**。

**为什么重要**：vault 的架构施加了具体的结构约束——bounded branching（每个导航节点直接子节点 ≤ 12）、typed edges 作为操作契约、分层检索优于平铺搜索。这些都根植于近期关于 language agents memory architectures 的研究（Barman et al. 2026 no-escape theorem；Hu et al. 2026 xMemory Fano bound；Janowicz 2015 pattern-based architecture）。Knowledge graph 流水线正是让 `/audit` 能自动检查结构完整性的关键——没有它，违规会悄无声息地累积。完整理由与支撑文献参见 [README 的 "Why Structured Hierarchy?" 一节](README.md#why-structured-hierarchy-research-basis)，方法论细节参见 vault 内 [Bounded Branching — Why This Skill Checks the Fano Bound](03%20-%20Resources/Obsidian%20Reference/Bounded%20Branching%20-%20Why%20This%20Skill%20Checks%20the%20Fano%20Bound.md)。

### Python 3 + PyYAML
```bash
brew install python3
pip install pyyaml
```

KG pipeline 脚本（`scripts/kg/vault-to-jsonld.py`）只需要标准库 + PyYAML。不需要 rdflib。

### Apache Jena
```bash
brew install jena
```

这会装上三个工具：
- **`arq`** — SPARQL 查询引擎（你主要用的那个）
- **`riot`** — RDF 格式转换器（JSON-LD → Turtle）
- **`shacl`** — SHACL 校验（检查图完整性）

### 验证
```bash
arq --version    # 应当显示 Apache Jena
riot --version
python3 -c "import yaml; print('PyYAML OK')"
```

### 配置 namespace 并构建
```bash
# 设置你的 namespace（或保留默认）
scripts/kg/setup-namespace.sh https://yourdomain.com/vault

# 构建 graph（全新 vault 会是空的——没关系）
scripts/kg/build-graph.sh --stats
```

---

## Tier 3 — Obsidian CLI (推荐)

Obsidian 1.12+ 自带。提供比 grep 快 54 倍的索引化搜索。

1. 打开 Obsidian
2. Settings → General → Command line interface → **Enable**
3. 按提示把它加入 PATH

### 验证
```bash
obsidian help
obsidian search query="test" limit=5
```

**如果 Obsidian 没运行**，CLI 也不能用。Claude Code 会自动 fallback 到 grep/Glob。

---

## Tier 4 — Claude Code Plugins 与 Obsidian Skills (强烈推荐)

这些扩展 Claude Code，让它能高效地与 Obsidian vaults 协作。需要 Node.js。

```bash
brew install node
```

### Obsidian Skills（来自 kepano/obsidian-skills）

**这是最重要的外部 skill 安装。** 它教 Claude Code 如何使用 Obsidian 专有语法（wikilinks、callouts、frontmatter properties）和 Obsidian CLI。

```bash
# 在 Claude Code 会话中运行：
/install-plugin obsidian-skills
```

或者从命令行安装：
```bash
claude plugins install obsidian@obsidian-skills --source https://github.com/kepano/obsidian-skills
```

这会安装 5 个 skills：
- **`obsidian:obsidian-markdown`** — Wikilinks、embeds、callouts、properties 以及 Obsidian 专有语法
- **`obsidian:obsidian-cli`** — 用于 search、read、tasks、backlinks 等的 Obsidian CLI
- **`obsidian:defuddle`** — 干净的网页内容抽取（剥除导航/广告以节省 tokens）
- **`obsidian:json-canvas`** — 创建和编辑 Obsidian Canvas 文件
- **`obsidian:obsidian-bases`** — 笔记的数据库化视图

**依赖**：defuddle skill 需要 defuddle CLI：
```bash
npm install -g defuddle-cli
```

### 推荐的 Vault Skills

下面三个 skills 由模板自带的 `.claude/skills/` 提供，但依赖外部工具：

| Skill | 作用 | 依赖 |
|-------|-------------|-----------|
| `/alphaxiv-paper-lookup` | 带 AI 摘要查找 arXiv 论文 | 无——使用 web |
| `/notebooklm` | 用 Google NotebookLM API 做研究综合 | Google 账号 |
| `/quarto` | 把文档渲染为 PDF、HTML、幻灯片 | `brew install --cask quarto` |

### Superpowers Plugin（用于代码 repos）

在 git repos 内工作（不是 vault）时，Superpowers plugin 增加项目规划和代码分析能力：

```bash
# 在 git repo 内的 Claude Code 会话中安装：
/install-plugin superpowers
```

这就是如何获得 repo 级别的项目规划，与 vault 级别的规划互为补充。参见 README 中的 Cross-Repo Workflow 一节。

---

## Tier 5 — Google Workspace 集成 (推荐, 免费)

需要 Google 账号和 API 设置。让 Claude Code 能访问 Gmail、Calendar、Drive、Docs、Sheets。

### 设置步骤
1. 在 https://console.cloud.google.com 创建一个 Google Cloud 项目
2. 启用你需要的 APIs（Gmail、Calendar、Drive 等）
3. 创建 OAuth 2.0 凭证
4. 安装 GWS skills：`npx @anthropic-ai/claude-code-skills install gws`
5. 认证：`gws auth login`

`gws-shared` skill 中有详细的设置说明。在 Claude Code 中运行 `/gws-shared` 进行引导。

---

## Tier 6 — 高级集成 (可选, 付费)

这些会加速特定工作流。每一项都有免费替代品——参见 [[Integration Ecosystem]]。

### Readwise (~$8/月)
自动从 Kindle、网页、播客同步高亮。
- 安装 Readwise Official Obsidian 插件（Settings → Community plugins）
- 单独安装处理 skill（模板未包含）

### Todoist (~$4/月)
带项目、标签、优先级的任务管理。
```bash
npm install -g @doist/todoist-cli
td login
```

### Paperpile (~$3/月)
带 Google Docs 集成的文献管理。替代品：**Zotero**（免费、开源）。

---

## 推荐的 Brewfile

一条命令搞定 Tier 0-2 加上常用工具：

```bash
# Save as Brewfile, then run: brew bundle
# Tier 0 — Essential
brew "git"
cask "obsidian"
# Tier 1 — Core CLI tools
brew "ripgrep"
brew "gh"
brew "jq"
brew "bat"
brew "pandoc"
cask "quarto"
# Tier 2 — Knowledge Graph
brew "jena"
# Tier 4 — Node.js ecosystem
brew "node"
# Useful extras
brew "tree"
brew "fzf"
```

```bash
# 装全部
brew bundle

# 然后是 Python 依赖
pip install pyyaml
```

---

## 验证你的安装

`/onboarding` skill 会自动检查已安装的工具。你也可以手动跑：

```bash
echo "=== Tier 0 ==="
which git && echo "✓ git" || echo "✗ git"
which claude && echo "✓ claude" || echo "✗ claude (Claude Code)"
which obsidian && echo "✓ obsidian" || echo "✗ obsidian"

echo "=== Tier 1 ==="
which rg && echo "✓ ripgrep" || echo "✗ ripgrep"
which gh && echo "✓ gh" || echo "✗ gh"
which jq && echo "✓ jq" || echo "✗ jq"

echo "=== Tier 2 ==="
which arq && echo "✓ jena (arq)" || echo "✗ jena"
python3 -c "import yaml" 2>/dev/null && echo "✓ pyyaml" || echo "✗ pyyaml"

echo "=== Tier 3 ==="
obsidian help >/dev/null 2>&1 && echo "✓ obsidian CLI" || echo "✗ obsidian CLI (app may not be running)"

echo "=== Tier 4 ==="
which node && echo "✓ node" || echo "✗ node"
which npx && echo "✓ npx" || echo "✗ npx"
```
