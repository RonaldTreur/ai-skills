---
name: project-manager
description: End-to-end project lifecycle management using GitHub Issues + Projects. Orchestrates the full flow from idea → kickoff → design → implementation → delivery, using outside-in test-driven development. Use when starting a new project, managing active development, or tracking work across agents.
---

# Project Manager — GitHub Issues Lifecycle Orchestrator

Manages the full development lifecycle of a project using GitHub Issues and GitHub Projects as the single source of truth. Uses **outside-in test-driven development** as the core build methodology.

## Linked Skills

Read these before starting. They define the capabilities this skill orchestrates:

**Project definition:**
- `/Users/merlin/.openclaw/workspace-main/skills/project-kickoff/SKILL.md` — 3-phase kickoff (brief → design → planning)
- `/Users/merlin/.openclaw/workspace-main/skills/ui-design-prompt/SKILL.md` — TC-EBC design framework

**Development:**
- `/Users/merlin/Development/skills/developing-web-projects/SKILL.md` — stack conventions
- `/Users/merlin/openclaw/skills/coding-agent/SKILL.md` — Codex/Vectrix delegation

**Testing (outside-in TDD):**
- `/Users/merlin/Development/skills/testing-orchestrator/SKILL.md` — orchestrates the full test pipeline
- `/Users/merlin/Development/skills/test-planning/SKILL.md` — generates TEST_PLAN.md
- `/Users/merlin/Development/skills/e2e-playwright/SKILL.md` — E2E tests (planner → generator → healer)
- `/Users/merlin/Development/skills/unit-vitest/SKILL.md` — unit tests
- `/Users/merlin/Development/skills/enforcing-test-coverage-vitest-playwright/SKILL.md` — coverage enforcement

**Operations:**
- `/Users/merlin/openclaw/skills/gh-issues/SKILL.md` — issue monitoring + auto-fix + PR review handling
- `/Users/merlin/openclaw/skills/github/SKILL.md` — `gh` CLI operations

## Philosophy

- **GitHub Issues is the kanban board.** No external tools, no custom boards.
- **Tests are the spec.** Outside-in TDD: write failing tests first, then implement to make them pass.
- **One issue = one deliverable.** Issues should be small enough for a single pipeline run.
- **Documents are context.** BRIEF.md, DESIGN.md, PLAN.md, TEST_PLAN.md, DECISIONS.md live in the repo — they ARE the project memory.
- **Agents work, humans steer.** Agents pick up issues, do the work, open PRs. Humans review and approve.
- **Fail visible.** If an agent can't complete an issue, it comments why and labels it `needs-human`.

## Repository Setup

When starting a new project, create the GitHub repo and project board:

### Step 1: Create Repository

```bash
gh repo create <owner>/<project-name> --private --clone
cd <project-name>
```

### Step 2: Create Labels

```bash
# Phase labels (mutually exclusive)
gh label create "phase:kickoff" --color "1d76db" --description "Project kickoff phase"
gh label create "phase:design" --color "a2eeef" --description "UI/UX design phase"
gh label create "phase:planning" --color "d4c5f9" --description "Implementation planning phase"
gh label create "phase:build" --color "0e8a16" --description "Active development"
gh label create "phase:review" --color "fbca04" --description "In review"

# Type labels
gh label create "type:feature" --color "a2eeef" --description "New feature"
gh label create "type:task" --color "c5def5" --description "Task or chore"
gh label create "type:bug" --color "d73a4a" --description "Bug fix"
gh label create "type:design" --color "f9d0c4" --description "Design work"
gh label create "type:test" --color "bfd4f2" --description "Test infrastructure"

# Pipeline step labels (track where in the TDD pipeline an issue is)
gh label create "step:test-plan" --color "c2e0c6" --description "Writing test plan"
gh label create "step:e2e-gen" --color "c2e0c6" --description "Generating E2E tests"
gh label create "step:unit-gen" --color "c2e0c6" --description "Generating unit tests"
gh label create "step:implement" --color "c2e0c6" --description "Implementing to pass tests"
gh label create "step:heal" --color "c2e0c6" --description "Healing flaky/broken tests"

# Agent labels
gh label create "agent:vectrix" --color "5319e7" --description "Assigned to Vectrix"
gh label create "agent:merlin" --color "006b75" --description "Assigned to Merlin"
gh label create "needs-human" --color "e4e669" --description "Blocked — needs human input"

# Priority labels
gh label create "P0" --color "b60205" --description "Critical — do immediately"
gh label create "P1" --color "d93f0b" --description "High — do this sprint"
gh label create "P2" --color "fbca04" --description "Medium — next sprint"
gh label create "P3" --color "0e8a16" --description "Low — backlog"
```

