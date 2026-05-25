# Agent Delegation Provenance

This document records the source material that shaped
`agent-delegation/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Treat delegation as mechanics, not project ownership.
2. Delegate only when it materially improves speed, focus, review, or
   independent exploration.
3. Provide a compact packet with goal, inputs, scope, write boundaries,
   verification, and return format.
4. Parallelize only independent tasks with non-overlapping write scopes.
5. Require explicit statuses: `DONE`, `DONE_WITH_CONCERNS`, `NEEDS_CONTEXT`,
   and `BLOCKED`.
6. Make the coordinating agent responsible for reviewing and integrating the
   returned work.

## Source Influence

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/dispatching-parallel-agents/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`,
  `skills/subagent-driven-development/implementer-prompt.md`,
  `skills/subagent-driven-development/spec-reviewer-prompt.md`,
  `skills/subagent-driven-development/code-quality-reviewer-prompt.md`
- License: MIT

What we took:

- Delegate one independent problem domain per agent.
- Give fresh agents explicit context, constraints, and expected output.
- Use clear status reporting and treat blocked/needs-context as real
  escalations.
- Review returned work before integration.

Local adaptation:

- Removed always-on subagent choreography, TodoWrite mechanics, commits inside
  subagents, and mandatory two-reviewer loops.
- Kept the status vocabulary and packet discipline as a reusable local skill.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `plugins/compound-engineering/skills/ce-code-review/references/subagent-template.md`,
  `plugins/compound-engineering/skills/ce-compound/SKILL.md`
- License: MIT

What we took:

- Specialist agents need strict output contracts.
- Parallel research/review agents should return compact summaries to the
  orchestrator.
- The orchestrator owns synthesis and final writes.

Local adaptation:

- Kept the controller/leaf-agent boundary without importing JSON schemas,
  artifact directories, or compound-specific command modes.

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `review/SKILL.md`, `autoplan/SKILL.md`, plan-review skill
  family, and source inventory notes on dispatch tiers
- License: MIT

What we took:

- Specialist review or planning passes can surface risks and close calls before
  execution.

Local adaptation:

- Kept optional specialist passes while rejecting generated preambles,
  telemetry, daemon/session machinery, and mandatory routing tiers.

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/grill-with-docs/SKILL.md`,
  `skills/engineering/tdd/SKILL.md`
- License: MIT

What we took:

- Ask only when a decision genuinely needs human or missing-context input.
- Keep feedback loops small and behavior-focused.

Local adaptation:

- Delegates should report missing context instead of guessing, while controllers
  keep the next action narrow and verifiable.

## Formal Trail

- `methodology/disciplines/agent-orchestration-delegation.md`
- `methodology/ADAPTATION_LOG.md`
