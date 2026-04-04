---
level: policy
domain: engineering
topic: search-and-retrieval
status: active
loaded: on-demand
canonical: true
triggers:
  - search
  - retrieval
  - ranking
  - query routing
related_policies:
  - engineering/sqlite-and-vector-search
  - engineering/ai-provider-selection
  - operations/testing-and-verification
---

# Search and Retrieval Policy

## Purpose

Define the current engineering stance for search execution, query routing, ranking, and latency-sensitive verification.

## Current Stance

Thoughtbase search is a local hybrid retrieval system. User queries should execute deterministically against SQLite, while remote model calls are limited to the narrow preparatory work that improves retrieval quality.

## Required Patterns

- Execute search only on explicit user submission, not on every keystroke.
- Prefer short direct queries for concept matching and route conversational or date-heavy queries only when structured interpretation is useful.
- Use local keyword, semantic, and metadata/date filtering together rather than treating any one retrieval mode as canonical.
- Bias short exact-topic queries toward precision before recall. When a clear keyword match exists, weak semantic tail results should be suppressed or demoted rather than filling the page with barely related thoughts.
- Keep database execution deterministic and local even when a model is used to interpret a query.
- Treat query-routing latency as optional overhead that must be justified by the query shape.
- For latency-sensitive search work, measure and report the time spent in routing, embeddings, and local retrieval separately when practical.
- Document user-visible search behavior in `docs/prd.md` and keep engineering heuristics in this policy or code-adjacent surfaces.

## Known Limitation

Current hybrid ranking can still over-return low-confidence semantic matches for short exact-topic queries. Future search work should improve precision for these cases before broadening recall.

## Anti-Patterns

- firing full search on each keystroke when the pipeline can invoke remote models
- letting a model generate or execute raw SQL directly
- hiding search latency behind vague “AI processing” language with no stage visibility
- treating semantic search as the only retrieval mode when keyword or date filtering is clearly relevant

## Update Rule

If search execution strategy, ranking philosophy, or routing heuristics change materially, rewrite this policy and update any narrow downstream references.