### Step 3: Create GitHub Project Board

```bash
gh project create --owner <owner> --title "<Project Name>" --format board
```

Configure columns: **Backlog → Ready → Testing → Building → Review → Done**

Note: Two active columns instead of one "In Progress":
- **Testing** = steps 1-3 of the pipeline (test plan, E2E gen, unit gen)
- **Building** = steps 4-5 (implementation, healing)

### Step 4: Create Issue Templates

Create `.github/ISSUE_TEMPLATE/` with structured templates:

**Feature issue template** (`.github/ISSUE_TEMPLATE/feature.md`):
```markdown
---
name: Feature
about: A new feature to implement
labels: type:feature, phase:build
---

## Summary
<!-- What this feature does, in 1-2 sentences -->

## Acceptance Criteria
<!-- Checklist of what "done" looks like -->
- [ ] ...

## Context
<!-- Links to BRIEF.md sections, DESIGN.md references, DECISIONS.md entries -->
Relevant brief section: <!-- e.g., "Core Features #3" -->
Design reference: <!-- e.g., "src/pages/dashboard.html" -->
Decision context: <!-- e.g., "DECISIONS.md: Auth approach" -->

## Test Scope
<!-- What should be tested for this feature -->
E2E flows: <!-- e.g., "User can create new item and see it in list" -->
Unit coverage: <!-- e.g., "Validation logic, API handler, data transform" -->

## Technical Notes
<!-- Implementation hints, constraints, dependencies on other issues -->
Depends on: <!-- e.g., #12 -->
```

**Design issue template** (`.github/ISSUE_TEMPLATE/design.md`):
```markdown
---
name: Design Task
about: UI/UX design work
labels: type:design, phase:design
---

## Summary
<!-- What needs to be designed -->

## TC-EBC Context
<!-- Task, Context, Examples, Behavior, Constraints — from ui-design-prompt skill -->

## Pages Affected
<!-- Which pages/views this design covers -->

## Reference
<!-- Screenshots, URLs, existing designs to match -->
```

### Step 5: Scaffold Project Documents

```
<project>/
  BRIEF.md              ← Created in Phase 1 (kickoff)
  DESIGN.md             ← Created in Phase 2 (design)
  PLAN.md               ← Created in Phase 3 (planning)
  TEST_PLAN.md          ← Created in Phase 3 (planning) — the test strategy
  DECISIONS.md          ← Progressive, updated across all phases
  IMPLEMENTATION_PLAN.md ← Vectrix's first output
  specs/                ← E2E test plans per feature (generated per issue)
  tests/
    e2e/               ← Playwright E2E tests
    unit/              ← Vitest unit tests (or co-located *.test.ts)
  .github/
    ISSUE_TEMPLATE/
      feature.md
      design.md
    workflows/
      test.yml         ← CI: runs unit + E2E on every PR
```

### Step 6: Set Up CI Pipeline

Create `.github/workflows/test.yml`:

```yaml
name: Tests
on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - run: npm ci
      - run: npm run test:unit:coverage
      - run: npm run build
      - run: npx playwright install --with-deps chromium
      - run: npm run test:e2e
      - uses: actions/upload-artifact@v4
        if: failure()
        with:
          name: test-results
          path: |
            test-results/
            playwright-report/
```

## Project Lifecycle

### Stage 1: Kickoff → Issues

**Trigger:** User describes a new project idea.

**Action:** Run the `project-kickoff` skill (all 3 phases). This produces:
- `BRIEF.md` — functional spec
- `DESIGN.md` — approved visual design
- `PLAN.md` — approved implementation plan
- `DECISIONS.md` — all decisions with rationale

