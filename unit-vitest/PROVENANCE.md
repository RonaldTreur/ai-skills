# Unit Vitest Provenance

This document records the source material that shaped `unit-vitest/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Own behavior-focused Vitest unit and integration tests for TypeScript.
2. Prefer factories, Arrange-Act-Assert, deterministic timers/data, and explicit
   TypeScript types.
3. Test public module/API contracts and meaningful boundaries, not private
   helpers or internal call order.
4. Mock external services and rare failure paths, not pure local logic owned by
   the project.
5. Keep strict coverage as a default while allowing justified exclusions in
   `TEST_PLAN.md`.

## Source Influence

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/tdd/SKILL.md`
- License: MIT

What we took:
- Tests should prove behavior through public interfaces and avoid coupling to
  implementation trivia.

Local adaptation:
- `unit-vitest` now warns against private-structure coverage games and points
  meaningless coverage pressure back to `TEST_PLAN.md` exclusions.

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `review/checklist.md`, selected testing review material
- License: MIT

What we took:
- Tests should cover meaningful contracts, failure paths, and data boundaries
  rather than style-only assertions.

Local adaptation:
- Added integration-boundary examples for Worker handlers, persistence, queues,
  auth callbacks, crypto, and cross-module behavior.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/writing-plans/SKILL.md`
- License: MIT

What we took:
- Limited direct unit-testing mechanics. The useful influence was making
  coverage scope explicit and recoverable for later agents.

Local adaptation:
- Coverage exclusions must live in `TEST_PLAN.md` or be explicitly approved.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`
- License: MIT

What we took:
- Test scenarios should reflect risks and contracts without freezing internal
  code structure.

Local adaptation:
- `unit-vitest` emphasizes behavior, edge cases, failure paths, and boundaries
  instead of private implementation details.

## Formal Trail

- `methodology/disciplines/testing-and-qa.md`
- `methodology/ADAPTATION_LOG.md`
