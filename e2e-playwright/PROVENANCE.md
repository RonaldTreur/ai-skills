# E2E Playwright Provenance

This document records the source material that shaped `e2e-playwright/SKILL.md`
and its role files.

## Rebuild Recipe

Keep these behaviors:

1. Own durable automated Playwright E2E tests, not exploratory browser QA.
2. Use planner/generator/healer roles for scenario-driven E2E generation and
   repair when they add confidence.
3. Allow tiny issue-local changes to add one focused failing Playwright test
   directly through `implement-issue` or `testing-orchestrator`.
4. Prefer semantic locators, deterministic fixtures, built app previews, and CI
   artifacts.
5. Treat missing safe auth, seed data, reset scripts, or preview setup as
   blocked coverage, not a reason to weaken tests.

## Source Influence

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `qa/SKILL.md`
- License: MIT

What we took:
- Browser-level verification needs real app access, evidence, and explicit
  blocker handling for auth, data, and environment problems.

Local adaptation:
- E2E guidance now treats missing auth/fixtures/preview setup as blocked
  coverage and routes setup gaps through `project-manager` or
  `implement-issue`.

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/tdd/SKILL.md`
- License: MIT

What we took:
- Tests should verify behavior through public/user-facing interfaces and keep
  the feedback loop tight.

Local adaptation:
- Kept the role pattern for larger E2E generation but allowed focused
  issue-local failing tests when the full role sequence adds ceremony.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/subagent-driven-development/SKILL.md`
- License: MIT

What we took:
- Delegated test roles need clear scope, outputs, and escalation when blocked.

Local adaptation:
- The healer now distinguishes app bugs and setup blockers from test bugs
  instead of silently rewriting tests to pass.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`
- License: MIT

What we took:
- Scenario plans are guardrails, not brittle implementation scripts.

Local adaptation:
- The E2E role pattern preserves traceability from markdown scenarios to tests
  while keeping implementation details adaptable to the current UI.

## Formal Trail

- `methodology/disciplines/testing-and-qa.md`
- `methodology/ADAPTATION_LOG.md`
