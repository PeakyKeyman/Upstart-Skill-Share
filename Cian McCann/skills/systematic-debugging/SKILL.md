---
name: systematic-debugging
description: "Use when encountering bugs, test failures, or unexpected behavior. 4-phase root-cause investigation."
triggers:
  - "debug"
  - "bug"
  - "error"
  - "failing test"
  - "broken"
  - "not working"
  - "investigate"
---

# Systematic Debugging Skill

## Iron Law
**NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST.**

## 4-Phase Process

### Phase 1: Root Cause Investigation
1. Search Cognee for prior occurrences of this error pattern
2. Read the FULL stack trace
3. Check KNOWN_ISSUES.md
4. Reproduce consistently
5. Use CodeGraph get_callers/get_callees to trace the call chain to the root — first function receiving WRONG input = closest to root cause

### Phase 2: Pattern Analysis
1. Use CodeGraph to find working examples doing similar things (symbol_search)
2. Identify ALL differences between working and broken
3. Common patterns: Polars LazyFrame on nonexistent columns, null coercion, join drops, async ordering

### Phase 3: Hypothesis & Testing
1. Form SPECIFIC hypothesis: "[X] causes [Y] when [Z]"
2. Test ONE variable at a time
3. If 3+ hypotheses fail: question architecture

### Phase 4: Fix
1. Write test reproducing the bug (RED)
2. Apply minimal fix (GREEN)
3. Run suite — no regressions (REFACTOR)
4. No "while I'm here" improvements

## Defense-in-Depth Validation
After fixing, validate at 4 layers: Entry → Business logic → Environment → Debug logging

## Post-Fix
Save the root cause and fix pattern to Cognee (`save_interaction`) before moving on.

## Escalation: 3 fix attempts max. Then present findings and stop.
