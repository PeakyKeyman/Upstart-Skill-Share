# Claude Cognee Skill System

A custom Claude Code environment with 11 agents, 28 skills, 17 slash commands, and Cognee knowledge graph integration. Built for two-dev teams working on AI agent platforms with data pipeline integrity as a first-class concern.

## What's Inside

| Folder | Count | Purpose |
|--------|-------|---------|
| `agents/` | 11 | Agent role definitions (how Claude approaches specific work types) |
| `skills/` | 28 | Focused process guides (reusable methodologies) |
| `commands/custom/` | 17 | Slash commands (`/custom:plan`, `/custom:debug`, etc.) |
| `references/` | 7 | Domain knowledge and conventions |
| `workflows/` | 4 | Pre-defined agent chains for common scenarios |
| `templates/` | 3 | Output templates (PLAN, RESEARCH, VERIFICATION) |
| `hooks/` | 10 | Session init, safety guards, auto-format, compaction |
| `CLAUDE.md` | 1 | Root configuration and index |

## Installation

Copy the contents into your `~/.claude/` directory:

```bash
# Clone the repo
git clone https://github.com/PeakyKeyman/claude-cognee-skill-system.git

# Copy to your Claude config (backup first)
cp -r ~/.claude ~/.claude.backup
cp -r claude-cognee-skill-system/* ~/.claude/

# Restart Claude Code to pick up changes
```

> **Note**: The `hooks/` directory contains custom hooks that replace GSD hooks. Review `settings.json` hook configuration to point to the new hook files if needed.

## Slash Commands

All commands use the `/custom:` prefix. Type `/custom:` in Claude Code for autocomplete.

| Command | Agent/Skill | What It Does |
|---------|-------------|-------------|
| `/custom:plan` | planner | Merged discuss + plan flow with goal-backward planning |
| `/custom:execute` | executor | TDD implementation with two-stage review per task |
| `/custom:debug` | debugger | 4-phase scientific debugging (no fixes without root cause) |
| `/custom:review` | code-reviewer | Two-stage: spec compliance → code quality |
| `/custom:research` | researcher | Context7-first research with time-boxing |
| `/custom:architect` | architect | Codebase mapping, design, spec mining, ADRs |
| `/custom:verify` | verifier | Goal-backward verification with fresh evidence |
| `/custom:devils-advocate` | devils-advocate | Adversarial reasoning (strongest counter-case, no straw men) |
| `/custom:common-ground` | common-ground | Surface hidden assumptions before work begins |
| `/custom:orchestrate` | orchestrator | Chain agents for complex workflows |
| `/custom:data-audit` | data-analyst | Pipeline integrity audit with lineage assertions |
| `/custom:prompt-craft` | prompt-engineering | Craft strong prompts with 6-section anatomy |
| `/custom:checkpoint` | checkpoint | Save named state snapshot |
| `/custom:learn` | continuous-learning | Extract reusable patterns from session |
| `/custom:security-scan` | security-scan | Scan 4 attack surfaces |
| `/custom:spec-mine` | spec-miner | Reverse-engineer specs from undocumented code |
| `/custom:eval` | eval-driven-dev | Design and run eval suites |

## Agents

### planner
Merged discuss + plan agent. Runs Common Ground → Brainstorm → Goal-Backward Planning → Task Design → Plan Review. Produces bite-sized tasks (2-5 min each) with dependency graphs.

### executor
TDD implementation engine. RED-GREEN-REFACTOR per task, two-stage review (spec compliance then quality), model routing (Sonnet for implementation, Opus for complex logic), data pipeline integrity checks at transformation boundaries.

### debugger
Scientific debugging: Root Cause Investigation → Pattern Analysis → Hypothesis Testing → Fix. Iron law: no fixes without understanding root cause. Max 3 attempts then escalate.

### code-reviewer
Two-stage review. Stage 1 (blocking): does the code do what the spec says? Stage 2: security, correctness, maintainability, performance. Severity-ranked: CRITICAL/HIGH block, MEDIUM/LOW don't.

