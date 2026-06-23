---
type: concept-note
domain: [crypto, AI, distributed-systems]
status: emerging
created: 2026-06-23
lang: en
translation_of: "[[Bitcoin as Supercomputer]]"

up: [[AI × Crypto]]
related:
  - [[About Bittensor 2025.en]]
  - [[Incentive Computing.en]]
source:
  - [[About Bittensor 2025.en]]

tags:
  - "#status/draft"
  - "#lang/en"
  - "#topic/ai-crypto"
---

# Bitcoin as Supercomputer

<p align="right">
  <strong>🌐 语言 / Language:</strong>
  <a href="Bitcoin%20as%20Supercomputer.md"><img src="https://img.shields.io/badge/%E4%B8%AD%E6%96%87-switch-lightgrey?style=for-the-badge" alt="中文"></a>
  <a href="Bitcoin%20as%20Supercomputer.en.md"><img src="https://img.shields.io/badge/English-current-blue?style=for-the-badge" alt="English (current)"></a>
</p>

> **Central thesis**: Bitcoin is not "digital money" — it is **the largest supercomputer on Earth**, a borderless 24/7 self-adaptive compute network whose hashpower is **450× greater than the combined output of the top six US compute providers**.

---

## The Numbers

| Metric | Top 6 US compute providers | Bitcoin Network |
|--------|---|---|
| Capital invested | ~$1 trillion | $50B - $300B |
| Compute (exaflops) | 1,000 | **450,000** |
| **Efficiency multiplier** | 1× | **700 - 9,000×** |
| Power draw | — | 23,000 MW (≈ all of Thailand) |
| Hashes/sec | — | 10²¹ |

```mermaid
xychart-beta
    title "Compute Output (exaflops)"
    x-axis ["Top 6 US compute providers", "Bitcoin Network"]
    y-axis "exaflops" 0 --> 500000
    bar [1000, 450000]
```

---

## Why is it so absurdly efficient?

Bitcoin has five properties that traditional corporations **structurally cannot replicate**:

```mermaid
mindmap
  root((Bitcoin<br/>Why so efficient?))
    Borderless
      Anyone in any country can mine
      No export controls
    24/7 nonstop
      No weekends
      No market close
    Fully permissionless
      No résumé required
      No HR
    Zero friction
      No KYC overhead
      No marketing
    Pure market
      Hashpower = income
      Identity-blind
```

Any corporation trying to match this efficiency would need HR, hiring pipelines, marketing budgets, compliance teams — Bitcoin operates without any of these **friction costs**.

---

## The first instance of [[Incentive Computing.en]]

Bitcoin's essence is an **incentive-driven self-adaptive optimization system**:

- **State**: Distribution of miner hardware
- **Objective**: Work measured in hash difficulty
- **Feedback**: BTC block rewards
- **Adaptation**: Hashpower flows toward most-profitable nodes
- **Loop**: Every 10 minutes

This structure ≡ a neural network's **State → Objective → Feedback → Adaptation → Loop** (see [[About Bittensor 2025.en]]).

---

## The generalization: Incentive Computing

If this mechanism produces the largest supercomputer in history, can it produce **other useful things**?

- Training LLMs? → Yes ([[Decentralized AI Training.en]])
- Renting GPUs? → Yes ([[DePIN]])
- Inference? → Yes
- Coding agents? → Yes (see [[About Bittensor 2025.en]], Case 1)

This is the core proposition of [[Bittensor]].

---

## Source

- Const (Jacob Steeves), [[About Bittensor 2025.en]] talk — core argument in the 11:00–16:30 segment.
