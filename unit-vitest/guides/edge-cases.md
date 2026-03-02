# Edge Cases for Unit Tests

## When to use
- Input validation logic
- Parsing/transformation code
- Security-sensitive or boundary-heavy paths

## Avoid when
- Case is impossible by type contract and runtime constraints
- Added case duplicates existing behavior with no new risk covered

## Checklist
- `null` / `undefined`
- Empty strings / arrays / objects
- Type boundaries (min/max numbers, long strings)
- Malformed input payloads
- Async failures and partial responses

## Example

```ts
import { describe, expect, it } from 'vitest';
import { parseAmount } from './parse-amount';

describe('parseAmount', () => {
	it('returns null for malformed values', () => {
		expect(parseAmount('abc')).toBeNull();
		expect(parseAmount('')).toBeNull();
	});

	it('parses decimal string', () => {
		expect(parseAmount('12.50')).toBe(12.5);
	});
});
```

## Anti-patterns
- Testing every mathematically possible value
- Ignoring malformed input because “UI already validates”
- Silent catch blocks in production code with no failing test
