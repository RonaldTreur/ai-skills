---
name: codex-implementation-cycle
description: Use when Ronald wants a feature or fix implemented through Codex ACP with a full implementation cycle: implement, self-verify, review, fix all P0-P3 findings, and merge.
---

# Codex Implementation Cycle

Use this skill when Ronald wants a feature or fix delivered with a strict done-definition, not just a patch.

This workflow is specifically for implementation work that must be driven through **Codex ACP**.

## Required flow

Always run these steps in order:

1. **Implement the requested feature / fix**
2. **Verify it yourself**
   - if possible, check it in the browser or otherwise validate the real user-facing behavior
3. **Review using the `code-review` skill**
4. **Fix all P0-P3 findings**
5. **Merge**

Do not stop at “implemented” or “PR open” if the request implies completion.

## Runtime requirements

For this workflow:

- all **code changes** must be done through **Codex ACP**
- all **review/fix cycles** must also be done through **Codex ACP**
- default model/runtime expectation:
  - `openai-codex/gpt-5.5/medium`
  - via ACP

If ACP is blocked or broken, state the blocker plainly instead of silently falling back to a different coding path.

## Checkpointed execution (default for longer work)

For longer coding tasks, do **not** rely on one final completion callback as the source of truth.

Default to **checkpointed execution**.

This means the workflow should produce or verify intermediate reality-based checkpoints instead of only waiting for a final “done” message.

### Default checkpoints

Use these checkpoints unless Ronald explicitly asks for a different gate:

1. **Implementation artifact**
   - branch, commit, changed files, or PR artifact exists
2. **Self-verification complete**
   - browser check, test run, build, lint, or other direct proof
3. **Review complete**
   - review findings summarized
4. **P0-P3 fixes applied**
   - follow-up artifact and recheck evidence
5. **Merge complete**
   - merge commit, merged PR, or equivalent final artifact

### Operational rule

For long Codex/Vectrix work:

- prefer checkpoint-style progress over silence
- do not trust the first status line as final truth
- if the final handoff is missing or suspicious, inspect repo state, child transcript, commits, tests, and artifacts before reporting status
- report the furthest verified checkpoint reached

### User shorthand

If Ronald says **"checkpointed"**, interpret that as:

- use the normal implementation cycle
- require checkpoint-style progress
- avoid brittle fire-and-forget delegation

He should not need to specify checkpoints manually unless the task needs special gates.

## Step-by-step guidance

### 1) Implement

- delegate the implementation to Codex ACP
- keep the task focused and concrete
- include the relevant project skill(s) when they apply
- require a branch/commit/PR artifact, not just analysis

### 2) Self-verify

After implementation, verify with the cheapest meaningful gate:

- browser check for UI/user-flow changes when possible
- otherwise relevant tests, build, lint, or direct inspection
- prefer real behavior checks over code-only confidence

If browser verification is expected and feasible, do it.

### 3) Review

Use the `code-review` skill for the review pass.

Review should look for at least:

- regressions
- architecture issues
- security/privacy problems
- reliability issues
- convention violations
- hidden edge cases

### 4) Fix all P0-P3 findings

Do not stop after receiving findings.

All review findings in these severities must be addressed:

- P0
- P1
- P2
- P3

If a finding is rejected, explain why explicitly.

After fixes, re-run the smallest meaningful verification again.

### 5) Merge

Completion means merge, unless Ronald explicitly asks to stop earlier.

Use the normal git workflow:

- branch
- commit
- push
- PR
- review
- fix
- merge

Follow the git conventions skill.

## Reporting back

When reporting progress or completion, include:

- current step in the 5-step cycle
- artifact produced
- verification performed
- review outcome
- whether all P0-P3 findings are resolved
- merge status

Avoid vague updates like “done” when the work is only at implementation or review stage.

## Real blockers

Only treat these as true blockers:

- ACP unavailable/broken
- required credentials or approvals missing
- repo/service access missing
- failing checks/findings that still need user decision

A long task is not a blocker.

## Definition of done

This workflow is done only when all are true:

- feature/fix implemented
- self-verified
- reviewed through the code-review workflow
- all P0-P3 findings fixed or explicitly resolved
- changes merged
