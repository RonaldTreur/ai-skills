---
name: test-ci-policy
description: "Configure or review project-wide test scripts, CI entrypoints, coverage thresholds, package-manager parity, and Vitest/Playwright enforcement policy. Use when setting up or auditing the testing enforcement layer, not for routine feature implementation or ordinary test writing."
---

# Test CI Policy

Use this skill when a project needs a reliable enforcement layer for tests:
package scripts, CI commands, coverage thresholds, Playwright artifacts, and
local/CI parity.

Do not use this as the default workflow for every code change. For day-to-day
test work, use the owner skill for the task:

- [[test-planning]] owns `TEST_PLAN.md`, coverage intent, exclusions, auth/test
  data readiness, and browser-QA scope.
- [[testing-orchestrator]] owns outside-in execution across E2E, integration,
  unit, and browser-QA verification.
- [[unit-vitest]] owns behavior-focused Vitest unit/integration tests.
- [[e2e-playwright]] owns durable Playwright E2E tests, fixtures, locators,
  storage state, and E2E artifacts.
- [[browser-qa]] owns exploratory browser verification and QA evidence.

## When To Use

Use this skill for:

- new project test/CI setup
- changing package-manager or script conventions
- adding or reviewing CI jobs for tests
- setting or auditing coverage thresholds
- deciding how `TEST_PLAN.md` exclusions map to coverage config
- making local and CI commands identical
- reviewing whether a project can honestly enforce its test policy

Do not use this skill merely because a feature changed. If scripts, CI, or
coverage policy are already established, the active implementation or testing
skill should run the existing commands directly.

## Policy Boundary

This skill owns enforcement plumbing, not test strategy or test content.

- It may define commands, thresholds, CI artifacts, and gates.
- It may reject enforcement that cannot run safely and repeatably.
- It must not pretend protected flows are covered without safe auth, fixtures,
  seed data, reset support, or a documented browser-QA path.
- It must not lower standards silently. Threshold reductions and exclusions need
  `TEST_PLAN.md` rationale or explicit user approval.

## Default Script Shape

Prefer one local command set that CI also calls:

```json
{
  "scripts": {
    "test": "npm run test:all",
    "test:all": "npm run test:unit && npm run test:e2e",
    "test:unit": "vitest run",
    "test:unit:watch": "vitest",
    "test:unit:coverage": "vitest run --coverage",
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui",
    "build": "vite build",
    "preview": "vite preview --port 4173 --strictPort"
  }
}
```

Rules:

- Use existing project commands when they already exist.
- Use `npm` by default.
- Use `pnpm` for monorepos.
- Only add Vite `build` or `preview` scripts when the project uses Vite.
- If the build system is unclear, inspect the project before choosing.

## Coverage Thresholds

Default Vitest coverage thresholds for owned TypeScript modules:

- lines: 100
- statements: 100
- functions: 100
- branches: 100

Exclusions are acceptable only when they increase signal:

- generated files
- framework wiring with no meaningful branch logic
- integration-only boundaries already covered elsewhere
- code that cannot be exercised safely in the current project setup

Every exclusion needs a visible rationale in `TEST_PLAN.md` or explicit user
approval. Do not satisfy thresholds by testing private structure, inert
constants, or implementation trivia.

## CI Requirements

CI must call the same scripts humans run locally.

npm example:

```yaml
- run: npm ci
- run: npm run test:unit:coverage
- run: npm run build
- run: npm run test:e2e
```

pnpm monorepo example:

```yaml
- run: pnpm install --frozen-lockfile
- run: pnpm run test:unit:coverage
- run: pnpm run build
- run: pnpm run test:e2e
```

For Playwright in CI:

- install browsers before E2E
- collect trace, screenshot, or video artifacts on failure
- test against a built preview unless the project requires dev mode
- avoid personal sessions, production credentials, and shared mutable staging
  records

## Enforcement Review

When auditing a project, answer these questions:

1. Can a fresh checkout install, build, and run the same tests locally and in CI?
2. Do coverage thresholds reflect `TEST_PLAN.md`, or are agents gaming metrics?
3. Can protected flows be reached through safe repeatable auth/test data?
4. Are E2E failure artifacts preserved in CI?
5. Are skipped tests, `test.fixme()`, and coverage exclusions explained?
6. Does browser QA cover any user-visible behavior that durable E2E deliberately
   defers?

If any answer is no, create or recommend setup work instead of claiming the
project is fully covered.
