---
name: _os-drift-audit
description: Audit the Thoughtbase agent operating system for drift across implementation, documentation purpose, and documentation size/structure limits. Use this whenever the user asks for an audit, cleanup pass, OS-vs-app comparison, doc hierarchy review, canonical ownership review, or periodic maintenance to detect where the app, docs, or OS file structure have drifted from the agent operating system.
---

# OS Drift Audit

Use this skill for periodic repo-wide audits that compare the current app, canonical docs, and operator surfaces against the Thoughtbase agent operating system.

## Purpose

Produce a concrete drift report and recommended remediation path without assuming that every mismatch should be fixed in code. Some drift means the implementation is wrong. Some drift means the agent OS docs are wrong. Some drift means the OS hierarchy is too flat.

## Required Reads

Always load:

1. `docs/os/00-constitution.md`
2. `docs/os/10-router.md`
3. `docs/os/policies/process/documentation-routing.md`
4. `docs/os/policies/process/document-structure-and-size.md`
5. `docs/prd.md`
6. `docs/operational-guide.md`

Then load only the additional domain handbooks and leaf policies actually touched by the current app surface, operator surface, or OS audit findings.

## Audit Categories

Classify every finding into one of these buckets:

1. `implementation drift`
What it means:
Code, runtime behavior, scripts, or operator checks no longer match canonical docs.

2. `document-purpose drift`
What it means:
A canonical OS or repo document no longer adheres to its own scope, canonical purpose, or ownership boundary.

3. `document-size drift`
What it means:
A canonical OS or repo file is too large, too broad, or too structurally dense for selective loading, even if the content is otherwise correct.

## Audit Workflow

1. Map canonical ownership.
Check which files own product truth, operator truth, OS principles, policy leaves, registries, and hierarchy mapping.

2. Inspect implementation.
Review the current app surface, runtime hooks, key APIs, scripts, and verification entrypoints relevant to the repo's active behavior.

3. Inspect documentation purpose.
For each touched canonical doc, ask:
- Does this file still match its declared purpose?
- Is it carrying facts owned somewhere else?
- Is it repeating content that should be a pointer instead?

4. Inspect documentation size and hierarchy.
Use `docs/os/policies/process/document-structure-and-size.md` to identify files whose purpose should be split into a new hierarchy layer with narrower canonical children.

5. Verify operator surfaces.
Run the strongest practical checks for the audited surfaces so the report distinguishes proven behavior from inferred behavior.

6. Update the audit tracker.
Write only unresolved drift items into `docs/os-audit-remediation-plan.md`. Remove stale completed items instead of letting the tracker become historical clutter.

## Report Requirements

The audit output must include:

- findings ordered by severity
- drift type for each finding: `implementation`, `document-purpose`, or `document-size`
- canonical owner for the affected fact or file
- fix options when more than one plausible path exists
- one singular recommendation for each finding that names the preferred fix direction:
  - `change code`
  - `change doc`
  - `move content`
  - `split file`
  - `delete stale content`
- whether the mismatch is already verified or still inferred
- which unresolved items were added or kept in `docs/os-audit-remediation-plan.md`

## Decision Rules

- Prefer fixing the narrower canonical owner rather than broadening a neighboring doc.
- If the implementation matches user intent and the docs are stale, change the docs.
- If the docs are correct and the app drifted, change the code.
- If a document is correct in substance but overloaded in scope, split the purpose and hierarchy rather than relaxing the limit.
- Do not preserve completed audit work in the open-items tracker.

## Anti-Patterns

- treating all drift as implementation drift
- allowing a broad doc to absorb multiple concerns just because it is convenient
- leaving file-size problems implicit because the content is “still accurate”
- producing a findings list without naming the canonical owner
- listing multiple fix options without choosing one recommended path
- leaving open audit items only in the final response instead of the tracker
