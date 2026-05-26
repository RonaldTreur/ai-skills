---
name: project-manager
description: "Manage GitHub-backed project lifecycle: kickoff handoff, repo setup, planning docs, testable project readiness, issue decomposition, dependency ordering, project status, and selection of issues for the implement-issue skill. Use when starting a new project, organizing an active project, creating issues from plans, checking progress, recovering stale project state, or deciding what should be built next."
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
- [[browser-qa]] owns browser-based user-flow verification. `project-manager`
  ensures repo setup and issue decomposition make that verification possible.
- [[code-review]] defines review method and P0-P3 severity for diff review.
- [[agent-delegation]] defines the handoff packet, write-scope, status, and
  parallel-safety rules when work is sent to another agent.
- [[documentation-handoff]] defines durable project docs, continuation state,
  decision capture, and recoverable handoff packets.

When this skill reaches "build this issue", stop orchestrating code details and
invoke [[implement-issue]] with a compact handoff.

## Core Principles

- GitHub Issues are the durable backlog.
- Repo-local docs are project memory. Use [[documentation-handoff]] for artifact
  roles such as `BRIEF.md`, `DESIGN.md`, `PLAN.md`, `TEST_PLAN.md`,
  `DECISIONS.md`, `DELIVERY_STATE.md`, ADRs, and specs.
- Issues should be independently mergeable slices with explicit dependencies.
- Project setup must make local verification, CI, test data, and browser QA
  practical before feature work depends on them.
- Humans approve product direction, design direction, test strategy, and project
  scope changes.
- Agents may choose conservative implementation defaults inside approved scope.
- Every handoff must be recoverable by a fresh agent from files and GitHub state.
  Use [[documentation-handoff]] for the compact handoff shape.

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
   - `.github/workflows/**/*.yml`
   - `package.json`
4. Extract:
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

### 1. Kickoff Handoff

When a new project is still being shaped, invoke [[project-kickoff]] first.
Expect these durable outputs:

- `BRIEF.md`
- `DESIGN.md`
- `PLAN.md`
- `DECISIONS.md`

Before creating build issues, create or update `TEST_PLAN.md` via
[[test-planning]]. For web projects, also load [[developing-web-projects]].

Then check project readiness before feature decomposition:

- repo has documented install, dev, build, test, and preview commands
- CI runs the same meaningful unit/E2E/build checks expected locally
- browser QA can reach the app through the active agent's controlled profile
- protected or role-specific flows have a safe non-production auth path:
  documented test account, seeded local user, fixture, ignored storage state, or
  production-disabled developer login
- seed data, fixtures, or reset steps exist for issue-level tests and QA
- `DELIVERY_STATE.md` or equivalent handoff state exists for long-running work

If readiness is missing, create setup issue drafts before feature issues. Do not
bury missing QA access, missing test data, or missing commands inside unrelated
feature issues.

### 2. Issue Decomposition

Turn approved docs into GitHub Issues only after the scope and testing strategy
are stable enough.

Each issue should include:

- summary
- acceptance criteria
- links to relevant `BRIEF.md`, `DESIGN.md`, `PLAN.md`, `TEST_PLAN.md`, and
  `DECISIONS.md` sections
- test scope
- browser QA scope, including auth/test-data prerequisites for protected flows
- dependencies
- out-of-scope notes
- likely affected areas, without over-prescribing exact code

Prefer issue slices that produce working, testable software. If a planned task
is too large, split it into independently mergeable units.

Create setup and infrastructure issues before feature issues when feature work
would otherwise depend on missing scripts, CI, seed data, test accounts,
preview/deployment plumbing, or browser-QA access.

### 3. Dependency Ordering

Use this readiness rule:

- issue is open
- no `needs-human`, `blocked`, `wontfix`, or `duplicate` label
- blockers are closed or explicitly resolved
- acceptance criteria are testable
- QA path, auth path, and test data are available or are explicitly part of the
  issue scope
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
   with a compact handoff shaped by [[documentation-handoff]].

Use [[agent-delegation]] when routing work to another agent. The handoff should
include:

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

For long-running projects, use [[documentation-handoff]] to keep
`DELIVERY_STATE.md` aligned with GitHub state. If state conflicts, trust durable
external truth first: merged PRs, open PRs, issue labels/comments, CI, then
local files.

When recovering stale or ambiguous project state:

1. Read open issues, open PRs, recently merged PRs, and failing CI.
2. Reconcile `DELIVERY_STATE.md` with GitHub state.
3. Identify the current integration branch and active feature branches.
4. Separate ready work from blocked work.
5. Report one next concrete action instead of a broad project summary when the
   user is waiting for a decision.

### 6. Lifecycle Monitoring

Use this skill for periodic or manual project-health checks. Report:

- stale active issues or PRs with no recent verified checkpoint
- merged PRs whose issue/project status was not updated
- `needs-human` or `blocked` issues and the decision needed
- newly unblocked issues that are ready for [[implement-issue]]
- failing CI on the integration branch
- gaps between `TEST_PLAN.md`, implemented tests, and browser-QA coverage

Lifecycle monitoring should create local issue drafts for real defects or setup
gaps, or create GitHub issues when the user already authorized that mutation,
then return to next-work selection. It should not silently start a new
implementation unless the user already asked for that workflow.

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
- issue dependencies are ambiguous and materially change build order
- project setup lacks the runnable commands, CI, seed data, auth path, or
  browser-QA access needed to make feature issues testable
- a required secret, billing, organization, production, or external-account
  action is needed
- no ready issue remains

For a single blocked issue, mark or document the blocker and continue finding
other ready work when useful.
