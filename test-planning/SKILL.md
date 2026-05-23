---
name: test-planning
description: Generate a TEST_PLAN.md before writing any test code. Use when starting a new feature, reviewing an existing codebase for coverage gaps, or before an outside-in development cycle.
---

# Test Planning Skill

Create a test plan **before** writing tests or feature code.

This skill owns test strategy, not implementation orchestration. For active
GitHub-issue implementation, [[implement-issue]] decides when to
execute the plan and how to update implementation state.

## What this skill does

1. Read `BRIEF.md` (requirements and constraints)
2. Scan source files (`src/`, workers, utilities, web components)
3. Scan existing tests (`tests/unit/`, `tests/integration/`, `tests/e2e/`, `tests/helpers/`)
4. Produce `TEST_PLAN.md` using `templates/test-plan.md`
5. If project already exists, produce `coverage-gap.md` notes using `templates/coverage-gap.md`

## Required plan structure

`TEST_PLAN.md` must include:

- **E2E tests**
  - user flows
  - happy paths
  - edge cases
  - error states
- **Unit tests**
  - per module
  - per function/method
- **Coverage gaps**
  - what exists vs what is missing
- **Not testing**
  - explicit exclusions + rationale

Link downstream execution skills:
- `[[e2e-playwright]]`
- `[[unit-vitest]]`

## Workflow rules

- For new projects or standalone planning, human reviews and approves
  `TEST_PLAN.md` **before any test code is written**.
- Inside an approved [[implement-issue]] run, existing issue
  acceptance criteria and standing implementation authority may count as approval for
  issue-local test additions. Ask only when the test plan would change product
  scope or user-visible behavior beyond the issue/spec.
- After implementation, update `TEST_PLAN.md` with:
  - checkmarks per planned item
  - current coverage percentages
  - deviations from original plan

## Opinionated defaults

- Prefer outside-in sequencing: critical user flows first, then unit coverage.
- Keep scope realistic; avoid exhaustive permutations with no product value.
- Align to project conventions from `[[developing-web-projects]]` (MPA, semantic HTML/CSS, Cloudflare-first, TypeScript).
