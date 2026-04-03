# Sync Surfaces Registry

## Purpose

Track active intentional duplication that must remain synchronized.

## Active Surfaces

### Parallel modal routes and hard routes

- Status: active
- Surfaces:
  - `src/app/@modal/(.)[route-name]/page.tsx`
  - `src/app/[route-name]/page.tsx`
- Why duplicated:
  - intercepting modal routes and direct hard routes are separate DOM trees in Next.js App Router
- What must stay synchronized:
  - wrapper topology
  - spacing and breakpoint structure
  - back-button behavior
  - success-path destination and dismissal semantics
  - primary recovery and error-path behavior when the shared workflow supports them
  - preserved-background-state expectations for intercepted overlays
  - layout-affecting visual changes
