---
name: incident-response
description: "Handle production issues systematically with severity-based protocol."
triggers:
  - "production issue"
  - "outage"
  - "post-mortem"
  - "incident"
  - "P0"
---

# Incident Response Skill

## Severity
- **P0**: System down, all users affected
- **P1**: Major feature broken, significant user impact
- **P2**: Degraded performance, partial impact
- **P3**: Minor issue, workaround available

## 5-Step Protocol

### 1. Assess
- What's broken? Who's affected? Since when?
- Severity level → determines response urgency

### 2. Communicate
- Notify stakeholders (team channel, status page)
- Set expectations for resolution timeline

### 3. Investigate
- Use systematic-debugging skill
- Focus on RESTORING SERVICE first, root cause second for P0/P1
- For P2/P3, can investigate root cause directly

### 4. Fix
- Minimal blast radius — smallest change that restores service
- Rollback if possible, hotfix if not
- Test fix before deploying

### 5. Post-Mortem (within 48 hours)

```markdown
# Post-Mortem: [Incident Title]
## Date: [YYYY-MM-DD]
## Severity: [P0-P3]
## Duration: [How long]
## Impact: [Who/what was affected]

## Timeline
| Time | Event |
|------|-------|
| HH:MM | [What happened] |

## Root Cause
[Technical root cause]

## Contributing Factors
[What made it worse or harder to detect]

## Action Items
| # | Action | Owner | Deadline |
|---|--------|-------|----------|
| 1 | [Specific action] | [Name] | [Date] |

## Lessons Learned
[What to do differently]
```

**Never blame individuals. Focus on systems and processes.**
