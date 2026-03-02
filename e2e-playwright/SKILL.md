---
name: e2e-playwright
description: Write and maintain Playwright E2E tests for web applications. Use when implementing end-to-end tests, testing user flows, or validating browser behavior.
---

# E2E Testing with Playwright

Use this skill to validate real user behavior in browser flows.

Related workflow: [[testing-orchestrator]]

## 3-agent pattern (Microsoft-style, adapted for OpenClaw)
Use three specialized roles in sequence:
1. **Planner** → explores the live app and writes a structured markdown plan in `specs/`
2. **Generator** → reads that plan and generates TypeScript Playwright tests in `tests/`
3. **Healer** → runs all tests, debugs failures, and repairs tests until stable

Role guides:
- `roles/planner.md`
- `roles/generator.md`
- `roles/healer.md`

These role files define **agent behavior**. The guides below remain your **reference knowledge** for implementation details.

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
