# Network Control in Playwright

## When to use
- Isolating flaky/unavailable third-party services
- Simulating edge cases hard to trigger naturally
- Replaying known traffic with HAR

## Avoid when
- Mocking your own backend for core user flows
- Mocking everything and losing end-to-end confidence

## Route interception

```ts
await page.route('**/api/weather', async (route) => {
	await route.fulfill({
		status: 200,
		contentType: 'application/json',
		body: JSON.stringify({ tempC: 12 })
	});
});
```

## HAR replay
- Use HAR for stable third-party integration responses
- Keep HAR fixtures versioned and minimal

## Response modification
- Intercept and patch only fields needed for scenario
- Preserve realistic response shape

## Anti-patterns
- Intercepting internal APIs in every test
- Returning unrealistic payloads that app never sees in production
- Forgetting to remove broad `**/*` routes
