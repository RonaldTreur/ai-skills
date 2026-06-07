---
name: project-manager
description: "Manage GitHub-backed project lifecycle: repo setup, planning docs, issue decomposition, dependency ordering, status recovery, and next-work selection."
---

# Project Manager

Use this skill to keep a software project organized across its full lifecycle.

Own project structure, issue hygiene, dependency ordering, status, and handoff.
Do not own per-issue implementation; route active execution to
[[implement-issue]].

## Ownership Boundary

- [[start-new-project]]: brief, design, plan, decisions.
- `project-manager`: repo setup, planning docs, issue decomposition,
  dependency graph, status, approval gates.
- [[implement-issue]]: active per-issue build execution.
- [[test-planning]] / [[testing-orchestrator]]: test strategy and workflow.
- [[browser-qa]]: browser verification; ensure setup makes it possible.
- [[documentation-handoff]]: durable docs, continuation state, handoffs.
- [[agent-delegation]]: delegation packets, write scopes, status, parallel
  safety.

When this skill reaches "build this issue", stop orchestrating code details and
invoke [[implement-issue]] with a compact handoff.

## Core Principles

- GitHub Issues are the durable backlog.
- Repo-local docs are project memory; use [[documentation-handoff]] for artifact
  roles and recoverable handoffs.
- For new or fuzzy projects, [[start-new-project]] owns research and discovery
  before issue decomposition.
- Issues should be independently mergeable slices with explicit dependencies.
- Project setup must make local verification, CI, test data, and browser QA
  practical before feature work depends on them.
- Humans approve product direction, design direction, test strategy, and project
  scope changes.
- Agents may choose conservative implementation defaults inside approved scope.
- Every handoff must be recoverable from files and GitHub state.

## Default Agent Roles

For Ronald's OpenClaw projects, use this delivery split unless the user says
otherwise:

- Merlin/main coordinates project state, issue routing, verification, and merge
  judgment.
- Vectrix owns implementation and the first implementation review/fix loop for
  ready build issues.
- Claude-review is the independent read-only review gate before merge for
  non-trivial PRs.
- Vectrix fixes valid Claude-review P0-P3 findings and reruns targeted
  verification before merge.

Merlin must not route a Vectrix implementation report to Claude-review until the
report includes the [[implement-issue]] loop evidence: active skills used,
tests-first or behavior-coverage decision, verification results, browser-QA
applicability/result, code-review result, P0-P3 fix status, and `ready for
independent review: yes`. A PR link or "checks passed" is not enough.

## Default Authority

Safe to do without asking:

- read repo docs, issues, PRs, and project state
- create or update planning drafts and issue drafts
- propose labels, milestones, and issue ordering
- create local planning artifacts
- summarize progress and blockers

Ask before:

- creating a new GitHub repository
- creating or mutating GitHub Projects/labels in bulk
- creating many issues from a plan
- changing project scope, design direction, or product behavior
- merging/releasing/deploying unless already covered by an invoked implementation workflow

## Repo Intake

1. Inspect repository state:
   - `git status -sb`
   - `git remote -v`
   - `git branch --show-current`
2. Read local instructions:
   - `AGENTS.md`
   - `README.md`
   - `.github/copilot-instructions.md`
   - `.codex/*`
3. Read project memory when present:
   - `BRIEF.md`
   - `DESIGN.md`
   - `PLAN.md`
   - `IMPLEMENTATION_PLAN.md`
   - `TEST_PLAN.md`
   - `DECISIONS.md`
   - `docs/adr/**/*.md`
   - `DELIVERY_STATE.md`
   - `docs/**/*.md`
   - `specs/**/*.md`
   - `.github/workflows/**/*.yml`
   - `package.json`
4. Read relevant repo, issue, PR, and memory context before asking the user to
   restate project state. Use current external research only when it can change
   backlog, scope, priority, or setup decisions; otherwise rely on start-new-project
   artifacts and GitHub truth.
5. Extract:
   - product goal
   - current phase
   - integration branch
   - test/build commands
   - local run or preview command
   - issue dependency conventions
   - QA/auth/test-data setup
   - blocked decisions
   - next ready issue candidates

## TODO Intake

When the user asks to turn a TODO list into issues and start work, treat that as
authorization to draft or create the issues unless they explicitly ask for a
proposal only. Do not turn TODO text into code tasks mechanically.

