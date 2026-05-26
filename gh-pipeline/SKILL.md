---
name: gh-pipeline
description: "Operate a label-driven GitHub issue pipeline for agent work. Use when setting up or running issue labels that move work through build, test, review, fix, approved, blocked, or failed states across project-manager, implement-issue, testing, review, and delegation workflows."
---

# GitHub Pipeline

Use this skill when GitHub labels are the durable state machine for agent-driven
issue work.

This skill owns pipeline state, label transitions, locks, recovery, and
orchestrator behavior. It does not replace:

- [[project-manager]] for backlog decomposition and next-work selection
- [[implement-issue]] for building one selected issue
- [[testing-orchestrator]] for test strategy and execution flow
- [[code-review]] for review method and finding severity
- [[agent-delegation]] for task packets and multi-agent handoffs

## Core Model

Keep the pipeline deliberately small:

- one issue is in at most one `agent:*` stage at a time
- `status:in-progress` is a lock, not a stage
- `status:blocked`, `status:failed`, and `status:approved` are terminal until
  a human or orchestrator deliberately moves the issue again
- stage transitions happen only after the responsible workflow has produced a
  durable artifact: branch, commit, PR, test result, review, blocker comment, or
  approval
- labels describe truth that can be recovered from GitHub, not aspirations

## Labels

Stage labels:

- `agent:build` - implementation is ready to start
- `agent:test` - implementation exists and needs tests or verification
- `agent:review` - tests/checks are ready for review
- `agent:fix-comments` - review or test feedback needs changes

Status labels:

- `status:in-progress` - one agent has claimed the issue
- `status:blocked` - human decision or missing prerequisite required
- `status:failed` - attempted stage failed unexpectedly and needs diagnosis
- `status:approved` - review passed and the issue is ready for merge/release

Priority labels are project-specific. If none exist, prefer `P0`, `P1`, `P2`,
`P3`; do not invent a second priority taxonomy for the pipeline.

Ask before creating labels in bulk. If labels already exist and the user has
asked to operate the pipeline, normal stage transitions are in scope.

## State Machine

Use this default flow:

```text
agent:build -> agent:test -> agent:review -> status:approved
                                  |
                                  v
                           agent:fix-comments
                                  |
                                  v
                            agent:review
```

Allowed transitions:

- `agent:build` -> `agent:test` when implementation is committed and a PR exists
- `agent:build` -> `status:blocked` when the issue is not buildable as written
- `agent:build` -> `status:failed` for unexpected tooling/runtime failure
- `agent:test` -> `agent:review` when relevant tests/checks pass or an explicit
  test-gap rationale is documented
- `agent:test` -> `agent:fix-comments` when tests expose implementation defects
- `agent:test` -> `status:blocked` when meaningful tests require missing
  product decisions, fixtures, auth paths, or environment setup
- `agent:review` -> `status:approved` when [[code-review]] finds no valid P0-P3
  blockers and required checks are green
- `agent:review` -> `agent:fix-comments` when valid review findings require
  changes
- `agent:fix-comments` -> `agent:review` when comments are addressed and pushed
- `agent:fix-comments` -> `status:blocked` when review comments need human
  judgment or cannot be resolved safely

Do not skip directly from `agent:build` to `status:approved` unless the issue is
documentation-only or explicitly exempt from tests/review, and record why.

## Orchestrator Loop

On each poll:

1. Read open issues with `agent:*` labels and no terminal status.
2. Ignore issues with `status:in-progress` unless the lock is stale.
3. Reject ambiguous state:
   - more than one `agent:*` label
   - terminal status plus active stage
   - closed issue with active stage
4. Sort by project priority, dependency readiness, age, then issue number.
5. Claim one issue by adding `status:in-progress` and commenting the intended
   stage action when useful.
6. Invoke the owning workflow for that stage.
7. Transition labels only after the owning workflow returns an artifact or a
   named blocker.
8. Remove `status:in-progress` last.

If the orchestrator crashes, recover from GitHub truth: issue labels, PR state,
branch existence, commits, checks, review state, and comments. Do not trust a
local memory file over GitHub.

## Stage Ownership

### Build

Use [[implement-issue]].

Input handoff:

- issue number, URL, title, body, acceptance criteria
- repo path and integration branch
- dependency/blocker labels
- expected branch naming convention
- required skills and repo-local instructions

Required output before moving to `agent:test`:

- branch exists
- commit exists
- PR exists and links the issue
- narrow verification has run or a documented reason exists

### Test

Use [[testing-orchestrator]] for non-trivial behavior changes. For tiny changes,
[[implement-issue]] may add the focused tests directly.

Required output before moving to `agent:review`:

- relevant tests/checks pass, or the PR documents why a test gap is acceptable
- any test-created fixes are committed and pushed
- browser-test/auth/fixture blockers are captured as blockers instead of hidden

### Review

Use [[code-review]].

Required output before moving to `status:approved`:

- fixed review base is identified
- issue/spec compliance, repo standards, and risk/quality are reviewed
- no valid P0-P3 findings remain
- required checks are green or explicitly waived by the project owner

### Fix Comments

Use [[implement-issue]] with the PR review comments as the selected work.

Required output before moving back to `agent:review`:

- valid comments are addressed
- rejected comments have a short rationale
- changes are committed and pushed
- narrow checks affected by the fixes have run

## Locks And Stale Work

`status:in-progress` prevents double pickup. Before claiming an issue:

1. Re-read the issue labels.
2. Confirm the expected stage label is still present.
3. Add `status:in-progress`.
4. Re-read labels again before dispatching work.

A lock is stale when there is no recent issue/PR comment, commit, check run, or
agent status update for the project-defined timeout. When clearing a stale lock,
comment with the evidence used and the next stage decision.

## Loop And Failure Handling

Track repeated review/fix loops in an issue or PR comment, for example:

```text
<!-- gh-pipeline:review-fix-loops=2 -->
```

After three review/fix loops, move to `status:blocked` unless the next fix is
obvious and low-risk.

Use `status:blocked` for known missing context or human decisions. Use
`status:failed` for unexpected tool/runtime failure that needs diagnosis before
the issue can continue.

Every blocked or failed transition needs a comment with:

- current stage
- exact blocker or failure
- evidence checked
- next human or agent action needed

## Setup

Before enabling a repository:

1. Confirm the repo has [[project-manager]]-level readiness: integration branch,
   runnable checks, issue conventions, and enough test/QA setup for feature
   work.
2. Ask before creating the pipeline labels in bulk.
3. Decide whether the orchestrator may mutate issues automatically or should run
   in dry-run/report-only mode.
4. Decide lock timeout, max concurrent issues, and notification channel.
5. Record the repo allow-list and settings in the local project handoff or
   approved config location.

Do not wire production-impacting deployment, release, or billing actions into
the pipeline unless the user explicitly authorizes that specific automation.

## Status Output

Pipeline status should be concise:

```text
Repo: owner/repo
Active: #12 agent:test, PR #34, lock age 8m
Blocked: #9 missing test auth path
Approved: #7 ready to merge
Next: run test stage for #12
```

For visible chat updates, report only durable transitions, blockers, and final
artifacts. Do not spam routine polling noise.