**Then create TEST_PLAN.md:**

After PLAN.md is finalized but before decomposing into issues, spawn an agent to create `TEST_PLAN.md` using the `test-planning` skill:

```
Read these project files:
1. <project>/BRIEF.md — functional requirements
2. <project>/DESIGN.md — approved design
3. <project>/PLAN.md — implementation plan
4. <project>/DECISIONS.md — decisions and rationale
5. /Users/merlin/Development/skills/test-planning/SKILL.md — test planning conventions
6. /Users/merlin/Development/skills/e2e-playwright/SKILL.md — E2E conventions
7. /Users/merlin/Development/skills/unit-vitest/SKILL.md — unit test conventions

Create TEST_PLAN.md covering:
- E2E test scenarios for every user flow in BRIEF.md
- Unit test targets for every module in PLAN.md
- Coverage strategy and explicit exclusions
- Outside-in sequencing: which E2E tests come first, which unit tests support them

Save to <project>/TEST_PLAN.md
```

Post `TEST_PLAN.md` to Discord for user approval before proceeding.

**Then decompose into GitHub Issues:**

Read `PLAN.md`, `IMPLEMENTATION_PLAN.md`, and `TEST_PLAN.md`. Break into issues:

1. Each ordered task from PLAN.md becomes one issue
2. Each issue includes a **Test Scope** section linking to relevant TEST_PLAN.md entries
3. Set dependencies using "Depends on: #N"
4. Label with phase, type, priority, and agent assignment
5. Add all issues to the project board in Backlog column

**Decomposition rules:**
- One issue per component, page, or logical unit
- Each issue should be completable in a single outside-in pipeline run (~2-3h for all 5 steps)
- If a task is too large, split it: scaffolding issue + implementation issue
- Infrastructure issues (project setup, build config, deploy) come before feature issues
- Include enough context in each issue for the pipeline to work independently — link to BRIEF.md, DESIGN.md, TEST_PLAN.md, and relevant DECISIONS.md entries

**Example decomposition:**
```
#1 — Project scaffolding (Vite, deps, config, test infra)  [P0, type:task]
#2 — Global styles + design tokens                         [P0, depends:#1]
#3 — Navigation component                                  [P1, depends:#2]
#4 — Home page                                             [P1, depends:#2,#3]
#5 — Dashboard page                                        [P1, depends:#2,#3]
#6 — Settings page                                         [P2, depends:#2,#3]
#7 — API routes + data model                               [P1, depends:#1]
#8 — Auth flow                                             [P1, depends:#7]
...
```

Post the issue breakdown to Discord for user approval before creating issues.

### Stage 2: Sprint Planning

**Trigger:** Issues exist in Backlog. User says "start building" or "next sprint."

**Action:**

1. Read all issues in the project
2. Identify issues whose dependencies are all met (in Done column)
3. Move eligible P0/P1 issues to Ready column
4. Present the sprint to the user:
   ```
   📋 Sprint ready:
   • #1 Project scaffolding [P0] — no dependencies
   • #7 API routes [P1] — no dependencies

   #1 and #7 can start in parallel (separate pipelines).
   #2 waits for #1 to merge.
   Start the outside-in pipeline?
   ```
5. On approval, move issues to Testing and begin Stage 3

### Stage 3: Outside-In Build Pipeline

**Trigger:** Issues moved from Ready to Testing.

**This is the core of the skill.** Each issue runs through a 5-step pipeline, orchestrated by the `testing-orchestrator` pattern. The pipeline is sequential within one issue, but multiple issues can run their pipelines in parallel (up to 2 concurrent pipelines to avoid merge conflicts).

#### Step 1: E2E Test Planning (Planner)

Move issue to Testing column. Add label `step:test-plan`.

Spawn a **Sonnet** sub-agent with the E2E Planner role:

