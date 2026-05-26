# GitHub Pipeline Provenance

This document records the source material that shaped `gh-pipeline/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Use GitHub labels as recoverable pipeline state.
2. Keep exactly one active `agent:*` stage label per issue.
3. Treat `status:in-progress` as a lock and terminal statuses as stop states.
4. Route build, test, review, and fix work to existing owner skills instead of
   duplicating their workflows.
5. Transition labels only after durable evidence exists.
6. Recover from GitHub truth first: labels, PRs, branches, commits, checks,
   reviews, and comments.
7. Ask before bulk label creation, repo configuration, deployment automation, or
   other external actions beyond the approved pipeline operation.
8. Keep orchestration updates concise and artifact-driven.

## Source Influence

### Existing Local gh-pipeline Skill

- Source: local OpenClaw workspace skill
- Reviewed ref: `/Users/merlin/.openclaw/workspace-main/skills/gh-pipeline/SKILL.md`
  as of 2026-05-26
- Reviewed material: full skill body
- License: repository-local guidance

What we took:
- Label-driven stage machine for build, test, review, and fix-comment stages.
- `status:in-progress` as the double-pickup prevention lock.
- Blocked, failed, and approved statuses.
- Loop detection for repeated review/fix cycles.

Local adaptation:
- Converted the implementation-heavy prompt templates into owner-skill routing:
  `project-manager`, `implement-issue`, `testing-orchestrator`,
  `code-review`, and `agent-delegation`.
- Added stronger artifact requirements before transitions.
- Added explicit authority boundaries and ask-before rules for bulk GitHub
  mutation and production-impacting automation.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/subagent-driven-development/SKILL.md`,
  `skills/requesting-code-review/SKILL.md`,
  `skills/dispatching-parallel-agents/SKILL.md`
- License: MIT

What we took:
- Fresh agents need explicit scope, constraints, status, and review before their
  output is trusted.
- Code review should independently read the work rather than trust implementer
  summaries.

Local adaptation:
- The pipeline dispatches stages to existing local skills and requires durable
  artifacts before label transitions instead of copying subagent prompt
  choreography.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `plugins/compound-engineering/skills/ce-compound/SKILL.md`,
  `plugins/compound-engineering/skills/ce-code-review/references/subagent-template.md`
- License: MIT

What we took:
- The controller remains responsible for synthesis and final state changes.
- Leaf work needs strict output expectations.

Local adaptation:
- The orchestrator owns label changes and recovery, while stage skills own the
  work. We did not import Compound's artifact schema or command-mode machinery.

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `review/SKILL.md`, `autoplan/SKILL.md`, plan-review skill
  family noted in source inventory
- License: MIT

What we took:
- Specialist review and plan/review gates should surface close calls before
  merge readiness.

Local adaptation:
- Kept the review gate as a pipeline stage owned by `code-review`. Rejected
  telemetry, generated preambles, and platform-specific session machinery.

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/tdd/SKILL.md`,
  `skills/engineering/grill-with-docs/SKILL.md`
- License: MIT

What we took:
- Keep loops small and falsifiable; ask for missing context instead of guessing.

Local adaptation:
- Test and blocker transitions require evidence and route missing context to
  `status:blocked`.

## Formal Trail

- `methodology/disciplines/github-issue-automation.md`
- `methodology/ADAPTATION_LOG.md`
