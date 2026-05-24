---
name: test-planning
description: "Create or update TEST_PLAN.md for project-level test strategy, coverage gaps, browser-QA scope, auth/test-data readiness, CI expectations, and outside-in sequencing. Use when starting a new project or feature, decomposing plans into issues, reviewing test coverage, or preparing an outside-in development cycle."
---

# Test Planning Skill

Create or update a test plan before broad test/code work begins.

This skill owns test strategy, not implementation orchestration. For active
GitHub-issue implementation, [[implement-issue]] decides when to
execute the plan and how to update implementation state.

## Ownership Boundary

- `test-planning` owns project-level test strategy, coverage intent, exclusions,
  test data, auth readiness, browser-QA scope, and CI expectations.
- [[testing-orchestrator]] owns how tests are generated and executed in the
  outside-in workflow.
- [[browser-qa]] owns exploratory browser verification and QA evidence.
- [[project-manager]] uses `TEST_PLAN.md` to decompose issues and identify setup
  blockers before feature work.
- [[implement-issue]] may add issue-local tests inside approved scope.

## What this skill does

1. Read product and planning docs: `BRIEF.md`, `DESIGN.md`, `PLAN.md`,
   `DECISIONS.md`, existing specs, and issue context when present.
2. Inspect app shape and current verification setup: source files, routes,
   package scripts, CI, Playwright/Vitest config, existing tests, fixtures, and
   seed/auth workflows.
3. Produce or update `TEST_PLAN.md`.
4. For existing projects, produce coverage-gap notes when useful.
5. Flag missing project-readiness work that should become setup issues before
   feature issues depend on it.

## Required plan structure

`TEST_PLAN.md` must include:

- **E2E tests**
  - user flows
  - happy paths
  - edge cases
  - error states
- **Integration/API tests**
  - worker/API boundaries
  - persistence, queues, auth callbacks, or external-service seams
- **Unit tests**
  - per module
  - per function/method
- **Browser QA**
  - smoke/focused/post-merge flows for [[browser-qa]]
  - responsive and console-error checks worth doing manually or with a browser
- **Auth and test data**
  - safe non-production auth path for protected flows
  - seed users, fixtures, storage state, reset steps, and forbidden production
    credentials/actions
- **CI and commands**
  - install, build, typecheck, lint, unit, E2E, preview, and coverage commands
  - artifact expectations for failing E2E runs
- **Coverage gaps**
  - what exists vs what is missing
- **Not testing**
  - explicit exclusions + rationale

Link downstream execution skills:
- `[[e2e-playwright]]`
- `[[unit-vitest]]`
- `[[browser-qa]]`
- `[[testing-orchestrator]]`

## Workflow rules

- For new projects or standalone planning, human reviews and approves
  `TEST_PLAN.md` **before any test code is written**.
- Before [[project-manager]] decomposes feature issues, `TEST_PLAN.md` should
  identify required setup work for scripts, CI, seed data, fixtures, safe auth,
  browser-QA access, and coverage thresholds.
- Inside an approved [[implement-issue]] run, existing issue
  acceptance criteria and standing implementation authority may count as
  approval for issue-local test additions. Ask only when the test plan would
  change product scope or user-visible behavior beyond the issue/spec.
- If protected flows lack safe test auth or seed data, do not pretend those
  flows are covered. Mark the setup gap and recommend a project setup issue.
- After implementation, update `TEST_PLAN.md` with:
  - checkmarks per planned item
  - current coverage percentages
  - deviations from original plan
  - any browser-QA coverage that remains manual or blocked

## Opinionated defaults

- Prefer outside-in sequencing: critical user flows first, then unit coverage.
- Plan vertical behavior slices: one behavior, failing public-interface test,
  minimal implementation, focused unit coverage, browser QA when user-visible.
- Keep scope realistic; avoid exhaustive permutations with no product value.
- Align to project conventions from `[[developing-web-projects]]` (MPA,
  semantic HTML/CSS, Cloudflare-first, TypeScript).
- Coverage should be strict by default, but exclusions are allowed only when
  explicit, justified, and visible in `TEST_PLAN.md`.
