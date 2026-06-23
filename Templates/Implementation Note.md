---
type: implementation-note
repo: # [path-to-repo] — set your dev path during onboarding
language: []
status: active

# Edge fields (typed relationships — consumed by KG pipeline)
up: []             # Parent MOC or project
concept: []        # Concepts this implements
source: []         # Papers describing this implementation
related: []        # Related implementations

created: <% tp.date.now("YYYY-MM-DD") %>
tags:
  - "#status/active"

# Bilingual linkage
lang: zh
translation_of: "[[Implementation Note.en]]"
aliases: ["实现笔记"]

# Curator fields (uncomment if ontology fit is uncertain)
# curator_status: pending
# curator_suggested_type:
# curator_suggested_up:
# curator_observations:
#   - ""
---

# <% tp.file.title %> · 实现笔记

<p align="right">
  <strong>🌐 语言 / Language:</strong>
  <a href="Implementation%20Note.md"><img src="https://img.shields.io/badge/%E4%B8%AD%E6%96%87-current-blue?style=for-the-badge" alt="中文 (current)"></a>
  <a href="Implementation%20Note.en.md"><img src="https://img.shields.io/badge/English-switch-lightgrey?style=for-the-badge" alt="English"></a>
</p>

**Repo**: `<% tp.file.cursor(1) %>`
**Status**: Prototype | Active | Archived
**Related**: [[Project Note]]

---

## 它是什么 (What It Is)

[简要描述]

---

## 架构 (Architecture)

[关键组件、设计决策]

---

## 关键文件 (Key Files)

- `src/core/` -
- `experiments/` -

---

## 结果与心得 (Results & Learnings)

[什么有效、什么无效]

---

## 后续工作 (Future Work)

- [ ]
