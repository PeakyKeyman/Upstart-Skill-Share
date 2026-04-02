---
name: verification-before-completion
description: "Evidence-before-claims verification. Never trust memory or cached results."
triggers:
  - "verify"
  - "done"
  - "before merge"
  - "is it complete"
---

# Verification Before Completion Skill

## Iron Law
**COLLECT FRESH EVIDENCE. DON'T TRUST MEMORY.**

## Before Marking ANY Task Complete

1. **Re-run tests** — `pytest path/to/test.py -x -v`, read the output
2. **Re-read modified files** — Open and scan for completeness
3. **Check for stubs** — Search: TODO, pass, NotImplementedError, console.log-only
4. **Verify integration** — New code is called from somewhere, imports used, routes registered

## Red Flag Rationalizations
If you catch yourself thinking ANY of these, STOP and re-verify:
- "I already checked that" → NO. Check again.
- "It worked before" → RUN IT AGAIN.
- "The tests passed earlier" → RUN THEM AGAIN.
- "It's a simple change" → Simple changes still need verification.
- "The logic looks right" → PROVE IT with a test.

## Evidence Standards
- "Tests pass" = you ran them THIS session and saw green output
- "File is correct" = you read it THIS session
- "Feature works" = you tested it THIS session
- NOT "I wrote it correctly" — that's claim, not evidence
