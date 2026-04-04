---
level: policy
domain: engineering
topic: system-architecture
status: active
loaded: on-demand
canonical: true
triggers:
  - architecture
  - system design
  - stack choices
  - networking
  - realtime
related_policies:
  - engineering/audio-capture-reliability
  - engineering/async-thought-processing
  - engineering/sqlite-and-vector-search
  - engineering/ai-provider-selection
  - operations/deployment
---

# System Architecture Policy

## Purpose

Define the current cross-cutting application architecture for Thoughtbase without storing that implementation worldview in the PRD.

## Current Stance

Thoughtbase is a local-first web application with private-network access, browser-native capture, durable async processing, realtime cross-device updates, and local retrieval infrastructure.

## Required Patterns

- Use a Next.js application as the primary frontend and server runtime boundary.
- Keep browser audio capture local-first by buffering recorder chunks in IndexedDB before final submission.
- Treat orphan recovery for interrupted voice capture as part of the architecture, not an optional UX layer.
- Use private-network HTTPS access through Tailscale so browser microphone APIs work without introducing public-internet auth architecture.
- Broadcast cross-device processing changes through the realtime event channel so open clients can update without manual refresh.
- Keep AI processing task-specific: transcription through the transcription provider path, coherent-document and query-routing work through the text-generation path, and embeddings through the embedding path owned by the provider-selection policy.
- Keep primary persistence and retrieval local through SQLite and `sqlite-vec`.
- Store implementation architecture here or in narrower engineering leaves, not in `docs/prd.md`.

## Current Architecture

- Network access: Tailscale private networking with MagicDNS-backed HTTPS access.
- Frontend and server framework: Next.js.
- Voice capture handoff: `MediaRecorder` plus IndexedDB chunk buffering and orphan recovery.
- Realtime sync: server-sent events to active clients.
- Audio normalization: `ffmpeg-static` and related server-side normalization.
- Transcription provider family: Groq.
- Coherent-document, query-routing, and embedding provider family: Gemini.
- Local datastore and retrieval: SQLite plus `sqlite-vec`.

## Anti-Patterns

- restating implementation architecture in the PRD as if it were product truth
- introducing public-web auth or SaaS persistence without a deliberate product and operations change
- treating realtime sync as optional when processing state must survive across open clients

## Update Rule

If the core application architecture changes materially, rewrite this policy and align the related engineering and operations leaves.