```
Read these files:
1. <project>/BRIEF.md — what we're building
2. <project>/DESIGN.md — approved design  
3. <project>/TEST_PLAN.md — overall test strategy
4. /Users/merlin/Development/skills/e2e-playwright/SKILL.md — E2E conventions
5. /Users/merlin/Development/skills/e2e-playwright/roles/planner.md — your role

Your current task is GitHub Issue #{N}:
Title: {title}
Description: {body}
Test Scope: {test_scope}

Explore the design files in <project>/src/ to understand what the UI should look like.
Write a structured E2E test plan to <project>/specs/issue-{N}-{slug}.md with:
- Scenario titles matching acceptance criteria
- Numbered steps with expected outcomes
- Success/failure criteria
- Edge cases and error states from TEST_PLAN.md

This plan will be used to generate failing Playwright tests.
Do NOT write test code — only the plan.
```

Model: `sonnet` — planning is a reasoning task, not coding.

**Output:** `specs/issue-{N}-{slug}.md`

#### Step 2: E2E Test Generation (Generator)

Add label `step:e2e-gen`, remove `step:test-plan`.

Spawn a **Codex** sub-agent with the E2E Generator role:

```
Read these files:
1. <project>/specs/issue-{N}-{slug}.md — the test plan you're implementing
2. /Users/merlin/Development/skills/e2e-playwright/SKILL.md — E2E conventions
3. /Users/merlin/Development/skills/e2e-playwright/roles/generator.md — your role
4. /Users/merlin/Development/skills/e2e-playwright/templates/seed.spec.ts — template

Generate TypeScript Playwright tests from the test plan.
- One test file per scenario group: tests/e2e/issue-{N}-{slug}.spec.ts
- describe/title must align with the spec plan
- Comments before each step explaining intent
- Tests WILL FAIL — that is expected. They define the target behavior.
- Do NOT implement production code. Only tests.

Follow Playwright conventions:
- getByRole() locators first
- No waitForTimeout
- Isolate tests (no shared mutable state)
- baseURL from config
```

Model: `codex` — this is code generation.

**Output:** `tests/e2e/issue-{N}-{slug}.spec.ts`

#### Step 3: Unit Test Generation

Add label `step:unit-gen`, remove `step:e2e-gen`.

Spawn a **Codex** sub-agent:

```
Read these files:
1. <project>/PLAN.md — implementation plan (tells you what modules will exist)
2. <project>/TEST_PLAN.md — overall test strategy
3. <project>/specs/issue-{N}-{slug}.md — E2E test plan for this feature
4. /Users/merlin/Development/skills/unit-vitest/SKILL.md — unit test conventions

For Issue #{N} ({title}), generate focused unit tests for the modules 
this feature will create/modify, based on PLAN.md's file structure.

- Test file per module: tests/unit/{module}.test.ts (or co-located)
- Use factory pattern: getMock<Thing>(overrides?)
- Arrange-Act-Assert structure
- Test behavior, not implementation
- Cover: happy path, edge cases, error handling, null/undefined boundaries
- Tests WILL FAIL — no production code exists yet. That's correct.
- Target 100% coverage for the modules this issue touches.

Do NOT implement production code. Only tests.
```

Model: `codex`

**Output:** Unit test files for the feature's modules.

#### Step 4: Implementation (Vectrix Builds)

Move issue to Building column. Add label `step:implement`, remove `step:unit-gen`.

Spawn a **Codex** (Vectrix) sub-agent — this is the main build step:

```
Read these project files:
1. <project>/BRIEF.md — what we're building
2. <project>/DESIGN.md — approved design
3. <project>/PLAN.md — implementation plan
4. <project>/DECISIONS.md — decisions and rationale
5. <project>/IMPLEMENTATION_PLAN.md — your detailed task breakdown
6. /Users/merlin/Development/skills/developing-web-projects/SKILL.md — stack conventions
7. /Users/merlin/Development/skills/enforcing-test-coverage-vitest-playwright/SKILL.md — coverage rules

Your current task is GitHub Issue #{N}:
Title: {title}
Description: {body}
Acceptance Criteria: {checklist}

IMPORTANT — Tests already exist and are currently FAILING:
- E2E tests: tests/e2e/issue-{N}-{slug}.spec.ts
- Unit tests: tests/unit/{relevant modules}
- E2E test plan: specs/issue-{N}-{slug}.md

Your job: write production code to make ALL tests pass.
- The tests define the expected behavior. Read them first.
- Do NOT modify existing tests unless they have a genuine bug (wrong assertion, not just failing).
- If a test seems wrong, comment on the issue explaining why before changing it.
- Run tests frequently: `npm run test:unit` and `npm run test:e2e`

Implementation rules:
- Work ONLY on this issue. Do not touch unrelated code.
- Create a branch: feature/issue-{N}-{slug}
- Follow the design in src/ — match the HTML/CSS exactly
- Convert design HTML into proper Web Components per the conventions skill
- Commit with: "feat: {description}\n\nCloses #{N}"

When all tests pass:
- Run `npm run test:unit:coverage` — verify 100% coverage for your modules
- Run `npm run test:e2e` — verify all E2E scenarios pass
- Push and open a PR targeting main

If blocked or confused, comment on the issue explaining what's unclear
and add the `needs-human` label. Do NOT guess.
```

