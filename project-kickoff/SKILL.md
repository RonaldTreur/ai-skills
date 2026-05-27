---
name: project-kickoff
description: "Shape a new project before implementation: run early grounding/research when it can change direction, clarify the brief, explore competing product/design directions, capture decisions, and produce handoff-ready BRIEF.md, DESIGN.md, PLAN.md, and DECISIONS.md. Use for greenfield or major new-project starts before project-manager decomposes work."
---

# Project Kickoff

Use this skill to turn a rough project idea into durable direction artifacts.
Kickoff owns product shaping, early research/discovery, surface detection,
domain/decision clarity, implementation guardrails, and decision capture. It
does not own detailed frontend design, GitHub issue decomposition, long-running
delivery, or active implementation; hand off to the right owner after each
boundary.

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
- [[agent-delegation]] owns delegation mechanics when kickoff uses critique,
  risk-review, or variant-generation agents.
- [[documentation-handoff]] owns durable artifact roles, decision capture, and
  handoff shape for kickoff outputs.

## Ground Rules

- Keep the human in control of product and taste decisions.
- Ask only questions that cannot be answered from existing context.
- When asking, recommend a default and explain the tradeoff.
- Use competing options to widen product or interaction choices, not to create
  ceremony.
- Record every significant choice and rejected alternative in `DECISIONS.md`
  using [[documentation-handoff]].
- Prefer artifacts over chat summaries. The project folder is the durable state.
- Do not hand directly to implementation until [[project-manager]] has checked
  setup, testability, issue slicing, and dependencies.

## Kickoff Defaults

- **Grill the domain before planning.** Resolve overloaded terms and hidden
  assumptions before they become design or implementation drift.
- **Ground before shaping.** Use the cheapest sufficient discovery pass before
  locking the brief, design direction, or plan. Skip research when it would not
  change the decision.
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

## Grounding Before Shaping

Use discovery when a project idea depends on facts outside the user's initial
prompt or when "surprise me" needs real substance. The point is to inform the
brief, product direction, and plan; do not turn kickoff into a standing research
report workflow.

Classify the research need:

- **Current/social signal**: what people are saying now, recent tools, market
  movement, prompt patterns, or recommendations. Use `last30days`, `x_search`,
  Reddit/X sources, and Brave-backed web search when current signal can change
  the direction.
- **Deep external research**: competitive landscape, prior art, trends, or
  source-backed decision support. Use `deep-research` only when a saved report
  is worth the time and token cost.
- **Repo/project discovery**: existing docs, code, issues, decisions, strategy,
  user feedback, or prior project artifacts. Read local context before asking
  the user to restate it.
- **Memory/session discovery**: relevant OpenClaw memory, session snapshots, or
  channel history when continuity affects the project framing.

Default to a compact grounding digest:

```markdown
## Grounding
- **Research value:** high | moderate | low | unavailable
- **Searched:** [sources, tools, files, issues, memory]
- **Strongest findings:** [decision-relevant findings]
- **Weak or conflicting signals:** [uncertainty and contradictions]
- **Implication:** [how this changes or confirms the brief/design/plan]
- **Next action:** [one concrete step or blocker]
```

Keep the digest in `<project>/context/grounding.md` or fold it into `BRIEF.md`
when short. Link full reports instead of pasting them into runtime kickoff
artifacts.

Skip discovery when:

- the work is already scoped by approved project docs
- the request is a tiny implementation task
- current external signal is unlikely to change product, design, or platform
  direction
- the user is asking for execution, not shaping
- research would only delay an answer the existing context already supports

When research surfaces a durable product, domain, or platform decision, record
it through [[documentation-handoff]] in `DECISIONS.md`.

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

After Phase 3, the stable handoff set should follow [[documentation-handoff]]
and normally include:

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

Use [[agent-delegation]] for prompt shape, status handling, and parallel-safety
rules.

Use sub-agents when independent perspectives materially improve the result:

- brief critique or question generation
- divergent product, interaction, or frontend design concepts
- plan critique from engineering, design, or product angles
- risk review before handoff

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
