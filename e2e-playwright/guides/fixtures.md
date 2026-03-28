# Playwright Fixtures

## When to use
- Sharing setup logic across tests safely
- Managing authenticated state and seeded data
- Reducing duplication without globals

## Avoid when
- Fixture hides critical test intent
- Shared fixture introduces cross-test coupling

## `test.extend()` example

```ts
import { test as base } from '@playwright/test';

type Fixtures = {
	authToken: string;
};

export const test = base.extend<Fixtures>({
	authToken: async ({}, use) => {
		await use('test-token');
	}
});
```

## Scoping
- Prefer test-scoped fixtures by default
- Use worker-scoped only for expensive, immutable setup

## Lifecycle
- Setup in fixture body
- Teardown after `await use(...)`

## Auth state
- Store deterministic auth state per role
- Regenerate when login flow or permissions change

## Anti-patterns
- Global mutable singletons shared by tests
- Hidden network setup in unrelated fixtures
- Massive “kitchen sink” fixtures used by every test
