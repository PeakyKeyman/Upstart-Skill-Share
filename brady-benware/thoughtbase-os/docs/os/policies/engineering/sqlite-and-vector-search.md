---
level: policy
domain: engineering
topic: sqlite-and-vector-search
status: active
loaded: on-demand
canonical: true
triggers:
  - sqlite
  - vector search
  - embeddings
related_skills:
  - sqlite-vec
---

# SQLite and Vector Search Policy

## Purpose

Define the current persistence and vector-search stance.

## Current Stance

Thoughtbase is local-first. SQLite is the canonical datastore, and vector search runs in-process through `sqlite-vec` rather than through an external SaaS or heavyweight service.

## Required Patterns

- Keep primary data in local SQLite under the designated host storage path.
- Model user-visible thoughts as aggregate parents with chronological child brain dumps.
- Recompute aggregate transcript, summary, coherent markdown, headline, and embedding whenever child dumps change.
- Index only the parent aggregate thought in search, not individual child dumps.
- Cast strict integer values explicitly when SQLite extensions require integer typing.
- Strip exact suffix/prefix overlap when recomputing chronological transcript merges.
- Keep the parent aggregate transcript asset separate from child transcript assets.

## Anti-Patterns

- indexing child dumps as first-class search records
- blindly concatenating overlapping dump text during recompute
- overwriting a child transcript file with the parent aggregate transcript
- introducing external persistence before a clear need exists

## Update Rule

If storage architecture or vector indexing changes, rewrite this policy and update any related engineering procedures.
