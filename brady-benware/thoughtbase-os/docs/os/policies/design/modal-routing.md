---
level: policy
domain: design
topic: modal-routing
status: active
loaded: on-demand
canonical: true
triggers:
  - modal
  - overlay
  - intercepting route
related_policies:
  - design/responsive-desktop
  - design/shared-workflow-models
  - process/non-dry-surfaces
---

# Modal Routing Policy

## Purpose

Define the current stance for modal and detail-route presentation.

## Current Stance

Overlay experiences that should preserve feed state and scroll position use Next.js parallel intercepting routes, but routing mechanics must stay subordinate to the simplest coherent user model. Soft-dismissal should return to preserved background state instead of reconstructing it only when that preserved-state behavior keeps the workflow simpler rather than introducing stacked or special-cased UX.

## Required Patterns

- Use Next.js parallel intercepting routes for capture and detail overlays that must preserve background state.
- Prefer one shared capture or detail pattern across closely related workflows instead of creating overlay-specific variants for each case.
- Choose the canonical post-success destination based on the simplest user mental model and shared status surface, not merely on which route launched the flow.
- Dismiss successful modal workflows with `router.back()` when the goal is to return to the preserved route state.
- On desktop, overlays should read as constrained floating surfaces or split panes with heavy backdrop blur rather than full-width stretched pages.
- Treat modal-route twins and hard-route twins as active sync surfaces governed by the process registry.
- Treat UX-specific branching, modal stacking, and route-local special casing as real complexity costs. Prefer simpler and drier user-facing routing patterns by default.

## Anti-Patterns

- using intercepting routes to justify a more complex workflow than the underlying user intent requires
- replacing preserved-state overlays with full navigations by default
- inventing separate success states or status surfaces for equivalent workflows when one shared surface would be clearer
- allowing modal wrappers and hard-route twins to drift structurally
- soft-navigation deletes that leave Next.js in a route-race state when a hard refresh is the safer reset

## Update Rule

If overlay navigation strategy changes, rewrite this policy and update both design and process references that depend on it.
