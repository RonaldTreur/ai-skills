---
name: enforcing-test-coverage-vitest-playwright
description: Use this skill whenever adding/changing functionality. Enforces full coverage via Vitest unit tests + Playwright E2E tests, orchestrated through npm scripts (pnpm only for monorepos) and runnable locally + in GitHub Actions.
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
  - If an exclusion is needed: **ASK THE USER**.
- E2E tests cover user-visible workflows (happy path + at least one relevant edge/negative path for critical flows).

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

## Playwright rules
- Prefer testing against a built app (`build` + `preview`) unless the project requires dev-mode.
- Use stable selectors (`data-testid`).
- Avoid sleeps; rely on auto-waits and explicit conditions.
- In CI, collect trace/screenshot/video on failure.

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
