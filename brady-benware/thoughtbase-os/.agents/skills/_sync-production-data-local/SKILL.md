---
name: _sync-production-data-local
description: Sync Thoughtbase production data into the local `~/.thought-db` for realistic dogfooding while backing up the current local dataset first.
---

# Sync Production Data Local Skill

## Core Directive

Use this skill when a session needs production-like local data to validate real behavior, especially search, retrieval, storage-path, or UX issues that may not appear with synthetic fixtures.

## Required Policy Context

Load:

1. `docs/os/10-router.md`
2. `docs/os/policies/operations/testing-and-verification.md`
3. `docs/os/policies/process/documentation-routing.md`

## Procedure

1. Back up the current local `~/.thought-db` into `~/.thought-db-local-backups/<timestamp>/` if it exists.
2. Inspect the remote production `~/.thought-db/` size before syncing so the user knows the scale of the copy.
3. Sync production `~/.thought-db/` down to local using an exact-copy strategy.
4. Verify the local dataset with a size check and a small SQLite row-count check.
5. Tell the user where the local backup was stored and remind them to restart the local app if an existing server process may still hold the old SQLite connection.

## Remote Host

Use:

`root@thoughtbase.mouse-reedfish.ts.net`

## Notes

- This is a dogfooding and verification workflow, not a deployment workflow.
- Treat the local backup path as the rollback point for the previous local dataset.
