---
name: issue-driven-delivery-loop
description: Use when asked to autonomously work a GitHub-backed software project from its repo docs and issue backlog. The skill discovers planning files, reads GitHub Issues and native issue dependencies, chooses the next ready slice, uses outside-in testing and development, prefers Vectrix for implementation, runs Codex and Claude-review gates, fixes P0-P3 findings, merges PRs into dev, and repeats until the backlog is done or only human-blocked work remains.
---

# Issue-Driven Delivery Loop

## Purpose

Run a software project from repository memory plus GitHub Issues. Use this skill when the user wants an agent to pick the next slice, determine issue order, implement with outside-in testing, review, merge PRs into `dev` when checks pass, run QA, and continue until done or only human-blocked work remains.

## Skill Hierarchy

This skill is an orchestration layer. It decides backlog order, branch/PR flow, review gates, QA bookkeeping, and when to continue or stop.

For implementation, prefer **Vectrix** unless Ronald explicitly requests another runtime or Vectrix is genuinely blocked. Codex can still perform planning, test generation, self-review, review evaluation, and fix work when that is the most reliable local tool, but the default build handoff goes to Vectrix.

For web-based projects, `developing-web-projects` is the leading skill for all implementation choices. It governs:

- architecture defaults, including MPA over SPA unless explicitly overridden
- Cloudflare-first platform decisions
- vanilla TypeScript, browser APIs, HTML semantics, and dependency restraint
- CSS approach, including semantic plain CSS and no Tailwind/reset packages by default
- README/AGENTS documentation expectations
- test expectations and related testing skills
- when to provide an implementation outline, and when approval is truly required

If this skill conflicts with `developing-web-projects` on a web project, follow `developing-web-projects`. Use this skill only to complement it with issue graph planning and delivery-loop mechanics.

## Minimal Invocation

The user should be able to start a run with a short prompt, for example:

```md
Use $issue-driven-delivery-loop to implement this project.
```

If no path is provided, use the current working directory when it is a git repo. If the prompt names a project but the current directory is not that repo, try obvious local workspace locations only when they are already known from conversation context; otherwise ask for the repo path.

## Default Operating Authority

When the user invokes this skill without extra permissions, assume Codex may:

- read repo docs, source files, git state, and GitHub Issues
- determine issue order from GitHub dependencies, labels, milestones, and issue bodies
- create local branches for ready issues
- write tests and implementation files
- update repo docs when the change requires it
- create or update repo-local `DELIVERY_STATE.md` for delivery-loop checkpoint/resume state
- run local checks and development/test commands
- use `code-review` and fix all P0-P3 findings
- commit focused issue work
- push feature branches
- open or update pull requests
- create `dev` from the default branch if the repo has no `dev` branch yet
- merge pull requests into `dev` when required checks pass and the review gates below are complete
- create GitHub Issues for QA defects, blockers, or follow-up work
- continue with the next ready issue until the project is done or only human-blocked work remains
- choose sensible best-practice defaults for underspecified implementation details
- document meaningful default decisions in `DECISIONS.md`, an ADR, the relevant issue/PR, or the nearest repo-local decision log

Do not do these without explicit user confirmation:

- deploy to production or change live infrastructure
- create, rotate, or reveal secrets
- change billing, paid services, or organization-level settings
- delete branches, rewrite shared history, or run destructive filesystem/git commands
- merge directly into `main`, override branch protection, or override failed required checks
- make product decisions that change scope or user-visible behavior beyond the issue/spec

If GitHub access or network approval is missing, request the needed approval through the available tool flow and continue when granted.

## Permission Preflight

Codex command approvals are controlled by the host app's sandbox/permission policy, not by this skill. A skill cannot disable those prompts. For unattended runs, reduce interruptions by requesting reusable command-prefix approvals at the beginning of the run for the commands this repo will need.

Before starting the first issue, inspect the repo scripts and likely workflow, then request persistent approvals for safe recurring command families such as:

- `git status`, `git diff`, `git branch`, `git switch`, `git add`, `git commit`, `git push`, `git fetch`
- `gh issue`, `gh pr`, `gh api`, `gh repo view`, `gh auth status`
- package-manager scripts discovered from the repo, such as `npm run test`, `npm run build`, `npm run typecheck`, `npm run lint`, `npm run dev`, or their `pnpm`/`bun` equivalents
- framework CLIs that are normal for the repo, such as `wrangler`, `vitest`, `playwright`, or migration commands
- `kill <pid>` only for stopping repo-owned dev servers, preview servers, test watchers, or other child processes started during the run

