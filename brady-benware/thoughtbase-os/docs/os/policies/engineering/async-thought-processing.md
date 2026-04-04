---
level: policy
domain: engineering
topic: async-thought-processing
status: active
loaded: on-demand
canonical: true
triggers:
  - background jobs
  - async thought processing
  - placeholder thoughts
  - processing status
related_policies:
  - engineering/audio-capture-reliability
  - engineering/sqlite-and-vector-search
  - operations/testing-and-verification
---

# Async Thought Processing Policy

## Purpose

Define the current engineering stance for durable background processing of newly submitted thoughts and appended brain dumps.

## Current Stance

Thought creation and append-to-existing-thought should not keep the user trapped in the original processing request. Once the backend has durably received the submitted capture, expensive processing work should continue asynchronously from persisted job state.

## Required Patterns

- Persist a durable processing job record before returning success for a newly submitted thought.
- Persist a placeholder parent thought immediately so refreshes and other devices can render in-progress state.
- Treat the feed placeholder thought as the canonical status surface for in-flight processing, not the transient capture request.
- When appending to an existing thought, persist the new brain dump and durable job first, then mark the parent thought as processing without discarding its previous aggregate content.
- Persist processing status and stage in SQLite so status survives refresh, reconnect, and server restarts.
- Broadcast processing-stage updates through the realtime sync channel so other open clients update quickly.
- Allow multiple thoughts to be in flight at the same time; do not block new submissions just because earlier jobs are still processing.
- Keep search indexing limited to completed aggregate thoughts, while still allowing recent-feed views to show pending placeholders or in-progress existing thoughts.
- Make the background processor idempotent enough that retries or restart recovery do not create duplicate completed thoughts.
- When a brand-new thought fails before first completion, keep it in a recoverable failed-capture state with explicit retry or replacement affordances rather than leaving it framed as still processing.
- When an append job fails, preserve the last completed aggregate transcript, coherent document, headline, summary, and search state as the canonical user-visible result until the failed update is retried or discarded.
- Failed async states should expose one clear primary status surface. Do not stack conflicting processing, failure, and coherent-success labels in a way that obscures what remains valid.

## Anti-Patterns

- tying long-running thought processing to the lifecycle of the initial browser request
- relying on in-memory state alone for processing status
- hiding pending thoughts until completion, which makes refresh and cross-device recovery ambiguous
- indexing placeholder thoughts as if they were finalized search records
- leaving stale search entries active while an existing thought is being recomputed from a newly appended dump
- preventing a user from submitting another thought while previous ones are still processing
- leaving a failed capture or append update without an explicit user recovery path
- replacing the last known-good aggregate thought with a half-applied append failure

## Update Rule

If the background execution model, placeholder-thought strategy, or job durability contract changes, rewrite this policy and align the product contract and verification guidance with it.
