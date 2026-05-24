---
name: unit-vitest
description: "Write and maintain Vitest unit and integration tests for TypeScript projects. Use when adding behavior-focused unit coverage, testing domain logic, validating API/Worker boundaries, reviewing mocks/factories, or enforcing justified coverage from TEST_PLAN.md."
---

# Unit Testing with Vitest

Use this skill for TypeScript unit tests with strict, behavior-focused coverage.

Related workflow: [[testing-orchestrator]]

## Core rules

- Factory pattern is the default primitive:
  - `getMock<Thing>(overrides?: Partial<Thing>)`
- Test location: top-level `tests/` directory with subdirectories:
  - `tests/unit/` — unit tests, mirroring `src/` structure
  - `tests/integration/` — integration tests (multiple modules wired together, real crypto/logic, but no browser)
  - `tests/helpers/` — shared test utilities, factories, mocks
  - `tests/e2e/` — Playwright browser tests (see [[e2e-playwright]])
- Mocking rules:
  - `vi.mock()` declarations before imports
  - mock external dependencies only
  - prefer dependency injection over heavy mocking
- Coverage defaults:
  - lines/statements/functions/branches = **100%**
  - lower thresholds or exclusions only when `TEST_PLAN.md` documents the
    rationale or the user explicitly approves
- Structure tests with Arrange-Act-Assert
- Keep `describe` blocks focused (usually 3–5 tests)
- Test behavior, not implementation details
- Prefer public module/API contracts over private helpers and internal call
  order
- Use integration tests for meaningful boundaries: Worker handlers, persistence,
  queues, auth callbacks, crypto, and other cross-module behavior
- Mock external services and rare failure paths, not pure local logic you own

## Practical defaults

- Use explicit TypeScript types; avoid `any`.
- Test null/undefined boundaries and malformed input.
- Prefer deterministic tests (fake timers, stable factories).
- Keep one behavior per `it()`.
- Keep test data realistic enough to preserve behavior, but small enough to make
  failures obvious.
- If a coverage target pushes tests toward private structure or meaningless
  assertions, update the coverage exclusion rationale in `TEST_PLAN.md` instead
  of gaming the metric.

## Typical setup snippet (TypeScript)

```ts
import { defineConfig } from 'vitest/config';

export default defineConfig({
	test: {
		coverage: {
			provider: 'v8',
			thresholds: {
				lines: 100,
				statements: 100,
				functions: 100,
				branches: 100
			}
		}
	}
});
```

## Guides

- `guides/patterns.md`
- `guides/mocking.md`
- `guides/edge-cases.md`
- `guides/async.md`
- `guides/cloudflare.md`
