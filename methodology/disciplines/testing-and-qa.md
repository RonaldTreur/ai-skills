# Discipline Review: Testing And QA

- Date: 2026-05-24
- Reviewer: Merlin
- Branch: `feat/testing-methodology`
- Local files reviewed: `test-planning/SKILL.md`,
  `testing-orchestrator/SKILL.md`, `e2e-playwright/SKILL.md`,
  `unit-vitest/SKILL.md`, `test-ci-policy/SKILL.md`,
  `browser-qa/SKILL.md`, `project-manager/SKILL.md`,
  `implement-issue/SKILL.md`
- External sources reviewed: Matt Pocock Skills, GStack
- Status: implemented

## Local Baseline

`test-planning` already owned `TEST_PLAN.md`, and `testing-orchestrator` already
preferred outside-in vertical slices after the implementation-lifecycle pass.
The remaining gap was coordination with the newer project-readiness and browser
QA decisions: safe auth, seed data, fixtures, CI, preview commands, and
browser-QA scope were not first-class in the testing plan.

`testing-orchestrator` also treated the E2E planner/generator/healer sequence as
mandatory. That was too rigid for small issue-local changes where
`implement-issue` can add a focused failing test directly.

`e2e-playwright` and `unit-vitest` needed to reflect the same
auth/fixture/readiness and behavior-over-metric policy. The old
`enforcing-test-coverage-vitest-playwright` skill also exposed a taxonomy
problem: most of its day-to-day behavior belonged in the owner skills, while the
useful remainder was project-wide test/CI policy.

## Source Comparison

### Matt Pocock Skills

- Source ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Useful pattern: behavior-first testing through public interfaces and vertical
  slices.
- Local adaptation: kept vertical behavior slices as the default and warned
  against private-structure coverage games.

### GStack

- Source ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Useful pattern: browser QA needs real app access, evidence, and explicit auth
  blocker handling.
- Local adaptation: test planning now includes browser-QA scope, safe auth, seed
  data, and blocked coverage instead of leaving those to late QA discovery.

## Adopted Changes

- `test-planning/SKILL.md`
  - Added ownership boundaries with `testing-orchestrator`, `browser-qa`,
    `project-manager`, and `implement-issue`.
  - Added required plan sections for integration/API tests, browser QA, auth and
    test data, CI/commands, and explicit coverage exclusions.
  - Added project-readiness setup gaps before feature decomposition.
- `testing-orchestrator/SKILL.md`
  - Added browser-QA coordination.
  - Added readiness checks for seed data, fixtures, safe auth, and local/preview
    commands before tests claim coverage.
  - Made the Playwright planner/generator/healer sequence conditional on need
    instead of mandatory for every small change.
  - Clarified coverage policy: strict defaults, explicit exclusions, public
    behavior over private structure.
- `e2e-playwright/SKILL.md`
  - Clarified that the role sequence is for durable scenario-driven E2E
    generation and repair, not mandatory ceremony for every tiny issue-local
    test.
  - Added safe auth, storage-state, fixture, and setup-blocker guidance.
- `unit-vitest/SKILL.md`
  - Clarified public module/API contracts, meaningful integration boundaries,
    mocking boundaries, and justified coverage exclusions.
- `test-ci-policy/SKILL.md`
  - Superseded `enforcing-test-coverage-vitest-playwright` with a narrower
    project-wide policy skill for scripts, CI entrypoints, coverage thresholds,
    local/CI parity, artifacts, and enforcement review.
  - Moved ordinary test-writing and coverage behavior back to
    `test-planning`, `testing-orchestrator`, `unit-vitest`, `e2e-playwright`,
    and `browser-qa`.

## Rejections And Deferrals

- Rejected pretending protected flows are covered when auth or seed data blocks
  the test or browser-QA path.
- Rejected mandatory full E2E role orchestration for tiny issue-local changes.
- Rejected a broad "use on every functionality change" coverage-enforcement
  skill because it duplicated the actual testing owner skills and would
  over-activate during normal implementation.
- Deferred only deeper guide-level rewrites for individual locator, mocking,
  network, and Cloudflare testing references.

## Verification Notes

- `[[skill-review]]` for `test-planning/SKILL.md`: PASS. No Critical or
  Important findings after confirming it owns strategy/readiness and not active
  implementation.
- `[[skill-review]]` for `testing-orchestrator/SKILL.md`: PASS. No Critical or
  Important findings after clarifying that the implementation step belongs to
  `[[implement-issue]]` during active issue work.
- Focused hardening review for `e2e-playwright`, `unit-vitest`, and
  `test-ci-policy`: PASS. No Critical or Important findings after aligning them
  with the merged testing model and narrowing the policy skill's activation.
- Validation:
  - YAML frontmatter parse passed for changed runtime skills.
  - `git diff --check` passed.
  - repository personal-name scan returned no matches.
