# CI policy

Read this when setting up or auditing a project's test scripts, CI jobs or coverage thresholds. The gates live in `SKILL.md` under Enforcement; this file holds the shapes and the audit questions.

## Script shape

Use the project's existing commands when they exist; otherwise:

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

`npm` by default, `pnpm` for monorepos. Add `build` and `preview` only when the project uses Vite; when the build system is unclear, inspect before choosing.

## CI shape

```yaml
- run: npm ci                      # pnpm install --frozen-lockfile
- run: npm run test:unit:coverage
- run: npm run build
- run: npm run test:e2e
```

For Playwright: install browsers before E2E, collect trace, screenshot or video on failure, test against the built preview unless the project requires dev mode, and never use personal sessions, production credentials or shared mutable staging records.

## Enforcement audit

Answer each; a "no" becomes setup work, not a claim of coverage.

1. Can a fresh checkout install, build and run the same tests locally and in CI?
2. Do coverage thresholds reflect `TEST_PLAN.md`, or are agents gaming metrics?
3. Can protected flows be reached through safe repeatable auth and test data?
4. Are E2E failure artifacts preserved in CI?
5. Are skipped tests, `test.fixme()` and coverage exclusions explained?
6. Does browser QA cover the user-visible behavior that durable E2E defers?
