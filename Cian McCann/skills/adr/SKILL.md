---
name: adr
description: "Architecture Decision Records. Document why decisions were made."
triggers:
  - "architecture decision"
  - "why did we choose"
  - "ADR"
  - "decision record"
---

# ADR (Architecture Decision Record) Skill

## Template
```markdown
# ADR-[NNNN]: [Title]

## Date
[YYYY-MM-DD]

## Status
proposed | accepted | deprecated | superseded by ADR-NNNN

## Context
[What prompted this decision? What's the problem?]

## Decision
[What we chose and WHY — the reasoning is the most valuable part]

## Consequences
### Positive
- [Good things that result]
### Negative
- [Trade-offs we accept]
### Neutral
- [Things that change but aren't clearly good or bad]

## Alternatives Considered
### [Alternative 1]
- [What it is]
- [Why we rejected it]
### [Alternative 2]
- [What it is]
- [Why we rejected it]
```

## Storage
- Directory: `.planning/adrs/`
- Numbering: Sequential (0001-*, 0002-*)
- Link to related ADRs when decisions interact

## When to Write
- Before major architectural changes
- When choosing between significant alternatives
- When a decision will be hard to reverse
- When multiple team members might question the choice later

## Rules
- Review existing ADRs before making related changes
- Never delete ADRs — mark as deprecated/superseded
- The reasoning (Context + Decision) is more valuable than the choice itself
