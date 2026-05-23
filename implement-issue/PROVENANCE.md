# Implement Issue Provenance

This document records the source material that shaped
`implement-issue/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Treat this skill as the canonical active-issue implementation workflow.
2. Execute one ready GitHub issue or backlog slice at a time.
3. Use `dev` as the integration target.
4. Use vertical behavior-first TDD: behavior, failing test, minimal code,
   verification, refactor while green, repeat.
5. Prefer Vectrix for substantial implementation, with Codex coordinating,
   reviewing, fixing, and verifying when appropriate.
6. Run Codex P0-P3 review and, for non-trivial PRs, one independent
   Claude-review pass.
7. Maintain `DELIVERY_STATE.md` and GitHub issue/PR state for recovery.
8. Keep project lifecycle concerns in `project-manager`.

## Source Influence

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/subagent-driven-development/SKILL.md`,
  `skills/subagent-driven-development/implementer-prompt.md`,
  `skills/executing-plans/SKILL.md`, `skills/writing-plans/SKILL.md`
- License: MIT

What we took:
- Fresh implementation agents or subagents when delegation helps.
- Status vocabulary: done, done-with-concerns, needs-context, blocked.
- Review order: spec compliance before quality review.
- Escalate instead of forcing through uncertainty.

Local adaptation:
- Kept delegation optional and Vectrix-first, while reserving "subagent" for
  actual spawned Codex/OpenClaw subagents.
- Replaced SuperPowers-specific TodoWrite/worktree mechanics with local branch,
  `DELIVERY_STATE.md`, GitHub issue/PR, Codex review, and Claude-review gates.

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/tdd/SKILL.md`
- License: MIT

What we took:
- Behavior-first testing through public interfaces.
- Avoid horizontal "write all tests first, then all implementation" sequencing.
- Use vertical tracer bullets: one failing test, minimal implementation, repeat.

Local adaptation:
- Applied this inside the issue implementation workflow while still preserving a
  higher-level `TEST_PLAN.md` and issue acceptance criteria.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`
- License: MIT

What we took:
- Plans should capture guardrails, decisions, scope, units, risks, and test
  scenarios, not brittle implementation choreography.
- Implementers should decide exact code with the current codebase in front of
  them.

Local adaptation:
- The workflow reads plans and tests as guardrails but does not require
  pre-written code snippets or micromanaged implementation steps.

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `autoplan/SKILL.md`, plan-review skill set
- License: MIT

What we took:
- Plan/review pipelines should surface close calls and decisions instead of
  silently guessing.

What we rejected:
- GStack setup hooks, telemetry, session stores, generated preambles, and
  auto-update machinery.

### Existing Local Skills

- `project-manager/SKILL.md`
- `developing-web-projects/SKILL.md`
- `testing-orchestrator/SKILL.md`
- `test-planning/SKILL.md`
- `code-review/SKILL.md`
- `debugging/SKILL.md`

What we took:
- Existing `dev` branch policy, Vectrix-first default, Cloudflare/web defaults,
  P0-P3 code-review gate, and durable recovery discipline.

## Formal Trail

- `methodology/disciplines/implementation-lifecycle.md`
- `methodology/ADAPTATION_LOG.md`
- source inventories under `methodology/sources/`
