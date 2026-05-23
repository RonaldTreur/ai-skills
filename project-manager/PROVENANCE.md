# Project Manager Provenance

This document records the source material that shaped
`project-manager/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Own project lifecycle, not per-issue implementation execution.
2. Use GitHub Issues and repo-local docs as durable project memory.
3. Decompose approved project docs into small, dependency-aware issues.
4. Recommend next ready work from priority, dependencies, milestone, size, and
   age.
5. Delegate active build execution to `issue-driven-delivery-loop`.
6. Ask before bulk GitHub mutations, project-scope changes, or product
   decisions.

## Source Influence

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`
- License: MIT

What we took:
- Plans as durable guardrails, with scope, units, risks, and test scenarios.
- Separate planning ownership from execution ownership.

Local adaptation:
- `project-manager` now manages durable project structure and hands active work
  to `issue-driven-delivery-loop`.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/writing-plans/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`
- License: MIT

What we took:
- Small independent tasks, explicit scope, testing decisions, and stop/blocked
  behavior.

Local adaptation:
- Kept the issue/project lifecycle shape, but removed the previous detailed
  implementation choreography from this skill.

### Existing Local Skills

- `project-kickoff/SKILL.md`
- `issue-driven-delivery-loop/SKILL.md`
- `test-planning/SKILL.md`
- `developing-web-projects/SKILL.md`

What we took:
- Kickoff docs, test-plan approvals, web defaults, and delivery-loop handoff
  boundaries.

## Formal Trail

- `methodology/disciplines/implementation-lifecycle.md`
- `methodology/ADAPTATION_LOG.md`
