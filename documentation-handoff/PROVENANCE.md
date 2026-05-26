# Documentation Handoff Provenance

This document records the source material that shaped
`documentation-handoff/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Treat docs as durable continuation state, not chat decoration.
2. Use specific artifacts for specific jobs: README, AGENTS, BRIEF, DESIGN,
   PLAN, TEST_PLAN, DECISIONS, DELIVERY_STATE, ADRs, and PR/issue handoffs.
3. Prefer compact handoff packets with goal, state, artifacts, decisions,
   checks, blockers, and one next action.
4. Update docs at workflow boundaries: kickoff, issue decomposition,
   delegation, PR, merge, pause, blocker, and recovery.
5. Trust GitHub state before local handoff files during recovery.
6. Avoid documentation ceremony for tiny self-contained work.
7. Never store secrets, personal credentials, or production-only access details
   in handoff docs.

## Source Influence

### Existing Local Skills

- Source: local repository skills
- Reviewed ref: `feat/documentation-handoff-adaptation`
- Reviewed material: `project-kickoff/SKILL.md`, `project-manager/SKILL.md`,
  `implement-issue/SKILL.md`, `developing-web-projects/SKILL.md`
- License: repository-local guidance

What we took:
- Kickoff artifacts, project memory, `DELIVERY_STATE.md`, README/AGENTS roles,
  PR issue context, and GitHub-first recovery.

Local adaptation:
- Consolidated scattered documentation and handoff mechanics into one owner
  skill while keeping workflow decisions in the invoking skills.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`,
  `docs/skills/ce-resolve-pr-feedback.md`, `README.md`
- License: MIT

What we took:
- Plans should capture guardrails, decisions, scope, risks, and test scenarios.
- Solution documentation is valuable when it captures durable rationale and
  constraints.

Local adaptation:
- Kept the durable artifact idea, but removed Compound-specific command modes,
  artifact schemas, and heavyweight organizational process.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/writing-plans/SKILL.md`,
  `skills/executing-plans/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`
- License: MIT

What we took:
- Plans and delegated work need explicit scope, files, tests, status, and
  blocker handling.

Local adaptation:
- Converted this into a compact handoff packet used across workflows, not a
  mandatory plan-execution choreography.

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `qa/SKILL.md`, `autoplan/SKILL.md`, `review/SKILL.md`
- License: MIT

What we took:
- Preserve evidence such as repro steps, screenshots, console output, and QA
  findings when they matter for later recovery.

Local adaptation:
- Kept evidence-backed handoff guidance while rejecting persistent report
  stores, telemetry, generated preambles, and platform-specific runtime
  machinery.

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/grill-with-docs/SKILL.md`,
  `skills/engineering/tdd/SKILL.md`
- License: MIT

What we took:
- Inspect existing docs/code before asking the user and sharpen overloaded
  domain language into explicit decisions.

Local adaptation:
- Added decision-capture guidance and a bias toward discoverable context over
  asking the user to restate what files already know.

## Formal Trail

- `methodology/disciplines/documentation-and-handoff.md`
- `methodology/ADAPTATION_LOG.md`
