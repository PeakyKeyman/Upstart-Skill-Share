---
name: _session-finalize
description: Finalize a Thoughtbase task by cleaning up, verifying canonical doc updates, checking sync surfaces, and ensuring no durable opinion exists only in code or skills.
---

# Session Finalize Skill

Use this skill to cleanly wrap up a development session after implementation. Ensure the next session sees the right current-state docs and no orphan opinions.

## Finalization Checklist

Before updating docs, read `docs/os/10-router.md` and `docs/os/policies/process/documentation-routing.md` to determine the canonical home for each new fact.

### 1. Code and debug cleanup

- Remove temporary logging, dead code, placeholder data, and leftover temporary files relevant to the session.
- If the session changed visible UI, confirm that rendered browser review already happened at the relevant viewport(s); do not defer first visual inspection to finalization.

### 2. Product update

- If the work changed user-facing requirements or contracts, update `docs/prd.md`.

### 3. Operator update

- If the work changed repository execution workflow or verification procedure, update `docs/operational-guide.md`.

### 4. Policy and abstraction review

- Verify that touched code still aligns with the relevant leaf policies.
- If a durable opinion changed, update the canonical policy.
- If a new narrow policy is needed, create it and register it.
- If intentional duplication remains active, ensure it is registered in `docs/os/registries/sync-surfaces.md`.

### 5. Policy and registry update

- Update the relevant files under `docs/os/policies/` or `docs/os/registries/` for any new durable standards or maps.

### 6. Sync-surface assessment

- Review `docs/os/registries/sync-surfaces.md`.
- If you modified any registered surface, verify its counterpart stayed synchronized.
- If you introduced a new intentional duplicate surface, add it to the registry.

### 7. Readme update

- If onboarding, setup, or feature summary changed materially, update `README.md`.

### 8. Documentation sanity check

- Classify each documentation change as product, operator workflow, principle, policy, procedure, or registry.
- Verify that each fact landed in its canonical home according to the router.
- Confirm that no durable opinion exists only in code or only in a skill.

### 8a. OS Improvement Check

- Identify what the session taught about the system, workflow, or docs beyond the immediate code change.
- Use brief root-cause analysis, such as 5 whys, until the issue is expressed at the process, policy, verification, abstraction, or ownership level rather than only as a surface symptom.
- Classify the primary cause of the session's issue or change before proposing any OS mutation. Use one primary bucket:
  - product requirement gap
  - implementation bug under correct requirements or policy
  - agent execution failure despite an adequate OS
  - OS harness failure
- Run the counterfactual test explicitly:
  - if the previous OS had been followed perfectly, would this issue still likely have shipped?
  - if `no`, default away from OS mutation unless the existing rule was too implicit or too easy to miss
  - if `yes`, update the OS in the narrowest canonical place that would have prevented the class of failure
- Ask separately whether the learning implies:
  - a narrow rule for this specific class of issue
  - a broader generalized OS rule that would prevent similar failures elsewhere
- Prefer the highest-leverage generalized fix when it cleanly covers a wider class of mistakes, but still capture the narrow rule when it remains independently useful.
- Ask whether that learning exposes a missing policy, missing procedure, unclear canonical owner, missing verification pattern, weak abstraction, or duplicated surface.
- If the answer is yes, update the narrowest canonical OS file now rather than leaving the learning only in the final message.
- Treat `no OS change needed` as a valid and sometimes preferred outcome when the failure was local implementation work or agent noncompliance with an already-adequate harness.

### 9. Final report

- Summarize cleanup, verification, and which canonical files changed.
- Always include a short OS-learning section with these exact decisions:
  - `Failure Classification`
  - `Counterfactual`
  - `OS Action`: `none`, `clarify`, or `extend`
  - `Canonical Target`: the owning file(s) if action was `clarify` or `extend`
  - `Why This Is The Right Scope`
