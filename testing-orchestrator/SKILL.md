---
name: testing-orchestrator
description: Orchestrate the full testing workflow for a web project. Coordinates test planning, E2E testing, and unit testing in an outside-in development cycle.
---

# Testing Orchestrator

Conductor skill for end-to-end testing workflow across:
- [[test-planning]]
- [[e2e-playwright]]
- [[unit-vitest]]

## Scope Boundary

This skill owns testing method and tooling for web projects. It does not own
GitHub issue ordering, branch/PR mechanics, merge gates, or delivery-loop state.
Use [[issue-driven-delivery-loop]] for active per-issue execution.

## Outside-in workflow (default)

Use a plan before coding, but execute implementation in vertical behavior
slices. Avoid horizontal "write all tests first, then all code" unless the user
explicitly asks for a full test-only pass.

Default loop:

1. **Test plan**: create or read markdown scenarios in `specs/` or
   `TEST_PLAN.md`
2. **Choose one behavior**: pick the next user-visible flow, API behavior, or
   internal contract
3. **E2E/integration test**: create the smallest failing test that proves that
   behavior when user-visible
4. **Unit tests**: add focused unit coverage for domain logic exposed by that
   behavior
5. **Implement**: write the minimal production code to pass
6. **Verify and refactor**: run narrow checks, refactor only while green, then
   move to the next behavior
7. **Heal**: use the E2E healer role only for real failures/flakes after the
   behavior slice exists

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
