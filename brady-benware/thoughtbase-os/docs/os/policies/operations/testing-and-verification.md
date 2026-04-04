---
level: policy
domain: operations
topic: testing-and-verification
status: active
loaded: on-demand
canonical: true
triggers:
  - test
  - verification
  - QA
related_skills:
  - dogfood
---

# Testing and Verification Policy

## Purpose

Define the current verification expectations for repository work.

## Current Stance

Every meaningful change needs explicit verification appropriate to its risk. Finalization should confirm that touched sync surfaces, docs, and code paths were checked rather than assumed.

## Required Patterns

- Run targeted verification for the specific behavior changed.
- Prefer stronger checks for user-facing flows, persistence changes, and deployment work.
- When a session changes visible UI, include rendered browser verification at the relevant viewport(s) as part of implementation, not as an optional polish step.
- When one user workflow exists in multiple meaningful presentation variants, such as modal vs hard route, intercepted vs direct route, or distinct mobile and desktop wrappers, verify the primary success and recovery path in each relevant variant rather than assuming one verified shell covers the others.
- When the goal is exploratory quality assessment or resilience hardening, prefer browser-led dogfooding of realistic user workflows before adding or expanding regression test suites unless the user explicitly asks for automated regression coverage.
- If browser automation is blocked, treat unblocking the browser harness as part of the verification work rather than silently substituting code-only confidence.
- When a session exposes realistic behavior only with production-like local data, prefer verifying against synced real data rather than assuming fixtures are sufficient.
- Use `npx -y knip` during heavy refactors or session finalization when static-pruning risk is relevant.
- Report what was verified and what was not.

## Anti-Patterns

- claiming completion without any stated verification
- treating finalization as docs-only cleanup
- defaulting to test-suite construction when the task is to explore the app like a real user
- accepting a broken browser harness while claiming strong confidence in user-facing behavior
- verifying only one presentation shell of a shared workflow when other live shells can change behavior
- leaving known unverified risk implicit

## Update Rule

If verification standards change, rewrite this policy and align operator procedures to it.
