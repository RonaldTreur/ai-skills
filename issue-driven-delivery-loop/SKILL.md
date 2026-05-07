---
name: issue-driven-delivery-loop
description: Use when asked to autonomously work a GitHub-backed software project from its repo docs and issue backlog. The skill discovers planning files, reads GitHub Issues and native issue dependencies, chooses the next ready slice, uses outside-in testing and development, conditionally requires developing-web-projects for web projects, reviews changes, fixes P0-P3 findings, and repeats until the backlog is done or blocked.
---

# Issue-Driven Delivery Loop

## Purpose

Run a software project from repository memory plus GitHub Issues. Use this skill when the user wants Codex to pick the next slice, determine issue order, implement with outside-in testing, review, merge or prepare PRs, run QA, and continue until done or blocked.

## Skill Hierarchy

This skill is an orchestration layer. It decides backlog order, branch/PR flow, review gates, QA bookkeeping, and when to continue or stop.

For web-based projects, `developing-web-projects` is the leading skill for all implementation choices. It governs:

- architecture defaults, including MPA over SPA unless explicitly overridden
- Cloudflare-first platform decisions
- vanilla TypeScript, browser APIs, HTML semantics, and dependency restraint
- CSS approach, including semantic plain CSS and no Tailwind/reset packages by default
- README/AGENTS documentation expectations
- test expectations and related testing skills
- when to pause for an implementation outline and approval

If this skill conflicts with `developing-web-projects` on a web project, follow `developing-web-projects`. Use this skill only to complement it with issue graph planning and delivery-loop mechanics.

## Required Inputs

- A repository path, or use the current working directory if none is provided.
- GitHub access through `gh` CLI or another available GitHub tool.
- Permission scope from the user: whether Codex may branch, commit, push, open PRs, merge, create issues, and continue across multiple issues.

If permissions are unclear, continue only through planning and local implementation. Do not merge or perform destructive operations without explicit authorization.

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

If a dependency is ambiguous, comment on the issue, apply `needs-human` when authorized, and skip it.

## Ready-Issue Selection

An issue is ready only when:

- it is open
- it is not labeled `needs-human`, `blocked`, `wontfix`, or `duplicate`
- every `blocked_by` issue is closed or otherwise explicitly resolved
- its acceptance criteria are clear enough to test
- its repo prerequisites exist or can be created within the issue's scope

Sort ready issues with this deterministic order:

1. Priority labels: `P0`, `P1`, `P2`, `P3`, then unlabeled.
2. Milestone due date or milestone order, if present.
3. Phase labels in this order: `phase:kickoff`, `phase:design`, `phase:planning`, `phase:build`, `phase:review`, `phase:qa`.
4. Smallest independently mergeable slice.
5. Oldest issue creation date.
6. Lowest issue number.

If the user names a specific issue, verify readiness first. If it is blocked, report the blockers and do not start coding unless the user explicitly overrides the dependency.

## Outside-In Delivery Cycle

For each selected issue:

1. Create or switch to a dedicated branch named from the issue, such as `issue-12-short-title`.
2. Read the full issue body, acceptance criteria, linked docs, and relevant code.
3. For web-based projects, re-check the issue against `developing-web-projects` before writing tests or implementation. Enforce the user's web defaults unless repo-local instructions or the user explicitly override them.
4. Write or update a short test plan in `specs/` or the repo's existing test-plan location when the behavior is user-visible.
5. Add failing E2E tests first for user-visible behavior, unless the change is internal-only.
6. Add focused unit tests for domain logic, validation, data access, and edge cases.
7. Implement the smallest production change that satisfies the tests and issue.
8. Run the repo's relevant checks: unit, E2E, typecheck, build, lint, and migrations as applicable.
9. Review the diff using the `code-review` skill. For web-based projects, include `developing-web-projects` conventions in the review scope.
10. Fix all P0-P3 findings before merge or final delivery when authorized.
11. Push/open/update a PR, or merge if explicitly authorized and checks pass.
12. Run post-merge or main-branch QA when merging is authorized.
13. If QA finds defects, create GitHub issues with priority labels and dependencies, then continue the loop.

Keep each branch scoped to one issue unless the issue is too small to test independently and the dependency graph says a combined slice is safer.

## Web Project Approval

For web-based projects, honor `developing-web-projects` by giving a short implementation outline before starting implementation work.

If the user's invocation already grants standing approval to run the delivery loop, that approval may cover the current sequence of ready issues. Still pause when:

- the selected issue requires a new architecture/platform decision
- implementation would introduce a framework, router, Tailwind, reset package, CSS-in-JS, Docker, non-Cloudflare hosting, or another deviation from `developing-web-projects`
- repo-local instructions conflict with the web defaults
- the plan changes materially after test discovery or code exploration

Without standing approval, stop after the outline and wait for the user before editing implementation files.

## Stop Conditions

Stop and report instead of continuing when:

- no open issue is ready
- required GitHub permissions are missing
- a product decision or acceptance criterion is ambiguous
- a secret, credential, deploy token, or production access is needed
- tests reveal behavior that contradicts the issue/spec
- merge is blocked by branch protection or failed required checks
- the next action is destructive or outside the user's granted authority

## Status Reporting

At the start of a run, report:

- repo path and GitHub repo
- planning files read
- whether the repo was classified as web-based, whether `developing-web-projects` is governing the run, and which supporting skills were loaded
- issue order summary
- selected next issue and why it is ready

After each issue, report:

- issue completed or blocker encountered
- branch/PR/merge state
- checks run and result
- review findings fixed
- QA result
- next issue selected or reason the loop stopped

## Example Invocation

```md
Use $issue-driven-delivery-loop for `/path/to/repo`.

You may create branches, commit, push, open PRs, create GitHub issues, fix all P0-P3 review findings, and continue picking ready issues until the project is done or blocked. Do not merge without explicit confirmation.
```
