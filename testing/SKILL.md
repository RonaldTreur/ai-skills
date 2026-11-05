---
name: testing
description: Plan, sequence and enforce tests: TEST_PLAN.md, outside-in behavior slices, the authoring gate for every new test, safe auth and test data, CI parity and coverage thresholds. Use when planning, writing or wiring tests.
---

# Testing

Owns test strategy, sequencing, the bar a test must clear, and the enforcement plumbing. [[unit-vitest]] and [[e2e-playwright]] own tool detail; [[browser-qa]] owns exploratory browser verification. Pruning an existing suite is the typed `test-audit` skill.

## Plan

Create or update `TEST_PLAN.md` before broad test work, from `templates/test-plan.md`; fill every section or mark it not applicable. It names: E2E flows, happy paths, edge cases and error states; integration seams (API, persistence, queues, auth callbacks, external services); unit coverage per module; browser-QA scope; the safe non-production auth path, seed data, fixtures and reset steps; the install, build, typecheck, lint, unit, E2E, preview and coverage commands; coverage gaps; and explicit exclusions with rationale.

Gates:

- For a new project or standalone planning, a person approves `TEST_PLAN.md` before any test code is written. Inside an approved issue, acceptance criteria approve issue-local tests; ask only when the plan would change product scope or user-visible behavior.
- Before [[project-manager]] decomposes feature issues, the plan names setup work for scripts, CI, seed data, fixtures, safe auth and browser-QA access.
- A protected flow without safe test auth or seed data is a setup gap, never "covered".
- After implementation, update the plan: items done, coverage numbers, deviations, browser QA still manual or blocked.

For an existing project with thin coverage, `templates/coverage-gap.md` structures the inventory first.

## Outside-in loop

Plan before coding, then implement in vertical behavior slices, not all tests first then all code. For each behavior: confirm seed data, fixtures, safe auth and preview commands exist, or stop and record a setup gap; write the smallest failing E2E or integration test when the behavior is user-visible or API-facing; add focused unit coverage for the domain logic it exposes; run or hand off [[browser-qa]] for changed user-visible behavior before merge.

Use the [[e2e-playwright]] role sequence for durable suites, not for a tiny issue-local change that needs one focused test, and run its healer only on a concrete failure.

Skip E2E only for internal-only changes and unit tests only for thin wiring with no branch logic; when unsure, include both. Browser QA still covers changed user-visible behavior when durable E2E is deferred.

## Authoring gate

Before adding or changing a test, answer all four; a missing answer means the test is not ready:

1. Which observable behavior, invariant or independent contract does it protect?
2. Which credible regression makes it fail?
3. Why does existing coverage not already catch that? Every contract has one primary owner test at its strongest boundary; another layer earns its own test only for a risk the owner cannot reach (transport, lifecycle, persistence). Extend a table-driven case or shared fixture before adding a near-duplicate.
4. Does it need a production seam (export, flag, wrapper, injection hook) that no production caller needs? Then test at the real boundary instead.

Then check it against the junk families; a match fails the gate unless the test names the contract it independently guards:

- vacuous or circular: assertion-free probes, self-comparisons, expected values computed by the code under test, mocks that implement the asserted behavior;
- duplicated or misplaced: copied fixtures or inventories, private call-shape tests that duplicate a real boundary, one scenario replayed at several layers;
- coupled to implementation: source or import greps, tests that exist to keep a test-only export alive, flag tests that restate a declaration;
- misleading: negative controls that pass for an unrelated reason, names that promise more than the input exercises.

The full list with examples is `references/junk-patterns.md`. A test that breaks under behavior-preserving refactoring asserts implementation; rewrite it at the owning boundary.

A bug regression test fails on the pre-fix code for the intended reason and passes after the fix at the owner boundary. One regression at the owner covers the bug.

## Auth, fixtures and test data

Use seeded local users, fixtures, mocked external services, reset scripts and local preview auth. Keep storage state, cookies, passwords, tokens and magic links out of git and out of reports. Never default to the user's personal session or production credentials. When CAPTCHA, 2FA, paid services, missing seed data or account approval blocks coverage, mark the flow blocked and route setup work through [[project-manager]].

## Enforcement

One local command set that CI also calls. Default Vitest thresholds for owned TypeScript modules are 100 percent lines, statements, functions and branches. An exclusion is acceptable only when it raises signal (generated files, wiring with no branch logic, boundaries covered elsewhere, code that cannot run safely here) and is visible in `TEST_PLAN.md` or approved by the user; the same holds for lowering a threshold. Thresholds are never met by testing private structure, inert constants or implementation trivia.

Read `references/ci-policy.md` when setting up or auditing scripts, CI jobs or thresholds for a project.
