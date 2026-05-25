---
name: project-kickoff
description: "Shape a new project before implementation: clarify the brief, explore competing product/design directions, capture decisions, and produce handoff-ready BRIEF.md, DESIGN.md, PLAN.md, and DECISIONS.md. Use for greenfield or major new-project starts before project-manager decomposes work."
---

# Project Kickoff

Use this skill to turn a rough project idea into durable direction artifacts.
Kickoff owns product shaping, design direction, implementation guardrails, and
decision capture. It does not own GitHub issue decomposition, long-running
delivery, or active implementation; hand off to [[project-manager]] after Phase
3.

## Ownership Boundary

- `project-kickoff` owns the initial `BRIEF.md`, `DESIGN.md`, `PLAN.md`, and
  `DECISIONS.md`.
- [[project-manager]] owns repo/project setup, testable readiness, issue
  decomposition, project boards, and selecting implementation slices.
- [[test-planning]] owns `TEST_PLAN.md` before broad test work begins.
- [[developing-web-projects]] owns web architecture and stack conventions.
- [[browser-qa]] owns real browser verification for generated web prototypes.

## Ground Rules

- Keep the human in control of product and taste decisions.
- Ask only questions that cannot be answered from existing context.
- When asking, recommend a default and explain the tradeoff.
- Use competing options to widen the design space, not to create ceremony.
- Record every significant choice and rejected alternative in `DECISIONS.md`.
- Prefer artifacts over chat summaries. The project folder is the durable state.
- Do not hand directly to implementation until [[project-manager]] has checked
  setup, testability, issue slicing, and dependencies.

## Source-Inspired Defaults

- **Design variants must diverge.** Distinct concepts should differ in layout,
  hierarchy, visual language, interaction model, or product framing. Avoid two
  variants that are cosmetic siblings.
- **Design work starts with a thesis.** Capture visual/interaction thesis,
  content priorities, and target user context before producing prototypes.
- **Plans are guardrails, not choreography.** `PLAN.md` records scope,
  decisions, work units, dependencies, risks, files, and test scenarios without
  pre-writing brittle implementation code.
- **Use stable work-unit IDs.** Plan units use IDs such as `U1`, `U2`, `U3` so
  later issues, blockers, and PRs can reference them without renumbering chaos.
- **Stress-test fuzzy language.** If terms like "account", "project", "admin",
  "publish", or "sync" are overloaded, resolve the domain meaning and record it
  in `DECISIONS.md`.

## Project Type Detection

Before Phase 1, classify the project:

- **Web application**: website, app, dashboard, admin panel, or tool UI.
- **Discord bot**: slash commands, embeds, interactions, modals, scheduled bot
  behavior.
- **Both**: a bot plus one or more companion web UIs.
- **Other**: still run Phase 1 and Phase 3, but replace Phase 2 with the
  relevant interaction or artifact design.

If the type is unclear and cannot be inferred, ask one concise question before
creating folders.

## Project Folder

Create the project folder at the start of Phase 1:

```text
<project-name>/
  BRIEF.md
  DECISIONS.md
  context/
```

During Phase 2, use temporary competing folders:

```text
<project-name>/
  design-a/
  design-b/
```

After Phase 3, the stable handoff set should be:

```text
<project-name>/
  BRIEF.md
  DESIGN.md
  PLAN.md
  DECISIONS.md
  src/ or docs/
```

## Phase Flow

### Phase 1: Functional Brief

Use [[phases/phase-1-brief]].

Goal: produce an approved `BRIEF.md` that defines the user, problem, flows,
scope boundaries, data, constraints, and open questions.

### Phase 2: Design Direction

For web UI work, use [[phases/phase-2-design]].

For Discord bot work, use [[phases/phase-2-design-discord]].

For "both" projects, design the Discord interaction model first, then run a
separate web UI design pass for each required interface.

Goal: produce an approved `DESIGN.md` plus `src/` for web prototypes or `docs/`
for bot interaction artifacts.

### Phase 3: Implementation Guardrails

Use [[phases/phase-3-planning]].

Goal: produce an approved `PLAN.md` with stable work units, dependencies,
files, risks, and test scenarios. The plan should be specific enough for issue
decomposition, but leave implementation details to the agent working with the
live codebase.

## Sub-Agent Pattern

Use sub-agents when independent perspectives materially improve the result:

- brief critique or question generation
- divergent design concepts
- plan critique from engineering, design, or product angles
- risk review before handoff

Keep prompts bounded. Pass file paths and write scopes, not long pasted context,
when the files already exist.

Fresh sub-agents should read:

```text
<project>/BRIEF.md
<project>/DESIGN.md (when available)
<project>/DECISIONS.md
<project>/context/<round>.md (when available)
```

## Handoff

After Phase 3, hand off to [[project-manager]], not directly to an implementer:

```text
New project kickoff is complete.

Read these files in order:
1. <project>/BRIEF.md
2. <project>/DESIGN.md
3. <project>/PLAN.md
4. <project>/DECISIONS.md
5. <project>/src/ or <project>/docs/

Use [[project-manager]] to:
- verify project readiness
- create or update TEST_PLAN.md through [[test-planning]]
- decompose PLAN.md work units into GitHub issues
- identify dependencies and setup blockers
- route implementation slices to the appropriate implementer
```

If a dedicated implementation agent is used later, it should receive the
project-manager issue context plus the kickoff artifacts, not a raw kickoff
handoff alone.
