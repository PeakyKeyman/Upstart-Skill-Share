---
level: policy
domain: engineering
topic: audio-capture-reliability
status: active
loaded: on-demand
canonical: true
triggers:
  - audio
  - recording
  - mobile capture
related_policies:
  - engineering/environment-validation
---

# Audio Capture Reliability Policy

## Purpose

Define the current stance for recording reliability, audio visualization, and mobile capture edge cases.

## Current Stance

Audio capture must bias toward preserving user data and keeping the recording pipeline resilient to hardware, browser, and mobile backgrounding behavior.

## Required Patterns

- Drive live audio visualization from Web Audio API data and motion values rather than React state for high-frequency animation.
- Use RMS-based level calculations to resist hardware auto-gain distortion.
- Implement wake-lock support during active mobile recordings.
- Listen for microphone track termination and flush recoverable chunks locally when the device backgrounds or locks.
- Use `accept="audio/*"` for generic mobile audio uploads to avoid Android intent traps.
- For browser voice capture, request speech-oriented recording settings up front so the default path already targets transcription fidelity when the platform honors those constraints.
- Normalize uploaded audio for speech-to-text only when the source format or fidelity exceeds the transcription target, and prefer speech-optimized compressed output that remains practical for direct provider uploads.
- Persist normalized audio using a container and file extension that match the actual stored bytes.
- When the current transcription provider's direct-upload size limit is exceeded after normalization, return an explicit user-facing error instead of collapsing the failure into a generic server error.
- Avoid blindly finalizing remote API work from backgrounded mobile `onended` handlers.

## Known Limitation

Thoughtbase does not yet auto-chunk oversized uploaded audio for transcription. Large files that remain above the provider's direct-upload limit after normalization must fail with a clear message until a chunked or URL-based long-audio path exists.

## Anti-Patterns

- using React state for 60 FPS audio meter updates
- assuming mobile microphone tracks survive screen lock or backgrounding
- permissive file input accept strings that trap Android users in camera or gallery flows
- capturing voice at materially higher fidelity than the transcription path requires by default
- expanding compressed uploads into PCM or WAV payloads when the transcription provider is constrained by direct-upload size
- surfacing provider size-limit failures as generic processing errors

## Update Rule

If capture reliability strategy changes, rewrite this policy and align any recording workflows with it.
