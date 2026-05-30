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

- [[project-kickoff]]: brief, design, plan, decisions.
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
- For new or fuzzy projects, [[project-kickoff]] owns research and discovery
  before issue decomposition.
- Issues should be independently mergeable slices with explicit dependencies.
- Project setup must make local verification, CI, test data, and browser QA
  practical before feature work depends on them.
- Humans approve product direction, design direction, test strategy, and project
  scope changes.
- Agents may choose conservative implementation defaults inside approved scope.
- Every handoff must be recoverable from files and GitHub state.

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
   backlog, scope, priority, or setup decisions; otherwise rely on kickoff
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

## Lifecycle Flow

1. **Kickoff handoff:** if the project is still being shaped, invoke
   [[project-kickoff]] first. Expect `BRIEF.md`, `DESIGN.md`, `PLAN.md`, and
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
