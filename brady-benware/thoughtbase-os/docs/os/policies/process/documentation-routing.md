---
level: policy
domain: process
topic: documentation-routing
status: active
loaded: on-demand
canonical: true
triggers:
  - docs
  - routing
  - canonical ownership
related_policies:
  - process/document-structure-and-size
  - process/non-dry-surfaces
  - process/opinion-update-rule
---

# Documentation Routing Policy

## Purpose

Define where durable facts should live and how documentation changes should be routed.

## Current Stance

Each fact should have one canonical home. Broader files should point to the canonical source rather than restating it.

## Required Patterns

- Treat the AI-agent OS doc set under `docs/os/` plus its canonical product and operator companions as the canonical source of agent-operational truth.
- Use `README.md` as the one human-facing exception: it may restate setup, run, or deploy guidance that helps a human onboard, but it does not become the canonical owner of AI-agent policy or procedure.
- Put onboarding and setup material for humans in `README.md`.
- Put user-facing requirements in `docs/prd.md`.
- Keep implementation architecture, provider choices, and runtime design out of `docs/prd.md` unless they materially define the user-facing contract.
- Put operator workflow in `docs/operational-guide.md`.
- Put principles, routing, domain stance, and leaf opinions under `docs/os/`.
- Keep skills procedural. Do not use skills as long-term worldview containers.
- When a new durable opinion does not fit an existing policy cleanly, create a new leaf policy and add it to the registries.
- Use `process/document-structure-and-size` when deciding whether a file should be split or a new hierarchy layer is needed.

## Anti-Patterns

- mixed files that combine principle, policy, procedure, and inventory without need
- repeating the same rule across multiple startup docs
- leaving a durable opinion only in code or only in a skill

## Update Rule

If the documentation map changes, rewrite this policy and update the router and registries together.
