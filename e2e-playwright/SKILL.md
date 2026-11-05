---
name: e2e-playwright
description: "Write and maintain durable Playwright E2E tests for web apps, including user flows, CI coverage, flaky-test repair, fixtures, auth, and storage state. Use browser-qa for exploratory checks."
---

# E2E Testing with Playwright

Use this skill to validate real user behavior in browser flows.

Related workflow: [[testing]]

## Role Pattern

Use the three specialized roles when generating or repairing durable
scenario-driven E2E coverage:

1. **Planner** → explores the live app and writes a structured markdown plan in `specs/`
2. **Generator** → reads that plan and generates TypeScript Playwright tests in `tests/e2e/`
3. **Healer** → runs all tests, debugs failures, and repairs tests until stable

For tiny issue-local changes, [[implement-issue]] or [[testing]]
may add one focused failing Playwright test directly. Do not force the full role
sequence when it would add ceremony without improving confidence.

Role guides:
- `roles/planner.md`
- `roles/generator.md`
- `roles/healer.md`

When the role files are assigned to separate agents, use
`references/delegation.md` under [[project-manager]] for the task packet,
write scope, status, and blocker reporting.

## Golden rules
- Prefer `getByRole()` locators first
- Never use `waitForTimeout`
- Isolate tests (no shared mutable state)
- Prefer fixtures over globals
- Mock external services only
- Test against built app (not ad-hoc dev state)
- Auth, storage state and test data follow [[testing]]; use storage state only
  when the project documents how it is generated, refreshed and kept out of git

## Conventions
- Framework-agnostic guidance only
- Tests live in `tests/e2e/`
- Use TypeScript test files (`*.spec.ts`)
- Use `templates/seed.spec.ts` as the seed format for generator bootstrap

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
