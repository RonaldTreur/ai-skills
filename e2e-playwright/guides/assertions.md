# Playwright Assertions

## When to use
- Verifying visible outcomes users care about
- Waiting for async UI transitions via web-first assertions

## Avoid when
- Asserting internal app state not visible through UI/API boundary
- Using fixed sleeps instead of condition-based waiting

## Web-first assertions

```ts
import { expect, test } from '@playwright/test';

test('shows validation error for empty email', async ({ page }) => {
	await page.goto('/signup');
	await page.getByRole('button', { name: 'Create account' }).click();
	await expect(page.getByText('Email is required')).toBeVisible();
});
```

## Snapshot assertions
- Use for stable, high-signal outputs only
- Keep snapshots small and intentional

## Custom assertions
- Wrap repeated domain checks in helper functions/fixtures

## Waiting patterns
- Prefer `expect(locator).to...`
- Use `await expect.poll()` for non-UI state checks when needed

## Anti-patterns
- `await page.waitForTimeout(1000)`
- Multiple unrelated asserts in one test
- Snapshotting entire pages for tiny behavior checks
