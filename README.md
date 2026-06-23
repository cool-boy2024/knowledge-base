# 🧠 我的智库 / My Knowledge Base

<p align="right">
  <strong>🌐 语言 / Language:</strong>
  <a href="README.md"><img src="https://img.shields.io/badge/%E4%B8%AD%E6%96%87-current-blue?style=for-the-badge" alt="中文 (current)"></a>
  <a href="README.en.md"><img src="https://img.shields.io/badge/English-switch-lightgrey?style=for-the-badge" alt="English"></a>
</p>

> 这是我的个人知识网络——所有看过的视频、读过的书、想过的问题都按主题归档、双向链接，像一颗会生长的大脑。

---

## 🌐 进入大脑网状图（交互式）

<p align="center">
  <a href="https://cool-boy2024.github.io/knowledge-base/graphify-out/graph.html">
    <img src="https://img.shields.io/badge/🧠%20打开知识图谱-点这里进入交互式大脑-7c3aed?style=for-the-badge" alt="打开知识图谱">
  </a>
</p>

**点上面那个紫色按钮**，会进入一个**可以拖动、缩放、点击节点跳转的网状图**——就像 Obsidian 的 Graph View，但可以在任何浏览器里看，包括手机。

---

## 📊 当前规模

- **163 个节点**（笔记/概念/链接到的外部资源）
- **248 条连线**（双向链接、类型化关系）
- **15 个社区**（自动聚类出来的主题群）

最核心的几个节点（"god nodes"，连接最多）：

| # | 节点 | 连接数 |
|---|------|------:|
| 1 | CLAUDE.md（项目说明书）| 27 |
| 2 | About Bittensor 2025 (EN) | 17 |
| 3 | Typed Relationships Rule | 13 |
| 4 | Encode Skill | 10 |
| 5 | Research Session Skill | 9 |

---

## 📁 分区结构（PARA 体系）

```
01 - Projects/        进行中的项目（有 deadline 的工作）
02 - Areas of Focus/  长期关注的领域（人生/工作的几大支柱）
03 - Resources/       按主题归档的知识 ← 主要内容在这里
04 - Archive/         不再活跃的旧内容
05 - Watching/        在观察但还没动手的素材
Daily/                每日笔记
Inbox/                待整理的原始输入
Templates/            各种笔记模板
```

## 🎯 当前主题

### AI × Crypto
- 📺 [About Bittensor 2025](03%20-%20Resources/AI%20%C3%97%20Crypto/About%20Bittensor%202025.md) — 视频深度笔记 + 10 张 Mermaid 图

---

## 🛠 怎么用

### 在本地用 Obsidian
1. 装 [Obsidian](https://obsidian.md)（免费）
2. 选"打开本地仓库" → 选这个目录
3. 按 `⌘+G` 看 Graph View，按 `⌘+P` 用命令面板

### 在 GitHub 网页直接看
笔记里的 Mermaid 图、双向链接、表格都能直接渲染。

### 想给 Claude 增加新笔记
直接对 Claude Code 说："**帮我总结这个视频/文章/书：[URL]**" — Claude 会自动：
1. 抓内容
2. 按 PARA 归档到正确目录
3. 生成 Mermaid 图、双向链接
4. 中英双语版本（按 [vault-bilingual-rule](file://~/.claude/memory/vault-bilingual-rule.md)）
5. commit + push 到这个仓库
6. 跑 `graphify` 更新大脑图谱

---

## 📜 完整的 vault 设计文档

这个 vault 基于 [LA3D/agentic-vault](https://github.com/LA3D/agentic-vault) 模板搭建，PARA + Areas of Focus 框架，配 14+ Claude Code skills 维护。

技术细节看：
- [CLAUDE.md](CLAUDE.md) — Claude Code 的项目级指令
- [SETUP 安装指南](SETUP.zh.md) / [SETUP (English)](SETUP.md)
- [VAULT-INDEX 完整索引](VAULT-INDEX.zh.md) / [VAULT-INDEX (English)](VAULT-INDEX.md)

---

<p align="center">
  <em>"AI 学得越多，这张图就越像一张神经网络。我的大脑是离线的，这是我的在线大脑。"</em>
</p>
