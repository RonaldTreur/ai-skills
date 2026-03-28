# Async Testing with Vitest

## When to use
- Promise-returning functions
- Event-driven flows
- Timer-based logic (debounce/retry/backoff)
- Stream processing

## Avoid when
- Function is synchronous (keep test sync)
- Timing behavior is irrelevant to expected outcome

## Promises

```ts
import { expect, it } from 'vitest';
import { fetchConfig } from './fetch-config';

it('rejects on network failure', async () => {
	await expect(fetchConfig()).rejects.toThrow('Network error');
});
```

## Fake timers

```ts
import { expect, it, vi } from 'vitest';
import { createDebounced } from './debounced';

it('fires once after delay', async () => {
	vi.useFakeTimers();
	const fn = vi.fn();
	const debounced = createDebounced(fn, 250);

	debounced();
	debounced();
	vi.advanceTimersByTime(250);

	expect(fn).toHaveBeenCalledTimes(1);
	vi.useRealTimers();
});
```

## Event/stream guidance
- Capture events in arrays and assert sequence
- Test cleanup (`unsubscribe`, `close`) explicitly

## Anti-patterns
- `await new Promise((r) => setTimeout(r, 100))` in tests
- Mixing fake and real timers without reset
- Not awaiting async assertions
