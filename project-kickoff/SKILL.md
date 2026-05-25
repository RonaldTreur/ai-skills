---
name: project-kickoff
description: "Shape a new project before implementation: clarify the brief, explore competing product/design directions, capture decisions, and produce handoff-ready BRIEF.md, DESIGN.md, PLAN.md, and DECISIONS.md. Use for greenfield or major new-project starts before project-manager decomposes work."
---

# Project Kickoff

Use this skill to turn a rough project idea into durable direction artifacts.
Kickoff owns product shaping, surface detection, domain/decision clarity,
implementation guardrails, and decision capture. It does not own detailed
frontend design, GitHub issue decomposition, long-running delivery, or active
implementation; hand off to the right owner after each boundary.

## Ownership Boundary

- `project-kickoff` owns the initial `BRIEF.md`, `DESIGN.md`, `PLAN.md`, and
  `DECISIONS.md`.
- [[project-manager]] owns repo/project setup, testable readiness, issue
  decomposition, project boards, and selecting implementation slices.
- [[test-planning]] owns `TEST_PLAN.md` before broad test work begins.
- [[developing-web-projects]] owns web architecture and stack conventions.
- [[frontend-design]] owns visual frontend design exploration when a project has
  a browser UI, dashboard, landing page, or other visual frontend.
- [[browser-qa]] owns real browser verification for generated web prototypes.

## Ground Rules

- Keep the human in control of product and taste decisions.
- Ask only questions that cannot be answered from existing context.
- When asking, recommend a default and explain the tradeoff.
- Use competing options to widen product or interaction choices, not to create
  ceremony.
- Record every significant choice and rejected alternative in `DECISIONS.md`.
- Prefer artifacts over chat summaries. The project folder is the durable state.
- Do not hand directly to implementation until [[project-manager]] has checked
  setup, testability, issue slicing, and dependencies.

## Kickoff Defaults

- **Grill the domain before planning.** Resolve overloaded terms and hidden
  assumptions before they become design or implementation drift.
- **Visual frontend work is routed out.** If the project has a browser UI,
  dashboard, landing page, or visual frontend, use [[frontend-design]] for the
  divergent visual design exploration.
- **Non-visual design stays here.** Bot-only, backend-only, CLI, and automation
  projects still need interaction/artifact design, but not frontend-design.
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

- **Visual frontend**: website, web app, dashboard, admin panel, landing page,
  browser tool, or UI-heavy frontend feature.
- **Discord bot**: slash commands, embeds, interactions, modals, scheduled bot
  behavior.
- **Both**: a bot/backend plus one or more companion frontends.
- **Non-visual software**: backend service, API, CLI, worker, automation, data
  pipeline, or other project with no user-facing visual UI.
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

During Phase 2, visual frontend projects may use temporary competing folders
owned by [[frontend-design]]:

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

### Phase 2: Surface Design

For visual frontend work, use [[phases/phase-2-design]], which delegates to
[[frontend-design]].

For Discord bot work, use [[phases/phase-2-design-discord]].

For "both" projects, design non-visual interaction surfaces first, then run a
separate [[frontend-design]] pass for each required visual interface.

Goal: produce an approved `DESIGN.md` plus `src/` for frontend prototypes,
`docs/` for bot interaction artifacts, or equivalent artifacts for non-visual
projects.

### Phase 3: Implementation Guardrails

Use [[phases/phase-3-planning]].

Goal: produce an approved `PLAN.md` with stable work units, dependencies,
files, risks, and test scenarios. The plan should be specific enough for issue
decomposition, but leave implementation details to the agent working with the
live codebase.

## Sub-Agent Pattern

Use sub-agents when independent perspectives materially improve the result:

- brief critique or question generation
- divergent product, interaction, or frontend design concepts
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
