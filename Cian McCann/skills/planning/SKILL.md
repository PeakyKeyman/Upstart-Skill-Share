---
name: planning
description: "Use when implementing features or breaking down complex tasks. Merged discuss+plan flow with bite-sized steps."
triggers:
  - "plan"
  - "plan this"
  - "break this down"
  - "implementation plan"
  - "how to implement"
  - "task breakdown"
  - "discuss and plan"
---

# Planning Skill

## This skill merges discussion + planning into one flow.

### Step 1: Gather Context
- Search Cognee for prior decisions/lessons about this area
- Use CodeGraph to map the current code structure (callers, dependencies, module boundaries)
- Surface assumptions. Confirm with user.

### Step 2: Brainstorm Approaches
2-3 options with trade-offs. Use CodeGraph impact_analysis to assess blast radius of each. Recommend one. Wait for approval.

### Step 3: Goal-Backward Planning
Goal → must-haves → tasks → dependency graph

### Step 4: Task Design
- 2-4 tasks per plan (split if more)
- Each task: 2-5 minute bite-sized steps with exact file paths and commands
- Test files listed BEFORE implementation files
- Each task has concrete "done when" criterion
- Ambiguities become checkpoints, not guesses

### Step 5: Plan Review
- [ ] Every must-have maps to a task
- [ ] No task exceeds 8 files
- [ ] Dependencies acyclic
- [ ] Data pipeline steps include lineage assertions

### Step 6: Persist
Save plan context to Cognee (`save_interaction`) so future sessions can reference this decision.

Use template: `~/.claude/templates/PLAN.md`
