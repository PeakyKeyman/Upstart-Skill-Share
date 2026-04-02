# Cian's Claude Code Configuration

> Global CLAUDE.md. Core preferences inline, deep knowledge in reference docs.
> 12 agents | 28 skills | 17 slash commands | 4 workflows | 7 references | 3 templates

## Slash Commands (invoke as /custom:[name])

`/custom:plan` `/custom:execute` `/custom:debug` `/custom:review` `/custom:research`
`/custom:architect` `/custom:verify` `/custom:devils-advocate` `/custom:common-ground`
`/custom:orchestrate` `/custom:data-audit` `/custom:prompt-craft` `/custom:checkpoint`
`/custom:learn` `/custom:security-scan` `/custom:spec-mine` `/custom:eval`

## MCP Tools — Use Proactively

### CodeGraph
Code navigation and impact analysis. Use BEFORE reading files manually.
- Symbol search, callers/callees, impact analysis, dependency tracing
- See `references/mcp-stack.md` for details

### Cognee
Cross-session AI memory via knowledge graphs.
- `search`: Query prior decisions, lessons learned, patterns at session start
- `save_interaction`: Persist important findings at session end
- See `references/mcp-stack.md` for details and `cognee-mcp/CLAUDE.md` for full docs

## Code Style

- Type hints on ALL function signatures — no `Any` without justification
- PEP 8, explicit imports, no wildcards. Enforced by ruff.
- Delete unused code — never comment it out
- Always have a fallback when parsing LLM output
- LLM-driven approaches over keyword matching for semantic decisions
- See `references/code-style.md` for full details

## UI Development

- Default to chat-based interfaces (`st.chat_message` + `st.chat_input`)
- No `st.form` unless explicitly requested
- Streaming responses when possible

## Workflow Preferences

### For Complex Tasks
1. Read relevant agents and skills FIRST
2. Plan BEFORE implementing (`/custom:plan`)
3. Break large changes into testable increments
4. Get approval on architectural changes before executing
5. If unsure, begin a dialogue with the user

### For Codebase Exploration
- Use CodeGraph MCP first for navigation
- Use `skills/codebase-mapping/SKILL.md` for full mapping
- For porting agents: use `skills/spec-miner/SKILL.md`

## Model Routing

- **Sonnet**: Implementation, review, verification, mechanical tasks
- **Opus**: Architecture, complex debugging, ambiguous requirements, prompt engineering
- **Never Haiku**
- See `skills/model-routing/SKILL.md`

## Testing

- TDD mandatory (`skills/tdd/SKILL.md`)
- Patch at EVERY import site when mocking
- pytest markers: unit/integration/slow
- FakeLLM for unit tests, real LLM for integration
- See `references/testing-patterns.md`

## Data Engineering

- Validate inputs early (lazy eval succeeds until materialization)
- Profile before building typed views
- `None` not `""` for missing numeric values
- Assert data lineage at every transformation boundary
- See `references/data-engineering.md` and `skills/data-pipeline-integrity/SKILL.md`

## LLM-First Architecture

LLM handles: routing, classification, schema interpretation, tool selection
Deterministic code handles: math, structural ops, validation, security
See `references/llm-architecture.md`

## Session Continuity

1. Use TodoWrite for explicit checkpoints
2. Document progress in todo items
3. When resuming: search Cognee for prior context, read recent todos
4. Use `/custom:checkpoint` for named state saves
5. Use Cognee `save_interaction` to persist cross-session findings

## Git Workflow

- Never commit to main/master — feature branches
- Lint before commits
- Small, focused, atomic commits

## Sub-Agent Execution

1. Build dependency graph → identify parallel opportunities
2. Launch independent tasks as sub-agents (max 3 concurrent)
3. Each self-verifies (tests must pass)
4. Max 3 fix attempts → escalate
See `references/agent-patterns.md`

## Self-Healing Debug Chains

1. Check KNOWN_ISSUES.md first
2. Classify against known patterns
3. Minimal fix → specific test → broader suite → document
4. Never stack fixes on broken fixes

## KNOWN_ISSUES.md Convention

Every project: `KNOWN_ISSUES.md` at root. Read at session start. Append after every resolved bug.

## Search Before Building

1. Existing repo code → 2. Library/package → 3. Context7 → 4. Build custom

## Escalation Rule

When undeterminable: don't guess. Ask with specific options + recommendation.

## Strategic Compaction

- Compact AFTER research→planning and after debugging
- NEVER mid-implementation or mid-test-fixing
- Before compacting: save to KNOWN_ISSUES.md, update TodoWrite, Cognee save, commit

## Directory Structure

```
~/.claude/
├── CLAUDE.md                    ← This file (root index)
├── agents/                      ← 11 agent definitions
├── skills/                      ← 28 skill directories (each with SKILL.md)
├── commands/custom/             ← 17 slash commands (/custom:*)
├── references/                  ← 7 reference docs (code-style, mcp-stack, nua-labs, etc.)
├── workflows/                   ← 4 workflow templates
├── templates/                   ← 3 output templates (PLAN, RESEARCH, VERIFICATION)
├── hooks/                       ← Session init, safety, formatting, compaction hooks
├── cognee-mcp/                  ← Cognee knowledge graph (MCP server + full repo)
├── settings.json                ← Permissions, hooks config, enabled plugins
└── [GSD/plugin dirs]            ← Legacy plugin directories (being phased out)
```
