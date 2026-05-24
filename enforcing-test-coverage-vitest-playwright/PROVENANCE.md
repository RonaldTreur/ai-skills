# Test Coverage Enforcement Provenance

This document records the source material that shaped
`enforcing-test-coverage-vitest-playwright/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Enforce one local/CI command set for Vitest coverage, builds, previews, and
   Playwright E2E.
2. Require meaningful tests for meaningful changes unless explicitly waived.
3. Keep 100% unit coverage as a default for owned TypeScript modules, with
   explicit `TEST_PLAN.md` exclusions when the metric would reduce confidence.
4. Prefer semantic Playwright locators and deterministic fixtures/auth over
   personal sessions or production data.
5. Require browser QA for changed user-visible behavior when durable E2E is
   intentionally deferred.

## Source Influence

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/tdd/SKILL.md`
- License: MIT

What we took:
- Strict feedback loops matter, but tests should remain behavior-focused and
  not exist only to satisfy a metric.

Local adaptation:
- Coverage enforcement now warns against private-structure and inert-constant
  tests and routes justified exclusions through `TEST_PLAN.md`.

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `qa/SKILL.md`
- License: MIT

What we took:
- Browser failures need artifacts, and protected flows need safe repeatable
  access before coverage can be trusted.

Local adaptation:
- Added trace/screenshot/video artifact emphasis, safe auth/fixture requirements,
  and browser-QA fallback when durable E2E is deferred.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/writing-plans/SKILL.md`
- License: MIT

What we took:
- Limited direct coverage mechanics. The useful influence was explicit plans and
  handoffs so future agents understand why a threshold or exclusion exists.

Local adaptation:
- Exclusions must be documented in `TEST_PLAN.md` or explicitly approved.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`
- License: MIT

What we took:
- Test coverage should connect to risks and scenarios, not become blind
  process.

Local adaptation:
- Coverage enforcement is tied back to `TEST_PLAN.md`, meaningful behavior, CI
  parity, and browser-QA coverage.

## Formal Trail

- `methodology/disciplines/testing-and-qa.md`
- `methodology/ADAPTATION_LOG.md`