Do not request broad approval for destructive commands. Never request persistent approval for `rm`, `git reset`, history rewrite commands, secret-management commands, production deploys, or billing/org administration.

For `kill`, first identify the process with `ps` or the active tool session. Only stop processes that were started for the current repo/run or are clearly stale dev/test processes blocking required ports. Do not request or use broad kill patterns such as `kill -9 -1`, `pkill`, or `killall` without explicit user confirmation.

If a command later asks for approval, request a reusable prefix when it is safe and likely to recur. If approval is denied, use an available non-destructive alternative or mark only the affected issue blocked and continue with other ready work.

## Overnight Autonomy Policy

Optimize for running unattended. Do not stop just because an issue has an underspecified detail or a command fails once.

Default behavior:

- Make the best conservative engineering decision from repo docs, issue acceptance criteria, active skills, and established project patterns.
- Prefer reversible, documented defaults over questions.
- Keep work scoped to the selected issue.
- If one issue is blocked, document the blocker, create or update a GitHub Issue when useful, label/comment as appropriate, then pick the next ready issue.
- Stop the whole run only when no useful ready work remains or every remaining path requires human intervention.

Best-practice default hierarchy:

1. Explicit user instructions in the current invocation.
2. Repo-local instructions such as `AGENTS.md`, `DECISIONS.md`, ADRs, specs, and issue acceptance criteria.
3. Required skills, with `developing-web-projects` leading for web projects.
4. Existing codebase conventions.
5. Conservative platform/framework defaults from the active skills.
6. Minimal, reversible implementation choices that keep future changes easy.

Document decisions when they affect architecture, public API contracts, data shape, security posture, test strategy, deployment assumptions, or operator workflow. Do not document tiny local coding choices.

## Branch Target

Use `dev` as the integration branch for delivery-loop PRs.

1. Check whether `origin/dev` exists.
2. If it does not, create `dev` from the repo default branch and push it before opening implementation PRs.
3. Open PRs from issue branches into `dev`, not `main`.
4. Do not merge to `main` during the loop unless Ronald explicitly asks for a release merge.
5. If branch protection or CI only exists for `main`, do not bypass it. Note the gap and still target `dev`; create a follow-up issue for protection/CI alignment if needed.

## Repo Intake

1. Resolve the repo path and inspect git state:
   - `git status -sb`
   - `git remote -v`
   - `git branch --show-current`
2. Read repo-local agent instructions first when present:
   - `AGENTS.md`
   - `.github/copilot-instructions.md`
   - `.codex/*`
3. Discover project memory with `rg --files`, then read only relevant files:
   - `README.md`
   - `BRIEF.md`, `PRD.md`, `REQUIREMENTS.md`
   - `DESIGN.md`, `ARCHITECTURE.md`
   - `PLAN.md`, `IMPLEMENTATION_PLAN.md`, `ROADMAP.md`
   - `TEST_PLAN.md`
   - `DECISIONS.md`, `ADR*.md`, `docs/**/*.md`
   - `DELIVERY_STATE.md`
   - `specs/**/*.md`
   - `.github/ISSUE_TEMPLATE/**`
4. Extract a short working context:
   - product goal
   - architecture constraints
   - quality/test commands
   - security-sensitive areas
   - open questions
   - existing issue/dependency conventions
5. Decide whether this is a web-based project. Treat it as web-based when any of these are present:
   - `package.json` with browser, Worker, Pages, Vite, Astro, frontend, web component, Playwright, or DOM-oriented scripts/dependencies
   - `wrangler.toml`, `_worker.js`, `functions/`, `public/`, `src/**/*.html`, `src/**/*.css`, `src/**/*.ts` for browser/Worker entrypoints
   - docs or issues mention website, web app, browser UI, Cloudflare Worker, Cloudflare Pages, API routes, HTML/CSS, Web Components, OAuth browser flow, or Playwright E2E
