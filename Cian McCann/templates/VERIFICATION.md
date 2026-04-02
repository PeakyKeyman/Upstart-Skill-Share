# Verification: [Plan/Feature Name]

## Original Goal
[Restated from plan]

## Requirements Check
| Requirement | Status | Evidence |
|-------------|--------|----------|
| [Req 1] | PASS/FAIL | [FRESH evidence — command run, output seen] |

## Stub Detection
- [ ] No TODO comments in new code
- [ ] No `pass` placeholders
- [ ] No `NotImplementedError`
- [ ] No console.log-only functions

## Integration Check (use CodeGraph)
- [ ] CodeGraph get_callers confirms new code is called from existing system
- [ ] No orphaned files/functions (CodeGraph symbol_search)
- [ ] Tests cover integration points

## Data Integrity (if applicable)
- [ ] Pipeline assertions at boundaries
- [ ] Row counts verified
- [ ] Schema matches expected

## Verdict: PASS | FAIL | NEEDS_WORK
[Summary]
