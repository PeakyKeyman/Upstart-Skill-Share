# Operational Guide

## Scope

`docs/operational-guide.md` owns operator workflow for working in this repository. Durable worldview belongs under `docs/os/`, and product truth belongs in `docs/prd.md`.

## Standard Session Workflow

1. Load `docs/os/00-constitution.md` and `docs/os/10-router.md`.
2. Classify the task.
3. Load only the relevant domain handbooks, policies, and procedures.
4. Implement and verify the change.
5. Update the narrowest canonical docs that own any new durable facts.
6. Finalize by checking cleanup, sync surfaces, and registry drift.

## Documentation Protocol

- Do not invent a new broad doc when a narrow policy file would do.
- If a durable opinion changes, update the canonical policy rather than appending history.
- Use `docs/os/policies/process/documentation-routing.md` when deciding where a fact belongs.
- Use `docs/os/policies/process/document-structure-and-size.md` when deciding whether to split a file or add a new hierarchy layer.
- If a new policy file is created, add it to the relevant registry.

## Verification Expectations

- Run the repository under its pinned runtime prerequisites before debugging app behavior. Thoughtbase currently requires `Node 24.x`; use `nvm use` in the repo before `npm install`, `npm run dev`, `npm run build`, or `npm start`.
- For browser-harness work, use the repo wrapper `npm run browser -- <agent-browser args>` rather than assuming `agent-browser` is on shell `PATH` or falling back to ad hoc `npx` downloads. `npm run browser:version` verifies the CLI is available.
- Run targeted checks appropriate to the change.
- If one workflow is exposed through multiple live presentation shells, such as a modal twin and a hard-route twin, verify the important success path in each shell instead of treating one checked shell as representative.
- For heavy refactors, run `npx -y knip` and treat `.agents/` CLI entrypoints as expected false positives.
- State what was verified and what remains unverified.

## Deployment Workflow

- Follow `docs/os/policies/operations/deployment.md`.
- Use `_redeploy-server` when the deployment procedure itself is needed.

## Internal Skill Naming

Project-owned skills should keep the underscore prefix in both directory name and `name` frontmatter field.

## External Skills

- Treat non-underscore skills under `.agents/skills/` as third-party or shared dependencies; do not edit them for Thoughtbase-specific behavior during normal repo work.
- When Thoughtbase needs repo-specific adaptation for an external skill, create an underscore-prefixed wrapper skill instead.
- For browser work in this repo, the project-owned wrapper is `_thoughtbase-browser`, which adapts generic browser skills to `npm run browser -- ...`.
