---
level: policy
domain: process
topic: skill-ownership
status: active
loaded: on-demand
canonical: true
triggers:
  - skill ownership
  - wrapper skill
  - third-party skill
related_policies:
  - process/documentation-routing
  - process/opinion-update-rule
---

# Skill Ownership Policy

## Purpose

Define how Thoughtbase treats project-owned skills versus third-party or shared installed skills.

## Current Stance

Skills with an underscore prefix are Thoughtbase-owned and may be edited as part of the repo. Skills without the underscore prefix are treated as third-party or shared dependencies and should remain unmodified unless the user explicitly wants to vendor or patch that external skill itself.

## Required Patterns

- Treat underscore-prefixed skills in `.agents/skills/` as project-owned wrappers or procedures.
- Treat non-underscore skills in `.agents/skills/` as external or shared skills that should remain read-only during normal repo work.
- When Thoughtbase needs repo-specific behavior layered onto an external skill, create a project-owned wrapper skill instead of editing the external skill.
- Put durable repo-specific overrides for external skills in Thoughtbase-owned OS docs or wrapper skills, not in the third-party skill body.
- If a wrapper skill exists for a repo-specific adaptation, prefer the wrapper when the task happens inside Thoughtbase.

## Anti-Patterns

- patching a third-party skill just to inject Thoughtbase-specific command paths or workflow assumptions
- storing repo-specific wrapper behavior only in ad hoc assistant memory instead of in a project-owned skill or OS doc
- using underscore naming for external skills or non-underscore naming for project-owned wrapper skills

## Update Rule

If Thoughtbase changes how it distinguishes project-owned skills from external skills, rewrite this policy and align the operator docs and skill map with it.
