# Discipline Review: Testing And QA — test value and pruning

- Date: 2026-10-04
- Reviewer: Claude (Fable 5.1), decisions by Ronald
- Branch: `skills/test-audit-adaptation`
- Local files reviewed: `unit-vitest/SKILL.md`, `test-ci-policy/SKILL.md`,
  `testing-orchestrator/SKILL.md`, `test-planning/SKILL.md`,
  `implement-issue/SKILL.md` (test rules), `code-review/SKILL.md` (test-risk
  rules), `methodology/disciplines/testing-and-qa.md`
- External sources reviewed: OpenClaw `test-audit`
  (`methodology/sources/openclaw-test-audit.md`)
- Status: implemented (decisions by Ronald, 2026-10-04)

## Local Baseline

The 2026-05-24 pass gave the testing discipline five owners. `unit-vitest`
says "test behavior, not implementation details" and prefers public contracts;
`code-review` assesses coverage and missing tests; `test-ci-policy` owns
thresholds and gates. None of them answers two recurring questions: does this
new test earn its place, and which existing tests can be removed safely?
Project `AGENTS.md` files (atlas-kit, for example) carry ad-hoc retention rules
instead, such as "retire one-off runners and experiment-bookkeeping assertions"
and "do not test historical prose or counts as SDK contracts".

## Source Comparison

### OpenClaw test-audit

- Source ref: `80930af448eb` (2026-09-23)
- Files reviewed: `SKILL.md`, `CAMPAIGN.md`
- Useful patterns: one value bar for authoring and audit; four authoring
  questions with one primary owner per contract; junk-pattern checklist;
  retention bar with the source-inspection exception; complete candidate
  evidence before deletion; net-negative edit shape; campaign ledger, keeper
  layer plan, preservation review with mutations, baseline failures as product
  bugs.
- Conflicts or risks: validation and landing steps name OpenClaw tooling and
  skills that do not exist locally; the upstream trigger fires on every test
  write and would compete with `unit-vitest`; campaign mode assumes a large
  monorepo and parallel agent lanes.
- Adoption recommendation: adapt as a new runtime owner `test-audit` for test
  value and pruning, with the campaign procedure as a companion file; keep
  `unit-vitest` as the writing owner and link rather than merge; route
  validation through `test-ci-policy`, `code-review`, and `implement-issue`.

## Questions For The User

Asked and answered on 2026-10-04:

1. Authoring gate placement: advisory only. `test-audit` is used when asked to
   cull, audit, or question tests; `unit-vitest` and `implement-issue` keep
   writing tests without an extra gate.
2. First use on atlas-kit: a bounded read-only trial on one lane (the
   docs/tooling/workflow tests), producing an R/F/C/D ledger with evidence and
   no deletions until Ronald reviews it.
3. Landing: commit directly to `main`, as the css-design-tokens adaptation
   was.

## Adopted Changes

- New runtime skill `test-audit/SKILL.md` with companion `test-audit/CAMPAIGN.md`
  (provenance entry `2026-10-04-testing-test-audit-adapted`).
- `methodology/DISCIPLINES.md`, `README.md`, and `methodology/README.md` list
  the new owner and source.
- Not adopted per decision 1: no pointer lines in `unit-vitest` or
  `implement-issue`; the gate stays advisory.

## Skill-Level Attribution

- `test-audit/PROVENANCE.md` created with the rebuild recipe, source ref,
  taken/adapted/rejected material, and log pointers.

## Rejections And Deferrals

- Rejected: installing the upstream skill verbatim (OpenClaw runtime coupling,
  always-on trigger). Entry `2026-10-04-testing-test-audit-verbatim-rejected`.
- Rejected: the mandatory `$autoreview` final step; local `code-review` takes
  that role.
- Deferred: ledger and mutation-check automation, and a shrink-only line-cap
  gate (would belong to `test-ci-policy`). Entry
  `2026-10-04-testing-test-audit-tooling-deferred`.

## Verification Notes

- `[[skill-review]]` for `test-audit/SKILL.md`: PASS. One Important finding
  fixed before landing: the description's "gate new or changed tests" trigger
  phrase could have pulled the skill into ordinary test writing despite the
  advisory decision; it now reads "check whether a new or changed test earns
  its place" under "use when asked". Progressive disclosure holds:
  `CAMPAIGN.md` is gated behind "read before starting a campaign" and the
  default audit path is inline. Realistic prompts: "cull our tests so we keep
  only meaningful ones" should trigger; "add a unit test for the parser's
  empty-input case" should not (`unit-vitest`); "review this PR's tests" is
  the edge, where `code-review` leads and this skill supplies the value bar.
  Fresh-session trigger runs were not performed.
- Validation: YAML frontmatter parse passed for `test-audit/SKILL.md`;
  `git diff --check` passed; runtime files contain no personal names and no
  provenance links.
