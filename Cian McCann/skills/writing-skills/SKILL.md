---
name: writing-skills
description: "How to write good Claude Code skills. TDD approach with CSO."
triggers:
  - "create skill"
  - "new skill"
  - "write a skill"
---

# Writing Skills Skill

## Structure
Every skill needs:
1. **YAML frontmatter**: name, description, triggers
2. **Purpose**: One-line summary
3. **Process**: Numbered steps
4. **Output format**: What the skill produces
5. **Anti-patterns**: What NOT to do

## TDD for Skills
1. Define what the skill should trigger on (write test phrases)
2. Define expected behavior for each trigger
3. Write the skill
4. Test with the trigger phrases
5. Iterate

## CSO (Claude Search Optimization)
Triggers should match how users naturally describe the task:
- Use both formal terms ("architecture decision record") AND casual ("why did we choose")
- Include action verbs ("debug", "fix", "investigate")
- Include problem descriptions ("error", "broken", "not working")

## Quality Checklist
- [ ] Frontmatter has name, description, 3+ triggers
- [ ] Process steps are specific and actionable
- [ ] Anti-patterns section exists
- [ ] Output format is defined
- [ ] Tested with natural language triggers
