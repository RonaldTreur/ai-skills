# Mocking in Vitest

## When to use
- Isolating external dependencies (HTTP, DB clients, queues)
- Forcing rare failure paths deterministically
- Verifying integration boundaries

## Avoid when
- You can pass a dependency as a function/class argument (prefer DI)
- Mocking your own pure logic just to satisfy assertions
- Mocking everything and losing behavioral confidence

## `vi.mock()` ordering

```ts
import { describe, expect, it, vi } from 'vitest';

vi.mock('./email-service', () => ({
	sendEmail: vi.fn().mockResolvedValue({ ok: true })
}));

import { notifyUser } from './notify-user';
```

## `vi.spyOn()`

```ts
import * as clock from './clock';
import { vi } from 'vitest';

vi.spyOn(clock, 'nowIso').mockReturnValue('2026-01-01T00:00:00.000Z');
```

## DI alternative

```ts
type Fetcher = (url: string) => Promise<Response>;

export const loadProfile = async (fetcher: Fetcher, id: string) => {
	const res = await fetcher(`/api/users/${id}`);
	return res.json();
};
```

## Mocking fetch/timers/dates
- Use `vi.useFakeTimers()` for timer-driven code
- Use `vi.setSystemTime()` for date logic
- Stub global `fetch` only when DI is not practical

## Anti-patterns
- Mocking internal utility modules owned by same unit
- Asserting exact mock call counts for non-critical details
- Leaving fake timers enabled between tests
