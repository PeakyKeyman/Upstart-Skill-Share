---
name: agent-harness
description: "Scaffolding for building new AI agents or porting existing ones."
triggers:
  - "build agent"
  - "scaffold agent"
  - "port agent"
  - "new agent"
---

# Agent Harness Skill

## Building a New Agent

1. **Define role and boundaries** — What does this agent do? What does it NOT do?
2. **Design tool/function interface** — What tools does it need? What's the API?
3. **Write system prompt** — Use prompt-engineering skill, follow 6-section anatomy
4. **Build eval harness** — Use eval-driven-dev skill, define success criteria FIRST
5. **Implement agent loop** — Input → reasoning → tool use → output
6. **Test with adversarial inputs** — What happens with bad input? Conflicting instructions?

## Porting an Existing Agent

### Port Checklist
1. **Map current tools → new tools** — What's equivalent? What's missing?
2. **Identify capability gaps** — What the old agent does that the new env can't
3. **Reverse-engineer specs** — Use spec-miner skill to get EARS-format requirements
4. **Test equivalence** — Same inputs should produce equivalent outputs
5. **Verify edge cases** — Test the 8 categories from TDD skill

### Nua Labs Specific
When porting agents (Burry, Ecomm, Steward) from isolated repos:
1. Codebase mapping of isolated repo (architect agent)
2. Spec mining in EARS format (spec-miner skill)
3. Map data flow through platform's 5 critical handoff points
4. Implementation plan with TDD (planner + executor agents)
5. Verification (verifier agent)
