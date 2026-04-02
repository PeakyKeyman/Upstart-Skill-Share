---
name: feature-spec
description: "Write requirements in EARS format with acceptance criteria."
triggers:
  - "requirements"
  - "spec"
  - "user story"
  - "feature spec"
  - "acceptance criteria"
---

# Feature Spec Skill

## EARS Format

### Ubiquitous (always true)
"The system shall [behavior]"
Example: "The system shall validate all user inputs before processing"

### Event-driven (triggered by something)
"When [trigger], the system shall [response]"
Example: "When a new file is uploaded, the system shall extract its schema"

### State-driven (while condition holds)
"While [condition], the system shall [behavior]"
Example: "While the pipeline is running, the system shall display progress updates"

### Unwanted (prevention)
"If [condition], the system shall [prevention]"
Example: "If the API key is missing, the system shall return a clear error message"

### Optional (feature-flagged)
"Where [feature enabled], the system shall [behavior]"
Example: "Where multi-tenancy is enabled, the system shall isolate user data by tenant ID"

## Acceptance Criteria
For each requirement, define:
- **Given**: Starting state
- **When**: Action taken
- **Then**: Expected result
- **And**: Additional conditions

## Output
```markdown
# Feature Spec: [Name]
## Requirements
[EARS-format requirements, numbered]
## Acceptance Criteria
[Given/When/Then for each requirement]
## Non-Requirements
[What we're explicitly NOT building]
```
