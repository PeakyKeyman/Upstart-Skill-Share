---
name: finishing-dev-branch
description: "Decision framework for completed branches: merge, PR, park, or discard."
triggers:
  - "merge"
  - "PR"
  - "branch done"
  - "park branch"
  - "ship it"
---

# Finishing Dev Branch Skill

## Decision Framework

### MERGE (direct to main)
**When**: All tests pass, review approved, no conflicts, small change
**Action**: Merge, delete branch

### PR (create pull request)
**When**: Ready for human review, needs discussion, medium+ change
**Action**: Push, create PR with summary, assign reviewer

### PARK (set aside)
**When**: Partially done, blocked by external dependency, need to switch tasks
**Action**: Document state in branch README, add to KNOWN_ISSUES, push

### DISCARD (abandon approach)
**When**: Approach failed, better alternative found, requirements changed
**Action**: Document WHY in ADR, delete branch

## Pre-Flight Checklist (before any option)
- [ ] All tests passing
- [ ] No TODOs in diff (unless PARK)
- [ ] Lint clean (ruff check)
- [ ] KNOWN_ISSUES.md updated if applicable
- [ ] Commit messages are clear
