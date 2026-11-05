---
name: unit-vitest
description: "Write and maintain Vitest unit/integration tests for TypeScript projects: behavior coverage, domain logic, API/Worker boundaries, mocks, factories, and TEST_PLAN.md coverage."
---

# Unit Testing with Vitest

Use this skill for TypeScript unit tests with strict, behavior-focused coverage.

Related workflow: [[testing]]

## Core rules

- Factory pattern is the default primitive:
  - `getMock<Thing>(overrides?: Partial<Thing>)`
- Test location: top-level `tests/` directory with subdirectories:
  - `tests/unit/`: unit tests, mirroring `src/` structure
  - `tests/integration/`: integration tests (multiple modules wired together, real crypto/logic, but no browser)
  - `tests/helpers/`: shared test utilities, factories, mocks
  - `tests/e2e/`: Playwright browser tests (see [[e2e-playwright]])
- Mocking: `vi.mock()` declarations before imports; mock external services and
  rare failure paths only, never local logic you own; prefer dependency
  injection over heavy mocking
- Coverage thresholds and exclusions: per [[testing]] Enforcement
- Keep `describe` blocks focused (usually 3 to 5 tests)
- Prefer public module/API contracts over private helpers and internal call
  order
- Use integration tests for meaningful boundaries: Worker handlers, persistence,
  queues, auth callbacks, crypto, and other cross-module behavior
- Test null/undefined boundaries and malformed input; prefer deterministic
  tests (fake timers, stable factories); keep test data realistic but small
  enough to make failures obvious

## Guides

- `guides/patterns.md`
- `guides/mocking.md`
- `guides/edge-cases.md`
- `guides/async.md`
- `guides/cloudflare.md`, read when the target is a Cloudflare Worker
