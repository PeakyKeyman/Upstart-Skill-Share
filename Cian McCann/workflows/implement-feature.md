# Implement Feature Workflow

1. **Plan** → Discuss + plan (`/custom:plan`)
2. **Execute** → TDD per task (`/custom:execute`)
3. **Review** → Spec compliance + quality (`/custom:review`)
4. **Verify** → Fresh evidence verification (`/custom:verify`)

For data-touching features, add:
- Data audit before and after (`/custom:data-audit`)
- Pipeline integrity checks in verification
