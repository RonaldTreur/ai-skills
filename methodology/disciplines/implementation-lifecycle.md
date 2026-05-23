# Discipline Review: Implementation Lifecycle

- Date: 2026-05-23
- Reviewer: Merlin
- Branch: `feat/implementation-lifecycle-methodology`
- Local files reviewed: `project-manager/SKILL.md`,
  `implement-issue/SKILL.md`,
  `codex-implementation-cycle/SKILL.md`, `developing-web-projects/SKILL.md`,
  `testing-orchestrator/SKILL.md`, `test-planning/SKILL.md`,
  `external-skill-adaptation/templates/discipline-review.md`
- External sources reviewed: GStack, SuperPowers, Compound Engineering, Matt
  Pocock Skills
- Status: implemented

## Local Baseline

Before this pass, implementation behavior was split across several overlapping
skills. `project-manager` described a full lifecycle but was too broad for
active issue execution. `implement-issue` already represented the
newer GitHub-issue execution path. `codex-implementation-cycle` was an older
Codex-specific implementation workflow that overlapped with implement-issue.
`developing-web-projects`, `testing-orchestrator`, and `test-planning`
contained implementation-adjacent rules that needed clearer ownership
boundaries.

## Source Comparison

### GStack

- Source ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Files reviewed: `autoplan/SKILL.md`, `plan-*` review skills
- Useful patterns: plan review should surface close calls, unresolved decisions,
  and cross-functional risks before implementation proceeds.
- Conflicts or risks: source includes runtime/tooling assumptions, generated
  preambles, telemetry/update behavior, and setup machinery that should not be
  imported into local runtime skills.
- Adoption recommendation: adapt planning/review principles only; reject runtime
  scaffolding.

### SuperPowers

- Source ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Files reviewed: `skills/writing-plans/SKILL.md`,
  `skills/executing-plans/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`,
  `skills/subagent-driven-development/implementer-prompt.md`
- Useful patterns: clear plan scope, small steps, delegated implementation with
  explicit context, escalation statuses, and spec review before quality review.
- Conflicts or risks: plan-writing guidance can over-prescribe exact files,
  code snippets, commands, and implementation order.
- Adoption recommendation: adapt delegation/status/review discipline without
  copying brittle choreography.

### Compound Engineering

- Source ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Files reviewed: `docs/skills/ce-plan.md`
- Useful patterns: plans should capture guardrails, decisions, scope, units,
  risks, and test scenarios; implementation should decide the current code-level
  details.
- Conflicts or risks: heavier multi-agent organization pattern can add ceremony
  if copied wholesale.
- Adoption recommendation: adopt the planning boundary: record WHAT and
  guardrails, avoid stale HOW.

### Matt Pocock Skills

- Source ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Files reviewed: `skills/engineering/tdd/SKILL.md`,
  `skills/deprecated/request-refactor-plan/SKILL.md`
- Useful patterns: behavior-first TDD through public interfaces, vertical
  tracer bullets, and small refactor plans.
- Conflicts or risks: low risk; adapt language to the local implement-issue
  workflow
  and avoid making every issue a heavy ceremony.
- Adoption recommendation: adopt vertical behavior-first slices in active
  implementation and outside-in testing.

## Questions For Ronald

- Should `codex-implementation-cycle` remain as a compatibility alias?
  Decision: no; `implement-issue` supersedes it.
- Should `project-manager` become more assertive now that it has not been used?
  Decision: yes; narrow it to project lifecycle and backlog ownership.
- Should outside-in development align with Matt's behavior-first TDD?
  Decision: yes; use vertical behavior slices rather than horizontal test/code
  batches.

## Adopted Changes

- `implement-issue/SKILL.md`
  - Provenance entries:
    `2026-05-23-implementation-superpowers-delegation`,
    `2026-05-23-implementation-matt-vertical-tdd`,
    `2026-05-23-implementation-compound-guardrails`,
    `2026-05-23-implementation-remove-codex-alias`
  - Became the canonical active-issue implementation workflow.
  - Reads broad project docs only when they are linked, missing from handoff,
    stale, or needed for a concrete implementation question.
- `project-manager/SKILL.md`
  - Provenance entries:
    `2026-05-23-implementation-project-manager-boundary`,
    `2026-05-23-implementation-compound-guardrails`
  - Became the lifecycle/backlog/status owner and now hands selected issues to
    `implement-issue` with compact context.
- `codex-implementation-cycle/SKILL.md`
  - Provenance entry: `2026-05-23-implementation-remove-codex-alias`
  - Removed as an obsolete Codex-specific alias.
- `developing-web-projects/SKILL.md`
  - Provenance entry: `2026-05-23-implementation-web-boundary`
  - Clarified that web defaults are not implementation state management.
- `testing-orchestrator/SKILL.md`
  - Provenance entry: `2026-05-23-implementation-matt-vertical-tdd`
  - Aligned outside-in testing with vertical behavior slices.
- `test-planning/SKILL.md`
  - Provenance entry: `2026-05-23-implementation-test-planning-boundary`
  - Clarified planning approval versus issue-local test additions.
- `external-skill-adaptation/templates/discipline-review.md`
  - Provenance entry:
    `2026-05-23-implementation-template-adopted-changes`
  - Renamed `Recommended Adaptations` to `Adopted Changes`.

## Skill-Level Attribution

Created or updated:

- `implement-issue/PROVENANCE.md`
- `project-manager/PROVENANCE.md`
- `developing-web-projects/PROVENANCE.md`
- `testing-orchestrator/PROVENANCE.md`
- `test-planning/PROVENANCE.md`
- `external-skill-adaptation/PROVENANCE.md`

## Rejections And Deferrals

- Rejected wholesale GStack runtime scaffolding, hooks, generated preambles, and
  telemetry/update assumptions.
- Rejected brittle plan choreography that pre-writes exact implementation code
  or stale command sequences.
- Rejected keeping `codex-implementation-cycle` as a compatibility alias because
  it preserves duplicate ownership and Codex-specific framing.
- Deferred a deeper project-lifecycle monitoring pass; this pass only clarified
  lifecycle ownership and active implementation boundaries.

## Verification Notes

- `[[skill-review]]` result for changed runtime skills: PASS.
  - Reviewed `project-manager`, `implement-issue`,
    `developing-web-projects`, `testing-orchestrator`, and `test-planning`.
  - No Critical or Important findings remained.
  - Follow-up review removed runtime history, runtime-specific review labels,
    imprecise Vectrix/subagent wording, README history, and duplicate broad-doc
    intake.
  - Local `[[skill-name]]` references were intentionally ignored as approved
    repository integration points.
- Validation:
  - YAML frontmatter parse passed for changed runtime skills.
  - `git diff --check` passed.
  - Historical references to `codex-implementation-cycle` remain only where they
    explain the deletion/supersession.
