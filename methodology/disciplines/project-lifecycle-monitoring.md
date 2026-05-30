# Discipline Review: Project Lifecycle Monitoring

- Date: 2026-05-24
- Reviewer: Merlin
- Branch: `feat/project-manager-methodology`
- Local files reviewed: `project-manager/SKILL.md`,
  `implement-issue/SKILL.md`, `browser-qa/SKILL.md`,
  `test-planning/SKILL.md`, `testing-orchestrator/SKILL.md`
- Status: implemented

## Local Baseline

`project-manager` already owned lifecycle and backlog organization after the
implementation-lifecycle pass, but it did not yet make project setup/testability
explicit enough. After adding `browser-qa`, this left a practical gap: feature
issues could be decomposed before the project had runnable commands, CI, seed
data, safe auth, or browser-QA access.

## Adopted Changes

- Added testable project readiness to the skill trigger description.
- Added `[[browser-qa]]` to the ownership boundary.
- Added a readiness gate before feature decomposition:
  install/dev/build/test/preview commands, CI, controlled browser profile,
  safe non-production auth, seed data or fixtures, and durable handoff state.
- Required issue decomposition to include browser-QA scope and auth/test-data
  prerequisites for protected flows.
- Clarified that missing setup becomes setup issue drafts before feature issues.
- Added stale-state recovery from GitHub truth first, then local handoff files.
- Added lifecycle monitoring for stale work, merged PR status drift, blocked
  issues, newly ready work, failing CI, and test/QA coverage gaps.

## Rejections And Deferrals

- Rejected moving per-issue implementation details back into
  `project-manager`; active build execution remains with `[[implement-issue]]`.
- Rejected automatic bulk mutation of GitHub Projects, labels, or issues without
  approval.
- Deferred deeper `test-planning` and `testing-orchestrator` changes to their
  own slice.

## Verification Notes

- `[[skill-review]]` for `project-manager/SKILL.md`: PASS. No Critical or
  Important findings after tightening lifecycle monitoring so GitHub issue
  creation only happens when the user has already authorized that mutation.
- Validation:
  - YAML frontmatter parse passed for `project-manager/SKILL.md`.
  - `git diff --check` passed.
  - repository personal-name scan returned no matches.
