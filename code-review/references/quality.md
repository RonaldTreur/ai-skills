# Code Quality Checklist

Use this checklist for maintainability, correctness, and TypeScript rigor.

## Error Handling
- Flag empty `catch` blocks.
- Flag catch-and-ignore patterns without telemetry/remediation.
- Flag unhandled promise rejections.
- Flag `console.log` used instead of structured error reporting for failure paths.
- Ensure public APIs return actionable error types/messages.

## Performance
- Flag synchronous work that should be async on hot paths.
- Flag N+1 query patterns.
- Flag missing pagination/limits for list endpoints and queries.
- Flag unnecessary large bundle imports.
- Flag excessive DOM work or repeated expensive operations.

## TypeScript Rigor
- Flag `any` usage and `as any` assertions.
- Flag missing return types on exported/public functions.
- Flag non-exhaustive discriminated union switches.
- Flag loose generics that erase useful constraints.

## Boundary Conditions
- Flag missing null/undefined checks before access.
- Flag unchecked array indexing.
- Flag `parseInt` calls without radix.
- Flag brittle floating-point equality comparisons.
- Verify behavior for empty arrays, empty strings, and absent records.

## Naming & Readability
- Flag unclear abbreviations and ambiguous names.
- Boolean names should use `is/has/should/can` prefixes.
- Prefer explicit intent over short clever names.

## Complexity & Structure
- Flag functions over 50 lines.
- Flag nesting deeper than 3 levels.
- Flag cyclomatic complexity above ~10.
- Suggest extraction into focused helpers when readability drops.

## DRY
- Flag copy-pasted logic blocks.
- Flag nearly identical functions that should be parameterized.
- Prefer shared utilities only when abstraction remains simple and readable.

## Review output expectation
For each finding, include:
1. Location (`file:line`)
2. Why it matters
3. Minimal concrete fix direction
4. Severity (P0–P3)
