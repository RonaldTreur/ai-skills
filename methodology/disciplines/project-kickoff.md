# Discipline Review: Project Kickoff

- Date: 2026-05-25
- Reviewer: Merlin
- Branch: `feat/project-kickoff-adaptation`
- Local files reviewed: `project-kickoff/SKILL.md`,
  `project-kickoff/phases/phase-1-brief.md`,
  `project-kickoff/phases/phase-2-design.md`,
  `project-kickoff/phases/phase-2-design-discord.md`,
  `project-kickoff/phases/phase-3-planning.md`,
  `frontend-design/SKILL.md`,
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

The phase files were useful but too procedural in places and too weak in others.
Phase 1 could ask a pile of questions instead of resolving discoverable context,
Phase 2 mixed visual frontend design into kickoff, and Phase 3 could drift
toward brittle implementation choreography.

## Source Comparison

### GStack

- Useful patterns: design-shotgun variants, anti-convergence, comparison boards,
  structured feedback, and plan review surfacing close calls.
- Local adaptation: moved visual variant exploration into `frontend-design`;
  kickoff detects visual frontends and routes there. Rejected runtime machinery,
  telemetry, command binaries, and home-directory artifact stores.

### Compound Engineering

- Useful patterns: context detection before frontend design, visual thesis,
  guardrails-not-choreography plans, stable work-unit identity, and learning
  capture.
- Local adaptation: added `frontend-design` for context detection and thesis
  checkpoints, stable `U<N>` kickoff plan units, and handoff to
  `project-manager`.

### SuperPowers

- Useful patterns: explicit subagent scope and plans with files/tests/tasks.
- Local adaptation: kickoff subagents now get bounded artifact paths and
  expected outputs, while detailed issue decomposition stays downstream.

### Matt Pocock Skills

- Useful patterns: challenge fuzzy domain language, ask one precise question at
  a time, and inspect existing code/docs before asking.
- Local adaptation: domain grilling is now the main Phase 1 discipline; resolved
  terms and assumptions are recorded in `DECISIONS.md`.

## Adopted Changes

- `project-kickoff/SKILL.md`
  - Added ownership boundaries with `project-manager`, `test-planning`,
    `developing-web-projects`, `frontend-design`, and `browser-qa`.
  - Replaced direct Vectrix handoff with `project-manager` handoff.
  - Added source-inspired defaults for domain grilling, visual-frontend routing,
    guardrail planning, stable work-unit IDs, and fuzzy-language resolution.
  - Removed hard-coded model names from runtime guidance.
- `frontend-design/SKILL.md`
  - Added a separate visual frontend owner skill for GStack-style divergent
    variants, visual thesis, shareable browser review, feedback loops, and
    final design approval.
- `phase-1-brief.md`
  - Shifted from many clarifying questions to context gathering, blocking
    ambiguity only, recommended defaults, and decision capture.
- `phase-2-design.md`
  - Reduced project-kickoff's web UI phase to routing and artifact handoff for
    `frontend-design`.
- `phase-2-design-discord.md`
  - Reframed bot design as interaction design with role, tone, visibility,
    command shape, permissions, embeds, and failure states.
- `phase-3-planning.md`
  - Reframed `PLAN.md` as implementation guardrails with stable `U<N>` work
    units, test strategy, setup/readiness, and issue-decomposition notes.

## Rejections And Deferrals

- Rejected direct kickoff-to-implementation handoff.
- Rejected mandatory two-model competition for every project size.
- Rejected keeping frontend-design inside kickoff; non-visual projects should
  not pay that context cost.
- Rejected implementation plans that pre-write exact code, imports, signatures,
  or shell choreography.
- Deferred deeper UI design prompt integration until the broader frontend-design
  slice.
- Deferred gh-pipeline integration until the issue automation slice.

## Verification Notes

- `[[skill-review]]` focused pass: PASS. The skill has a clear trigger,
  conservative ownership boundaries, progressive disclosure through phase files,
  and no provenance-only material in runtime text.
