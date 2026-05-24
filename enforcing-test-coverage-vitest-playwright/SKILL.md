---
name: enforcing-test-coverage-vitest-playwright
description: "Enforce Vitest + Playwright coverage policy for TypeScript web projects. Use when adding or changing functionality, setting npm/pnpm test scripts, aligning local and CI commands, reviewing coverage thresholds, or applying TEST_PLAN.md exclusions for unit/E2E/browser coverage."
---

# Test Coverage Skill (Vitest + Playwright)

## Identity
You enforce tests for every meaningful change: **Vitest** for unit tests and **Playwright** for E2E. Optimize for high confidence, low flakiness, and identical local/CI commands.

## Defaults
- Package manager: **npm** (unless monorepo → **pnpm**)
- Unit tests: **Vitest**
- E2E tests: **Playwright**
- Test orchestration: **package.json scripts** (not Playwright)

## Non-negotiables
- No meaningful change without tests (unless user explicitly says otherwise).
- Unit tests aim for **100%** lines/statements/functions/branches.
  - Exclusions are allowed only when `TEST_PLAN.md` documents the rationale or
    the user explicitly approves.
- E2E tests cover user-visible workflows (happy path + at least one relevant edge/negative path for critical flows).
- Browser QA still covers changed user-visible behavior when durable E2E is
  intentionally deferred or too expensive for the current slice.
- Protected flows need safe auth, fixtures, seed data, reset scripts, or
  documented storage state before tests can claim coverage.

## Required scripts (orchestrator)
Provide these scripts so the same commands run locally and in CI:

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

Notes:
- Use the project’s existing build/preview commands if they already exist.
- Only add the Vite `build`/`preview` scripts if the project uses Vite.
- If the build system is unclear, **ASK THE USER**.

## Coverage enforcement (Vitest)
Configure thresholds to 100% (ask before lowering):

- lines: 100
- statements: 100
- functions: 100
- branches: 100

Do not satisfy thresholds by testing private structure, inert constants, or
implementation trivia. If 100% creates noise without confidence, record the
explicit exclusion in `TEST_PLAN.md` and keep behavior coverage strong.

## Playwright rules
- Prefer testing against a built app (`build` + `preview`) unless the project requires dev-mode.
- Prefer semantic locators (`getByRole`, labels, accessible names). Add
  `data-testid` only when semantic locators cannot express a stable user-facing
  target.
- Avoid sleeps; rely on auto-waits and explicit conditions.
- In CI, collect trace/screenshot/video on failure.
- Do not use personal sessions, production credentials, or shared mutable
  staging records as the default test path.

## GitHub Actions entrypoints
CI must call the same scripts:
- Use the project’s package manager for installs and scripts.
- npm example:
  - `npm ci`
  - `npm run test:unit:coverage`
  - `npm run build`
  - `npm run test:e2e`
- pnpm example (monorepo):
  - `pnpm install --frozen-lockfile`
  - `pnpm run test:unit:coverage`
  - `pnpm run build`
  - `pnpm run test:e2e`

(Install Playwright browsers in CI before running E2E.)

## When E2E does not make sense
Only skip E2E for changes that cannot affect user-visible behavior. If unsure: **ASK THE USER**.

When E2E is skipped for a user-visible change, record why in `TEST_PLAN.md` or
the PR and run [[browser-qa]] for the changed flow before merge.
