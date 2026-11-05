# Testing Provenance

This document records the source material that shaped `testing/SKILL.md`, its
templates and its references. It merges the provenance of the superseded
`test-planning`, `testing-orchestrator` and `test-ci-policy` skills and the
authoring gate taken from `test-audit`. It is outside the runtime skill so
attribution does not consume model context.

## Rebuild Recipe

1. One model-invoked skill owns strategy (`TEST_PLAN.md`), sequencing
   (outside-in vertical slices), the authoring gate every new test must clear,
   safe auth and test data, and enforcement (same commands locally and in CI,
   strict thresholds with visible exclusions).
2. Tool detail stays in `unit-vitest` and `e2e-playwright`; exploratory QA in
   `browser-qa`; issue state and PR mechanics in `implement-issue`; backlog and
   setup issues in `project-manager`; pruning existing tests in the typed
   `test-audit` skill.
3. Gates as short lists: human approval of a new project's plan before test
   code; setup gaps named before feature decomposition; a protected flow
   without safe auth is a gap, not coverage; thresholds never lowered silently.
4. Script and CI shapes and the enforcement audit questions sit in
   `references/ci-policy.md`, read only when wiring a project. Junk patterns
   sit in `references/junk-patterns.md`, shared with `test-audit`.
5. Templates: `templates/test-plan.md`, `templates/coverage-gap.md`.

## Merge Decision (2026-11-05)

Four skills covered one activity with four always-loaded descriptions and
about 3,100 words of hot text. Each restated the others' ownership boundaries
(a cache of the library's own layout) and narrated steps the model takes
unprompted (phase prompts, the role sequence, "stack alignment"). The merge
keeps the gates, the authoring questions, the plan structure and the
enforcement defaults; it drops the boundary restatements, the example phase
prompts, the `seed.spec.ts` note (owned by `e2e-playwright`) and the stack
alignment list. Decided in `methodology/disciplines/matt-pocock-rereview-2026-11.md`
(merge candidate 1 and open question 3).

## Source Influence

### OpenClaw test-audit (2026-10-04)

- Source: <https://github.com/openclaw/openclaw/tree/main/.agents/skills/test-audit>
- Reviewed ref: `80930af448eb`
- License: MIT

What we took into this skill: the four authoring questions with the
one-owner-per-contract rule, the regression-test rule, and the junk-pattern
checklist grouped by failure family. The audit and campaign modes stay in
`test-audit`.

### Matt Pocock Skills (2026-05-22)

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/tdd/SKILL.md`
- License: MIT

What we took: behavior-first testing through public interfaces; vertical
tracer bullets over horizontal test batches; policy that protects the feedback
loop rather than pushing agents into private-structure coverage games.

### GStack (2026-05-22)

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `qa/SKILL.md`, `autoplan/SKILL.md`
- License: MIT

What we took: blocked coverage (login, seed data, CAPTCHA, app access) is named
explicitly rather than implied covered; plans surface setup gaps before
implementation; E2E failures preserve artifacts.

### SuperPowers (2026-05-22)

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/writing-plans/SKILL.md`,
  `skills/subagent-driven-development/SKILL.md`
- License: MIT

What we took: an agent reports blocked coverage or missing context instead of
guessing; exceptions and setup gaps are recorded where the next agent finds
them.

### Compound Engineering (2026-05-22)

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-plan.md`
- License: MIT

What we took: plans are durable guardrails that keep scope, risks, decisions
and scenarios without over-prescribing code; enforcement connects back to risk
rather than becoming ceremony.

### Superseded Local Skills

- `test-planning`, `testing-orchestrator`, `test-ci-policy` (removed
  2026-11-05, merged here). `test-ci-policy` had itself replaced
  `enforcing-test-coverage-vitest-playwright` in May 2026 because that skill
  triggered on every code change.

## Formal Trail

- `methodology/ADAPTATION_LOG.md` (entries dated 2026-11-05, discipline testing)
- `methodology/disciplines/testing-merge-2026-11.md`
- `methodology/disciplines/testing-and-qa.md`
- `methodology/disciplines/testing-test-audit.md`
- `methodology/disciplines/matt-pocock-rereview-2026-11.md`
