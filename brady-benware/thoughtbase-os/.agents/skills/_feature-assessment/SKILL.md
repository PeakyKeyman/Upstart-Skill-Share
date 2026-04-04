---
name: _feature-assessment
description: Assess and research a new feature, enhancement, or bug fix request. Use this skill after initialization to classify the request, load only the relevant policies, and recommend the next implementation path. Do not write code in this skill.
---

# Feature Assessment Skill

## Core Directive

Do not start implementation immediately. Use this skill to classify the request, retrieve only the relevant policy leaves, and produce a recommendation.

### 1. Classify and retrieve

- Read `docs/os/10-router.md`.
- Classify the request by impacted domain.
- Load the relevant domain handbooks.
- Load only the leaf policies touched by the request.
- Identify whether the request conflicts with an existing stored opinion or exposes a policy gap.

### 2. Codebase study

- Study the relevant code paths to understand current behavior.
- Ensure you understand how the affected area maps back to the active policies.

### 3. Research and best practices

- Research best practices associated with the request.
- Extract the user’s underlying intent rather than trusting flawed implementation details.
- Consider existing project policies before inventing a new pattern.

### 4. Technical feasibility and impact

- Assess the size, risk, and structural soundness of the change.
- Quantify how much of the codebase and policy surface it affects.

### 5. Procedure selection

- Identify which implementation procedures or skills would be used next if the work is approved.
- Treat skills as workflow wrappers around policy docs, not as worldview sources.

### 6. Final recommendation

The assessment output must explicitly list:

- impacted domains
- impacted leaf policies
- any policy conflicts or gaps
- whether an existing policy should be updated
- whether a new policy file is needed
- which implementation procedures or skills should be used next

No implementation or code writing is allowed during this phase.
