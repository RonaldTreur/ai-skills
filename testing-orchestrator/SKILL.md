---
name: testing-orchestrator
description: Orchestrate the full testing workflow for a web project. Coordinates test planning, E2E testing, and unit testing in an outside-in development cycle.
---

# Testing Orchestrator

Conductor skill for end-to-end testing workflow across:
- [[test-planning]]
- [[e2e-playwright]]
- [[unit-vitest]]

## Outside-in workflow (default)
1. **Test plan**: spawn E2E Planner role to produce markdown scenarios in `specs/`
2. **E2E generation**: spawn E2E Generator role to create failing/target E2E tests from plan
3. **Unit tests**: generate focused unit tests with [[unit-vitest]] for core logic/branches
4. **Implement**: write production code to satisfy unit + E2E expectations
5. **Heal**: spawn E2E Healer role to stabilize failures/flakes and verify correctness

## 3-phase E2E pattern (explicit role order)
Always orchestrate E2E in this sequence:
1. `[[e2e-playwright]]` role: `roles/planner.md`
2. `[[e2e-playwright]]` role: `roles/generator.md`
3. `[[e2e-playwright]]` role: `roles/healer.md`

Do not skip or reorder unless explicitly requested.

## Example phase prompts

### Phase 1 — Planner prompt
"Use `e2e-playwright/roles/planner.md`. Explore the live app from a fresh state and create a structured markdown test plan in `specs/<feature>-plan.md` with clear scenario titles, numbered steps, expected outcomes, and success/failure criteria."

### Phase 2 — Generator prompt
"Use `e2e-playwright/roles/generator.md`. Read `specs/<feature>-plan.md`, validate each scenario step live, and generate TypeScript Playwright tests (one test per file) with describe/title alignment to the plan and comments before each step."

### Phase 3 — Healer prompt
"Use `e2e-playwright/roles/healer.md`. Run all Playwright tests, debug each failing test, apply minimal robust fixes, re-run to verify, and mark `test.fixme()` only when the app is likely broken (with comment)."

## `seed.spec.ts` convention
- Seed template lives at: `e2e-playwright/templates/seed.spec.ts`
- Use this template when bootstrapping generator output shape
- Keep generated tests TypeScript-only and framework-agnostic

## Script conventions (`package.json`)

```json
{
  "scripts": {
    "test": "npm run test:all",
    "test:all": "npm run test:unit && npm run test:e2e",
    "test:unit": "vitest run",
    "test:unit:watch": "vitest",
    "test:unit:coverage": "vitest run --coverage",
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui"
  }
}
```

## Coverage policy
- Default enforcement: 100% lines/statements/functions/branches
- Ask before lowering thresholds or adding exclusions

## CI/CD policy
- Use the same scripts locally and in GitHub Actions
- Install browsers in CI before E2E
- Store artifacts (trace/screenshots/videos) on failures

## When E2E or unit tests may not make sense
- Skip E2E only for non-user-visible/internal-only changes
- Skip unit tests only for thin wiring with negligible branch logic
- If uncertain, include both or ask for explicit approval to skip

## Stack alignment
- TypeScript-first examples
- Framework-agnostic tests
- Compatible with vanilla HTML/CSS, Web Components, MPA, and Cloudflare-first projects