Model: `codex` (Vectrix)

**Output:** Production code + passing tests + PR opened.

#### Step 5: Test Healing (if needed)

Add label `step:heal`, remove `step:implement`.

Only run if Step 4's PR has test failures in CI. Spawn a **Codex** sub-agent with the Healer role:

```
Read these files:
1. /Users/merlin/Development/skills/e2e-playwright/SKILL.md — E2E conventions
2. /Users/merlin/Development/skills/e2e-playwright/roles/healer.md — your role

PR #{pr_number} on branch feature/issue-{N}-{slug} has test failures.

1. Pull the branch and run all tests
2. For each failing test:
   - Diagnose: is it a test bug or a code bug?
   - If test bug: apply minimal fix to the test (wrong selector, timing issue, etc.)
   - If code bug: fix the production code
   - If app is genuinely broken: mark test with test.fixme() and comment explaining why
3. Re-run full suite until green
4. Push fixes to the same branch

Do NOT rewrite tests to match broken behavior. Tests are the spec.
```

Model: `codex`

**Output:** All tests passing, PR updated.

#### Pipeline Completion

When all 5 steps complete (or 4 if no healing needed):
- Remove all `step:*` labels
- Move issue to Review column
- Add label `phase:review`
- Notify user in Discord: "PR #{pr} ready for review: {title} — {url} (all tests passing ✅)"

### Stage 4: Review Cycle

**Trigger:** PR opened by pipeline with all tests passing.

**Action:**

1. User (or automated reviewer) reviews the PR
2. CI runs the full test suite on the PR (`.github/workflows/test.yml`)
3. If changes requested → use `gh-issues` Phase 6 (PR Review Handler) to address comments
4. If test failures introduced by review fixes → re-run Step 5 (Healer)
5. If approved → merge, move issue to Done, check for newly unblockable issues

### Stage 5: Continuous Monitoring

**Trigger:** Cron job or manual check.

**Action:** Periodic health check of the project:

1. Check for stale Testing/Building issues (no commits in >24h) → ping in Discord
2. Check for merged PRs that haven't updated issue status → auto-close
3. Check for new `needs-human` labels → notify user
4. Check for unblocked Backlog items → suggest next sprint
5. Check for CI failures on main → auto-create bug issue with `P0` + `type:bug`
6. Generate weekly progress summary:
   ```
   📊 Project: <name>
   Done: 12/20 issues (60%)
   Building: 2 (pipelines active)
   Testing: 1 (writing tests)
   Blocked: 1 (#14 — needs API key decision)
   Ready: 4
   Backlog: 0

   This week: #10, #11, #12 completed
   Test health: 47 E2E passing, 128 unit tests, 98% coverage
   Next up: #15, #16, #17 (all unblocked)
   ```

### Stage 6: Regression & Coverage Monitoring (Cron)

These run independently of active development, as scheduled cron jobs.

#### E2E Health Check (weekly)

Runs the full E2E suite against the deployed/preview app to catch regressions.

- **Schedule:** Weekly (Sunday 2:00 AM)
- **Model:** sonnet
- **Action:**
  1. Build and preview the app
  2. Run `npm run test:e2e`
  3. If failures: spawn Healer agent to diagnose
  4. If app bug found: auto-create bug issue with `P0` label
  5. Report to Discord

#### Coverage Gap Analysis (weekly)

