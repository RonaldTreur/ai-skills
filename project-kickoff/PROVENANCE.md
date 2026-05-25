# Project Kickoff Provenance

This document records the source material and local decisions that shaped
`project-kickoff/SKILL.md` and its phase files.

## Rebuild Recipe

Keep these behaviors:

1. Kickoff produces durable direction artifacts: `BRIEF.md`, `DESIGN.md`,
   `PLAN.md`, and `DECISIONS.md`.
2. The user controls product and taste decisions; agents recommend defaults and
   ask only for choices that cannot be discovered.
3. Visual frontend design is a separate owner skill; kickoff detects when it is
   needed and routes to it.
4. Kickoff uses domain grilling and concise questions to resolve project
   language before design/planning.
5. Implementation plans are guardrails with stable work-unit IDs, not brittle
   code choreography.
6. Kickoff hands off to `project-manager` for test planning, issue
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

- Project kickoff should route visual frontend work to a divergent-variant
  design workflow when visual direction matters.
- Planning review should surface close calls and scope/taste decisions instead
  of auto-deciding them.

Local adaptation:

- The visual design-shotgun behavior now lives in `frontend-design`; kickoff
  only detects that a visual frontend is needed and passes the right artifacts.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-frontend-design.md`,
  `docs/skills/ce-plan.md`, `docs/skills/ce-compound.md`
- License: MIT

What we took:

- Frontend design should begin with context detection and a visual thesis.
- Plans should capture guardrails, scope, risks, test scenarios, and stable work
  units without pre-writing implementation code.
- Learning and decisions compound only when artifacts are discoverable later.

Local adaptation:

- Routed frontend-specific design context detection and thesis checkpoints to
  `frontend-design`; kept stable `U<N>` work units and explicit
  `project-manager` handoff in kickoff.

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

- Domain grilling is now central to Phase 1. Kickoff resolves ambiguous terms
  and records domain decisions in `DECISIONS.md` without introducing separate
  glossary/ADR files by default.

## Rejected Material

- GStack home-directory artifact stores, generated preambles, telemetry, and
  command-specific design binary assumptions.
- Keeping visual frontend design inside `project-kickoff`; it is now a separate
  `frontend-design` skill so non-visual projects do not load frontend design
  machinery.
- SuperPowers micro-step implementation plans with exact code snippets; those
  conflict with the local guardrails-not-choreography planning boundary.
- Compound's heavier multi-agent organizational loop; kickoff keeps optional
  perspectives rather than mandatory specialist pipelines.
- Direct handoff from kickoff to implementation; this is superseded by the local
  `project-manager` boundary.

## Formal Trail

- `methodology/disciplines/project-kickoff.md`
- `methodology/ADAPTATION_LOG.md`
