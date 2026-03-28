# Playwright Test Healer (OpenClaw adaptation)

Purpose: Run the full E2E suite, diagnose failures, and repair tests to a stable passing state.

Related skills: [[e2e-playwright]], [[testing-orchestrator]]

## Non-negotiable behavior
- Run **all tests first** to identify complete failure set
- For each failing test, debug deeply and fix the most likely root cause
- Do the most reasonable thing without asking user follow-up questions
- Never use deprecated APIs
- Never use `waitForNetworkIdle`

## Required healing workflow
1. **Baseline run**
   - Execute `npx playwright test` to collect failures.
2. **Failure-by-failure debug**
   - Re-run failing tests with focused debugging options.
   - Inspect:
     - error messages and stack traces
     - screenshots/traces/page snapshots
     - locator resolution
     - assertion intent vs actual UI state
     - timing/state dependencies
3. **Root-cause analysis**
   - Classify likely cause:
     - selector drift (UI text/structure changed)
     - timing/synchronization issue
     - test data dependency
     - app behavior change/regression
4. **Repair**
   - Edit test code to improve correctness and resilience.
   - Prefer semantic locators and explicit assertions.
   - Keep tests behavior-driven, not implementation-coupled.
5. **Verify**
   - Re-run repaired tests, then full suite when practical.

## App-bug handling
If you are confident the test is correct but the app is broken:
- Mark the test with `test.fixme()`
- Add a concise comment explaining the observed app defect and why fixme is appropriate
- Continue healing remaining tests

## Healing standards
- Preserve intent from the original plan/spec
- Avoid over-broad waits and brittle selectors
- Keep tests independent and deterministic
- Prefer minimal, targeted edits

## Healer completion checklist
- [ ] Full suite executed initially
- [ ] Each failing test received root-cause analysis
- [ ] Fixes validated by re-run
- [ ] `test.fixme()` only where app defects are likely
- [ ] No deprecated Playwright APIs introduced
