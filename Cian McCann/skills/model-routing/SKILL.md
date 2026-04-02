---
name: model-routing
description: "Decision matrix for Sonnet vs Opus. Never Haiku. Token cost awareness."
triggers:
  - "which model"
  - "save tokens"
  - "model routing"
  - "sonnet or opus"
---

# Model Routing Skill

## Decision Matrix

| Task Type | Model | Reasoning |
|-----------|-------|-----------|
| Implementation, standard features | Sonnet | High throughput, good quality |
| Mechanical changes, formatting | Sonnet | Efficient for structured tasks |
| Code review | Sonnet | Pattern matching, structured |
| Standard verification | Sonnet | Checklist-driven |
| Standard research | Sonnet | Information gathering |
| Architecture decisions | Opus | Deep trade-off analysis |
| Complex debugging (multi-service) | Opus | Needs to hold full system in context |
| Ambiguous requirements | Opus | Nuanced interpretation |
| Prompt engineering | Opus | Understands model behavior deeply |
| Adversarial reasoning | Opus | Critical thinking requires depth |
| Deep research, design | Opus | Comprehensive analysis |

## Token Cost
Opus is ~5x the cost of Sonnet. Use deliberately — not every task needs Opus.

## Rules
- **Never use Haiku** — insufficient for production engineering work
- Default to Sonnet — escalate to Opus when complexity demands it
- If unsure, start with Sonnet and escalate if quality is insufficient
- Opus for decisions that are expensive to reverse (architecture, design)
- Sonnet for decisions that are cheap to reverse (implementation details)
