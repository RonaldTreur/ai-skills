# Test Planning Provenance

This document records the implementation-lifecycle changes to
`test-planning/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Own test strategy and coverage planning.
2. Require human approval for new-project or standalone `TEST_PLAN.md` work.
3. Allow issue-local test additions inside an approved implementation workflow when they
   stay within issue acceptance criteria.
4. Ask when test planning changes product scope or user-visible behavior.
5. Plan auth, fixtures, seed data, browser-QA scope, CI, and coverage exclusions
   before feature issues depend on them.

## Source Influence

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `qa/SKILL.md`, `autoplan/SKILL.md`
- License: MIT

What we took:
- Browser QA and test planning should name blocked coverage explicitly instead
  of implying full coverage when login, seed data, or app access is missing.
- Useful plans surface setup gaps before implementation proceeds.

Local adaptation:
- `TEST_PLAN.md` now includes browser-QA scope, safe auth/test-data needs, CI
  commands, and blocked coverage/exclusions.

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/tdd/SKILL.md`
- License: MIT

What we took:
- Test plans should organize work around vertical behavior slices and public
  interfaces, not private implementation structure.

Local adaptation:
- `TEST_PLAN.md` planning now calls out one behavior, failing public-interface
  test, minimal implementation, focused unit coverage, and browser QA when the
  behavior is user-visible.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/writing-plans/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`
- License: MIT

What we took:
- Little direct test-planning mechanics. The useful influence was mostly
  boundary discipline: plans should make scope, blockers, and handoff context
  explicit for later agents.

Local adaptation:
- Kept `test-planning` as strategy and readiness planning, not active
  implementation or delegation.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`
- License: MIT

What we took:
- Plans are durable guardrails: they should preserve scope, risks, decisions,
  and test scenarios without over-prescribing code.

Local adaptation:
- `TEST_PLAN.md` records strategy, coverage intent, setup gaps, and exclusions
  while leaving issue-local test execution to `testing-orchestrator` and
  `implement-issue`.

### Existing Local Skills

- `implement-issue/SKILL.md`
- `project-manager/SKILL.md`
- `browser-qa/SKILL.md`
- `testing-orchestrator/SKILL.md`

What we took:
- The implementation workflow has standing authority for ready issue-local implementation,
  but project-level test strategy remains a human-approved artifact.
- Project readiness and browser QA require explicit test data/auth planning, not
  late discovery during QA.

## Formal Trail

- `methodology/disciplines/implementation-lifecycle.md`
- `methodology/disciplines/testing-and-qa.md`
- `methodology/ADAPTATION_LOG.md`
