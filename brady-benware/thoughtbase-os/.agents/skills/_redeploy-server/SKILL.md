---
name: _redeploy-server
description: Use this skill when the user asks to deploy or check server status. It executes the Thoughtbase production redeploy procedure defined by the operations deployment policy.
---

# Auto-Redeploy Skill

## Core Directive

Follow `docs/os/policies/operations/deployment.md` and execute the canonical redeploy flow against the Thoughtbase production host.

The server address is:
`root@thoughtbase.mouse-reedfish.ts.net`

## Pre-Flight Checks

Before executing anything against the remote server:

1. Check local `git status`.
2. If there are uncommitted changes, ask the user whether they want those changes committed and pushed first.
3. Ensure the local branch is pushed to `origin main`.

## Execution Sequence

Do not run an interactive SSH session. Use a single remote command chain.

Before the deploy, create a timestamped backup of the production Thoughtbase data directory so the current SQLite DB and captured assets can be restored if the release fails.

Run this command:

```bash
ssh root@thoughtbase.mouse-reedfish.ts.net "backup_root=\"$HOME/.thought-db-backups\" && backup_dir=\"$backup_root/$(date +%Y-%m-%d_%H-%M-%S)\" && mkdir -p \"$backup_dir\" && cp -a \"$HOME/.thought-db/.\" \"$backup_dir/\" && find \"$backup_root\" -mindepth 1 -maxdepth 1 -type d | sort | head -n -5 | xargs -r rm -rf && cd thoughtbase && git pull origin main && if [ -s \"$HOME/.nvm/nvm.sh\" ]; then . \"$HOME/.nvm/nvm.sh\" && nvm use; fi && node -v | grep -E '^v24\\.' >/dev/null && npm install && npm run build && pm2 reload thoughtbase && printf \"BACKUP_DIR=%s\\n\" \"$backup_dir\""
```

The backup command copies `~/.thought-db/` into a timestamped folder under `~/.thought-db-backups/`, then prunes older backup folders so only the five newest snapshots remain.

This flow prefers repo-managed `nvm` when present, but it must also work on hosts where Node `24.x` is already available on `PATH`.

## Post-Flight Verification

After the command completes, validate PM2 state:

```bash
ssh root@thoughtbase.mouse-reedfish.ts.net "pm2 status thoughtbase"
```

## Final Report

Report whether the deploy succeeded, confirm PM2 state, and include the latest backup location. If any step failed, report the exact failing stage and remind the user that the newest backup under `~/.thought-db-backups/` is available for rollback.
