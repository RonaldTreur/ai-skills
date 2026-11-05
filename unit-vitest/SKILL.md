---
name: unit-vitest
description: "Write and maintain Vitest unit/integration tests for TypeScript projects: behavior coverage, domain logic, API/Worker boundaries, mocks, and factories."
---

# Unit Testing with Vitest

Use this skill for TypeScript unit tests with strict, behavior-focused coverage;
strategy and sequencing come from [[testing]].

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

Read the one the task needs:

- `guides/patterns.md` when structuring a new test file or factory
- `guides/mocking.md` when mocking a module or dependency
- `guides/edge-cases.md` when covering boundaries and malformed input
- `guides/async.md` when testing timers, promises or streams
- `guides/cloudflare.md` when the target is a Cloudflare Worker
