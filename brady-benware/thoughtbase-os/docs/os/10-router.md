---
level: router
status: active
loaded: always
canonical: true
---

# Thoughtbase OS Router

## Purpose

This file governs both canonical ownership and retrieval flow. Load it early, use it to classify the task, and then pull only the relevant domain handbooks, policies, and procedures.

## Startup Path

Load on every session:

1. `docs/os/00-constitution.md`
2. `docs/os/10-router.md`

Then stop until the task is classified.

## Retrieval Flow

1. Classify the task by domain and intent.
2. Load the smallest relevant domain handbook.
3. Load only the leaf policies touched by the task.
4. Load only the procedural skill files needed to execute the workflow.
5. During finalization, update the canonical policy, procedure, product, or registry file that owns any new durable fact.

## Task Routing

### Product

Load `docs/os/domains/product.md` when the task changes:

- user-facing workflows
- capture or search product behavior
- data model contracts that users experience
- PRD-level requirements

Common follow-ons:

- `docs/prd.md`
- `docs/os/policies/process/documentation-routing.md`

### Design

Load `docs/os/domains/design.md` when the task changes:

- layout or interaction patterns
- visual direction
- modal or route presentation
- responsive behavior

Common leaf policies:

- `docs/os/policies/design/dark-oled-luxury.md`
- `docs/os/policies/design/responsive-desktop.md`
- `docs/os/policies/design/modal-routing.md`

### Engineering

Load `docs/os/domains/engineering.md` when the task changes:

- React or Next.js architecture
- storage, vector search, or transcript recompute behavior
- environment validation
- audio capture or realtime implementation details

Common leaf policies:

- `docs/os/policies/engineering/react-composition.md`
- `docs/os/policies/engineering/system-architecture.md`
- `docs/os/policies/engineering/sqlite-and-vector-search.md`
- `docs/os/policies/engineering/search-and-retrieval.md`
- `docs/os/policies/engineering/async-thought-processing.md`
- `docs/os/policies/engineering/audio-capture-reliability.md`
- `docs/os/policies/engineering/environment-validation.md`
- `docs/os/policies/engineering/ai-provider-selection.md`

### Operations

Load `docs/os/domains/operations.md` when the task changes:

- deployment
- server behavior
- testing and verification
- operator workflow

Common leaf policies:

- `docs/os/policies/operations/deployment.md`
- `docs/os/policies/operations/testing-and-verification.md`

### Process

Load process policies when the task changes how the repo is maintained:

- documentation ownership
- sync-surface handling
- durable preference mutation

Common leaf policies:

- `docs/os/policies/process/documentation-routing.md`
- `docs/os/policies/process/document-structure-and-size.md`
- `docs/os/policies/process/non-dry-surfaces.md`
- `docs/os/policies/process/opinion-update-rule.md`
- `docs/os/policies/process/skill-ownership.md`

## Canonical Ownership

- `README.md`: human-facing onboarding, setup, and deploy entrypoint material; it may restate what a human needs, but it does not override canonical AI-agent OS docs
- `docs/prd.md`: user-facing requirements and durable product contracts, not implementation architecture unless a detail materially defines the contract
- `docs/operational-guide.md`: operator workflow and repository procedures
- `docs/os/00-constitution.md`: top-level principles and precedence
- `docs/os/10-router.md`: retrieval flow and canonical routing
- `docs/os/domains/*.md`: domain stance summaries
- `docs/os/policies/**/*.md`: detailed current opinions and standards
- `docs/os/registries/*.md`: navigation-only indexes and active sync surfaces
- `.agents/skills/*/SKILL.md`: procedural wrappers

## Eager vs On-Demand Loading

- eager: constitution, router
- on-demand: domain handbooks, leaf policies, skill bodies, registries
- rarely eager: `docs/prd.md` and `docs/operational-guide.md` only when the task clearly touches product contract or operator procedure

## Documentation Update Rules

- Update the narrowest canonical file that owns the fact.
- If a broader file needs to mention it, add only a brief pointer.
- Replace outdated policy text instead of appending historical notes.
- If no current file cleanly owns a new durable opinion, create a new policy leaf and add it to the relevant registry.