### researcher
Context7-first source priority. Time-boxed: Quick (5 min), Standard (15 min), Deep (30 min). Always ends with recommendation + confidence level.

### architect
5 modes: codebase mapping, architecture design, review, spec mining (EARS format), ADR creation. Always uses Opus.

### verifier
Goal-backward verification with mandatory fresh evidence. Re-runs tests, re-reads files, searches for stubs. Never trusts memory or cached results.

### devils-advocate
Adversarial reasoning. Attacks assumptions, argues the strongest possible counter-case (no straw men), identifies hidden risks, delivers verdict with specific mitigations. Always Opus.

### common-ground
Surfaces Claude's hidden assumptions across Technical, Data, Architecture, and Process. Prevents the "Claude assumed X for Dev A but Y for Dev B" problem. Saves agreements for team reference.

### orchestrator
Coordinates multi-agent workflows. 6 templates: Feature, Bug Fix, Architecture, Agent Port, Security, Research→Implementation. Manages handoffs and quality gates.

### data-analyst
Data pipeline specialist. Schema discovery, integrity audits, lineage assertion generation, quality reports. Knows Polars and BigQuery gotchas for silent data loss.

## Model Routing

| Use Sonnet For | Use Opus For |
|---------------|-------------|
| Implementation, standard features | Architecture decisions, system design |
| Code review, verification | Complex debugging (multi-service) |
| Mechanical changes, refactoring | Ambiguous or novel requirements |
| Standard research | Prompt engineering, adversarial reasoning |

**Never use Haiku.** Opus is ~5x the cost of Sonnet — use deliberately for decisions expensive to reverse.

## MCP Integration

### CodeGraph
Code navigation and impact analysis. Use **before** reading files manually for faster structural understanding.

### Cognee
Cross-session AI memory via knowledge graphs. Search at session start for prior context. Save findings at session end with `save_interaction`.

See `references/mcp-stack.md` for full details.

## Key Methodologies

These are baked into the agents and skills:

- **TDD Iron Law**: No production code without a failing test first
- **Two-Stage Review**: Spec compliance (blocking) → code quality
- **Goal-Backward Planning**: Start from desired end state, work backward to tasks
- **Evidence-Before-Claims**: Never trust memory — collect fresh evidence
- **Data Pipeline Integrity**: Lineage assertions at every transformation boundary
- **Common Ground**: Surface assumptions before work begins
- **EARS Requirements**: Ubiquitous, Event-driven, State-driven, Unwanted, Optional
- **Scientific Debugging**: 4-phase root cause investigation, no guessing

## Directory Structure

```
~/.claude/
├── CLAUDE.md                    ← Root config (core preferences, command list)
├── agents/                      ← 11 agent definitions
├── skills/                      ← 28 skill directories (each with SKILL.md)
├── commands/custom/             ← 17 slash commands (/custom:*)
├── references/                  ← 7 reference docs
├── workflows/                   ← 4 workflow templates
├── templates/                   ← 3 output templates
├── hooks/                       ← Session hooks (init, safety, format, compact)
└── claude-environment-guide.docx ← Full reference guide document
```

## Sources

Built from patterns and methodologies extracted from:

- [Get Shit Done (GSD)](https://github.com/gsd-build/get-shit-done) — Goal-backward planning, hooks, session management
- [Superpowers](https://github.com/obra/superpowers) — TDD iron laws, two-stage review, brainstorming hard gate, scientific debugging
- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) — Continuous learning, hook enforcement, orchestration chains, 170+ skill patterns
- [Awesome Claude Skills](https://github.com/ComposioHQ/awesome-claude-skills) — Skill structure patterns
- [Claude Skills / Common Ground](https://github.com/Jeffallan/claude-skills) — EARS specs, assumption surfacing
- [Cognee](https://github.com/topoteretes/cognee) — Knowledge graph memory for cross-session persistence
