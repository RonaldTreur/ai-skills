---
name: implement-issue
description: "Implement one ready GitHub issue or backlog slice through branch, behavior-first tests, code changes, verification, review, PR merge, and post-merge QA."
---

# Implement Issue

Use this skill for active implementation of one ready issue or backlog slice.

## Ownership Boundary

- [[project-manager]] owns lifecycle, issue decomposition, backlog ordering, and
  multi-issue status.
- `implement-issue`: one active slice from branch through post-merge QA.
- [[developing-web-projects]]: web architecture and implementation defaults.
- [[testing-orchestrator]], [[test-planning]], [[e2e-playwright]],
  [[unit-vitest]]: testing strategy and tooling.
- [[browser-qa]]: exploratory/post-merge browser QA for user-visible behavior.
- [[code-review]]: review method and P0-P3 severity.
- [[debugging]]: non-trivial failures discovered during implementation.
- [[documentation-handoff]]: `DELIVERY_STATE.md`, PR/issue handoffs, decisions,
  blockers, recovery summaries.

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

1. Inspect git state:
   - `git status -sb`
   - `git remote -v`
   - `git branch --show-current`
2. Resolve the selected issue and current handoff context.
3. Read repo-local instructions: `AGENTS.md`, `.github/copilot-instructions.md`, `.codex/*`.
4. Read only issue-relevant docs: selected issue, linked issue/PR context,
   `DELIVERY_STATE.md`, named handoff sections, and planning/spec/ADR docs only
   when linked, stale, missing from the handoff, or needed for a concrete
   implementation question.
5. For web projects, load [[developing-web-projects]] before writing code.
6. Identify issue number, acceptance criteria, dependencies, behavior,
   tests/checks, browser-QA/auth needs, and risks.

If no issue is named, use [[project-manager]] rules to select one ready issue
before entering this workflow.

Avoid rereading broad planning documents already summarized by [[project-manager]]
unless the handoff is incomplete, inconsistent with the repo, or directly
insufficient for the selected issue.

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

Use [[agent-delegation]] for packet shape, write scopes, parallel safety, and status.
Prefer Vectrix for substantial implementation unless requested otherwise or blocked.

Delegation packets include issue, branch, repo path, relevant docs, active skills,
checkpoint, and expected report: changed files, tests, status, blockers, concerns.

Use "subagent" only for actual spawned Codex/OpenClaw subagents, not for
Vectrix.

## Verification Gates

Before review:

- run narrow behavior tests
- run relevant unit, E2E, typecheck, build, lint, and migrations
- run [[browser-qa]] for user-visible browser changes
- verify safe QA auth for authenticated browser behavior, or stop before merge
  with a blocking setup issue
- inspect the diff for unrelated changes

Review loop:

1. Run [[code-review]]. For non-trivial diffs, let `code-review` use
   `autoreview` as its executable closeout helper when available.
2. Fix valid P0-P3 findings.
3. Rerun the smallest meaningful verification.
4. Repeat until clean or rejected findings are justified.
5. Use one independent review for non-trivial PRs when available. For Ronald's
   OpenClaw projects, default to Claude-review as a read-only review gate before
   merge, then fix valid P0-P3 findings and rerun targeted verification.

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
- valid P0-P3 findings are fixed
- acceptance criteria are satisfied
- browser QA can cover user-visible behavior, including changed auth flows
- no human decision blocks the change

After merge, run [[browser-qa]] against the integration branch or closest
preview. If QA finds defects, create follow-up issues and return to [[project-manager]].

## Phase Heads-Ups

For visible long-running work, send compact updates at major transitions:

- issue selected
- branch created
- behavior/test slice
- implementation
- self-verification
- review
- CI/PR gate
- merge
- post-merge QA
- next issue/blocker

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
