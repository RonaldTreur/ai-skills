---
name: e2e-playwright
description: "Write and maintain durable Playwright E2E tests for web applications. Use when implementing automated browser tests, generating scenario-driven E2E coverage, validating user flows in CI, repairing flaky Playwright tests, or setting up fixtures/auth/storage state for repeatable browser tests. Do not use for exploratory browser QA reports; use browser-qa for that."
---

# E2E Testing with Playwright

Use this skill to validate real user behavior in browser flows.

Related workflow: [[testing-orchestrator]]
Related delegation workflow: [[agent-delegation]]

## Role Pattern

Use the three specialized roles when generating or repairing durable
scenario-driven E2E coverage:

1. **Planner** → explores the live app and writes a structured markdown plan in `specs/`
2. **Generator** → reads that plan and generates TypeScript Playwright tests in `tests/`
3. **Healer** → runs all tests, debugs failures, and repairs tests until stable

For tiny issue-local changes, [[implement-issue]] or [[testing-orchestrator]]
may add one focused failing Playwright test directly. Do not force the full role
sequence when it would add ceremony without improving confidence.

Role guides:
- `roles/planner.md`
- `roles/generator.md`
- `roles/healer.md`

These role files define **agent behavior**. The guides below remain your **reference knowledge** for implementation details.

When the role files are assigned to separate agents, use [[agent-delegation]]
for the task packet, write scope, status, and blocker reporting.

## Golden rules
- Prefer `getByRole()` locators first
- Never use `waitForTimeout`
- Isolate tests (no shared mutable state)
- Set `baseURL` in Playwright config
- Retries: `2` in CI, `0` locally
- Traces on first retry
- Prefer fixtures over globals
- One behavior per test
- Mock external services only
- Test against built app (not ad-hoc dev state)
- Keep auth, storage state, generated data, passwords, tokens, and cookies out
  of git and out of reports
- Do not use the user's personal browser session or production credentials as
  the default E2E auth path
- If a protected flow lacks safe test auth, seed data, or reset support, mark
  the coverage blocked and route setup work through [[project-manager]]

## Conventions
- Framework-agnostic guidance only
- Tests live in `tests/e2e/`
- Use TypeScript test files (`*.spec.ts`)
- Use `templates/seed.spec.ts` as the seed format for generator bootstrap
- Prefer seeded users, fixtures, reset scripts, mocked external services, and
  local/preview auth paths for deterministic state
- Use storage state only when the project documents how it is generated,
  refreshed, and excluded from git

## Recommended config defaults

```ts
import { defineConfig } from '@playwright/test';

export default defineConfig({
	testDir: 'tests/e2e',
	use: {
		baseURL: 'http://127.0.0.1:4173',
		trace: 'on-first-retry'
	},
	retries: process.env.CI ? 2 : 0
});
```

## Guides
- `guides/locators.md`
- `guides/assertions.md`
- `guides/fixtures.md`
- `guides/network.md`
- `guides/data.md`
- `guides/debugging.md`
- `guides/ci.md`
