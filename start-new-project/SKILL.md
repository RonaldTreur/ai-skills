---
name: start-new-project
description: "Start greenfield or major projects before implementation: grounding, brief, product/design direction, decisions, and handoff-ready BRIEF.md, DESIGN.md, PLAN.md, and DECISIONS.md."
---

# Start New Project

Turn a rough new-project idea into durable direction artifacts. Own product
shaping, early discovery, surface detection, domain clarity, implementation
guardrails, and decisions. Do not own detailed frontend design, GitHub issue
decomposition, long-running delivery, or active implementation.

## Ownership Boundary

- `start-new-project`: initial `BRIEF.md`, `DESIGN.md`, `PLAN.md`,
  `DECISIONS.md`.
- [[project-manager]]: repo setup, readiness, issues, project boards, next
  implementation slices.
- [[testing]]: `TEST_PLAN.md` before broad test work.
- [[developing-web-projects]]: web architecture and stack conventions.
- [[frontend-design]]: visual frontend exploration.
- [[browser-qa]]: real browser verification for generated web prototypes.
- `references/delegation.md` under [[project-manager]]: critique, risk or variant agent handoffs.
- [[documentation-handoff]]: artifact roles, decisions, handoff shape.

## Rules

- The human controls product and taste decisions. Ask the questions that
  affect taste, scope, audience, workflow and non-goals here, so implementation
  can later run from the artifacts without reopening them.
- Ask nothing that existing context answers. Group what remains into concise
  checkpoints with recommended defaults and the tradeoff in outcome terms.
- Grill the domain: resolve overloaded terms ("account", "project", "admin",
  "publish", "sync") and hidden assumptions, and record the meaning in
  `DECISIONS.md`.
- Ground before shaping with the cheapest sufficient discovery pass; skip it
  when it would not change the decision.
- Shaping may run over hours or days: update the artifacts after each answer
  and resume from them, never from chat memory. The project folder is the
  durable state.
- Use competing options to widen product or interaction choices, not for
  ceremony.
- Record every significant choice and rejected alternative in `DECISIONS.md`
  via [[documentation-handoff]]; create an ADR there when a technical choice
  shapes architecture, data, auth, platform, deployment or integration.
- Visual frontend work goes to [[frontend-design]]. Non-visual design (bot,
  backend, CLI, automation) stays here as interaction or artifact design.
- `PLAN.md` is a guardrail, not choreography: scope, work units with stable IDs
  (`U1`, `U2`), dependencies, risks, files and tests, no pre-written code.
- Hand off to [[project-manager]], never directly to implementation.

## Grounding Before Shaping

Use discovery when outside facts can change the brief, product direction, or
plan. Do not turn this skill into a standing research report workflow.

Use web or social search, a deep-research report, repo discovery, or the
harness's memory and session history only when the result can change the
brief, design direction or plan.

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
`context/` as soon as the project type and folder name are clear. These files
are the resumable checkpoint for starting the project, including during question
gathering.

Maintain the open-question queue in `context/questions.md`, with compact
statuses such as `unanswered`, `answered`, `assumed default`, and `blocked`.
After each user answer, update `BRIEF.md`, `DECISIONS.md`, and the question
queue before asking the next question. If the user answers everything in one
run, apply the same updates in one pass.

Visual frontend Phase 2 may use temporary competing design folders owned by
[[frontend-design]]. After Phase 3, the stable handoff set normally contains
`BRIEF.md`, `DESIGN.md`, `PLAN.md`, `DECISIONS.md`, and `src/` or `docs/`.

## Phase Flow

### Phase 1: Functional Brief

Goal: an approved `BRIEF.md` with overview, target users, core use cases, user
flows (happy and error paths), data and state, grounding, surfaces, scope
boundaries, constraints and open questions.

1. Read the description and every linked note, sketch, doc, repo file, prior
   decision or reference before asking anything; run the grounding pass when
   outside context could change the brief.
2. Draft the brief with stated assumptions, then ask one checkpoint:

   ```markdown
   I can draft the brief with these assumptions:
   - [assumption + consequence]
   The only blocking choices are:
   1. [question with recommended default]
   ```

   Use a follow-up round only when an answer exposes a real product or design
   fork, or the user wants deeper shaping.
3. For a large, fuzzy or high-stakes idea, obtain an independent critique
   (questions, assumptions, scope risks from a product and an engineering
   angle) and merge it before showing the user; post nothing duplicate or
   generic.
4. Record each meaningful decision in `DECISIONS.md` as decision, why,
   rejected alternatives, user input. Capture what a future implementer would
   otherwise rediscover, not noise.
5. Exit only when the user approves the brief or gives enough concrete edits to
   finalize it.

### Phase 2: Surface Design

For visual frontend work, invoke [[frontend-design]] with `BRIEF.md`,
`DECISIONS.md` and any brand assets, sketches or existing design system; it
returns the approved `DESIGN.md`, the prototype under `src/` and the
`DECISIONS.md` updates. For Discord bot work, use
`phases/phase-2-design-discord.md`.

For "both" projects, design non-visual interaction surfaces first, then run a
separate [[frontend-design]] pass for each required visual interface.

Goal: produce an approved `DESIGN.md` plus `src/` for frontend prototypes,
`docs/` for bot interaction artifacts, or equivalent artifacts for non-visual
projects.

### Phase 3: Implementation Guardrails

Use `phases/phase-3-planning.md`.

Goal: produce an approved `PLAN.md` with stable work units, dependencies,
files, risks, and test scenarios. The plan should be specific enough for issue
decomposition, but leave implementation details to the agent working with the
live codebase.

If Phase 3 settles a significant technical direction, create or update the
relevant ADR before handing off.

## Independent Critique

Obtain an independent critique only when it materially improves the result: a
large or fuzzy brief, divergent product or interaction concepts, a risky plan.
A critique reads only `BRIEF.md`, `DESIGN.md` when available, `DECISIONS.md`
and the current context notes. When another agent provides it, use
`references/delegation.md` under [[project-manager]].

## Handoff

After Phase 3, hand `BRIEF.md`, `DESIGN.md`, `PLAN.md`, `DECISIONS.md`, the
ADRs and `src/` or `docs/` to [[project-manager]], which verifies readiness,
creates `TEST_PLAN.md`, decomposes `PLAN.md` into issues and routes the
slices. Implementation agents receive issue context plus these artifacts, never
raw shaping output alone.
