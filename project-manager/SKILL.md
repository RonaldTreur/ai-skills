---
name: project-manager
description: "Manage GitHub-backed project lifecycle: kickoff handoff, repo setup, planning docs, issue decomposition, dependency ordering, project status, and selection of issues for the implement-issue skill. Use when starting a new project, organizing an active project, creating issues from plans, checking progress, or deciding what should be built next."
---

# Project Manager

Use this skill to keep a software project organized across its full lifecycle.

This skill owns project structure, issue hygiene, dependency ordering, status,
and handoff. It does **not** own per-issue implementation. Active issue
execution is delegated to [[implement-issue]].

## Ownership Boundary

- [[project-kickoff]] owns initial brief, design, planning, and decisions.
- `project-manager` owns repo/project setup, planning docs, issue decomposition,
  dependency graph, status, and human approval gates.
- [[implement-issue]] owns active per-issue build execution.
- [[developing-web-projects]] owns web architecture, platform, styling, and
  implementation defaults.
- [[test-planning]] and [[testing-orchestrator]] own testing strategy and
  outside-in test workflow.
- [[code-review]] defines review method and P0-P3 severity for diff review.

When this skill reaches "build this issue", stop orchestrating code details and
invoke [[implement-issue]] with a compact handoff.

## Core Principles

- GitHub Issues are the durable backlog.
- Repo-local docs are project memory: `BRIEF.md`, `DESIGN.md`, `PLAN.md`,
  `TEST_PLAN.md`, `DECISIONS.md`, `DELIVERY_STATE.md`, ADRs, and specs.
- Issues should be independently mergeable slices with explicit dependencies.
- Humans approve product direction, design direction, test strategy, and project
  scope changes.
- Agents may choose conservative implementation defaults inside approved scope.
- Every handoff must be recoverable by a fresh agent from files and GitHub state.

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
   - `DELIVERY_STATE.md`
   - `docs/**/*.md`
   - `specs/**/*.md`
4. Extract:
   - product goal
   - current phase
   - integration branch
   - test/build commands
   - issue dependency conventions
   - blocked decisions
   - next ready issue candidates

## Lifecycle Flow

### 1. Kickoff Handoff

When a new project is still being shaped, invoke [[project-kickoff]] first.
Expect these durable outputs:

- `BRIEF.md`
- `DESIGN.md`
- `PLAN.md`
- `DECISIONS.md`

Before creating build issues, create or update `TEST_PLAN.md` via
[[test-planning]]. For web projects, also load [[developing-web-projects]].

### 2. Issue Decomposition

Turn approved docs into GitHub Issues only after the scope and testing strategy
are stable enough.

Each issue should include:

- summary
- acceptance criteria
- links to relevant `BRIEF.md`, `DESIGN.md`, `PLAN.md`, `TEST_PLAN.md`, and
  `DECISIONS.md` sections
- test scope
- dependencies
- out-of-scope notes
- likely affected areas, without over-prescribing exact code

Prefer issue slices that produce working, testable software. If a planned task
is too large, split it into independently mergeable units.

### 3. Dependency Ordering

Use this readiness rule:

- issue is open
- no `needs-human`, `blocked`, `wontfix`, or `duplicate` label
- blockers are closed or explicitly resolved
- acceptance criteria are testable
- prerequisites exist or can be created inside the issue scope

Sort ready issues by:

1. priority labels: `P0`, `P1`, `P2`, `P3`, then unlabeled
2. dependency order
3. milestone order or due date
4. smallest independently mergeable slice
5. oldest issue
6. lowest issue number

### 4. Sprint / Next-Work Proposal

When asked "what is next?", "next sprint", or "start building":

1. List ready issues and blocked issues.
2. Recommend the next one or two issues with rationale.
3. Identify what can run in parallel without merge conflict.
4. Ask for approval only when changing the backlog, project scope, or a GitHub
   project/label state.
5. Once an issue is selected for active implementation, invoke [[implement-issue]]
   with a compact handoff.

The handoff should include:

- repo path and integration branch
- selected issue number, URL, and acceptance criteria
- relevant dependency/blocker state
- linked or relevant doc sections, not whole planning docs unless needed
- known test/build commands
- active constraints from repo instructions
- current `DELIVERY_STATE.md` checkpoint when present
- known blockers or human decisions

### 5. Status And Recovery

Status reports should include:

- current phase
- active issue/branch/PR
- last verified checkpoint
- checks/reviews/QA state
- blockers
- next concrete action

For long-running projects, keep `DELIVERY_STATE.md` aligned with GitHub state.
If state conflicts, trust durable external truth first: merged PRs, open PRs,
issue labels/comments, CI, then local files.

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

Stop and ask Ronald when:

- project direction or scope is unclear
- issue creation would encode a product decision
- issue dependencies are ambiguous and materially change build order
- a required secret, billing, organization, production, or external-account
  action is needed
- no ready issue remains

For a single blocked issue, mark or document the blocker and continue finding
other ready work when useful.
