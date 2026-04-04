---
level: policy
domain: process
topic: non-dry-surfaces
status: active
loaded: on-demand
canonical: true
triggers:
  - drift
  - duplicated layouts
  - sync surfaces
related_policies:
  - design/modal-routing
---

# Non-DRY Surfaces Policy

## Purpose

Define how intentionally duplicated structures are managed so they do not drift.

## Current Stance

Intentional duplication is allowed when abstraction would damage framework behavior, performance, or clarity. When duplication is deliberate, the duplicate surfaces must be registered and kept in sync.

## Required Patterns

- Register each active duplicated surface in `docs/os/registries/sync-surfaces.md`.
- When editing one registered surface, verify whether its twin or sibling requires the same change.
- Keep duplicated content strictly structural when shared content can still be abstracted.
- Review sync surfaces during finalization for touched files.

## Anti-Patterns

- silent duplication with no registry entry
- modifying a modal or route twin without checking the paired surface
- using duplication as a substitute for straightforward reusable content

## Update Rule

If a duplicated pattern is removed or replaced, update the registry to reflect the new current state.
