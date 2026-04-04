---
name: _opinion-update
description: Rewrite the canonical Thoughtbase policy when a user changes a durable preference or stored opinion. Use this to update current-state guidance without preserving obsolete rules as history.
---

# Opinion Update Skill

## Core Directive

When the user rejects or revises a stored durable opinion, update the current truth in place. Do not preserve obsolete rules as narrative history.

## Procedure

1. Read `docs/os/00-constitution.md`, `docs/os/10-router.md`, and `docs/os/policies/process/opinion-update-rule.md`.
2. Identify the canonical policy file that owns the existing opinion.
3. Rewrite that policy to the new current stance.
4. Update any downstream docs, registries, or internal skills that point to the old rule.
5. Remove contradictory wording elsewhere.
6. Report the new current rule and the files changed.

## Guardrails

- Prefer one canonical policy owner.
- If no current policy cleanly owns the opinion, create a new leaf policy and register it.
- Do not add a timeline or historical diary entry unless omitting prior context would cause an operational mistake.
