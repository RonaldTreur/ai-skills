---
name: implement-issue
description: "Implement one ready GitHub issue or backlog slice through branch, behavior-first tests, code changes, verification, review, PR merge, and post-merge QA."
---

# Implement Issue

Owns one active slice from branch through post-merge QA. Lifecycle ownership is
in [[project-manager]].

## Authority

For a ready issue, assume the agent may:

- read project state
- create a focused branch
- edit tests/code/docs
- update `DELIVERY_STATE.md`
- run checks and [[browser-qa]]
- commit, push, and open/update a PR
- create/update ADRs for architecture decisions discovered inside scope
- fix valid P0-P3 review findings
- merge to the authorized integration branch
- create follow-up issues

Ask before:

- production deploys or migrations
- secrets, billing, org, or external-account actions
- destructive git/filesystem operations
- merging to `main` without explicit authorization
- changing product scope beyond the issue/spec

## Intake

1. Resolve the selected issue and current handoff context.
2. Read the repo's agent instruction files.
3. Read only issue-relevant docs: selected issue, linked issue/PR context,
   `DELIVERY_STATE.md`, named handoff sections, and planning/spec/ADR docs only
   when linked, stale, missing from the handoff, or needed for a concrete
   implementation question.
4. For web projects, load [[developing-web-projects]] before writing code.
5. Identify issue number, acceptance criteria, dependencies, behavior,
   tests/checks, browser-QA/auth needs, and risks.

If no issue is named, use [[project-manager]] rules to select one ready issue
before entering this workflow.

## Branch And State

Use the repo's active integration branch. Prefer `dev` only when the repo
already has one. Otherwise use the documented integration/default branch; never
create `dev` just because this workflow was invoked.

1. Identify the integration branch from instructions, open PR targets, or remotes.
2. Create a focused branch, e.g. `issue-12-short-title`.
3. Update `DELIVERY_STATE.md` with issue, branch, checkpoint, checks, blockers,
   and next action via [[documentation-handoff]].
4. Add issue/PR notes for meaningful long-running or delegated checkpoints.

## Implementation Loop

Use vertical behavior-first slices. Do not batch imagined tests before learning
from implementation.

For each meaningful behavior:

1. Name the behavior and affected public interface/user flow.
2. Identify browser QA and safe non-production auth/test data when needed.
3. Write the smallest failing E2E/integration test; use unit tests first only for
   internal/module/API behavior.
4. Confirm failure, make the smallest passing change, add focused unit coverage,
   run narrow checks, refactor only while green, then repeat.

Tests should verify behavior through public interfaces. Avoid tests that lock in
private structure unless the structure is itself the contract.

## Delegation

When another agent does the work, use `references/delegation.md` under
[[project-manager]] for the packet, write scope, parallel safety and status.

## Verification Gates

Before review:

- run narrow behavior tests
- run relevant unit, E2E, typecheck, build, lint, and migrations
- run [[browser-qa]] for user-visible browser changes
- verify safe QA auth for authenticated browser behavior, or stop before merge
  with a blocking setup issue
- inspect the diff for unrelated changes

Review loop:

1. Run [[code-review]].
2. Fix valid P0-P3 findings.
3. Rerun the smallest meaningful verification.
4. Repeat until clean or rejected findings are justified.
5. For non-trivial PRs, one independent review of the PR diff, started only
   once the branch's checks ran and the PR body records the checks, browser QA
   and review findings listed below; then fix valid P0-P3 findings and rerun
   targeted verification.

After review fixes, rerun checks most likely to catch regressions. If UI/routing
changed, repeat [[browser-qa]].

## PR And Merge

Open or update a PR targeting the repo integration branch.

PR body includes:

- linked issue
- scope
- acceptance criteria covered
- docs/decisions updated
- ADRs created/updated when architecture changed
- tests/checks run
- review findings
- follow-ups/blockers

Merge only when:

- required checks are green
- an independent review ran on the PR diff for non-trivial PRs
- valid P0-P3 findings are fixed
- acceptance criteria are satisfied
- browser QA can cover user-visible behavior, including changed auth flows
- no human decision blocks the change

After merge, run [[browser-qa]] against the integration branch or closest
preview. If QA finds defects, create follow-up issues and return to [[project-manager]].

## Phase Heads-Ups

For visible long-running work, send a compact update at each major transition:

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
5. Continue from the last verified checkpoint, not the last claimed checkpoint.

## Stop Conditions

Pause when:

- acceptance criteria are not testable
- browser QA lacks safe auth, seed data, fixtures, or preview
- repo instructions conflict
- secrets, production access, billing/org settings, or external accounts are
  needed
- implementation would deviate from [[developing-web-projects]] without approval
- the fix changes product scope beyond the issue/spec
- the fix requires an architecture decision not covered by an existing ADR,
  plan, or explicit user approval
- useful checks are blocked
- the next safe step is destructive

Document the blocker in `DELIVERY_STATE.md` and the issue/PR using
[[documentation-handoff]]. Then return to [[project-manager]] to find other
ready work when useful.
