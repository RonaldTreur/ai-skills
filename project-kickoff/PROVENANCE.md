# Project Kickoff Provenance

This document records the source material and local decisions that shaped
`project-kickoff/SKILL.md` and its phase files.

## Rebuild Recipe

Keep these behaviors:

1. Kickoff produces durable direction artifacts: `BRIEF.md`, `DESIGN.md`,
   `PLAN.md`, and `DECISIONS.md`.
2. The user controls product and taste decisions; agents recommend defaults and
   ask only for choices that cannot be discovered.
3. Design variants must be meaningfully divergent, not cosmetic siblings.
4. Implementation plans are guardrails with stable work-unit IDs, not brittle
   code choreography.
5. Kickoff hands off to `project-manager` for test planning, issue
   decomposition, readiness checks, and implementation routing.

## Source Influence

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `design-shotgun/SKILL.md`, `design-html/SKILL.md`,
  `plan-design-review/SKILL.md`, `autoplan/SKILL.md`,
  `plan-ceo-review/SKILL.md`, `plan-eng-review/SKILL.md`
- License: MIT

What we took:

- Generate multiple visual directions when taste is undecided.
- Prevent converged variants by requiring materially different visual and
  interaction concepts.
- Collect structured feedback and confirm the interpretation before finalizing.
- Surface close calls and scope/taste decisions instead of auto-deciding them.

Local adaptation:

- Kept the multi-variant design loop but removed GStack runtime machinery,
  telemetry, persistent home-directory design stores, and command-specific
  tooling.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-frontend-design.md`,
  `docs/skills/ce-plan.md`, `docs/skills/ce-compound.md`
- License: MIT

What we took:

- Design should begin with context detection and a visual/interaction thesis.
- Plans should capture guardrails, scope, risks, test scenarios, and stable work
  units without pre-writing implementation code.
- Learning and decisions compound only when artifacts are discoverable later.

Local adaptation:

- Added design context detection, thesis checkpoints, stable `U<N>` work units,
  and an explicit handoff to `project-manager`.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/writing-plans/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`
- License: MIT

What we took:

- Subagents need explicit scope, file paths, expected output, and fresh context.
- Plans need clear file responsibilities, tests, and task decomposition.

Local adaptation:

- Kickoff now passes paths and artifacts to bounded subagents and leaves issue
  decomposition to `project-manager` rather than embedding a full execution
  workflow in kickoff.

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/grill-with-docs/SKILL.md`,
  `skills/engineering/improve-codebase-architecture/SKILL.md`
- License: MIT

What we took:

- Challenge fuzzy domain language and ask one precise question at a time when a
  decision truly needs the user.
- Explore existing docs/code instead of asking when the answer is discoverable.

Local adaptation:

- Phase 1 now resolves ambiguous terms and records domain decisions in
  `DECISIONS.md` without introducing separate glossary/ADR files during kickoff.

## Rejected Material

- GStack home-directory artifact stores, generated preambles, telemetry, and
  command-specific design binary assumptions.
- SuperPowers micro-step implementation plans with exact code snippets; those
  conflict with the local guardrails-not-choreography planning boundary.
- Compound's heavier multi-agent organizational loop; kickoff keeps optional
  perspectives rather than mandatory specialist pipelines.
- Direct handoff from kickoff to implementation; this is superseded by the local
  `project-manager` boundary.

## Formal Trail

- `methodology/disciplines/project-kickoff.md`
- `methodology/ADAPTATION_LOG.md`
