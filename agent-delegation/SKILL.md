---
name: agent-delegation
description: "Use after deciding to delegate work to another agent/runtime/subagent. Defines scope, context, write boundaries, status reporting, parallel safety, and integration review."
---

# Agent Delegation

Use this skill when another agent, runtime, or subagent will do part of the
work. The goal is to make delegation recoverable, bounded, and reviewable.

This skill is not a reason to delegate. It is the protocol for delegation after
a workflow has already decided that another agent will materially improve speed,
focus, review quality, or independent exploration.

This skill owns delegation mechanics. It does not decide project priority,
issue scope, frontend direction, test strategy, or code-review findings; those
belong to the workflow skill that invoked delegation.

## When To Delegate

Delegate only when the invoking workflow has a concrete reason:

- an implementation slice is ready for a dedicated implementation agent
- multiple tasks are independent and can run without shared state
- a specialist perspective would catch real risk
- a fresh context is useful for review, critique, or variant generation
- the coordinating agent can keep doing non-overlapping work while the delegate
  runs
- the work is large enough that coordination cost is lower than local execution

Default to one capable agent for small, sequential, tightly coupled, or
ambiguous work. Keep work local when the next step is blocked on the result, or
when the coordination cost is larger than the work.

## Delegation Packet

Every delegated task needs a compact packet:

- **Goal**: one concrete outcome.
- **Repo/path**: exact working directory or artifact folder.
- **Inputs**: issue URL, plan unit, files, docs, screenshots, or commands to
  read first.
- **Scope**: what is in scope and explicitly out of scope.
- **Write boundaries**: files, folders, or artifact paths the delegate may edit.
- **Coordination note**: whether other agents may be editing the same repo.
- **Verification**: tests, checks, browser pass, or review expected before
  reporting done.
- **Return format**: status, changed files, checks run, blockers, and concerns.

Pass file paths and durable artifact names instead of pasting long context when
the delegate can read the files directly.

## Parallel Safety

Run agents in parallel only when their work is genuinely independent.

Parallel work is safe when:

- write scopes do not overlap
- tasks can complete in any order
- each task has its own fixture/data/browser/session needs
- one task's output is not required before another starts

Do not parallelize when:

- tasks touch the same files or migrations
- one change may invalidate another task's assumptions
- the system needs a single coherent design decision first
- shared local services, accounts, ports, or test data would collide

## Status Contract

Require one of these statuses:

- `DONE`: work and requested verification completed
- `DONE_WITH_CONCERNS`: work completed, but correctness, scope, design, or
  verification concerns remain
- `NEEDS_CONTEXT`: specific missing context prevents safe progress
- `BLOCKED`: the task cannot be completed safely as scoped

Do not ignore escalations. Provide missing context, split the task, change the
model/runtime, narrow the scope, or mark the parent work blocked.

## Controller Duties

The coordinating agent remains responsible for the outcome.

Before dispatch:

1. Decide whether delegation is worth the coordination cost.
2. Define the write scope and expected output.
3. Make the task self-contained enough for a fresh agent.
4. Preserve the relevant skill references in the delegate prompt.

After return:

1. Read the delegate's summary and changed files.
2. Check for scope drift and conflicts with other work.
3. Run or review the stated verification.
4. Integrate or revise the result before reporting completion.

Delegate reports are evidence, not proof. The controller must still inspect the
work before treating it as done.

## Prompt Shape

Use this shape for implementation or artifact work:

```text
Task: <one concrete outcome>

Read first:
- <file or URL>
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
- Blockers, concerns, or follow-up needed
```

For read-only review or critique, set write scope to `none` and ask for findings
grounded in files, lines, screenshots, or artifact names.
