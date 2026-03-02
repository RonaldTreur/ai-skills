---
name: unit-vitest
description: Write and maintain Vitest unit tests for TypeScript projects. Use when implementing unit tests, reviewing test quality, or adding coverage for existing code.
---

# Unit Testing with Vitest

Use this skill for TypeScript unit tests with strict, behavior-focused coverage.

Related workflow: [[testing-orchestrator]]

## Core rules

- Factory pattern is the default primitive:
  - `getMock<Thing>(overrides?: Partial<Thing>)`
- Follow existing test location convention first:
  - co-located `*.test.ts`, or
  - `tests/unit/`
- Mocking rules:
  - `vi.mock()` declarations before imports
  - mock external dependencies only
  - prefer dependency injection over heavy mocking
- Coverage defaults:
  - lines/statements/functions/branches = **100%**
  - ask before lowering thresholds
- Structure tests with Arrange-Act-Assert
- Keep `describe` blocks focused (usually 3–5 tests)
- Test behavior, not implementation details

## Practical defaults

- Use explicit TypeScript types; avoid `any`.
- Test null/undefined boundaries and malformed input.
- Prefer deterministic tests (fake timers, stable factories).
- Keep one behavior per `it()`.

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
