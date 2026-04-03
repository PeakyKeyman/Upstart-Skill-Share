# Skill Map

## Purpose

Map project skills to the procedures they own and the policies they commonly load.

## Internal Skills

- `_session-initialize`: loads `docs/os/00-constitution.md` and `docs/os/10-router.md`, then relevant domain handbooks if the task is already classifiable
- `_feature-assessment`: classifies the request, loads relevant domain handbooks and leaf policies, identifies policy conflicts or gaps, and recommends the next implementation path
- `_os-drift-audit`: audits implementation drift, document-purpose drift, and document-size drift against the canonical Thoughtbase docs and keeps `docs/os-audit-remediation-plan.md` current
- `_session-finalize`: cleans up, verifies canonical updates landed in the right place, checks sync surfaces, and updates registries when policy structure changes
- `_responsive-desktop-design`: applies `docs/os/policies/design/responsive-desktop.md` and related design policies during relevant UI work
- `_redeploy-server`: executes the deployment procedure defined by `docs/os/policies/operations/deployment.md`
- `_sync-production-data-local`: backs up the current local datastore, syncs production `~/.thought-db` into local, and verifies the copied dataset for realistic dogfooding
- `_opinion-update`: rewrites the canonical policy when a user changes a durable preference
- `_thoughtbase-browser`: wraps external browser skills for repo-local browser automation via `npm run browser -- ...`

## External or Shared Skills Commonly Referenced

- `frontend-design-pro`: visual design execution
- `vercel-composition-patterns`: React composition guidance
- `sqlite-vec`: SQLite vector-search implementation guidance
- `agent-browser`: generic browser automation workflow; Thoughtbase-specific command adaptation belongs in `_thoughtbase-browser`
- `dogfood`: exploratory QA workflow
