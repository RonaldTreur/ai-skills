---
name: testing-orchestrator
description: "Orchestrate outside-in testing for web projects: test planning, vertical behavior slices, E2E/integration tests, unit tests, fixtures/auth setup, CI verification, and handoff to browser QA. Use when turning TEST_PLAN.md or issue acceptance criteria into executable tests and verification flow."
---

# Testing Orchestrator

Conductor skill for end-to-end testing workflow across:
- [[test-planning]]
- [[e2e-playwright]]
- [[unit-vitest]]
- [[browser-qa]]

## Scope Boundary

This skill owns testing method and tooling for web projects. It does not own
GitHub issue ordering, branch/PR mechanics, merge gates, or implementation
state. Use [[project-manager]] for backlog/project decisions and
[[implement-issue]] for active per-issue execution.

## Outside-in workflow (default)

Use a plan before coding, but execute implementation in vertical behavior
slices. Avoid horizontal "write all tests first, then all code" unless the user
explicitly asks for a full test-only pass.

Default loop:

1. **Test plan**: create or read markdown scenarios in `specs/` or
   `TEST_PLAN.md`
2. **Choose one behavior**: pick the next user-visible flow, API behavior, or
   internal contract
3. **Readiness check**: confirm needed seed data, fixtures, safe auth, and
   preview/local commands exist; if not, stop and create a setup gap instead of
   faking coverage
4. **E2E/integration test**: create the smallest failing test that proves that
   behavior when user-visible or API-facing
5. **Unit tests**: add focused unit coverage for domain logic exposed by that
   behavior
6. **Implement**: inside an active issue workflow, [[implement-issue]] writes
   the minimal production code to pass
7. **Verify and refactor**: run narrow checks, refactor only while green, then
   move to the next behavior
8. **Browser QA**: for changed user-visible behavior, run or hand off to
   [[browser-qa]] before merge
9. **Heal**: use the E2E healer role only for real failures/flakes after the
   behavior slice exists

## E2E role pattern

Use the [[e2e-playwright]] role sequence when generating durable Playwright tests
from scenarios:

1. `roles/planner.md` explores or reads the target behavior and creates a
   structured markdown scenario plan.
2. `roles/generator.md` turns the scenario plan into TypeScript Playwright
   tests.
3. `roles/healer.md` diagnoses and repairs failing/flaky E2E tests after tests
   exist.

Do not force the full role sequence for tiny issue-local changes where
[[implement-issue]] can add one focused failing test directly. Do not run the
healer before there is a concrete failure to diagnose.

## Example phase prompts

### Phase 1 — Planner prompt
"Use `e2e-playwright/roles/planner.md`. Explore the live app from a fresh state and create a structured markdown test plan in `specs/<feature>-plan.md` with clear scenario titles, numbered steps, expected outcomes, and success/failure criteria."

### Phase 2 — Generator prompt
"Use `e2e-playwright/roles/generator.md`. Read `specs/<feature>-plan.md`, validate each scenario step live, and generate TypeScript Playwright tests (one test per file) with describe/title alignment to the plan and comments before each step."

### Phase 3 — Healer prompt
"Use `e2e-playwright/roles/healer.md`. Run all Playwright tests, debug each failing test, apply minimal robust fixes, re-run to verify, and mark `test.fixme()` only when the app is likely broken (with comment)."

## Auth, Fixtures, And Test Data

Tests must use safe, repeatable state:

- prefer seeded local users, fixtures, mocked external services, reset scripts,
  and local preview auth paths
- keep storage state, cookies, passwords, tokens, and magic links out of git and
  out of reports
- do not use the user's personal session or production credentials as the
  default way to test
- if CAPTCHA, 2FA, paid services, missing seed data, or account approval blocks
  coverage, mark the flow blocked and route setup work through
  [[project-manager]]

Authenticated behavior is not "covered" until the test or browser-QA path can
reach it safely and repeatably.

## `seed.spec.ts` convention
- Seed template lives at: `e2e-playwright/templates/seed.spec.ts`
- Use this template when bootstrapping generator output shape
- Keep generated tests TypeScript-only and framework-agnostic

## Script conventions (`package.json`)

```json
{
  "scripts": {
    "test": "npm run test:all",
    "test:all": "npm run test:unit && npm run test:e2e",
    "test:unit": "vitest run",
    "test:unit:watch": "vitest",
    "test:unit:coverage": "vitest run --coverage",
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui"
  }
}
```

## Coverage policy

- Default enforcement: 100% lines/statements/functions/branches for owned
  TypeScript modules.
- Exclusions must be explicit in `TEST_PLAN.md` with rationale.
- Ask before lowering thresholds globally.
- Do not chase meaningless coverage by testing private structure. Prefer public
  behavior, edge cases, and failure paths.

## CI/CD policy
- Use the same scripts locally and in GitHub Actions
- Install browsers in CI before E2E
- Store artifacts (trace/screenshots/videos) on failures
- Ensure CI has deterministic fixtures, seed data, and preview commands before
  relying on E2E coverage

## When E2E or unit tests may not make sense
- Skip E2E only for non-user-visible/internal-only changes
- Skip unit tests only for thin wiring with negligible branch logic
- If uncertain, include both or ask for explicit approval to skip
- Browser QA is still required for changed user-visible browser behavior even
  when durable E2E coverage is intentionally deferred

## Stack alignment
- TypeScript-first examples
- Framework-agnostic tests
- Compatible with vanilla HTML/CSS, Web Components, MPA, and Cloudflare-first projects
