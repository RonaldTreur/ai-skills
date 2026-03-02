# Playwright Test Generator (OpenClaw adaptation)

Purpose: Transform markdown plans from `specs/` into executable TypeScript Playwright tests in `tests/`.

Related skills: [[e2e-playwright]], [[testing-orchestrator]]

## Operating model
- Read the test plan markdown first
- Use `templates/seed.spec.ts` pattern for setup shape
- For **each scenario step**, execute the action against the live app (via `browser` or `exec` Playwright scripts) before finalizing code
- Capture what actually works (a generator log/notes) and encode those validated selectors/actions/assertions

## Required workflow
1. **Read plan**
   - Parse sections/scenarios from `specs/*.md`.
2. **Set up scenario context**
   - Start from deterministic page state.
   - Prepare needed test data/fixtures without coupling tests.
3. **Step-by-step live verification**
   - Manually execute every planned step in real time.
   - Verify selectors and assertions against current UI.
   - Prefer semantic locators (`getByRole`, `getByLabel`, etc.).
4. **Generate test file**
   - One scenario per file.
   - File name must be filesystem-safe scenario name.
   - `test.describe()` name matches plan section.
   - `test()` title matches scenario name.
   - Add comments before each step block.
5. **Sanity run**
   - Run generated tests and fix obvious generation issues immediately.

## Code standards
- TypeScript only (`*.spec.ts`)
- One behavior per test
- No framework-specific assumptions
- No `waitForTimeout` and no deprecated APIs
- Keep assertions explicit and user-observable

## Example generation pattern

```ts
import { test, expect } from '@playwright/test';

test.describe('Authentication', () => {
  test('User can sign in with valid credentials', async ({ page }) => {
    // Step 1: Navigate to sign-in page
    await page.goto('/signin');

    // Step 2: Fill credentials
    await page.getByLabel('Email').fill('user@example.com');
    await page.getByLabel('Password').fill('correct horse battery staple');

    // Step 3: Submit form
    await page.getByRole('button', { name: 'Sign in' }).click();

    // Step 4: Verify successful sign-in
    await expect(page.getByRole('heading', { name: 'Dashboard' })).toBeVisible();
  });
});
```

## File/output rules
- Plans: `specs/*.md`
- Tests: `tests/*.spec.ts` (or project-defined E2E dir if orchestrator specifies)
- Keep test names stable and descriptive
- Preserve traceability from plan scenario → generated file

## Generator completion checklist
- [ ] Every scenario came from a markdown plan
- [ ] Every planned step was validated live before coding
- [ ] One test per file with fs-safe names
- [ ] Describe/title alignment with plan sections/scenario names
- [ ] Generated tests run and are syntactically/execution valid
