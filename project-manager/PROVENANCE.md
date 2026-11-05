# Project Manager Provenance

This document records the source material that shaped
`project-manager/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Own project lifecycle, not per-issue implementation execution.
2. Use GitHub Issues and repo-local docs as durable project memory.
3. Decompose approved project docs into small, dependency-aware issues.
4. Recommend next ready work from priority, dependencies, milestone, size, and
   age.
5. Hand selected issues to `implement-issue` with compact context.
6. Ask before bulk GitHub mutations, project-scope changes, or product
   decisions.
7. Treat runnable commands, CI, test data, safe auth, and browser-QA access as
   project readiness concerns, not late implementation surprises.
8. Recover stale project state from GitHub truth first, then local handoff
   files.
9. Use kickoff artifacts as the main research/discovery input; project-manager
   only refreshes repo, issue, PR, memory, or external context when it can
   change backlog or next-work decisions.

## Source Influence

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`
- License: MIT

What we took:
- Plans as durable guardrails, with scope, units, risks, and test scenarios.
- Separate planning ownership from execution ownership.

Local adaptation:
- `project-manager` now manages durable project structure and hands selected
  issues to `implement-issue` with compact context.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/writing-plans/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`
- License: MIT

What we took:
- Small independent tasks, explicit scope, testing decisions, and stop/blocked
  behavior.

Local adaptation:
- Kept the issue/project lifecycle shape, but removed the previous detailed
  implementation choreography from this skill.

### Existing Local Skills

- `start-new-project/SKILL.md`
- `implement-issue/SKILL.md`
- `browser-qa/SKILL.md`
- `test-planning/SKILL.md`
- `developing-web-projects/SKILL.md`

What we took:
- Kickoff docs, test-plan approvals, browser-QA readiness, web defaults, and
  implementation handoff boundaries.

### Local Browser QA Readiness Decision

- Source: local project lifecycle discussion
- Reviewed ref: `2026-05-24 #claw-enhance`
- License: repository-local decision

What we took:
- Auth, seed data, local commands, CI, preview workflows, and browser-QA access
  must be planned before feature issues depend on them.

Local adaptation:
- `project-manager` now checks project readiness before feature decomposition
  and creates setup issue drafts for missing verification infrastructure.

### Research And Discovery Fold-In

- Source: local research/discovery review
- Reviewed ref: `feat/research-discovery-adaptation` on 2026-05-27
- Reviewed material: `methodology/disciplines/research-and-discovery.md`,
  `start-new-project/SKILL.md`
- License: repository-local decision

What we took:
- Early research/discovery belongs in `start-new-project`, where it can shape the
  brief, design direction, and planning guardrails.
- Project-manager should refresh research or memory only when it changes
  backlog, scope, priority, setup, or next-work decisions.

Local adaptation:
- Added narrow intake and stale-state recovery language without turning
  project-manager into another research router.

## Formal Trail

- `methodology/disciplines/implementation-lifecycle.md`
- `methodology/disciplines/project-lifecycle-monitoring.md`
- `methodology/disciplines/research-and-discovery.md`
- `methodology/ADAPTATION_LOG.md`

## Local Integration Decision (2026-11-03)

Skills stay harness-agnostic and describe the work and its gates, never who
performs them (see `methodology/disciplines/role-script-removal-2026-11.md`).
In this skill, the Default Agent Roles section (Merlin, Vectrix, Claude-review, loop-evidence precondition) became a Merge Gate stated as three required artifacts; the compact prompt and the delegate-return rule lost their role names.

## Local Integration Decision (2026-11-05)

Two skills folded in (see `methodology/disciplines/small-merges-2026-11.md`):

- `add-feature` (339 words, created 2026-05 from local workflow discussion)
  became the Feature Intake section: classify an existing-project feature
  request, create the smallest issue shape, continue at dependency ordering.
- `agent-delegation` (789 words) became `references/delegation.md`, read only
  when another agent will do the work. Its sources carry over: SuperPowers
  (`f2cbfbefebbfef77321e4c9abc9e949826bea9d7`, MIT: one problem domain per
  agent, explicit context and output, status vocabulary, review before
  integration); Compound Engineering
  (`5297a9440fa009822ceef8052b9e644e782281e1`, MIT: strict output contracts,
  compact summaries to the orchestrator, orchestrator owns final writes);
  GStack (`61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`, MIT: optional specialist
  passes); Matt Pocock (`b8be62ffacb0118fa3eaa29a0923c87c8c11985c`, MIT: ask
  only when a decision needs human input). The local restraint rule from
  2026-05-25 (delegation is a protocol, not a default) stays as the reference's
  first paragraph. Rejected upstream material is recorded in
  `methodology/disciplines/agent-orchestration-delegation.md`.

## Local Integration Decision (2026-11-05, skill-review pass)

Trimmed per `methodology/disciplines/skill-review-pass-2026-11.md`: rules
stated once, environment facts the agent can look up removed, branch-only
material moved behind gated references, harness-specific names removed. The
findings and the fixes applied are listed there per skill.
