# Discipline Review: GitHub Issue Automation

- Date: 2026-05-26
- Reviewer: Merlin
- Branch: `feat/gh-pipeline-adaptation`
- Local files reviewed: local OpenClaw `gh-pipeline` skill,
  `project-manager/SKILL.md`, `implement-issue/SKILL.md`,
  `testing-orchestrator/SKILL.md`, `code-review/SKILL.md`,
  `agent-delegation/SKILL.md`
- External sources reviewed: GStack, SuperPowers, Compound Engineering, Matt
  Pocock Skills
- Status: implemented

## Local Baseline

The local workspace already had a practical `gh-pipeline` skill, but this
repository did not. The workspace version contained useful labels, transitions,
prompt templates, cron setup notes, and guard rails, but it duplicated behavior
now owned by the adapted lifecycle skills.

After the agent-delegation slice, the right shape is a pipeline owner that
controls GitHub state and dispatches to existing owner skills instead of
embedding full implementation, testing, and review prompts.

## Source Comparison

### GStack

- Source ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Files reviewed: `review/SKILL.md`, `autoplan/SKILL.md`, plan-review skill
  family from source inventory
- Useful patterns: specialist review and planning gates can surface close calls
  before work is treated as merge-ready.
- Conflicts or risks: generated preambles, telemetry, routing tiers, and session
  machinery are runtime-specific and too heavy for this repository.
- Adoption recommendation: keep review/plan gates as stage ideas; reject the
  runtime machinery.

### SuperPowers

- Source ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Files reviewed: `skills/subagent-driven-development/SKILL.md`,
  `skills/requesting-code-review/SKILL.md`,
  `skills/dispatching-parallel-agents/SKILL.md`
- Useful patterns: delegated agents need explicit context, status, constraints,
  and independent review before their work is trusted.
- Conflicts or risks: mandatory subagent choreography and pasted full context
  would make a label pipeline too ceremonial.
- Adoption recommendation: adapt the stage handoff and review discipline through
  `agent-delegation` and `code-review`.

### Compound Engineering

- Source ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Files reviewed: `plugins/compound-engineering/skills/ce-compound/SKILL.md`,
  `plugins/compound-engineering/skills/ce-code-review/references/subagent-template.md`
- Useful patterns: controller owns synthesis and final state; leaf work has
  strict output expectations.
- Conflicts or risks: artifact schema, command-mode machinery, and heavy
  orchestration are specific to Compound.
- Adoption recommendation: adopt controller/stage boundaries without importing
  schemas or tool assumptions.

### Matt Pocock Skills

- Source ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Files reviewed: `skills/engineering/tdd/SKILL.md`,
  `skills/engineering/grill-with-docs/SKILL.md`
- Useful patterns: keep loops small, behavior-focused, and grounded in
  evidence; ask when needed context cannot be discovered.
- Conflicts or risks: little direct label-pipeline guidance.
- Adoption recommendation: use as calibration for `status:blocked` and
  evidence-before-transition behavior.

## Questions For The User

- Should the label pipeline replace `project-manager` next-work selection?
  Decision: no. It starts only when an issue has entered the agent pipeline.
- Should this create labels and cron jobs automatically?
  Decision: no. Ask before bulk label creation or automation setup.
- Should the runtime skill include full per-stage prompt templates?
  Decision: no. Route stages to existing owner skills and keep prompt mechanics
  in `agent-delegation`.

## Adopted Changes

- `gh-pipeline/SKILL.md`
  - Provenance entry: `2026-05-26-gh-pipeline-owner-skill`
  - Created a dedicated owner for label state, locks, transitions, recovery,
    setup checks, and pipeline status output.
- `README.md`
  - Provenance entry: `2026-05-26-gh-pipeline-readme-pointer`
  - Added a short pointer explaining the skill's place in the lifecycle.

## Skill-Level Attribution

Created:

- `gh-pipeline/PROVENANCE.md`

## Rejections And Deferrals

- Rejected copying implementation-heavy prompt templates into the runtime skill.
- Rejected automatic label creation, cron setup, deployment, or release actions
  without explicit approval.
- Rejected treating `gh-pipeline` as a replacement for issue decomposition,
  implementation, test strategy, review, or delegation owner skills.
- Deferred concrete orchestrator scripts/config to a later implementation pass
  if Ronald wants to operationalize this beyond skill guidance.

## Verification Notes

- `[[skill-review]]` result for `gh-pipeline`: PASS.
  - Trigger is specific to label-driven GitHub issue automation.
  - Runtime text is operational and excludes source/provenance notes.
  - Skill stays under the lifecycle owner skills instead of duplicating them.
  - Safety boundaries require approval for bulk label/config/production actions.
- Validation:
  - YAML frontmatter parse passed for `gh-pipeline/SKILL.md`.
  - `git diff --check` passed.
  - Runtime source/provenance leakage scan passed.
