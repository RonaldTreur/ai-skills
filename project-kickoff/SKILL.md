---
name: project-kickoff
description: "Shape greenfield or major projects before implementation: grounding, brief, product/design direction, decisions, and handoff-ready BRIEF.md, DESIGN.md, PLAN.md, and DECISIONS.md."
---

# Project Kickoff

Turn a rough project idea into durable direction artifacts. Own product shaping,
early discovery, surface detection, domain clarity, implementation guardrails,
and decisions. Do not own detailed frontend design, GitHub issue decomposition,
long-running delivery, or active implementation.

## Ownership Boundary

- `project-kickoff`: initial `BRIEF.md`, `DESIGN.md`, `PLAN.md`,
  `DECISIONS.md`.
- [[project-manager]]: repo setup, readiness, issues, project boards, next
  implementation slices.
- [[test-planning]]: `TEST_PLAN.md` before broad test work.
- [[developing-web-projects]]: web architecture and stack conventions.
- [[frontend-design]]: visual frontend exploration.
- [[browser-qa]]: real browser verification for generated web prototypes.
- [[agent-delegation]]: critique/risk/variant agent handoffs.
- [[documentation-handoff]]: artifact roles, decisions, handoff shape.

## Ground Rules

- Keep the human in control of product and taste decisions.
- Ask only questions that cannot be answered from existing context.
- When asking, recommend a default and explain the tradeoff.
- Use competing options to widen product or interaction choices, not to create
  ceremony.
- Record every significant choice and rejected alternative in `DECISIONS.md`
  using [[documentation-handoff]].
- Create an ADR via [[documentation-handoff]] when a technical choice shapes
  architecture, data, auth, platform, deployment, or integration boundaries.
- Prefer artifacts over chat summaries. The project folder is the durable state.
- Do not hand directly to implementation until [[project-manager]] has checked
  setup, testability, issue slicing, and dependencies.

## Kickoff Defaults

- **Grill the domain before planning.** Resolve overloaded terms and hidden
  assumptions before they become design or implementation drift.
- **Ground before shaping.** Use the cheapest sufficient discovery pass before
  locking the brief, design direction, or plan. Skip research when it would not
  change the decision.
- **Visual frontend work is routed out.** Browser UI, dashboards, landing pages,
  and visual frontends use [[frontend-design]] for divergent design.
- **Non-visual design stays here.** Bot-only, backend-only, CLI, and automation
  projects still need interaction/artifact design, but not frontend-design.
- **Plans are guardrails, not choreography.** `PLAN.md` records scope, work
  units, dependencies, risks, files, and tests without pre-writing code.
- **Use stable work-unit IDs.** Plan units use IDs such as `U1`, `U2`, `U3` so
  later issues, blockers, and PRs can reference them without renumbering chaos.
- **Stress-test fuzzy language.** If terms like "account", "project", "admin",
  "publish", or "sync" are overloaded, resolve the domain meaning and record it
  in `DECISIONS.md`.

## Grounding Before Shaping

Use discovery when outside facts can change the brief, product direction, or
plan. Do not turn kickoff into a standing research report workflow.

Classify the research need:

- **Current/social signal**: use `last30days`, `x_search`, Reddit/X, and
  Brave-backed web search only when current signal can change direction.
- **Deep external research**: use `deep-research` when a saved report is worth
  the time and token cost.
- **Repo/project discovery**: read existing docs, code, issues, decisions, and
  prior artifacts before asking the user to restate them.
- **Memory/session discovery**: use relevant OpenClaw memory/session/channel
  history when continuity affects framing.

Default to a compact grounding digest in `<project>/context/grounding.md` or
`BRIEF.md` when short:

```markdown
## Grounding
- **Research value:** high | moderate | low | unavailable
- **Searched:** [sources, tools, files, issues, memory]
- **Strongest findings:** [decision-relevant findings]
- **Weak or conflicting signals:** [uncertainty and contradictions]
- **Implication:** [how this changes or confirms the brief/design/plan]
- **Next action:** [one concrete step or blocker]
```

Skip discovery when:

- the work is already scoped by approved project docs
- the request is a tiny implementation task
- current signal is unlikely to change product, design, or platform direction
- the user is asking for execution, not shaping
- research would only delay an answer the existing context already supports

When research surfaces a durable product, domain, or platform decision, record
it through [[documentation-handoff]] in `DECISIONS.md`.

## Project Type Detection

Before Phase 1, classify the project:

- **Visual frontend**: website, web app, dashboard, admin panel, landing page,
  browser tool, or UI-heavy feature.
- **Discord bot**: slash commands, embeds, interactions, modals, schedules.
- **Both**: a bot/backend plus one or more companion frontends.
- **Non-visual software**: backend service, API, CLI, worker, automation, data
  pipeline, or other project with no user-facing visual UI.
- **Other**: run Phase 1 and Phase 3; replace Phase 2 with relevant artifact or
  interaction design.

If the type is unclear and cannot be inferred, ask one concise question before
creating folders.

## Project Folder

Create the project folder at Phase 1 with `BRIEF.md`, `DECISIONS.md`, and
`context/`. Visual frontend Phase 2 may use temporary competing design folders
owned by [[frontend-design]]. After Phase 3, the stable handoff set normally
contains `BRIEF.md`, `DESIGN.md`, `PLAN.md`, `DECISIONS.md`, and `src/` or
`docs/`.

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

If Phase 3 settles a significant technical direction, create or update the
relevant ADR before handing off.

## Sub-Agent Pattern

Use [[agent-delegation]] for prompt shape, status handling, and parallel-safety
rules.

Use sub-agents only when independent perspectives materially improve the result:

- brief critique or question generation
- divergent product, interaction, or frontend design concepts
- plan critique from engineering, design, or product angles
- risk review before handoff

Fresh sub-agents read only the relevant kickoff artifacts: `BRIEF.md`,
`DESIGN.md` when available, `DECISIONS.md`, and current context notes.

## Handoff

After Phase 3, hand off to [[project-manager]], not directly to implementation.
Tell it to read:

- `BRIEF.md`
- `DESIGN.md`
- `PLAN.md`
- `DECISIONS.md`
- relevant `docs/adr/` records
- `src/` or `docs/`

Then it should:

- verify readiness
- create/update `TEST_PLAN.md`
- decompose `PLAN.md` into issues
- identify blockers
- route implementation slices

Implementation agents receive project-manager issue context plus kickoff
artifacts, not raw kickoff output alone.
