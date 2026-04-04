---
level: policy
domain: process
topic: document-structure-and-size
status: active
loaded: on-demand
canonical: true
triggers:
  - doc size
  - document hierarchy
  - splitting docs
  - context control
related_policies:
  - process/documentation-routing
  - process/non-dry-surfaces
---

# Document Structure and Size Policy

## Purpose

Define the principles, limits, and splitting procedure that keep the Thoughtbase agent operating system small enough for task-specific retrieval and clear canonical ownership.

## Current Stance

The Thoughtbase agent operating system exists to be loaded selectively. The hierarchy is not just an organization preference; it is part of the OS context-control strategy.

When a document grows too large, it starts pulling unrelated worldview into tasks that only needed a narrow fact. That makes retrieval noisier, ownership blurrier, and updates riskier. The correct response is usually not to tolerate the larger file, but to introduce another layer of hierarchy and split the purpose into narrower canonical roles.

## Principles

- Optimize the documentation tree for selective loading, not for browsing everything in one place.
- A canonical file should be small enough that reading it rarely drags in unrelated policy.
- Broader files route and summarize; narrower files hold durable specifics.
- When a file starts mixing multiple independently changing concerns, the hierarchy is too flat.
- Splitting is not just about line count. It is about preserving relevance, ownership, low-context reads, and canonical purpose.

## Limits

- Hard cap: no canonical documentation file should exceed `280` lines without an explicit user-approved exception.
- Soft split threshold: once a canonical documentation file crosses `180` lines, treat splitting or introducing a narrower child file as the default path.
- Root files, router files, domain handbooks, and registries should stay materially below the hard cap and should usually remain near their current scale. If one of these starts approaching the soft threshold, prefer adding a new child policy or registry entry rather than expanding the parent.

## Splitting Procedure

When a file approaches the soft threshold or starts carrying multiple concerns:

1. Reconfirm the file's canonical purpose.
2. Identify the distinct sub-purposes that are currently being collapsed into one file.
3. Introduce the next hierarchy layer needed to map those narrower purposes cleanly.
4. Give each new child file its own canonical purpose within that broader schema.
5. Move content according to the new purpose boundaries rather than splitting paragraphs mechanically.
6. Rewrite the parent so it becomes a mapper or summary for the new structure instead of continuing to carry the old mixed purpose.
7. Update the router, registries, or pointers so retrieval follows purpose rather than file adjacency.
8. Remove duplicated wording that became unnecessary after the split.

## Preferred Hierarchy Pattern

- `README.md`: human onboarding, setup, run commands, and only the overlap a human needs
- `docs/prd.md`: user-facing product contract
- `docs/operational-guide.md`: operator workflow
- `docs/os/00-constitution.md`: top-level principles
- `docs/os/10-router.md`: retrieval flow and canonical ownership map
- `docs/os/domains/*.md`: compact domain stance summaries
- `docs/os/policies/**/*.md`: narrow durable standards and opinions
- `docs/os/registries/*.md`: navigation-only indexes and active sync surfaces
- `.agents/skills/*/SKILL.md`: procedures, not long-term worldview

## Anti-Patterns

- treating the hard cap as a budget to fill
- expanding a parent file when a child leaf would preserve cleaner retrieval
- splitting content across multiple files without introducing new purpose boundaries or mapping
- using broad docs as convenient dumping grounds for facts that change independently
- allowing one file to become required reading for many unrelated tasks
- solving document sprawl by repeating the same rule in multiple broad files

## Update Rule

If the system adopts a new hierarchy layer or the line-count limits change, rewrite this policy and update the router, registries, and any affected procedures to match.
