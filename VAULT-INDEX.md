---
type: index
up: "[[VAULT-INDEX]]"
lang: zh
translation_of: "[[VAULT-INDEX.en]]"
aliases: ["知识库索引"]
---

# Vault Index · 知识库索引

<p align="right">
  <strong>🌐 语言 / Language:</strong>
  <a href="VAULT-INDEX.md"><img src="https://img.shields.io/badge/%E4%B8%AD%E6%96%87-current-blue?style=for-the-badge" alt="中文 (current)"></a>
  <a href="VAULT-INDEX.en.md"><img src="https://img.shields.io/badge/English-switch-lightgrey?style=for-the-badge" alt="English"></a>
</p>

> **这是什么**：Claude Code 在浏览你的 vault 时读取的第一个文件。它是一张路由表——用简短的条目指向更深层知识所在的位置。保持精简。
>
> **如何工作**：Claude 从这里跟随链接到达 sub-indexes 和 MOCs（Maps of Content），再从那里到达单独的笔记。这种分层方式叫做 *progressive disclosure*（渐进式披露）——详见 [[How Progressive Disclosure Works]]。

---

## Areas of Focus (02 - Areas of Focus/)

基础所在——其他一切都为这些服务。框架参见 [[Areas of Focus - Pullein Methodology]]。

> **设置方式**：运行 onboarding skill，或从 `Templates/Area of Focus.md` 手动创建 area 笔记。定义你自己的 areas——下面的默认值只是起点建议。

- （onboarding 之后你的 areas 会列在这里）

---

## Projects (01 - Projects/)

服务于你的 areas 的有时间界限的努力。用 `Templates/Project Note.md` 创建。

- （你的 projects 会列在这里）

---

## Resources (03 - Resources/)

按主题组织的知识。每个主题领域都有一个 MOC（Map of Content）作为导航中枢。

- [[LITERATURE-INDEX]] — 按主题分组的文献笔记
- （创建后你的 MOCs 会列在这里）

### Vault 参考资料 (Vault Reference)
- [[Memory Architecture - Why Different Kinds of Memory]] — 四种 memory 类型及本 vault 如何实现它们
- [[Why PARA and How We Modify It]] — 为什么用这个结构、我们改了什么、Router 如何强制执行
- [[Managing Cognitive Load with AI Agents]] — vault 为什么对 AI 工作会话施加结构
- [[How Progressive Disclosure Works]] — Claude 如何分层浏览
- [[How Wikilinks Create Structure]] — 链接如何构成一个可遍历的 knowledge graph
- [[How the Index System Works]] — 路由层级结构详解
- [[Vault Architecture]] — 完整结构参考
- [[Vault Vocabulary]] — 规范化的 types 和 edge fields

---

## Watching (05 - Watching/)

正在关注但尚未承诺投入的事项。等清晰之后：升级到 `01 - Projects/` 或归档到 `04 - Archive/`。

- （Fleeting notes 会出现在这里）
