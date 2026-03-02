# Vitest for Cloudflare Workers

## When to use
- Testing Worker handlers and routes
- Validating D1/KV/Durable Objects behavior
- Running Worker tests close to runtime semantics

## Avoid when
- You only need full browser journey validation (use [[e2e-playwright]])
- You are testing third-party services end-to-end (mock boundary instead)

## Tooling
- `vitest`
- `miniflare` (where applicable)
- `@cloudflare/vitest-pool-workers`

## Minimal TypeScript config

```ts
import { defineWorkersConfig } from '@cloudflare/vitest-pool-workers/config';

export default defineWorkersConfig({
	test: {
		poolOptions: {
			workers: {
				wrangler: { configPath: './wrangler.toml' }
			}
		}
	}
});
```

## What to test
- Worker request/response contracts
- D1 queries and error handling
- KV read/write paths and missing-key behavior
- Durable Object state transitions

## Anti-patterns
- Hitting production resources in unit tests
- Asserting Cloudflare internals instead of your behavior
- Skipping local runtime config parity with `wrangler.toml`
