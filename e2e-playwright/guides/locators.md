# Playwright Locators

## When to use
- Writing resilient selectors for user-facing behavior
- Reducing flaky tests caused by brittle CSS selectors

## Avoid when
- You are asserting internal implementation details
- You depend on unstable generated class names

## Selector priority
1. `getByRole()` with accessible name
2. `getByLabel()`, `getByPlaceholder()`, `getByText()` (when meaningful)
3. `getByTestId()` for hard-to-express elements
4. CSS/XPath only as last resort

## Example

```ts
await page.getByRole('button', { name: 'Save profile' }).click();
await expect(page.getByRole('status')).toHaveText('Saved');
```

## When to use `data-testid`
- Repeated structural elements with ambiguous accessible names
- Non-semantic wrappers where role/name cannot be stabilized

## Anti-patterns
- `page.locator('div:nth-child(4) > span')`
- Selecting by random IDs generated at runtime
- Using text selectors for invisible/debug-only text
