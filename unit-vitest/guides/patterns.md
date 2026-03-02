# Vitest Patterns

## When to use
- Defining repeatable test structure for domain modules
- Creating readable, maintainable test suites
- Building realistic test data quickly

## Avoid when
- You need integration/E2E confidence (use [[e2e-playwright]])
- You are asserting UI rendering details best covered in browser tests

## Factory pattern (default)

```ts
type User = {
	id: string;
	email: string;
	isActive: boolean;
};

export const getMockUser = (overrides: Partial<User> = {}): User => ({
	id: 'user-1',
	email: 'user@example.com',
	isActive: true,
	...overrides
});
```

## AAA structure

```ts
import { describe, expect, it } from 'vitest';
import { canLogin } from './can-login';

describe('canLogin', () => {
	it('returns true for active user with email', () => {
		// Arrange
		const user = getMockUser();

		// Act
		const result = canLogin(user);

		// Assert
		expect(result).toBe(true);
	});
});
```

## Naming
- `describe('module/function')`
- `it('does X when Y')`
- Prefer plain behavior language over internal method names

## Anti-patterns
- One giant `describe` with dozens of unrelated tests
- Repeating raw object literals instead of factories
- Asserting private helpers or internal call order without value
- Multiple behaviors in one `it()`