6. If the project is web-based, load and follow `developing-web-projects` before selecting or implementing an issue. Treat that skill as authoritative, then use this skill to order and run the work. Also load related skills when applicable:
   - `architecting-cloudflare-systems` for Cloudflare Workers, Pages, D1, KV, R2, Queues, Durable Objects, or Stream
   - `generating-web-components` when implementation includes Web Components
   - `enforcing-test-coverage-vitest-playwright`, `e2e-playwright`, and `unit-vitest` when adding or changing functionality

Prefer repo-local instructions and `developing-web-projects` over this skill when they are more specific and do not conflict with safety rules.

## Issue Graph

Resolve the GitHub repo from `origin`, then read open issues:

```bash
gh issue list --state open --limit 200 --json number,title,body,labels,milestone,assignees,url,createdAt,updatedAt
```

Use GitHub native issue dependencies as the strongest ordering signal. For each open issue, query:

```bash
gh api repos/OWNER/REPO/issues/ISSUE_NUMBER/dependencies/blocked_by
gh api repos/OWNER/REPO/issues/ISSUE_NUMBER/dependencies/blocking
```

If native dependency data is unavailable, parse the issue body as fallback only:

```md
## Dependencies
Blocked by: #1, #3
Blocking: #8
```

When an obvious dependency is missing, add the native GitHub dependency if authorized. To add `BLOCKER_NUMBER` as a blocker of `ISSUE_NUMBER`, first resolve the blocker REST id:

```bash
gh api repos/OWNER/REPO/issues/BLOCKER_NUMBER --jq .id
gh api --method POST repos/OWNER/REPO/issues/ISSUE_NUMBER/dependencies/blocked_by -f issue_id=BLOCKER_REST_ID
```

If a dependency is ambiguous, first infer from the dependency hierarchy above. If a safe inference is not possible, comment on the issue, apply `needs-human` when authorized, skip that issue, and continue with the next ready issue.

## Ready-Issue Selection

An issue is ready only when:

- it is open
- it is not labeled `needs-human`, `blocked`, `wontfix`, or `duplicate`
- every `blocked_by` issue is closed or otherwise explicitly resolved
- its acceptance criteria are clear enough to test, or can be made testable through a documented conservative default
- its repo prerequisites exist or can be created within the issue's scope

Sort ready issues with this deterministic order:

1. Priority labels: `P0`, `P1`, `P2`, `P3`, then unlabeled.
2. Milestone due date or milestone order, if present.
3. Phase labels in this order: `phase:kickoff`, `phase:design`, `phase:planning`, `phase:build`, `phase:review`, `phase:qa`.
4. Smallest independently mergeable slice.
5. Oldest issue creation date.
6. Lowest issue number.

If the user names a specific issue, verify readiness first. If it is blocked, document the blockers and move to other ready work unless the user explicitly asked to work only that issue.

## Outside-In Delivery Cycle

For each selected issue:

1. Ensure the `dev` integration branch exists, then create or switch to a dedicated branch from `dev`, such as `issue-12-short-title`.
2. Read the full issue body, acceptance criteria, linked docs, and relevant code.
3. For web-based projects, re-check the issue against `developing-web-projects` before writing tests or implementation. Enforce the user's web defaults unless repo-local instructions or the user explicitly override them.
4. Write or update a short test plan in `specs/` or the repo's existing test-plan location when the behavior is user-visible.
5. Add failing E2E tests first for user-visible behavior, unless the change is internal-only.
6. Add focused unit tests for domain logic, validation, data access, and edge cases.
7. Claim the issue visibly before substantial work: update `DELIVERY_STATE.md` and comment on or label the GitHub issue with the selected issue, branch, current checkpoint, and next action.
8. Implement the smallest production change that satisfies the tests and issue, preferring Vectrix for the build step.
9. Run the repo's relevant CLI checks: unit, E2E, typecheck, build, lint, and migrations as applicable.
10. Run browser QA for user-visible browser behavior whenever feasible. Use local preview/dev servers for unmerged changes; use deployed preview or production only when the task is specifically about deployed behavior.
11. Run the Codex review loop:
    - review the diff using the `code-review` skill
    - for web-based projects, include `developing-web-projects` conventions in the review scope
    - fix all P0-P3 findings
    - review again
    - repeat until Codex finds no remaining P0-P3 issues, or any rejected finding is explicitly justified in the PR/issue
