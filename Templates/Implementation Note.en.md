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
lang: en
translation_of: "[[Implementation Note]]"

# Curator fields (uncomment if ontology fit is uncertain)
# curator_status: pending
# curator_suggested_type:
# curator_suggested_up:
# curator_observations:
#   - ""
---

# <% tp.file.title %>

<p align="right">
  <strong>🌐 语言 / Language:</strong>
  <a href="Implementation%20Note.md"><img src="https://img.shields.io/badge/%E4%B8%AD%E6%96%87-switch-lightgrey?style=for-the-badge" alt="中文"></a>
  <a href="Implementation%20Note.en.md"><img src="https://img.shields.io/badge/English-current-blue?style=for-the-badge" alt="English (current)"></a>
</p>

**Repo**: `<% tp.file.cursor(1) %>`
**Status**: Prototype | Active | Archived
**Related**: [[Project Note]]

---

## What It Is

[Brief description]

---

## Architecture

[Key components, design decisions]

---

## Key Files

- `src/core/` -
- `experiments/` -

---

## Results & Learnings

[What worked, what didn't]

---

## Future Work

- [ ]
