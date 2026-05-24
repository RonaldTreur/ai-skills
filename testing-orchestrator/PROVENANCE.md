# Testing Orchestrator Provenance

This document records the implementation-lifecycle changes to
`testing-orchestrator/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Own testing method and tooling for web projects.
2. Use plans and specs before code, but execute implementation as vertical
   behavior slices.
3. Avoid horizontal "all tests first, all code later" unless explicitly running
   a test-only pass.
4. Delegate implementation state and PR mechanics to `implement-issue`.
5. Treat auth, fixtures, seed data, CI, and browser-QA handoff as part of the
   testing workflow rather than optional afterthoughts.
6. Use the E2E planner/generator/healer roles when they add value, but do not
   force the full sequence for tiny issue-local changes.

## Source Influence

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/tdd/SKILL.md`
- License: MIT

What we took:
- Behavior-first testing through public interfaces.
- Vertical tracer bullets over horizontal test batches.

Local adaptation:
- Kept the existing E2E planner/generator/healer roles, but made vertical
  execution the default implementation pattern.

### Existing Local Skills

- `browser-qa/SKILL.md`
- `project-manager/SKILL.md`
- `test-planning/SKILL.md`

What we took:
- Browser QA access and project-readiness setup must be planned and verified
  before tests claim protected flows are covered.

Local adaptation:
- Added safe auth/test-data requirements, browser-QA handoff, and setup-gap
  routing through `project-manager`.

## Formal Trail

- `methodology/disciplines/implementation-lifecycle.md`
- `methodology/disciplines/testing-and-qa.md`
- `methodology/ADAPTATION_LOG.md`