1. Normalize each TODO into a backlog candidate:
   - outcome
   - user-visible behavior or internal contract
   - acceptance criteria
   - likely affected area
   - test and browser-QA scope
   - dependencies and blockers
   - out-of-scope notes
2. Merge duplicates, split oversized TODOs into independently mergeable slices,
   and keep setup/readiness work ahead of dependent feature work.
3. If a TODO hides a product decision, design decision, architecture decision,
   secret, production action, or unclear dependency, mark it blocked and ask for
   the decision instead of encoding a guess as an issue.
4. Create or update GitHub Issues using the repo's existing labels and milestone
   conventions. If the repo has no conventions, use the simple labels below and
   avoid bulk label creation unless approved.
5. List ready and blocked issues, recommend the first issue to process, then
   invoke [[implement-issue]] for the first ready issue when the user asked to
   start processing.

Compact prompt this skill should satisfy:

```text
Use project-manager to convert this TODO list into GitHub issues, order
dependencies, identify ready vs blocked work, then start the first ready issue
with Vectrix using implement-issue. Use the default roles: Merlin coordinates,
Vectrix implements and self-reviews, Claude-review is the independent pre-merge
review gate.
```

## Lifecycle Flow

1. **Kickoff handoff:** if the project is still being shaped, invoke
   [[start-new-project]] first. Expect `BRIEF.md`, `DESIGN.md`, `PLAN.md`, and
   `DECISIONS.md`. Before build issues, create/update `TEST_PLAN.md`; for web
   projects, load [[developing-web-projects]].
2. **Readiness gate:** verify:
   - documented install/dev/build/test/preview commands
   - meaningful CI
   - browser-QA access
   - safe non-production auth for protected flows
   - seed data, fixtures, or reset steps
   - `DELIVERY_STATE.md` for long-running work

   Missing readiness becomes setup issues before feature issues.
3. **Issue decomposition:** create issues only after scope and testing strategy
   are stable. Each issue needs:
   - summary
   - acceptance criteria
   - linked docs
   - test scope
   - browser-QA/auth/test-data prerequisites
   - dependencies
   - out-of-scope notes
   - likely affected areas

   Prefer independently mergeable slices.
   If an issue depends on an architectural choice that is not recorded, create
   or request an ADR via [[documentation-handoff]] before encoding the work.
4. **Dependency ordering:** an issue is ready when open, unblocked, testable,
   and its QA/auth/test-data path exists or is part of scope. Sort by `P0`-`P3`,
   dependency order, milestone/due date, smallest mergeable slice, age, then
   issue number.
5. **Next-work proposal:** list ready and blocked issues, recommend the next one
   or two, identify safe parallel work, and ask only before changing backlog,
   scope, labels, or project state. When selected, invoke [[implement-issue]]
   with a compact [[documentation-handoff]] packet.
   When a delegate returns, reject incomplete implementation handoffs before
   independent review: no loop evidence means the issue is still in
   implementation.
6. **Status and recovery:** report:
   - phase
   - active issue/branch/PR
   - last verified checkpoint
   - checks/QA/review state
   - blockers
   - next action

   On stale state, trust merged PRs, open PRs, issue labels/comments, CI, then
   local files.
7. **Lifecycle monitoring:** flag:
   - stale issues/PRs
   - missed issue/project status
   - `needs-human` or `blocked` decisions
   - newly unblocked work
   - failing CI
   - gaps between `TEST_PLAN.md`, implemented tests, and browser-QA coverage

   Create drafts/issues only when authorized; do not start implementation unless
   requested.

## Labels

Use simple labels unless the repo already has its own taxonomy:

- priority: `P0`, `P1`, `P2`, `P3`
- type: `type:feature`, `type:bug`, `type:task`, `type:test`,
  `type:design`
- phase: `phase:kickoff`, `phase:design`, `phase:planning`,
  `phase:build`, `phase:review`, `phase:qa`
- state: `needs-human`, `blocked`
- agent: `agent:vectrix`, `agent:merlin`

Do not create or mutate labels in bulk without approval.

## Stop Conditions

Stop and ask the user when:

- project direction or scope is unclear
- issue creation would encode a product decision
- issue creation would encode an unrecorded architecture decision
- issue dependencies are ambiguous and materially change build order
- project setup lacks the runnable commands, CI, seed data, auth path, or
  browser-QA access needed to make feature issues testable
- a required secret, billing, organization, production, or external-account
  action is needed
- no ready issue remains

For a single blocked issue, mark or document the blocker and continue finding
other ready work when useful.
