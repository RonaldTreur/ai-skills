# Test CI Policy Provenance

This document records the source material and local decision that shaped
`test-ci-policy/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Treat scripts, CI commands, coverage thresholds, and local/CI parity as
   project-level enforcement plumbing.
2. Do not activate the policy skill for every feature change.
3. Keep coverage intent and exclusions in `TEST_PLAN.md`.
4. Keep unit and E2E testing details in their specialist skills.
5. Require safe auth, fixtures, seed data, reset support, or browser-QA coverage
   before protected flows can be called covered.

## Source Influence

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/tdd/SKILL.md`
- License: MIT

What we took:

- Testing policy should protect behavior-focused feedback loops, not push agents
  into private-structure coverage games.

Local adaptation:

- `test-ci-policy` keeps strict thresholds as a default, but routes meaningful
  exclusions through `TEST_PLAN.md`.

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `qa/SKILL.md`
- License: MIT

What we took:

- Browser and protected-flow verification need artifacts, app access, and clear
  blocker handling.

Local adaptation:

- CI policy requires E2E artifacts and safe repeatable auth/test data before a
  project can claim coverage for protected flows.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/writing-plans/SKILL.md`
- License: MIT

What we took:

- Future agents need explicit handoff state for why a threshold, exclusion, or
  setup gap exists.

Local adaptation:

- The policy skill points threshold exceptions and skipped coverage back to
  `TEST_PLAN.md` instead of hiding them inside config.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`
- License: MIT

What we took:

- Plans should be durable guardrails. Enforcement should connect back to risk
  and scenarios instead of becoming blind ceremony.

Local adaptation:

- The old broad coverage-enforcement skill was superseded by a narrower
  project-wide test/CI policy skill. Test strategy and content now stay with the
  skills that actually own them.

## Superseded Local Skill

This skill replaces `enforcing-test-coverage-vitest-playwright`.

Reason:

- The old skill duplicated day-to-day testing rules from `test-planning`,
  `testing-orchestrator`, `unit-vitest`, and `e2e-playwright`.
- Its "use whenever adding/changing functionality" trigger was too broad and
  would over-activate during normal implementation.
- The useful remaining material is project-level enforcement policy: scripts,
  CI, thresholds, artifacts, and parity.

## Formal Trail

- `methodology/disciplines/testing-and-qa.md`
- `methodology/ADAPTATION_LOG.md`
