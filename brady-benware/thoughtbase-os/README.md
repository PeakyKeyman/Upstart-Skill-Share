# Thoughtbase Agent OS

This repository is not the Thoughtbase product application. The application was intentionally stripped away. What remains is the agent operating system that evolved alongside that product while it was being built.

The point of sharing this repo is to show the operating model in place at this stage of the project: how the memory system is structured, how agent context is routed, how durable decisions are stored, and how the project is kept scalable as complexity grows.

This is not presented as a generic framework you should drop into another repo unchanged. It co-evolved with one specific product. The value here is the design pattern: the project and its agent memory system are meant to evolve together so the system stays grounded in the real codebase instead of drifting into a detached documentation layer.

## What This Repo Demonstrates

This repo shows a way to run a large product project with agents without letting the context layer collapse into:

- huge startup prompts
- duplicated rules scattered across docs
- stale architecture summaries
- undocumented decisions trapped only in code
- procedural knowledge trapped only in agent skills
- large-project drift that turns into spaghetti code and hard-to-debug regressions

The core idea is simple:

1. Keep the root context thin.
2. Route agents into only the domain knowledge needed for the current task.
3. Give each durable fact one canonical home.
4. Keep procedures in skills and policy in docs.
5. Continuously rewrite the memory system to reflect the current project state.

## Why The OS Exists

As a project grows, agent help gets worse unless memory becomes deliberate.

Without a system, one of two failure modes usually happens:

- The agent gets too little context and starts making local changes that violate product, design, or architecture intent.
- The agent gets too much context and starts operating from bloated, stale, contradictory instructions.

This OS is meant to solve that by treating project memory as an explicit part of the product-development system.

The docs under `docs/os/` are not general project docs. They are the operational memory layer that helps agents work on a large codebase with bounded context while still staying aligned with the real project.

## How The Memory System Works

The memory model is defined in [00-constitution.md](/docs/os/00-constitution.md) and routed through [10-router.md](/docs/os/10-router.md).

The OS stores only a few classes of memory:

- principles: stable operating beliefs
- policies: current durable standards and opinions
- procedures: repeatable execution workflows
- registries: navigation aids and active sync surfaces

That constraint matters. It prevents the memory layer from turning into a diary, changelog, or junk drawer.

The system is built around a few rules:

- The root stays thin and loads first.
- Task classification happens early.
- Only the smallest relevant domain handbook and leaf policies are loaded next.
- Every durable fact should have one canonical home.
- Broader docs point to canonical sources instead of restating them.
- When an opinion changes, the canonical file is rewritten to the new current state rather than accumulating history.

This lets the project keep a living memory layer without creating another source of complexity.

## How The Repo Is Structured

- [docs/os/00-constitution.md](/docs/os/00-constitution.md): top-level principles, precedence, and memory model
- [docs/os/10-router.md](/docs/os/10-router.md): routing logic, canonical ownership, and retrieval flow
- [docs/os/domains/](/docs/os/domains): domain handbooks for product, design, engineering, and operations
- [docs/os/policies/](/docs/os/policies): narrow current-state opinions and standards
- [docs/os/registries/](/docs/os/registries): indexes and declared sync surfaces
- [docs/prd.md](/docs/prd.md): canonical product intent and user-facing contract
- [docs/operational-guide.md](/docs/operational-guide.md): operator workflow for working in the repo
- [.agents/skills/](/.agents/skills): procedural wrappers used to execute recurring workflows

The important design choice is that not everything is stored in one place.

The README is for humans. The PRD owns product truth. The operational guide owns human workflow. The OS owns agent-operational memory. Skills own procedure. Registries track the places where deliberate duplication exists and must stay synchronized.

## How This Helps A Large Project Stay Scalable

Large projects usually become messy for predictable reasons:

- architecture intent gets separated from implementation
- product requirements and implementation detail bleed into each other
- duplicated UI or workflow surfaces drift apart
- old decisions remain in docs after the code has moved on
- agents keep re-learning the same lessons because the project has no canonical memory

This OS is designed to counter that.

### 1. Thin startup context

Agents do not load the whole project worldview up front. They load the constitution and router first, then stop until the task is classified.

That keeps startup context small and reduces accidental reasoning from irrelevant or stale instructions.

### 2. Domain routing

Once a task is classified, the agent loads only the relevant domain handbook and then only the leaf policies touched by that task.

That gives the agent depth where needed without turning every task into a full-repo brain dump.

### 3. Canonical ownership

Each fact has one owner. This sharply reduces contradiction and stale duplication.

The routing rules for that live in [documentation-routing.md](/docs/os/policies/process/documentation-routing.md).

### 4. Current-state rewriting

The memory system is not an archive of every opinion the project has ever had. When a durable preference changes, the narrowest canonical policy is rewritten.

That keeps the memory layer useful for execution instead of burying agents under historical sediment.

### 5. Managed non-DRY surfaces

Sometimes duplication is the right engineering choice. But when duplication is intentional, it is registered and tracked.

That pattern is formalized in [non-dry-surfaces.md](/docs/os/policies/process/non-dry-surfaces.md) and [sync-surfaces.md](/docs/os/registries/sync-surfaces.md).

This is important for avoiding large-project bugs where parallel implementations slowly drift apart.

### 6. Skills stay procedural

Skills are execution wrappers, not the place where the enduring worldview lives.

That separation matters because procedure changes often, while durable project truth needs canonical ownership and reviewable structure.

## Co-Evolution Is The Point

This repo should be read as evidence of co-evolution between a product and its agent memory system.

The original Thoughtbase project forced the OS to become more precise over time:

- product docs clarified what belonged in the PRD versus architecture policy
- engineering policies captured real implementation constraints
- process policies emerged to manage drift and canonical ownership
- registries appeared where deliberate duplication had to be tracked
- skills wrapped recurring workflows so agents could execute them consistently

In other words, the OS was not designed in the abstract and then imposed on the project. It adapted to the project as the project became more complex.

That is the main thing this repository is trying to show.

## What This Is Not

- It is not a generic starter kit.
- It is not a portable framework that should be copied wholesale into unrelated repos.
- It is not the full Thoughtbase application.
- It is not meant to prove that docs alone solve architecture problems.

The argument is narrower: if you want agents to help build and maintain a large product over time, the project needs a deliberate memory layer that co-evolves with the real work.

## Suggested Reading Order

If you want to understand the system quickly, read in this order:

1. [docs/os/00-constitution.md](/docs/os/00-constitution.md)
2. [docs/os/10-router.md](/docs/os/10-router.md)
3. [docs/prd.md](/docs/prd.md)
4. [docs/operational-guide.md](/docs/operational-guide.md)
5. [docs/os/policies/process/documentation-routing.md](/docs/os/policies/process/documentation-routing.md)
6. [docs/os/policies/process/non-dry-surfaces.md](/docs/os/policies/process/non-dry-surfaces.md)
7. [docs/os/registries/policy-index.md](/docs/os/registries/policy-index.md)

## Bottom Line

This repository is a snapshot of an agent operating system after it had already been pressured by a real product.

The thing being shared is not just a set of docs. It is a model for how project memory can be structured so agents can keep contributing as a codebase grows, while reducing drift, preserving canonical ownership, and helping the project stay legible instead of collapsing into large-project chaos.
