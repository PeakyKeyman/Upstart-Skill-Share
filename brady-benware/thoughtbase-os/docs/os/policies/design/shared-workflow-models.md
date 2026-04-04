---
level: policy
domain: design
topic: shared-workflow-models
status: active
loaded: on-demand
canonical: true
triggers:
  - shared user model
  - shared status surface
  - workflow unification
related_policies:
  - design/modal-routing
  - process/non-dry-surfaces
---

# Shared Workflow Models Policy

## Purpose

Define the current stance for unifying closely related user workflows.

## Current Stance

When multiple workflows express the same user intent, Thoughtbase should prefer one shared user model, one shared status surface, and one reused interaction pattern unless a split clearly reduces user confusion or unlocks a materially different outcome.

## Required Patterns

- Start from the underlying user intent rather than the implementation path or launch point.
- Reuse one shared status surface when closely related workflows are reporting the same real-world state.
- Reuse one shared interaction pattern when the user is trying to accomplish the same job in slightly different contexts.
- Introduce a split only when it materially clarifies the mental model, reduces confusion, or enables a genuinely different outcome.

## Anti-Patterns

- creating separate workflow variants only because they start from different routes, entry points, or internal code paths
- inventing separate success, pending, or failure surfaces for equivalent user intent
- encoding UX branching that makes the product feel inconsistent without giving the user a meaningful benefit

## Update Rule

If Thoughtbase changes how it decides when similar workflows should unify or split, rewrite this policy and align related design policies with it.