12. Run one final Claude-review pass after the Codex loop is clean.
13. Have Codex evaluate the Claude-review findings, fix all valid P0-P3 findings, and explicitly document any rejected findings with rationale.
14. Re-run the smallest meaningful verification after review fixes, including browser QA again when user-visible behavior changed.
15. Push/open/update a PR targeting `dev`, then merge into `dev` when required checks pass and all review gates are complete.
16. Run post-merge QA against `dev` or the closest available preview of `dev`.
17. If QA finds defects, create GitHub issues with priority labels and dependencies, then continue the loop.
18. If the issue cannot be completed without human action, create/update a blocker issue or comment, label it `needs-human` when available, restore a clean working state for unrelated work without destroying user changes, and continue with the next ready issue.

Keep each branch scoped to one issue unless the issue is too small to test independently and the dependency graph says a combined slice is safer.

## Per-Issue Checkpoints

For longer Vectrix/Codex work, do not rely on one final completion callback as the source of truth. Verify and report the furthest real checkpoint reached:

1. **Implementation artifact**: branch, commit, changed files, or PR exists.
2. **Self-verification complete**: CLI checks and, when relevant, browser QA have run.
3. **Codex review loop complete**: Codex review reports no remaining P0-P3 findings.
4. **Claude-review complete**: Claude-review findings were received.
5. **Claude findings resolved**: Codex evaluated and fixed or explicitly rejected findings.
6. **Merge complete**: PR merged into `dev`.
7. **Post-merge QA complete**: `dev` or its preview passed the relevant smoke/browser checks.

If final handoff is missing or suspicious, inspect repo state, child transcript, commits, tests, PR status, and artifacts before reporting status.

## User-Visible Phase Heads-Ups

The loop must make progress legible to Ronald. Treat issue and phase transitions as required status events, not optional narration.

Send a short visible heads-up whenever the loop enters one of these phases:

1. **Issue selected**: name the issue, why it is next, and whether it is ready or blocked.
2. **Planning/test-plan**: say what behavior is being pinned down and where the test plan or acceptance criteria live.
3. **Implementation**: say who is implementing, the branch/PR target, and the intended smallest slice.
4. **Self-verification**: say which checks are running or have just passed/failed.
5. **Codex review**: say the implementation is moving from tests into local review.
6. **Claude-review**: say the independent review gate is starting, or why it is being skipped.
7. **Review fixes**: say which findings are being fixed and whether they block merge.
8. **CI/PR gate**: say whether checks are pending, failed, green, flaky/rerun, or blocked.
9. **Merge**: say the PR is being merged to `dev`, or explicitly say why it is green-but-not-merged.
10. **Post-merge QA**: say what smoke/QA is being run against `dev` or preview.
11. **Next issue / blocked handoff**: say which issue the loop moved to next, or the exact blocker if no ready work remains.

Keep heads-ups compact: one to three bullets or a short paragraph. Include the issue number, PR number, phase name, and one concrete next action. Do not dump logs. Link issues/PRs when available.

When a phase transition is discovered from a sub-agent completion, verify the claimed state first when practical, then send the heads-up. For live chat contexts, send the visible update with the platform message tool rather than relying on a private final answer.

Recommended format:

```md
Phase: #<issue> <phase>
State: <branch/PR/checkpoint>
Next: <single concrete action>
```

After every checkpoint, update both durable recovery surfaces:

- `DELIVERY_STATE.md` in the repo
- the relevant GitHub issue or PR comment/body

The update must be enough for a fresh agent with no session memory to resume.

## Durable Resume State

Use repo-local `DELIVERY_STATE.md` as the canonical local resume file for long delivery-loop runs. Create it if missing. Keep it concise, current, and free of secrets.

Recommended shape:

```md
# DELIVERY_STATE

Last updated: <ISO timestamp>
Goal: <durable objective>
Repo: <owner/repo>
Integration branch: dev

## Current Slice
- Issue: #<number> <title>
- Branch: <branch>
- PR: #<number or n/a>
- Checkpoint: <one of the per-issue checkpoints>
- Next action: <specific next command/action>
- Blocker: <none or explicit blocker>

## Verification
- CLI checks: <commands + pass/fail/last run>
- Browser QA: <scope + pass/fail/last run>
- Codex review: <clean or findings summary>
- Claude-review: <pending/clean/findings summary>

## Queue
- Ready next: #<number>, #<number>
- Blocked: #<number> because <reason>
```

Resume protocol after a gateway restart, compaction, or lost child result:

