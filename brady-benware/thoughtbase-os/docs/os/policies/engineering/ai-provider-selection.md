---
level: policy
domain: engineering
topic: ai-provider-selection
status: active
loaded: on-demand
canonical: true
triggers:
  - ai models
  - provider selection
  - llm defaults
related_policies:
  - engineering/environment-validation
---

# AI Provider Selection Policy

## Purpose

Define how Thoughtbase chooses AI providers and model defaults without hard-coding stale worldview into broad docs.

## Current Stance

Thoughtbase chooses AI providers by task fit first, then cost. Model names are current defaults, not eternal product truth.

## Required Patterns

- Use Groq for transcription when it remains the best fit for low-cost, high-quality speech-to-text in the current provider set.
- Use Gemini for coherent-document generation, query-routing work, and embeddings while it remains the best fit for the project's existing integration and accuracy needs.
- Default to the highest-accuracy practical model for tasks where output quality materially affects retrieval, summarization, or user trust.
- Use faster or cheaper Gemini variants only when the task is less accuracy-sensitive and the tradeoff is explicit.
- When changing model defaults, research the latest currently available options from the providers Thoughtbase already uses before switching.
- Keep the current default model choices in narrow engineering docs or code-adjacent config, not in broad product or onboarding docs.

## Current Defaults

- Transcription: Groq `whisper-large-v3-turbo`
- Coherent document generation: Gemini `gemini-3.1-pro-preview`
- Embeddings: Gemini `gemini-embedding-001`

## Anti-Patterns

- treating a specific model name as a permanent product requirement
- picking a cheaper model first when the task is accuracy-sensitive
- leaving model-selection rationale only in code or informal conversation

## Update Rule

If provider strategy or default models change, rewrite this policy and any narrow downstream references to match the new current stance.
