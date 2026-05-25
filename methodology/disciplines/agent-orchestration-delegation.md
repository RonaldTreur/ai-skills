# Discipline Review: Agent Orchestration and Delegation

- Date: 2026-05-25
- Reviewer: Merlin
- Branch: `feat/delegation-adaptation`
- Local files reviewed: `implement-issue/SKILL.md`,
  `project-manager/SKILL.md`, `project-kickoff/SKILL.md`,
  `testing-orchestrator/SKILL.md`, `e2e-playwright/SKILL.md`,
  `frontend-design/SKILL.md`, `code-review/SKILL.md`
- External sources reviewed: GStack, SuperPowers, Compound Engineering, Matt
  Pocock Skills
- Status: implemented

## Local Baseline

Delegation guidance existed, but it was scattered. `implement-issue` carried
the clearest implementation-agent handoff. `project-manager` described compact
issue handoffs and parallel candidate identification. `project-kickoff`
described sub-agent use for critique and divergent concepts. `testing-orchestrator`
and `e2e-playwright` described planner/generator/healer role files.

The problem was not missing behavior; it was duplicated mechanics. Each owner
skill had to remember context packets, write scopes, status vocabulary,
parallel safety, and integration review.

## Source Comparison

### GStack

- Source ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Files reviewed: `review/SKILL.md`, `autoplan/SKILL.md`, plan-review skill
  family, source inventory notes on dispatch tiers
- Useful patterns: specialist review and planning passes can surface risks,
  close calls, and cross-functional concerns before work proceeds.
- Conflicts or risks: generated preambles, routing tiers, telemetry, session
  stores, and platform runtime assumptions are too broad for local runtime
  skills.
- Adoption recommendation: keep optional specialist passes, not the runtime
  machinery.

### SuperPowers

- Source ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Files reviewed: `skills/dispatching-parallel-agents/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`,
  `skills/subagent-driven-development/implementer-prompt.md`,
  `skills/subagent-driven-development/spec-reviewer-prompt.md`,
  `skills/subagent-driven-development/code-quality-reviewer-prompt.md`
- Useful patterns: independent domains can run in parallel; delegated tasks need
  explicit context, constraints, expected output, status vocabulary, and review
  before integration.
- Conflicts or risks: always-on task dispatch, mandatory review choreography,
  subagent commits, and pasted full plan text can become ceremony.
- Adoption recommendation: adapt the packet, status, escalation, and
  parallel-safety discipline into one local owner skill.

### Compound Engineering

- Source ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Files reviewed: `plugins/compound-engineering/skills/ce-code-review/references/subagent-template.md`,
  `plugins/compound-engineering/skills/ce-compound/SKILL.md`
- Useful patterns: leaf agents should have strict output contracts; orchestrators
  own synthesis, integration, and final writes.
- Conflicts or risks: JSON schemas, artifact directories, and command-mode
  machinery are specific to Compound workflows.
- Adoption recommendation: adopt controller/leaf-agent boundaries and compact
  return expectations without importing the schema machinery.

### Matt Pocock Skills

- Source ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Files reviewed: `skills/engineering/grill-with-docs/SKILL.md`,
  `skills/engineering/tdd/SKILL.md`
- Useful patterns: ask only when context cannot be discovered; keep loops small,
  behavior-focused, and falsifiable.
- Conflicts or risks: little direct delegation mechanics.
- Adoption recommendation: use as calibration for when delegates should report
  `NEEDS_CONTEXT` instead of guessing.

## Questions For The User

- Should delegation be a new owner skill or remain duplicated in each workflow?
  Decision: make it a new shared owner skill and keep workflow skills thin.
- Should mandatory two-stage subagent review be required for all delegated work?
  Decision: no; keep review proportional and let `code-review`/owner skills
  decide the verification depth.
- Should this make multi-agent work more common?
  Decision: no; the skill is a protocol for justified delegation, not a
  recommendation to delegate.

## Adopted Changes

- `agent-delegation/SKILL.md`
  - Provenance entry: `2026-05-25-agent-delegation-owner-skill`
  - Created one shared owner for delegation packets, write scope, parallel
    safety, statuses, controller duties, and prompt shape.
- `implement-issue/SKILL.md`
  - Delegation section now points to `agent-delegation` and keeps only
    implementation-specific defaults such as Vectrix-first routing.
- `project-manager/SKILL.md`
  - Issue handoff and parallel-candidate guidance now reference
    `agent-delegation` for mechanics.
- `project-kickoff/SKILL.md`
  - Sub-agent pattern now delegates prompt/status/parallel mechanics to
    `agent-delegation`.
- `testing-orchestrator/SKILL.md` and `e2e-playwright/SKILL.md`
  - E2E role-agent use now points to `agent-delegation`.
- `frontend-design/SKILL.md`
  - Variant or critique agents now point to `agent-delegation`.

## Skill-Level Attribution

Created:

- `agent-delegation/PROVENANCE.md`

Existing skill provenance remains in place for owner skills that now reference
the shared delegation mechanics.

## Rejections And Deferrals

- Rejected mandatory subagent dispatch for every implementation plan.
- Rejected making multi-agent workflows the default for ordinary work.
- Rejected requiring delegated agents to commit by default.
- Rejected importing external task tools, generated preambles, telemetry,
  session stores, artifact schemas, or always-on routing tiers.
- Deferred GitHub label/state-machine automation to the `gh-pipeline` slice.

## Verification Notes

- `[[skill-review]]` result for `agent-delegation`: PASS.
  - Runtime text is operational, not provenance-flavored.
  - Trigger is specific to delegating work, not general project management.
  - Local `[[skill-name]]` references are intentional integration points.
- Validation:
  - YAML frontmatter parse passed for changed runtime skills.
  - `git diff --check` passed.
