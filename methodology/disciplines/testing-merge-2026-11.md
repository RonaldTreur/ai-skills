# Discipline Review: Testing Merge (November 2026)

- Date: 2026-11-05
- Reviewer: Claude (Fable 5.1), with Ronald
- Branch: `docs/pocock-rereview-2026-11`
- Local files reviewed: `test-planning/`, `testing-orchestrator/`,
  `test-ci-policy/`, `test-audit/`, `unit-vitest/SKILL.md`,
  `e2e-playwright/SKILL.md`, `browser-qa/SKILL.md`, every runtime file linking
  the four, `README.md`, `methodology/DISCIPLINES.md`
- External sources reviewed: none new; applies merge candidate 1 and open
  question 3 of `matt-pocock-rereview-2026-11.md`
- Status: landed

## Local Baseline

Seven skills covered testing. Four of them (`test-planning` 534 words,
`testing-orchestrator` 698, `test-ci-policy` 677, `test-audit` 1,181 plus a
798-word `CAMPAIGN.md`) were model-invoked and spent much of their text telling
each other what they owned. `test-ci-policy` existed because an earlier
coverage skill fired on every code change; `test-audit` had an authoring gate
that must fire on every new test and a pruning procedure that fires once a
year, under one always-loaded description. Upstream covers the same ground
with `tdd` plus two reference files.

## Adopted Changes

- `testing/SKILL.md` (825 words, model-invoked) merges plan, outside-in loop,
  authoring gate, auth and test data, and enforcement. Entry
  `2026-11-05-testing-merge`.
- `testing/references/ci-policy.md` (script and CI shapes, the six audit
  questions) and `testing/references/junk-patterns.md` (shared with
  `test-audit`) load only on their branch. `testing/templates/` holds the two
  templates moved from `test-planning`.
- `test-planning/`, `testing-orchestrator/`, `test-ci-policy/` removed. Every
  runtime `[[link]]` to them now points at `[[testing]]`; three lines that
  would have read `[[testing]] / [[testing]]` were collapsed, and
  `developing-web-projects` lost two stale path references.
- `test-audit/SKILL.md` (698 words, user-invoked) keeps value bar, retention
  bar, discovery, evidence, edit shape, validation and landing. The authoring
  gate and junk patterns moved out; `CAMPAIGN.md` became
  `references/pruning-campaign.md` at 626 words. Entry
  `2026-11-05-test-audit-user-invoked`.
- `README.md` and `methodology/DISCIPLINES.md` list the new owners.

What was dropped as cache or choreography: the ownership-boundary sections
that restated the library's layout; the three example phase prompts for the
Playwright roles; the `seed.spec.ts` convention (owned by `e2e-playwright`);
the stack-alignment list; the "when to use" lists that repeated the
descriptions. Every gate in the old text survived as a list item in the new
one.

Effect on context: testing went from 7 skills to 5, of which 4 are
model-invoked (`testing`, `unit-vitest`, `e2e-playwright`, `browser-qa`). The
repository holds 30 skills, 25 model-invoked, with about 4,560 characters of
always-loaded description text, down from 33 skills and about 5,800 characters
before the first slice. Hot words for the testing activity fell from about
3,100 to about 800.

Shared reference across the invocation line: a user-invoked skill cannot be
reached by a model-invoked one, so `testing` names `test-audit` in plain text,
and `test-audit` reads the junk patterns from `../testing/references/` by
relative path. The repository root is the skill root in every harness used
here, so the path holds; a harness that installs skills one folder at a time
would need the file copied.

## Skill-Level Attribution

- `testing/PROVENANCE.md` created, merging the four previous provenance files
  and recording the merge decision.
- `test-audit/PROVENANCE.md` gained a dated Local Integration Decision.

## Rejections And Deferrals

- Rejected: folding the pruning campaign into the `testing` body. It runs
  about once a year and would load on every test task.
- Rejected: keeping `test-audit` model-invoked with a narrowed description. It
  fires only when typed.
- Rejected: a separate `test-ci-policy` skill. Its gates are five sentences;
  its shapes are a reference.
- Deferred: turning the greppable junk patterns into lint rules. That is a
  per-project `retro` outcome, not a skill change.

## Verification Notes

- `ruby skill-review/scripts/audit-skills.rb --root ~/Development/ai-skills --root ~/.claude/skills`:
  41 skills across two roots; no duplicate names, bodies or superseded names;
  no description overlap above threshold; `test-audit` left the long-description
  list; neither new file is flagged for body bloat.
- No runtime file outside `methodology/` references the three removed skills
  or `CAMPAIGN.md`.
- `testing` description 218 characters; `test-audit` description 205
  characters.
- No em-dashes introduced.
- `[[skill-review]]` pass on both skills and their references, run by a
  separate agent without this session's reading, including a check for gates
  dropped from the four old files: see below.

### Review results

A separate agent reviewed both skills, their references and the four removed
files without this session's reading, with an explicit check for dropped
gates. Verdicts before fixes: NEEDS WORK for both. Findings and what was done:

- Important, `testing`: the plan section required four things the template
  did not have (integration seams, browser-QA scope, auth and test data, CI
  and commands). Four headings added to `templates/test-plan.md`; the skill
  now says "fill every section or mark it not applicable".
- Important, `testing`: the junk-pattern reference sat on the default path of
  every test write. The four families are now inline under the authoring gate
  in about ninety words; the full list stays in the reference for audits.
- Important, `testing`: the old rule that lowering a threshold needs
  `TEST_PLAN.md` rationale or approval survived only in the CI reference. Added
  to the Enforcement gate.
- Important, `test-audit` campaign reference: the guardrail "record maintainer
  decisions in the PR evidence rather than editing gates" had been dropped, and
  "each step ends on its completion criterion" pointed at steps without one.
  Guardrail restored; every step now ends on a Done when clause.
- Polish applied: "for a web project" dropped from the `testing` description
  (Worker and API repos count); the Playwright-in-CI sentence and the
  restated role pattern removed from the body (the reference holds them); the
  ownership cache for `implement-issue` and `project-manager` cut; "CI policy"
  became "CI config" in `test-audit`; parallel lanes now go through
  `[[agent-delegation]]`.
- Probes: `testing` fires on wiring coverage and CI and on writing a test
  (co-firing with `unit-vitest`, as intended), and not on a preview check;
  `test-audit` fires on "half these tests look like dead weight" and not on
  "add tests for the webhook handler".
- Reviewer's out-of-scope catch: `~/.claude/skills` symlinked the three
  removed testing skills and `skill-maintenance`, and had no link for
  `testing`, `test-audit` or `retro`. The four dangling links were removed and
  the three missing ones added, so the installed library matches the repo.

Verdict after fixes: PASS for both, with the reviewer's findings applied as
written. Final sizes: `testing/SKILL.md` 825 words, description 218
characters; `test-audit/SKILL.md` 698 words; `pruning-campaign.md` 626 words.
