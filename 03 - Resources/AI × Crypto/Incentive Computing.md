---
type: concept-note
domain: [crypto, AI, distributed-systems]
status: emerging
created: 2026-06-23
lang: zh
translation_of: "[[Incentive Computing.en]]"
aliases: ["激励计算", "激励驱动计算"]

up: [[AI × Crypto]]
related:
  - [[About Bittensor 2025]]
  - [[Bitcoin as Supercomputer]]
  - [[Bittensor Subnet Architecture]]
  - [[Decentralized AI Training]]
extends: []
source:
  - [[About Bittensor 2025]]

tags:
  - "#status/draft"
  - "#lang/zh"
  - "#topic/ai-crypto"
---

# Incentive Computing · 激励计算

<p align="right">
  <strong>🌐 语言 / Language:</strong>
  <a href="Incentive%20Computing.md"><img src="https://img.shields.io/badge/%E4%B8%AD%E6%96%87-current-blue?style=for-the-badge" alt="中文 (current)"></a>
  <a href="Incentive%20Computing.en.md"><img src="https://img.shields.io/badge/English-switch-lightgrey?style=for-the-badge" alt="English"></a>
</p>

> **定义**：用**经济激励**作为驱动力的一种新型计算范式。把"什么是有价值的工作"用激励函数定义清楚，让一个无许可的全球市场去**自我组织、自我优化**地生产那种工作。

---

## 与其他计算范式的并列关系

```mermaid
flowchart LR
    ML[机器学习<br/>Machine Learning] -.|学习者主动调参| Adaptation
    RL[强化学习<br/>Reinforcement Learning] -.|环境-奖励循环| Adaptation
    GA[遗传算法<br/>Genetic Programming] -.|选择-变异-淘汰| Adaptation
    IC[**激励计算**<br/>Incentive Computing] -.|经济激励-市场淘汰| Adaptation

    Adaptation[**反馈循环范式**<br/>State → Objective → Feedback → Adaptation → Loop]

    style IC fill:#ffd54f
    style Adaptation fill:#c8e6c9
```

四种都是**反馈循环驱动的优化范式**，区别只在反馈信号是什么：
- ML: loss / gradient
- RL: reward
- GA: fitness ranking
- **IC: 真金白银的市场收益**

---

## 关键属性

让激励计算**结构上**比传统组织高效几个数量级：

| 属性 | 说明 |
|------|------|
| **无国界** (borderless) | 任何国家、任何人都能参与 |
| **24/7 不停** | 没有周末、季节、交易所收盘 |
| **完全无许可** (permissionless) | 不要简历、不要 HR、不要面试 |
| **零摩擦** | 没有 KYC 成本、公关、营销开支 |
| **纯市场** | 干多少活拿多少钱，**完全身份盲** |

⟶ 没有传统组织能在**结构层面**复制这些属性，这就是为什么 Bitcoin 能产生 **700-9000 倍**于美国六大算力厂的算力效率（详见 [[Bitcoin as Supercomputer]]）。

---

## 第一个实例：Bitcoin

Bitcoin 是激励计算的**第一个 demo**——它证明了这种范式能在全球尺度上 work。但它只优化**一件事**：哈希算力。

```mermaid
flowchart LR
    Miner[矿工] -->|产 hash| Network[网络验证]
    Network -->|发 BTC 奖励| Miner

    style Miner fill:#fde7c4
    style Network fill:#bbdefb
```

详见 [[Bitcoin as Supercomputer]]。

---

## 通用化：[[Bittensor Subnet Architecture]]

如果同样的机制能让 Bitcoin 产生历史最大算力，**为什么不让它优化其他东西**？

[[Bittensor]] 把 Bitcoin 的具体逻辑抽象成一种"通用激励计算机"——每个子网都是一个独立的激励市场，可以用任意规则定义"什么是有价值的工作"：

- 编程 agent（SWE-Bench 子网）
- 跨网训练大模型 ([[Decentralized AI Training]])
- GPU 算力市场 ([[DePIN]])
- 推理服务
- 股票信号、天气预测、药物发现、量子计算……

---

## 类比理解

| 深度学习 | 激励计算 |
|---------|---------|
| MNIST (单一应用 demo) | Bitcoin |
| PyTorch (通用语言/框架) | [[Bittensor]] |
| TensorFlow / JAX | （未来其他激励计算框架）|

激励计算之于 Bitcoin，就像**深度学习之于 MNIST**——后者证明了思路可行，前者展开成一整个通用工具栈和无数应用。

---

## 来源

- [[Const (Jacob Steeves)]] 在 [[About Bittensor 2025]] 演讲中**首次正式命名**这个范式（16:18 时间点）
- 原话翻译："比特币只是这种新型计算的第一个实例。我把它称为**激励计算**（incentive computer），它和机器学习、强化学习、遗传编程并列，是一种**值得专门研究**的计算范式。"
