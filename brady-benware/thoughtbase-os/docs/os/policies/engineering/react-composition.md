---
level: policy
domain: engineering
topic: react-composition
status: active
loaded: on-demand
canonical: true
triggers:
  - react
  - composition
  - abstraction
related_skills:
  - vercel-composition-patterns
related_policies:
  - design/responsive-desktop
---

# React Composition Policy

## Purpose

Define the current stance for React and Next.js composition.

## Current Stance

Thoughtbase follows modern React composition patterns and strongly prefers AHA over premature abstraction. Clear duplication is cheaper than the wrong shared abstraction.

## Required Patterns

- Delay abstraction until a pattern has clearly repeated enough to justify it.
- Avoid boolean-prop proliferation that turns one component into multiple tangled variants.
- Prefer explicit Tailwind class strings over dynamic string construction that breaks static analysis.
- Preserve Next.js server-component boundaries instead of centralizing helpers that force client expansion.
- Avoid using context as a convenience escape hatch when top-level fetching or request deduplication is cleaner.

## Anti-Patterns

- `text-${color}-500` style Tailwind generation
- abstraction before the rule of three has been earned
- context introduced mainly to avoid prop drilling
- shared helpers that widen the client bundle for convenience

## Update Rule

If the project changes its stance on abstraction or composition, rewrite this policy and keep any dependent skills aligned.
