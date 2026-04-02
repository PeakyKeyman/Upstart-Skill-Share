---
name: common-ground
description: "Surface hidden assumptions before implementation. Critical for two-dev teams."
triggers:
  - "assumptions"
  - "align"
  - "before starting"
  - "common ground"
---

# Common Ground Skill

## Process
1. State Claude's assumptions across 4 categories: Technical, Data, Architecture, Process
2. Present as table: Assumption | Claude's Default | Status (Confirm/Change/Lock)
3. Get explicit confirmation for each
4. Save to `.planning/common-ground/[feature].md`

## Categories
- **Technical**: Language version, framework, libraries, build tools
- **Data**: Schema, null handling (None not ""), encoding, datetime/timezone
- **Architecture**: Where new code fits, dependency direction, state management
- **Process**: Testing approach, deployment, review, branch strategy

## When to Use
- Before any new project or major feature
- Before architectural changes
- When second developer joins existing work
- When porting an agent from isolated repo
