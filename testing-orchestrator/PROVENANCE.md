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
4. Delegate implementation state and PR mechanics to `implement-issue`.
5. Treat auth, fixtures, seed data, CI, and browser-QA handoff as part of the
   testing workflow rather than optional afterthoughts.
6. Use the E2E planner/generator/healer roles when they add value, but do not
   force the full sequence for tiny issue-local changes.

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

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `qa/SKILL.md`, `autoplan/SKILL.md`
- License: MIT

What we took:
- Auth, missing data, CAPTCHA, and app-access blockers need explicit handling;
  otherwise tests and QA can report false confidence.
- E2E failures should preserve useful evidence and route real setup gaps back to
  planning rather than being patched around in tests.

Local adaptation:
- Added safe auth/fixtures/test-data requirements and setup-gap routing through
  `project-manager`.
- Kept GStack's browser-first QA influence in `browser-qa` instead of moving
  exploratory QA into `testing-orchestrator`.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/writing-plans/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`
- License: MIT

What we took:
- Limited direct testing mechanics. The useful influence was explicit handoff
  and escalation: an agent should report blocked coverage or missing context
  instead of guessing.

Local adaptation:
- `testing-orchestrator` now stops on missing auth/fixtures/preview commands and
  routes the setup gap through `project-manager`.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`
- License: MIT

What we took:
- Planning artifacts should capture tests, risks, and guardrails while allowing
  implementation details to evolve.

Local adaptation:
- `testing-orchestrator` consumes `TEST_PLAN.md` and specs as guardrails, but
  executes in small behavior slices through `implement-issue` instead of a
  brittle all-tests-first sequence.

### Existing Local Skills

- `browser-qa/SKILL.md`
- `project-manager/SKILL.md`
- `test-planning/SKILL.md`

What we took:
- Browser QA access and project-readiness setup must be planned and verified
  before tests claim protected flows are covered.

Local adaptation:
- Added safe auth/test-data requirements, browser-QA handoff, and setup-gap
  routing through `project-manager`.

## Formal Trail

- `methodology/disciplines/implementation-lifecycle.md`
- `methodology/disciplines/testing-and-qa.md`
- `methodology/ADAPTATION_LOG.md`
