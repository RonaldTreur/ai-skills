# Final Taxonomy Cleanup

- Date: 2026-05-27
- Branch: `chore/final-taxonomy-cleanup`
- Local files reviewed: `README.md`, `methodology/DISCIPLINES.md`,
  `implement-issue/SKILL.md`, `implement-issue/PROVENANCE.md`,
  `project-kickoff/SKILL.md`, `project-manager/SKILL.md`,
  `test-ci-policy/SKILL.md`
- External sources reviewed: none newly reviewed; this cleanup consolidates the
  completed adaptation slices.

## Goal

Close the external-source adaptation branch without adding shelfware. The cleanup
checks whether the final skill taxonomy is readable, whether broad or superseded
owners still appear as active runtime skills, and whether runtime trigger
language matches the boundaries established by the completed slices.

## Findings

### Top-Level Taxonomy

`README.md` still described the adapted skills as a sequence of added slices.
That was accurate during the adaptation work, but less useful as a stable repo
overview. The final shape needed a workflow-owner view so future agents can see
which skill owns lifecycle, testing, design, review, automation, and handoff.

### Discipline Map

`methodology/DISCIPLINES.md` still had `Final taxonomy cleanup` under "Next
Candidate Slices" even though this branch is the cleanup. It also listed broad
disciplines without showing the runtime owner decisions, folded behaviors, or
superseded skills.

### Integration Branch Language

`implement-issue/SKILL.md` still hard-coded `dev` as the integration branch.
That matched the preferred branch policy for repos that actually have `dev`, but
it was too broad as a runtime rule. The local workspace convention is to prefer
`dev` when a repo uses it, not to create or assume `dev` everywhere.

### Research And Discovery

No separate runtime skill was created. The useful behavior remains in
`project-kickoff` as "Grounding Before Shaping", with `project-manager` limited
to refreshing context when it can change backlog, scope, setup, priority, or
next-work decisions.

### Testing Taxonomy

The broad `enforcing-test-coverage-vitest-playwright` owner remains superseded.
The active testing model is split across `test-planning`,
`testing-orchestrator`, `unit-vitest`, `e2e-playwright`, `browser-qa`, and
`test-ci-policy`.

## Changes Made

- Rewrote the README methodology overview around current owner groups instead of
  historical slice order.
- Converted the discipline map into current runtime owners, folded/deferred
  disciplines, completed slices, and rejected/superseded owners.
- Removed "Final taxonomy cleanup" from next-candidate status by marking it as a
  completed adaptation slice.
- Changed `implement-issue` from a hard-coded `dev` branch workflow to
  integration-branch discovery, while still preferring `dev` when the repo
  actually has one.
- Updated `implement-issue/PROVENANCE.md` to match the integration-branch rule.

## Adoption Decision

Adopted: final taxonomy cleanup as a local consolidation slice.

Rejected: creating any new runtime owner during cleanup. No remaining gap passed
the bar of repeated local pain, reduced duplication, direct triggers, and clear
non-use rules.

## Verification

- `git diff --check`: pass.
- Frontmatter parse for `implement-issue/SKILL.md`: pass.
- Runtime source/provenance leakage scan: pass. No external-source names,
  provenance-only fields, `research-discovery`, or superseded coverage-skill
  references remain in runtime `SKILL.md` files outside
  `external-skill-adaptation/SKILL.md`.
- Stale taxonomy scan: pass. No `Next Candidate` section or hard-coded
  `dev`-targeting implementation rules remain.
- `[[skill-review]]` for `implement-issue/SKILL.md`: PASS. The integration
  branch wording improves trigger safety without broadening the skill; `main`
  merges still require explicit authorization.

## Remaining Risk

The final integration target is still a repository decision. This clone exposes
`origin/main`; no remote `dev` branch has been observed. Do not integrate the
adaptation branch until the target is confirmed.
