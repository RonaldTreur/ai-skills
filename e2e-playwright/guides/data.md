# E2E Test Data Strategy

## When to use
- Creating deterministic test inputs
- Seeding backend data for realistic user flows
- Cleaning up side effects after tests

## Avoid when
- Using random uncontrolled data that makes failures unreproducible
- Depending on shared long-lived staging records

## Factory example (TypeScript)

```ts
type AccountSeed = {
	email: string;
	plan: 'free' | 'pro';
};

export const getAccountSeed = (overrides: Partial<AccountSeed> = {}): AccountSeed => ({
	email: 'e2e-user@example.com',
	plan: 'free',
	...overrides
});
```

## Guidance
- Seed through official APIs or scripts
- Use unique IDs per test run when needed
- Cleanup created entities in teardown hooks

## Anti-patterns
- Hard-coding production identifiers
- Tests depending on execution order
- Reusing mutable records across parallel workers
