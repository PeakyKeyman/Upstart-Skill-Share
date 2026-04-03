---
level: domain
domain: engineering
status: active
loaded: on-demand
canonical: true
---

# Engineering Domain Handbook

## Purpose

This handbook orients work that affects architecture, framework boundaries, storage, audio, vector search, and runtime correctness.

## Current Stance

- Prefer clear local patterns over premature abstraction.
- Preserve Next.js server and client boundaries deliberately.
- Treat environment validation, storage integrity, and transcript recompute behavior as first-class correctness rules.
- Keep detailed implementation opinions in narrow engineering policies.

## Use This Handbook When

- modifying React or Next.js architecture
- changing persistence, embeddings, or transcript recompute logic
- handling environment or runtime validation
- touching audio recording, upload, or realtime systems

## Governing Policies

- `docs/os/policies/engineering/react-composition.md`
- `docs/os/policies/engineering/system-architecture.md`
- `docs/os/policies/engineering/sqlite-and-vector-search.md`
- `docs/os/policies/engineering/search-and-retrieval.md`
- `docs/os/policies/engineering/async-thought-processing.md`
- `docs/os/policies/engineering/audio-capture-reliability.md`
- `docs/os/policies/engineering/environment-validation.md`
- `docs/os/policies/engineering/ai-provider-selection.md`
