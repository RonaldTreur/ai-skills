# Discipline Review: Project Kickoff

- Date: 2026-05-25
- Reviewer: Merlin
- Branch: `feat/project-kickoff-adaptation`
- Local files reviewed: `project-kickoff/SKILL.md`,
  `project-kickoff/phases/phase-1-brief.md`,
  `project-kickoff/phases/phase-2-design.md`,
  `project-kickoff/phases/phase-2-design-discord.md`,
  `project-kickoff/phases/phase-3-planning.md`,
  `project-manager/SKILL.md`, `test-planning/SKILL.md`,
  `developing-web-projects/SKILL.md`, `browser-qa/SKILL.md`
- External sources reviewed: GStack, Compound Engineering, SuperPowers, Matt
  Pocock Skills
- Status: implemented

## Local Baseline

`project-kickoff` already had a useful three-phase structure: functional brief,
design competition, and implementation planning. The main gaps were ownership
and rigidity.

The old skill jumped from `PLAN.md` directly to Vectrix implementation, which
conflicted with the newer `project-manager` boundary. It also hard-coded model
names, Discord-specific orchestration details, and a mandatory two-model debate
even when a smaller pass would be enough.

The phase files were useful but too procedural in places and too weak in others:
design variants were not explicitly forced to diverge, Phase 1 could ask a pile
of questions instead of resolving discoverable context, and Phase 3 could drift
toward brittle implementation choreography.

## Source Comparison

### GStack

- Useful patterns: design-shotgun variants, anti-convergence, comparison boards,
  structured feedback, and plan review surfacing close calls.
- Local adaptation: kept the multi-variant and structured feedback discipline;
  rejected runtime machinery, telemetry, command binaries, and home-directory
  artifact stores.

### Compound Engineering

- Useful patterns: context detection before frontend design, visual thesis,
  guardrails-not-choreography plans, stable work-unit identity, and learning
  capture.
- Local adaptation: added design context detection, thesis checkpoint, stable
  `U<N>` plan units, and handoff to `project-manager`.

### SuperPowers

- Useful patterns: explicit subagent scope and plans with files/tests/tasks.
- Local adaptation: kickoff subagents now get bounded artifact paths and
  expected outputs, while detailed issue decomposition stays downstream.

### Matt Pocock Skills

- Useful patterns: challenge fuzzy domain language, ask one precise question at
  a time, and inspect existing code/docs before asking.
- Local adaptation: Phase 1 resolves ambiguous terms and records decisions in
  `DECISIONS.md` rather than adding separate domain docs during kickoff.

## Adopted Changes

- `project-kickoff/SKILL.md`
  - Added ownership boundaries with `project-manager`, `test-planning`,
    `developing-web-projects`, and `browser-qa`.
  - Replaced direct Vectrix handoff with `project-manager` handoff.
  - Added source-inspired defaults for divergent variants, design thesis,
    guardrail planning, stable work-unit IDs, and fuzzy-language resolution.
  - Removed hard-coded model names from runtime guidance.
- `phase-1-brief.md`
  - Shifted from many clarifying questions to context gathering, blocking
    ambiguity only, recommended defaults, and decision capture.
- `phase-2-design.md`
  - Added design context detection, thesis checkpoints, anti-convergence, browser
    review, and structured feedback capture.
- `phase-2-design-discord.md`
  - Reframed bot design as interaction design with role, tone, visibility,
    command shape, permissions, embeds, and failure states.
- `phase-3-planning.md`
  - Reframed `PLAN.md` as implementation guardrails with stable `U<N>` work
    units, test strategy, setup/readiness, and issue-decomposition notes.

## Rejections And Deferrals

- Rejected direct kickoff-to-implementation handoff.
- Rejected mandatory two-model competition for every project size.
- Rejected implementation plans that pre-write exact code, imports, signatures,
  or shell choreography.
- Deferred deeper UI design prompt integration until the dedicated UI design
  slice.
- Deferred gh-pipeline integration until the issue automation slice.

## Verification Notes

- `[[skill-review]]` focused pass: PASS. The skill has a clear trigger,
  conservative ownership boundaries, progressive disclosure through phase files,
  and no provenance-only material in runtime text.
