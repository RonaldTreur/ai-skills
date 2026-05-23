---
name: implement-issue
description: "Implement one selected GitHub issue or ready backlog slice from repo context through branch, vertical behavior-first tests, code changes, verification, code review, optional Claude review, PR merge into dev, and post-merge QA. Use when asked to build, fix, continue, or implement a specific ready issue in a GitHub-backed software project."
---

# Implement Issue

Use this skill for active implementation of one ready issue or backlog slice.

This is the canonical active-issue implementation workflow. It supersedes the old
`codex-implementation-cycle` alias, which has been removed.

## Ownership Boundary

- [[project-manager]] owns project lifecycle, issue decomposition, backlog
  ordering, and status across many issues.
- `implement-issue` owns one active implementation slice at a time:
  issue selection, branch, tests, implementation, verification, review, PR,
  merge, and post-merge QA.
- [[developing-web-projects]] governs web architecture and implementation
  defaults.
- [[testing-orchestrator]], [[test-planning]], [[e2e-playwright]], and
  [[unit-vitest]] govern testing method and tooling.
- [[code-review]] governs P0-P3 review findings.
- [[debugging]] governs non-trivial failures discovered during implementation.

## Default Authority

When invoked for a ready issue, assume the agent may:

- read repo docs, issues, PRs, and source files
- create a branch from `dev`
- write or update tests and production code
- update `DELIVERY_STATE.md`
- run local checks, tests, build, lint, browser QA, and relevant migrations
- commit, push, open/update a PR targeting `dev`
- run review gates and fix valid P0-P3 findings
- merge into `dev` when checks and review gates are clean
- create follow-up issues for defects, blockers, or out-of-scope work

Ask before:

- production deploys or production-impacting migrations
- secrets, credentials, billing, organization settings, or external accounts
- deleting branches, rewriting history, or destructive filesystem/git actions
- merging to `main`
- changing product scope or user-visible behavior beyond the issue/spec

## Intake

1. Inspect git state:
   - `git status -sb`
   - `git remote -v`
   - `git branch --show-current`
2. Resolve the GitHub repo and selected issue.
3. Read repo-local instructions and project memory:
   - `AGENTS.md`
   - `README.md`
   - `BRIEF.md`, `DESIGN.md`, `PLAN.md`, `IMPLEMENTATION_PLAN.md`
   - `TEST_PLAN.md`, `DECISIONS.md`, `DELIVERY_STATE.md`
   - relevant `docs/`, `specs/`, ADRs, and linked issue/PR context
4. For web projects, load [[developing-web-projects]] before writing code.
5. Identify the implementation slice:
   - issue number and acceptance criteria
   - dependencies
   - affected user behavior
   - relevant tests/checks
   - likely risk areas

If no issue is named, use [[project-manager]] rules to select one ready issue
before entering this workflow.

## Branch And State

Use `dev` as the integration branch.

1. Ensure `origin/dev` exists; create it from the default branch only when the
   repo policy allows and the user has authorized this workflow to do so.
2. Create a focused branch from `dev`, such as `issue-12-short-title`.
3. Update `DELIVERY_STATE.md` with issue, branch, checkpoint, checks, blockers,
   and next action.
4. Add an issue comment or PR note for meaningful checkpoints when the work is
   long-running or delegated.

## Implementation Loop

Use vertical behavior-first slices. Do not generate a large batch of imagined
tests before learning from implementation.

For each meaningful behavior in the issue:

1. Name the behavior and the public interface or user flow it affects.
2. Write the smallest failing E2E or integration-style test that proves that
   behavior. Use unit tests first only when the change is internal-only or the
   public interface is a module/API.
3. Run the test and confirm the expected failure.
4. Implement the smallest production change that makes the test pass.
5. Add focused unit tests for domain logic, validation, data access, edge cases,
   and failure paths exposed by that behavior.
6. Run the narrow checks.
7. Refactor only while green.
8. Repeat for the next behavior until acceptance criteria are covered.

Tests should verify behavior through public interfaces. Avoid tests that lock in
private structure unless the structure is itself the contract.

## Delegation

Prefer Vectrix for substantial implementation unless Ronald explicitly asks for
another runtime or Vectrix is blocked.

When delegating:

- give the sub-agent the exact issue, branch, repo path, relevant docs, active
  skills, and current checkpoint
- keep the write scope clear
- state that other agents may also be working in the repo
- require a report with changed files, tests run, status, blockers, and concerns

Use these statuses:

- `DONE`: implementation and verification completed
- `DONE_WITH_CONCERNS`: work completed but correctness, scope, or design doubts
  remain
- `NEEDS_CONTEXT`: more repo/spec context is needed
- `BLOCKED`: the task cannot be completed safely as scoped

Do not ignore escalations. Provide missing context, split the task, use a more
capable model, or mark the issue blocked.

## Verification Gates

Before review:

- run the narrow tests that prove the changed behavior
- run relevant unit, E2E, typecheck, build, lint, and migration checks
- run browser QA for user-visible browser behavior when feasible
- inspect the diff for unrelated changes

Then run the Codex review loop:

1. Review the diff with [[code-review]].
2. Fix all valid P0-P3 findings.
3. Re-run the smallest meaningful verification.
4. Repeat until no valid P0-P3 findings remain, or rejected findings are
   explicitly justified in the PR/issue.

Run one independent Claude-review pass when available for non-trivial PRs.
Codex then evaluates those findings, fixes valid P0-P3 items, and documents any
rejected findings with rationale.

After review fixes, rerun the checks most likely to catch regressions. If UI or
routing changed, repeat browser QA.

## PR And Merge

Open or update a PR targeting `dev`.

The PR should include:

- linked issue
- scope summary
- acceptance criteria covered
- tests/checks run
- review findings fixed or explicitly rejected
- known follow-ups or blockers

Merge into `dev` only when:

- required checks are green
- valid P0-P3 review findings are fixed
- the issue acceptance criteria are satisfied
- no unresolved human decision blocks the change

After merge, run post-merge QA against `dev` or the closest available preview.
If QA finds defects, create follow-up issues with priority/dependencies and
return to [[project-manager]] for the next work decision.

## Phase Heads-Ups

For visible long-running work, send compact updates at these transitions:

- issue selected
- branch created
- behavior/test slice started
- implementation delegated or started
- self-verification
- Codex review
- Claude-review
- review fixes
- CI/PR gate
- merge
- post-merge QA
- next issue or blocker

Use this shape:

```md
Phase: #<issue> <phase>
State: <branch/PR/checkpoint>
Next: <single concrete action>
```

## Recovery

Fresh-session resume order:

1. Read GitHub issue/PR state.
2. Read `DELIVERY_STATE.md`.
3. Inspect actual git state.
4. Reconcile in favor of durable external truth: merged PRs, open PRs, issue
   labels/comments, CI, then local files.
5. Continue from the last verified checkpoint, not from the last claimed
   checkpoint.

## Stop Conditions

Pause the selected issue when:

- acceptance criteria are not testable
- repo-local instructions conflict and no conservative interpretation exists
- a required secret, credential, production access, billing/org setting, or
  external account action is needed
- implementation would deviate from [[developing-web-projects]] defaults without
  explicit approval
- fixing the issue requires changing product scope or user-visible behavior
  beyond the issue/spec
- all useful checks are blocked by environment or permissions
- the next safe step would be destructive

Document the blocker in `DELIVERY_STATE.md` and the issue/PR. Then return to
[[project-manager]] to find other ready work when useful.
