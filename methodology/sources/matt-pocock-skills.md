# Source Inventory: Matt Pocock Skills

- Source URL: https://github.com/mattpocock/skills
- License: MIT
- Commit/tag/release reviewed: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Retrieved: 2026-05-22 via shallow local clone
- Reviewer: Vectrix
- Local clone/path, if any: `/tmp/external-skill-sources/matt-pocock-skills`

## Scope Reviewed

- `README.md`
- `skills/engineering/README.md`
- `skills/engineering/diagnose/SKILL.md`
- `skills/engineering/tdd/SKILL.md`
- `skills/in-progress/review/SKILL.md`
- `skills/engineering/grill-with-docs/SKILL.md`
- `skills/engineering/improve-codebase-architecture/SKILL.md`

## Relevant Disciplines

- Diagnosis
- Test-driven development
- Architecture review
- Skill writing
- Documentation and handoff
- Domain language

## Strong Ideas

- Build a fast, deterministic feedback loop before theorizing.
- Treat the debug loop itself as a product: faster, sharper, more deterministic.
- Require falsifiable hypotheses and targeted probes instead of diffuse logging.
- Cleanup discipline: tagged debug logs, rerun original repro, note the winning
  hypothesis in commit/PR history.
- Split code review into standards compliance and spec compliance axes.
- Pin the review fixed point and discover spec/standards sources before judging
  the diff.
- TDD should proceed in vertical behavior slices: one failing test, minimal
  implementation, repeat. Avoid horizontal "all tests first, all code later"
  sequencing.
- Planning conversations should sharpen overloaded domain language and inspect
  existing docs/code before asking the user to answer discoverable questions.

## Adoption Risks

Generally low blast radius, but still adapt tone, trigger rules, and questioning behavior to the user's workflow and OpenClaw conventions.

## Re-Review Trigger

Revisit during each discipline pass and at least every six months while this project remains active.
