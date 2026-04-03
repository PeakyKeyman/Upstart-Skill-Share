---
level: policy
domain: design
topic: dark-oled-luxury
status: active
loaded: on-demand
canonical: true
triggers:
  - visual design
  - theme
  - dark mode
related_skills:
  - frontend-design-pro
related_policies:
  - design/responsive-desktop
---

# Dark OLED Luxury Policy

## Purpose

Define the current visual direction for Thoughtbase.

## Current Stance

Thoughtbase uses a premium dark visual language built around true blacks, high contrast, subtle glow, and restrained chrome. Expanded layouts must still feel cinematic rather than generic dashboard UI.

## Required Patterns

- Use deep black surfaces such as `#000000` and `#0a0a0a`.
- Favor high-contrast typography and restrained accent usage.
- Use thin, low-visibility custom scrollbars on dark surfaces.
- Preserve the same visual language across mobile, desktop, overlays, and prose rendering.

## Anti-Patterns

- default system scrollbars on dark UI
- drifting into medium-gray dashboard styling on desktop
- adding visual noise to compensate for large screens

## Update Rule

If the user changes the visual direction, rewrite this policy to the new current standard and update any design skill or code references that rely on it.
