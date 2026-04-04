---
level: policy
domain: operations
topic: deployment
status: active
loaded: on-demand
canonical: true
triggers:
  - deploy
  - production
  - server
related_skills:
  - _redeploy-server
---

# Deployment Policy

## Purpose

Define the current deployment stance for Thoughtbase.

## Current Stance

Production deploys target the Hetzner host over Tailscale, protect local-first data with a pre-deploy backup, and use PM2 reload semantics for minimal interruption.

## Required Patterns

- Verify local git state before deploying.
- Ensure the deploy path uses the canonical host `root@thoughtbase.mouse-reedfish.ts.net`.
- Create a timestamped backup of `~/.thought-db/` under `~/.thought-db-backups/` before updating the app.
- Retain only the five newest backup snapshots.
- Ensure the remote deploy runs under Node `24.x`; if repo-managed `nvm` is present, activate it, otherwise use the server's existing `PATH` runtime after explicitly verifying the major version.
- Ensure production hosts that run the markdown-to-PDF utility have Puppeteer's Linux shared-library dependencies installed before relying on server-side PDF generation. On Ubuntu 24 this includes `libnspr4`, `libnss3`, `libgtk-3-0t64`, `libgbm1`, `libx11-6`, `libx11-xcb1`, `libxcb1`, `libxcomposite1`, `libxdamage1`, `libxext6`, `libxfixes3`, `libxrandr2`, `libxrender1`, `libxss1`, `libxtst6`, `libatk1.0-0t64`, `libatk-bridge2.0-0t64`, `libcups2t64`, `libpango-1.0-0`, `libpangocairo-1.0-0`, `libasound2t64`, `fonts-liberation`, `xdg-utils`, `wget`, and `ca-certificates`.
- Build and reload through PM2 rather than restarting the process blindly.
- Verify PM2 status after deployment and report the active backup location.

## Anti-Patterns

- deploying with uncommitted local changes without explicit user intent
- skipping the data backup step
- hardcoding a shell-init path for runtime activation when the host may already expose the correct Node version on `PATH`
- using an interactive SSH flow when a single remote command sequence is enough

## Update Rule

If deployment infrastructure changes, rewrite this policy and update `_redeploy-server`.
