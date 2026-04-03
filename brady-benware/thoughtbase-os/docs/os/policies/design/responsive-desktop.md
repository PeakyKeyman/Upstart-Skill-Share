---
level: policy
domain: design
topic: responsive-desktop
status: active
loaded: on-demand
canonical: true
triggers:
  - desktop layout
  - responsive UI
  - feed grid
related_skills:
  - _responsive-desktop-design
related_policies:
  - design/dark-oled-luxury
  - design/modal-routing
---

# Responsive Desktop Policy

## Purpose

Define how Thoughtbase turns mobile-first structures into native-feeling desktop layouts.

## Current Stance

Desktop layouts must use lateral space intentionally. Do not stretch a narrow mobile column across a wide screen and call it done.

## Required Patterns

- Promote single-column feeds into multi-column or multi-pane layouts at larger breakpoints.
- Expand content constraints on desktop and use grid-based distribution where the content benefits from it.
- Move primary desktop actions into headers or anchored desktop controls instead of keeping mobile FAB patterns.
- Prefer CSS breakpoint adaptation over separate mobile and desktop render trees.
- When desktop and mobile wrappers must diverge structurally, keep the internal content shared and duplicate only the structural shell.
- Add `min-w-0` to grid or flex children when long text can inflate track sizing.
- Treat rendered visual review as required implementation work for any user-visible UI change; inspect the actual interface in-browser at the relevant viewport(s) before considering the UI task complete.
- Do not treat lint, build success, or code inspection as substitutes for rendered review of a changed interface.

## Anti-Patterns

- desktop pages that remain a stretched `max-w-2xl` single column without intent
- branching entire trees with `isDesktop ? ... : ...` when CSS can handle it
- duplicating interactive content just to wrap it differently on desktop

## Update Rule

If the team changes its desktop ergonomics, rewrite this policy and keep `_responsive-desktop-design` aligned to it.
