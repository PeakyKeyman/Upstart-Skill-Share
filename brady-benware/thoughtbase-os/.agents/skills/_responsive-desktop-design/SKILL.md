---
name: _responsive-desktop-design
description: Internal procedure for applying Thoughtbase's responsive desktop policy during UI work. Load the design policies on demand instead of storing the worldview here.
---

# Desktop Design Procedure

This skill is procedural. The durable desktop worldview lives in `docs/os/policies/design/responsive-desktop.md` and related design policies.

## Required Reads

Load before applying this skill:

1. `docs/os/domains/design.md`
2. `docs/os/policies/design/responsive-desktop.md`
3. `docs/os/policies/design/dark-oled-luxury.md`
4. `docs/os/policies/design/modal-routing.md` when overlays are involved

## Procedure

1. Identify where the current UI still behaves like a stretched mobile layout.
2. Apply the responsive-desktop policy to layout, action placement, and structural divergence.
3. Keep shared content shared; duplicate only structural wrappers when required.
4. Verify the rendered result in-browser at the relevant viewport(s); do not rely on code inspection alone for visible UI changes.
5. If the task creates a new durable desktop rule, update the canonical policy rather than expanding this skill body.
