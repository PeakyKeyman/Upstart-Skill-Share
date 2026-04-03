---
level: policy
domain: engineering
topic: environment-validation
status: active
loaded: on-demand
canonical: true
triggers:
  - env
  - startup
  - validation
related_policies:
  - engineering/sqlite-and-vector-search
---

# Environment Validation Policy

## Purpose

Define the current stance for runtime prerequisites and host-level correctness checks.

## Current Stance

Environment validation must fail fast during startup. Missing provider credentials or host requirements should be discovered before the first user-triggered request.

## Required Patterns

- Validate required AI provider keys in a shared server env module during startup.
- Load and validate environment variables during Next.js boot, not only during first request execution.
- Fail fast when the local runtime does not match the repository's pinned Node major version, especially when native modules depend on ABI compatibility.
- Exclude native packages from Turbopack bundling when runtime resolution requires the host binary.
- Exclude static binary wrappers when path rewriting would break runtime execution.

## Anti-Patterns

- relying on SDK constructors to reveal missing credentials
- allowing ABI-sensitive native dependencies to fail later because the process booted under the wrong Node major
- allowing native modules to be bundled into unsupported server builds
- treating environment validation as a lazy runtime concern

## Update Rule

If startup validation strategy changes, rewrite this policy and keep all startup procedures aligned.
