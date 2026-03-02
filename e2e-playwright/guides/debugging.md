# Debugging Playwright Tests

## When to use
- Investigating flaky failures
- Understanding timing/locator issues
- Diagnosing CI-only failures

## Avoid when
- Editing tests blindly without reproducing locally
- Leaving debug-only code enabled in committed tests

## Tools
- Trace Viewer (`trace: 'on-first-retry'`)
- Headed mode
- `page.pause()` for interactive stepping
- UI mode (`playwright test --ui`)
- Screenshot/video on failure

## Quick workflow
1. Re-run one failing test with trace
2. Inspect actionability and locator timeline
3. Fix selector/assertion, not with sleeps
4. Re-run in headed + CI-like environment

## Anti-patterns
- Fixing flakes by increasing arbitrary timeouts
- Ignoring trace artifacts in CI
- Debugging the whole suite at once instead of single-test isolation
