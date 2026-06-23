# Graph Report - .  (2026-06-23)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 163 nodes · 248 edges · 15 communities (11 shown, 4 thin omitted)
- Extraction: 94% EXTRACTED · 6% INFERRED · 0% AMBIGUOUS · INFERRED: 15 edges (avg confidence: 0.75)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `9765aedf`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]

## God Nodes (most connected - your core abstractions)
1. `CLAUDE.md (project instructions)` - 27 edges
2. `About Bittensor 2025 (EN)` - 17 edges
3. `Typed Relationships Rule` - 13 edges
4. `Encode Skill` - 10 edges
5. `Research Session Skill` - 9 edges
6. `Audit Skill` - 8 edges
7. `Memory Architecture — Why Different Kinds of Memory` - 8 edges
8. `Literature Note Template` - 8 edges
9. `Discipline Gates Rule` - 7 edges
10. `Linking Guide Rule` - 7 edges

## Surprising Connections (you probably didn't know these)
- `Vault Vocabulary` --references--> `Area of Focus Template`  [INFERRED]
  03 - Resources/Obsidian Reference/Vault Vocabulary.md → Templates/Area of Focus.md
- `Vault Vocabulary` --references--> `Concept Note Template`  [INFERRED]
  03 - Resources/Obsidian Reference/Vault Vocabulary.md → Templates/Concept Note.md
- `Vault Vocabulary` --references--> `External Resource Note Template`  [INFERRED]
  03 - Resources/Obsidian Reference/Vault Vocabulary.md → Templates/External Resource Note.md
- `CLAUDE.md (project instructions)` --references--> `Obsidian Spec-to-Implementation Skill`  [EXTRACTED]
  CLAUDE.md → .claude/skills/obsidian-spec-to-implementation/SKILL.md
- `CLAUDE.md (project instructions)` --references--> `Typed Edges as Interface Operations`  [EXTRACTED]
  CLAUDE.md → .claude/rules/typed-relationships.md

## Import Cycles
- None detected.

## Communities (15 total, 4 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.06
Nodes (31): audio-recorder, backlink, bases, bookmarks, canvas, command-palette, daily-notes, editor-status (+23 more)

### Community 1 - "Community 1"
Cohesion: 0.25
Nodes (26): Audit Skill, CLAUDE.md (project instructions), Discipline Gates Rule, Encode Skill, Encode Router Memory, Fano Bound / Bounded Branching, Linking Guide Rule, Memory Audit Skill (+18 more)

### Community 2 - "Community 2"
Cohesion: 0.14
Nodes (21): build_graph(), build_title_uri_map(), extract_frontmatter(), load_type_map(), main(), note_to_jsonld(), process_edge_value(), Convert a note title to a URI-safe slug.     Spaces -> hyphens, percent-encode t (+13 more)

### Community 3 - "Community 3"
Cohesion: 0.14
Nodes (19): author-note type, Curator Observation Fields, concept: edge field, source: edge field, Implementation Note Template, implementation-note type, KG Pipeline, author: edge field (+11 more)

### Community 4 - "Community 4"
Cohesion: 0.13
Nodes (18): AI × Crypto, AlexNet, Bitcoin as Supercomputer, Bittensor, Closed-Source AI vs Open-Source Crypto-AI, Const (Jacob Steeves), Decentralized AI Training, DePIN (+10 more)

### Community 5 - "Community 5"
Cohesion: 0.23
Nodes (12): AI-ese to Avoid, Area of Focus Template, Concept Note Template, External Resource Note Template, How Progressive Disclosure Works, How the Index System Works, How Wikilinks Create Structure, Integration Ecosystem (+4 more)

### Community 6 - "Community 6"
Cohesion: 0.25
Nodes (11): Barman et al. 2026 (The Price of Meaning), Bounded Branching — Why This Skill Checks the Fano Bound, Fano's Inequality, Hu et al. 2026 (xMemory), No-Escape Theorem (flat semantic retrieval), Claude Code Auto Dream Docs, Claude Code Extensions Docs, Claude Code Memory Docs (+3 more)

### Community 7 - "Community 7"
Cohesion: 0.33
Nodes (5): CoALA Cognitive Architecture (Sumers 2023), Knowledge Graph Pipeline (scripts/kg/), PARA System (Modified), Progressive Disclosure, Typed Edges as Interface Operations

### Community 8 - "Community 8"
Cohesion: 0.33
Nodes (5): hooks, PostToolUse, permissions, allow, deny

## Knowledge Gaps
- **72 isolated node(s):** `allow`, `deny`, `PostToolUse`, `file-explorer`, `global-search` (+67 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `CLAUDE.md (project instructions)` connect `Community 1` to `Community 7`?**
  _High betweenness centrality (0.022) - this node is a cross-community bridge._
- **Why does `Memory Architecture — Why Different Kinds of Memory` connect `Community 6` to `Community 5`?**
  _High betweenness centrality (0.012) - this node is a cross-community bridge._
- **What connects `allow`, `deny`, `PostToolUse` to the rest of the system?**
  _82 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.0625 - nodes in this community are weakly interconnected._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.14285714285714285 - nodes in this community are weakly interconnected._
- **Should `Community 3` be split into smaller, more focused modules?**
  _Cohesion score 0.14035087719298245 - nodes in this community are weakly interconnected._
- **Should `Community 4` be split into smaller, more focused modules?**
  _Cohesion score 0.13071895424836602 - nodes in this community are weakly interconnected._