---
name: _thoughtbase-browser
description: Thoughtbase wrapper for browser automation. Use this when browser work happens inside the Thoughtbase repo so agent-browser commands run through the canonical repo entrypoint instead of assuming a global PATH install.
---

# Thoughtbase Browser Wrapper

## Purpose

Adapt generic browser-automation workflows to Thoughtbase's repo-local browser harness.

## Core Rule

When working inside `/Users/bradybenware/projects/thoughtbase`, invoke browser automation through:

```bash
npm run browser -- <agent-browser args>
```

Do not assume `agent-browser` is on shell `PATH`. Do not use `npx agent-browser`.

## How To Use With External Skills

- If `agent-browser` is also in play, use that skill for the generic interaction workflow, but translate command execution to `npm run browser -- ...`.
- If `dogfood` is also in play, use that skill for the QA workflow, but execute all browser commands via `npm run browser -- ...`.

## Repo Checks

- `npm run browser:version` verifies that the installed CLI is available.

## Examples

```bash
npm run browser -- open http://localhost:3000
npm run browser -- snapshot -i
npm run browser -- click @e1
```
