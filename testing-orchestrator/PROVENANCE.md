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
4. Delegate delivery state and PR mechanics to `issue-driven-delivery-loop`.

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

## Formal Trail

- `methodology/disciplines/implementation-lifecycle.md`
- `methodology/ADAPTATION_LOG.md`
