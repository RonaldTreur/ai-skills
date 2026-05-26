# Discipline Review: Documentation and Handoff

- Date: 2026-05-26
- Reviewer: Merlin
- Branch: `feat/documentation-handoff-adaptation`
- Local files reviewed: `project-kickoff/SKILL.md`,
  `project-manager/SKILL.md`, `implement-issue/SKILL.md`,
  `developing-web-projects/SKILL.md`, `README.md`
- External sources reviewed: GStack, SuperPowers, Compound Engineering, Matt
  Pocock Skills
- Status: implemented

## Local Baseline

Documentation and handoff behavior existed, but it was scattered.
`project-kickoff` produced direction artifacts. `project-manager` treated docs
and `DELIVERY_STATE.md` as project memory. `implement-issue` updated delivery
state and PR summaries. `developing-web-projects` defined README and AGENTS
expectations for web projects.

The gap was ownership. Each workflow repeated a slice of durable-state behavior,
but no skill said when to update docs, what each artifact is for, or what a
recoverable handoff packet must contain.

## Source Comparison

### GStack

- Source ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Files reviewed: `qa/SKILL.md`, `autoplan/SKILL.md`, `review/SKILL.md`
- Useful patterns: preserve evidence for later recovery: repro steps,
  screenshots, console output, QA findings, and explicit report/fix boundaries.
- Conflicts or risks: persistent report stores, generated preambles, telemetry,
  and runtime session machinery are too specific to GStack.
- Adoption recommendation: adopt evidence-backed handoffs, not the reporting
  machinery.

### SuperPowers

- Source ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Files reviewed: `skills/writing-plans/SKILL.md`,
  `skills/executing-plans/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`
- Useful patterns: plans and handoffs need explicit scope, files, tests, status,
  and blocker handling.
- Conflicts or risks: mandatory plan-execution choreography is too heavy for
  small local work.
- Adoption recommendation: adapt the compact handoff packet and blocker
  discipline.

### Compound Engineering

- Source ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Files reviewed: `docs/skills/ce-plan.md`,
  `docs/skills/ce-resolve-pr-feedback.md`, `README.md`
- Useful patterns: durable plans capture guardrails, decisions, scope, units,
  risks, and test scenarios; solution docs preserve useful rationale.
- Conflicts or risks: command modes, artifact schemas, and organizational
  process are heavier than this repository needs.
- Adoption recommendation: adopt durable rationale and guardrails while keeping
  runtime docs concise.

### Matt Pocock Skills

- Source ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Files reviewed: `skills/engineering/grill-with-docs/SKILL.md`,
  `skills/engineering/tdd/SKILL.md`
- Useful patterns: inspect docs/code before asking the user and sharpen
  overloaded domain language.
- Conflicts or risks: little direct handoff machinery.
- Adoption recommendation: use for decision-capture calibration and
  discoverable-context discipline.

## Questions For The User

- Should documentation/handoff become a shared owner skill or remain scattered?
  Decision: create a shared owner skill and keep workflow skills thin.
- Should all work require handoff docs?
  Decision: no. Use docs when state must survive a session, agent, PR, or later
  decision; avoid ceremony for tiny self-contained changes.
- Should README/AGENTS remain web-specific?
  Decision: no. Their roles belong in the shared documentation skill; web
  defaults may still require creating/updating them for web projects.

## Adopted Changes

- `documentation-handoff/SKILL.md`
  - Provenance entry: `2026-05-26-documentation-handoff-owner-skill`
  - Created a shared owner for artifact roles, update triggers, handoff packets,
    `DELIVERY_STATE.md`, `DECISIONS.md`, PR/issue handoffs, quality rules, and
    recovery.
- `project-manager/SKILL.md`
  - Provenance entry: `2026-05-26-documentation-handoff-owner-skill`
  - Pointed documentation and recovery mechanics to `documentation-handoff`.
- `implement-issue/SKILL.md`
  - Provenance entry: `2026-05-26-documentation-handoff-owner-skill`
  - Pointed active delivery state, PR handoff, blockers, and recovery docs to
    `documentation-handoff`.
- `project-kickoff/SKILL.md`
  - Provenance entry: `2026-05-26-documentation-handoff-owner-skill`
  - Pointed durable kickoff artifacts and decisions to `documentation-handoff`.
- `developing-web-projects/SKILL.md`
  - Provenance entry: `2026-05-26-documentation-handoff-owner-skill`
  - Clarified README/AGENTS roles by referencing the shared owner.

## Skill-Level Attribution

Created:

- `documentation-handoff/PROVENANCE.md`

Existing workflow-skill provenance remains in place; this slice changes their
cross-skill ownership boundary rather than their original source influence.

## Rejections And Deferrals

- Rejected mandatory documentation updates for tiny self-contained changes.
- Rejected chat transcripts as durable documentation.
- Rejected external persistent report stores, telemetry, generated preambles,
  command modes, and artifact schemas.
- Deferred any automated docs validator or handoff template generator.

## Verification Notes

- `[[skill-review]]` result for `documentation-handoff`: PASS.
  - Trigger is specific to durable docs and handoff state.
  - Runtime text stays operational and does not include provenance notes.
  - Skill owns documentation mechanics without taking over project direction,
    implementation, testing, or review decisions.
  - Local `[[skill-name]]` references are intended integration points.
- Validation:
  - YAML frontmatter parse passed for changed runtime skills.
  - `git diff --check` passed.
  - Runtime source/provenance leakage scan passed.
