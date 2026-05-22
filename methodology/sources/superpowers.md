# Source Inventory: SuperPowers

- Source URL: https://github.com/obra/superpowers
- License: MIT
- Commit/tag/release reviewed: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Retrieved: 2026-05-22 via shallow local clone
- Reviewer: Vectrix
- Local clone/path, if any: `/tmp/external-skill-sources/superpowers`

## Scope Reviewed

- `README.md`
- `skills/systematic-debugging/SKILL.md`
- `skills/systematic-debugging/defense-in-depth.md`
- `skills/dispatching-parallel-agents/SKILL.md`
- `skills/test-driven-development/SKILL.md`

## Relevant Disciplines

- Brainstorming
- Implementation planning
- Test-driven development
- Systematic debugging
- Review before completion
- Skill activation behavior

## Strong Ideas

- Strong "no fixes before root-cause investigation" gate.
- Four-phase debugging loop with explicit red flags for guessing and multi-fix
  thrash.
- Conditional defense-in-depth after identifying a real root-cause pattern.
- Parallel investigation for clearly independent failures.

## Adoption Risks

Hook-driven and always-on skill activation patterns may be too forceful for Merlin/main. Adapt the methodology, not the bootstrap posture, unless explicitly approved.

## Re-Review Trigger

Revisit during each discipline pass and at least every six months while this project remains active.
