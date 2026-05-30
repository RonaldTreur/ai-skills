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
- `skills/requesting-code-review/SKILL.md`
- `skills/requesting-code-review/code-reviewer.md`
- `skills/writing-plans/SKILL.md`
- `skills/executing-plans/SKILL.md`
- `skills/subagent-driven-development/SKILL.md`
- `skills/subagent-driven-development/implementer-prompt.md`
- `skills/subagent-driven-development/code-quality-reviewer-prompt.md`
- `skills/subagent-driven-development/spec-reviewer-prompt.md`

## Relevant Disciplines

- Brainstorming
- Implementation planning
- Test-driven development
- Systematic debugging
- Review before completion
- Skill activation behavior
- Agent orchestration and delegation

## Strong Ideas

- Strong "no fixes before root-cause investigation" gate.
- Four-phase debugging loop with explicit red flags for guessing and multi-fix
  thrash.
- Conditional defense-in-depth after identifying a real root-cause pattern.
- Parallel investigation for clearly independent failures.
- Code review should be independent: do not trust implementation reports; read
  the actual diff.
- Separate spec compliance review from code-quality review.
- For implementation plans, define scope, files, tests, and tasks clearly.
- For delegated implementation, use fresh subagents, explicit context, status
  reporting, and spec-compliance review before code-quality review.

## Adoption Risks

Hook-driven and always-on skill activation patterns may be too forceful for
Merlin/main. The source also leans toward highly choreographed plans with exact
steps and code snippets; adapt the delegation/status/review discipline without
copying brittle implementation choreography.

## Re-Review Trigger

Revisit during each discipline pass and at least every six months while this project remains active.
