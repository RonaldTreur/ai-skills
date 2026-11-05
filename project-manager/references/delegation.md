# Delegation

Read this after a workflow has decided that another agent, runtime or subagent will do part of the work. It is the protocol, not a reason to delegate: default to one capable agent for small, sequential, tightly coupled or ambiguous work, and keep work local when the next step is blocked on its result or the coordination costs more than the work.

## Packet

Every delegated task carries:

- **Goal**: one concrete outcome.
- **Repo/path**: exact working directory or artifact folder.
- **Inputs**: issue URL, plan unit, files, docs, screenshots or commands to read first. Pass paths and durable artifact names, not pasted context, when the delegate can read the files.
- **Scope**: in scope and explicitly out of scope.
- **Write boundaries**: files, folders or artifact paths the delegate may edit.
- **Coordination note**: whether other agents may be editing the same repo.
- **Verification**: tests, checks, browser pass or review expected before reporting done.
- **Return format**: status, changed files, checks run, blockers and concerns. For implementation work, the branch, the PR and the verification that ran, so the controller can inspect the artifact.

## Parallel safety

Parallel only when all four hold:

- write scopes do not overlap;
- tasks can complete in any order;
- each task has its own fixture, data, browser or session needs;
- no task's output is required before another starts.

Serialize when tasks touch the same files or migrations, when one change may invalidate another's assumptions, when a single coherent design decision is needed first, or when shared local services, accounts, ports or test data would collide.

## Status contract

The delegate returns exactly one of:

- `DONE`: work and requested verification completed.
- `DONE_WITH_CONCERNS`: completed, but correctness, scope, design or verification concerns remain.
- `NEEDS_CONTEXT`: specific missing context prevents safe progress.
- `BLOCKED`: the task cannot be completed safely as scoped.

An escalation gets an answer: provide the context, split the task, change the runtime, narrow the scope, or mark the parent work blocked.

## Controller duties

The coordinating agent stays responsible for the outcome.

Before dispatch:

1. Decide whether delegation is worth the coordination cost.
2. Define write scope and expected output.
3. Make the task self-contained for a fresh agent.
4. Name the skills the delegate should follow.

After return:

1. Read the summary and the changed files.
2. Check for scope drift and conflicts with other work.
3. Run or review the stated verification.
4. Integrate or revise before reporting completion.

A report is evidence, not proof.

## Prompt shape

```text
Task: <one concrete outcome>

Read first:
- <file or URL>

Scope:
- In scope: <specific work>
- Out of scope: <explicit exclusions>

Write scope:
- <allowed files/folders/artifacts>

Constraints:
- Other agents may be working in this repo; do not revert unrelated edits.
- Follow <relevant skill paths or local instructions>.
- Stop and report NEEDS_CONTEXT or BLOCKED instead of guessing.

Verify:
- <commands/checks/browser/review expected>

Return:
- Status: DONE | DONE_WITH_CONCERNS | NEEDS_CONTEXT | BLOCKED
- Changed files or artifacts
- Checks run and results
- For implementation: branch, PR, and the verification that ran
- Blockers, concerns, or follow-up needed
```

For read-only review or critique, set write scope to `none` and ask for findings grounded in files, lines, screenshots or artifact names.