1. Read GitHub issues/PRs first.
2. Read `DELIVERY_STATE.md`.
3. Inspect actual git state: branch, commits, diff, working tree, remotes.
4. Reconcile conflicts in favor of durable external truth: merged PRs, open PRs, issue labels/comments, CI/check status, then local `DELIVERY_STATE.md`.
5. Continue from the last verified checkpoint, not from the last claimed checkpoint.
6. If state is ambiguous, update the issue with the ambiguity, choose the safest verifiable next step, and continue when possible.

For GitHub checkpoint comments, include at minimum:

- current issue/branch/PR
- current checkpoint
- checks or QA completed
- review state
- blocker or next action

Do not paste secrets, long logs, or noisy transcripts into `DELIVERY_STATE.md` or GitHub comments. Link to CI runs, PRs, commits, and artifacts instead.

## QA Placement

QA happens in three places:

1. **Before review**: after implementation, run CLI verification and browser QA for affected user-visible flows.
2. **After review fixes**: rerun the smallest checks that prove Codex/Claude-review fixes did not regress behavior; repeat browser QA if UI or routing changed.
3. **After merge into `dev`**: run post-merge QA against `dev` or the closest available preview/deployed environment.

Use CLI QA for deterministic project health: unit tests, E2E tests, build, typecheck, lint, migrations, and API contract checks. Use browser QA for actual user-facing behavior, layout, interaction, routing, accessibility signals, console errors, and deployed asset/path issues.

## Web Project Approval

For web-based projects, honor `developing-web-projects` by giving a short implementation outline before starting implementation work. During an unattended run, this outline is a logged status update, not a blocking approval request, unless a true human-intervention condition below applies.

The default operating authority above counts as standing approval to proceed through the delivery loop for ready issues. Do not pause for ordinary web implementation choices when `developing-web-projects`, repo docs, or codebase conventions provide a clear default.

Pause the selected issue, document it as blocked, and move to the next ready issue only when no repo-local instruction, active skill, existing convention, or conservative default can resolve the choice. Examples:

- the selected issue requires a new architecture/platform decision and the governing defaults do not answer it
- implementation would introduce a framework, router, Tailwind, reset package, CSS-in-JS, Docker, non-Cloudflare hosting, or another deviation from `developing-web-projects`
- repo-local instructions conflict with the web defaults and no conservative interpretation exists
- the plan changes materially after test discovery or code exploration in a way that changes product scope or user-visible behavior beyond the issue/spec

If the user explicitly asks for planning only or says not to edit files, stop after the outline and wait for the user before editing implementation files.

## Blockers and Stop Conditions

Do not stop the whole run for a single blocked issue. First try to work around it safely:

- pick a documented best-practice default
- add or update tests to expose the expected behavior
- fix failing checks and rerun them
- use local mocks, fixtures, env examples, or stubs when secrets/external services are absent and the issue can still be advanced honestly
- split the work and create a follow-up issue for the truly blocked part
- label/comment the blocked issue and continue with another ready issue

Stop the whole run only when human intervention is required and there is no other ready work that can be progressed. Human intervention is required when:

- the repo path or GitHub repo cannot be determined
- GitHub access, network approval, or required local permissions are unavailable after requesting approval
- every remaining ready-looking issue requires a secret, credential, production access, billing/org setting, or external account action
- every remaining issue requires a product decision that would change scope or user-visible behavior beyond the issue/spec
- all available PRs are blocked by failed required checks or branch protection that cannot be fixed from the repo
- the next useful action would be destructive or outside the default operating authority
- repo-local instructions directly conflict and no conservative interpretation exists

## Status Reporting

At the start of a run, report:

- repo path and GitHub repo
- planning files read
- whether the repo was classified as web-based, whether `developing-web-projects` is governing the run, and which supporting skills were loaded
- issue order summary
- selected next issue and why it is ready

During each issue, report every phase transition listed in **User-Visible Phase Heads-Ups**. This is the default for long-running autonomous loops. The goal is that Ronald can tell whether the loop is active, waiting on CI/review, fixing a finding, merging, or moving to the next issue without asking for status.

After each issue, report:

- issue completed or blocker encountered
- branch/PR/merge state
- checks run and result
- review findings fixed
- Claude-review result and fixes
- QA result
- next issue selected or reason the loop stopped

## Example Invocation

```md
Use $issue-driven-delivery-loop to implement this project.
```
