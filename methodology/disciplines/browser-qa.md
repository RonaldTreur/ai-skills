# Discipline Review: Browser QA

- Date: 2026-05-23
- Reviewer: Merlin
- Branch: `feat/browser-qa-methodology`
- Local files reviewed: `implement-issue/SKILL.md`, `e2e-playwright/SKILL.md`,
  `testing-orchestrator/SKILL.md`, `debugging/SKILL.md`,
  `methodology/sources/gstack.md`
- External sources reviewed: GStack, SuperPowers, Compound Engineering, Matt
  Pocock Skills
- Status: implemented

## Local Baseline

The repo had strong skills for writing Playwright tests and orchestrating test
plans, but no focused owner for exploratory browser QA. `implement-issue`
referred to browser QA and post-merge QA inline without defining what that meant.
It also had no explicit rule for protected areas that require login, even though
browser QA is incomplete when authenticated flows are inaccessible.

That created an ownership gap:

- [[e2e-playwright]] writes durable E2E tests.
- [[testing-orchestrator]] plans and generates test suites.
- [[debugging]] investigates defects.
- No skill owned "open the app in a browser, act like a user, check console,
  responsive behavior, and report defects with evidence."

## Source Comparison

### GStack

- Source ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Files reviewed: `qa/SKILL.md`
- Useful patterns:
  - Browser QA should actually use a browser, not substitute static checks.
  - QA depth can vary by mode: quick, diff/focused, full, and regression.
  - Console checks, screenshots, responsive checks, repro steps, and severity
    triage make findings actionable.
  - Authentication is a real QA blocker; protected app areas need an explicit
    way through login before coverage can be complete.
  - QA can produce a report and separate fixed/deferred issues.
- Conflicts or risks:
  - The source bundles telemetry, update checks, generated preambles, command
    aliases, auto-commits, health scoring, persistent report directories, and
    test-framework bootstrapping.
  - It combines QA, bug fixing, regression-test generation, and commit policy
    into one large workflow.
- Adoption recommendation:
  - Adopt browser-first verification, modes, evidence, and triage.
  - Reject GStack runtime machinery and heavy report/commit requirements.

### SuperPowers

- Source ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Files reviewed: `skills/test-driven-development/SKILL.md`
- Useful patterns:
  - Fixes should earn regression coverage through behavior tests.
- Conflicts or risks:
  - Strict test-first rules belong to implementation and debugging, not to a
    lightweight browser QA pass.
- Adoption recommendation:
  - Use as comparison only. Browser QA can discover defects; regression-test
    creation stays with implementation/debugging/testing skills.

### Compound Engineering

- Source ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Files reviewed: `docs/skills/ce-debug.md`
- Useful patterns:
  - Non-trivial defects should route to root-cause investigation instead of
    symptom fixes.
- Conflicts or risks:
  - Full causal-chain debugging would make browser QA too heavy as a default.
- Adoption recommendation:
  - Route non-trivial defects to [[debugging]].

### Matt Pocock Skills

- Source ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Files reviewed: `skills/engineering/tdd/SKILL.md`
- Useful patterns:
  - Verify behavior through public interfaces.
- Conflicts or risks:
  - Matt's TDD workflow is implementation-facing, not QA-facing.
- Adoption recommendation:
  - Apply the behavior-first principle to browser QA flows without importing
    TDD planning gates.

## Questions For The User

None blocking. The user explicitly asked for a proper QA skill that smartly uses a
browser to test web projects.

## Adopted Changes

- Created `browser-qa/SKILL.md` as the runtime owner for browser-based QA,
  post-merge QA, defect evidence, and QA summaries.
  - Provenance entry: `2026-05-23-browser-qa-gstack-browser-first`
- Added authenticated-QA guidance to `browser-qa/SKILL.md`: prefer documented
  non-production accounts, seeded users, fixtures, local ignored storage state,
  or production-disabled dev auth paths; record missing auth setup as QA
  infrastructure.
  - Provenance entry: `2026-05-23-browser-qa-auth-blockers`
- Added browser-profile guidance: use the active agent's own controlled browser
  profile unless the user explicitly instructs otherwise.
  - Provenance entry: `2026-05-24-browser-qa-controlled-profile`
- Updated `implement-issue/SKILL.md` so implementation must build user-visible
  web features with browser-QA access in mind. New or changed protected flows
  need a safe QA auth path before merge.
  - Provenance entry: `2026-05-23-browser-qa-implementation-testability`
- Added `browser-qa/PROVENANCE.md`.
- Updated `implement-issue/SKILL.md` to call [[browser-qa]] instead of defining
  browser QA inline.
  - Provenance entry: `2026-05-23-browser-qa-implement-issue-specialist`
- Updated the discipline map and GStack source inventory.

## Skill-Level Attribution

No exception is needed:

- `browser-qa/PROVENANCE.md`
- `implement-issue/PROVENANCE.md`

Runtime `SKILL.md` files do not contain source attribution or rebuild notes.

## Rejections And Deferrals

- Rejected GStack health scoring as a default; it is attractive but too heavy
  for routine PR/post-merge checks.
- Rejected automatic test-framework bootstrap during QA; [[e2e-playwright]] and
  [[testing-orchestrator]] own durable test setup.
- Rejected relying on the user's personal browser session or production
  credentials as the default auth solution for QA.
- Rejected mandatory screenshots for every page; screenshots are required when
  visual evidence matters, but DOM/console evidence is often enough.
- Deferred a deeper testing-orchestrator pass. This slice only closes the
  exploratory browser QA ownership gap.

## Verification Notes

- `git diff --check`: passed.
- YAML frontmatter parse for `browser-qa/SKILL.md` and
  `implement-issue/SKILL.md`: passed.
- `[[skill-review]]` for `browser-qa/SKILL.md`: PASS. No Critical or
  Important findings after the authenticated-QA update. Optional polish only:
  keep future browser-tool-specific guidance in references if the skill grows.
- `[[skill-review]]` for `implement-issue/SKILL.md`: PASS. No Critical or
  Important findings after fixing one Important issue: the verification gate
  still said browser QA was only required "when feasible", which weakened the
  new merge gate. It now requires [[browser-qa]] for changed user-visible
  browser behavior and treats missing authenticated QA setup as a stop before
  merge.
