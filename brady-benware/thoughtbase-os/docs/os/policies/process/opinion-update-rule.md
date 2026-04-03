---
level: policy
domain: process
topic: opinion-update-rule
status: active
loaded: on-demand
canonical: true
triggers:
  - preference change
  - durable opinion
  - policy rewrite
related_skills:
  - _opinion-update
---

# Opinion Update Policy

## Purpose

Define how durable preferences change without turning the OS into a history log.

## Current Stance

Preference changes should mutate the current truth in place. The system should not preserve obsolete rules as narrative history.

## Required Patterns

- Rewrite the canonical policy file to the new current stance.
- Update downstream docs, registries, and skills that point to the old stance.
- Remove contradictory wording elsewhere.
- Report the new rule clearly after the mutation is complete.

## Anti-Patterns

- appending a dated note about the old rule instead of replacing it
- leaving contradictory text in sibling docs or skills
- storing a preference change only in code

## Update Rule

Use this policy whenever user feedback conflicts with a stored durable opinion.