Compares `TEST_PLAN.md` against actual test files.

- **Schedule:** Weekly (Monday 9:00 AM)
- **Model:** qwen3:8b (lightweight analysis)
- **Action:**
  1. Read `TEST_PLAN.md`
  2. Scan `tests/e2e/` and `tests/unit/` for implemented tests
  3. Identify planned-but-not-implemented test scenarios
  4. Check coverage report for uncovered modules
  5. Report gaps to Discord with suggested issues to create

#### CI Failure Monitor (on merge)

Watches for test failures on the `main` branch after PR merges.

- **Trigger:** GitHub Actions webhook or cron polling
- **Action:**
  1. Check latest CI run on `main`
  2. If failed: identify which tests broke and which merge caused it
  3. Auto-create bug issue: `type:bug`, `P0`, link to failing CI run
  4. The bug issue enters the normal pipeline (Stage 3) — gets tests written, then fixed

## Orchestration Commands

| Command | Action |
|---------|--------|
| "Start this project" | Run full kickoff (Stage 1) |
| "Decompose the plan" | Break PLAN.md into issues (Stage 1, decomposition step) |
| "Next sprint" / "What's ready?" | Sprint planning (Stage 2) |
| "Build #N" / "Start #N" | Run full outside-in pipeline for issue (Stage 3) |
| "Build all ready issues" | Start pipelines for all Ready issues (Stage 3) |
| "Test #N only" | Run only steps 1-3 (generate tests, no implementation) |
| "Implement #N" | Run only steps 4-5 (assumes tests exist) |
| "Heal #N" | Run only step 5 (fix failing tests) |
| "Status" / "Progress" | Show project health (Stage 5) |
| "Test health" | Show test suite status, coverage, flaky test count |
| "What's blocked?" | List needs-human and dependency-blocked issues |
| "Reprioritize #N to P0" | Update issue priority |
| "Add a feature: ..." | Create new issue from description, add to Backlog |

## Context Flow Across Stages

```
User idea
    ↓
[project-kickoff skill] ← Phases 1-3
    ↓
BRIEF.md + DESIGN.md + PLAN.md + TEST_PLAN.md + DECISIONS.md
    ↓
[project-manager: decompose] ← Issues created with test scope
    ↓
GitHub Issues in Backlog
    ↓
[project-manager: sprint planning] ← Move to Ready
    ↓
┌─────────────────────────────────────────────────┐
│ Outside-In Pipeline (per issue)                 │
│                                                 │
│ 1. E2E Planner (Sonnet)    → specs/*.md         │
│ 2. E2E Generator (Codex)   → tests/e2e/*.spec.ts│
│ 3. Unit Generator (Codex)  → tests/unit/*.test.ts│
│ 4. Implementer (Vectrix)   → src/* (pass tests) │
│ 5. Healer (Codex)          → fix flakes/failures│
│                                                 │
│ Tests define behavior. Code satisfies tests.    │
└─────────────────────────────────────────────────┘
    ↓
PR opened (all tests green)
    ↓
[gh-issues: PR review handling]
    ↓
Human review → merge → issue closed
    ↓
[Cron: regression + coverage monitoring]
```

## Key Principles

1. **Tests are the spec.** E2E and unit tests define what "done" means. Production code exists to make tests pass — not the other way around.
2. **Outside-in sequencing.** E2E first (user behavior), then unit tests (implementation contracts), then code. Never write code before tests.
3. **Documents over conversation.** Everything important lives in a file. Chat is for steering, files are for knowledge.
4. **Issues are atomic.** One issue = one pipeline run = one PR. If it can't be done in ~2-3h, split it.
5. **Dependencies are explicit.** "Depends on: #N" in every issue. No hidden ordering.
6. **Agents read everything.** Every pipeline step includes the full document set. No context loss.
7. **Humans approve gates.** Brief approval, design approval, test plan approval, PR approval.
8. **Fail loud.** `needs-human` label + Discord notification > silent failure.
9. **CI is the safety net.** Same test commands locally and in GitHub Actions. Failures auto-create bug issues.
10. **Tests survive agents.** Agents come and go. Tests persist. A new agent can pick up any issue because the tests tell it what to build.
