---
name: documentation-handoff
description: "Create durable project docs and handoff state: README/AGENTS updates, DELIVERY_STATE.md, DECISIONS.md, ADRs, PR/issue handoffs, continuation notes, and recovery summaries."
---

# Documentation Handoff

Use this skill when project knowledge needs to survive a fresh agent, a later
session, a PR review, or a handoff between workflows.

This skill owns documentation and continuation state. It does not decide product
scope, implementation order, test strategy, or review findings. Those decisions
belong to the workflow that invoked this skill.

## Core Principle

Write the minimum durable artifact that lets the next capable agent continue
without rereading the entire chat.

Prefer paths, issue numbers, PR numbers, decisions, checks, and blockers over
long narrative. Do not use docs to hide unresolved decisions.

## Artifact Roles

- `README.md`: human setup, usage, architecture overview, commands, and
  operational notes.
- `AGENTS.md`: repo-local instructions for AI agents, constraints, commands,
  safety boundaries, and workflow expectations.
- `BRIEF.md`: product problem, audience, goals, constraints, and non-goals.
- `DESIGN.md`: approved user experience, interaction model, visual direction, or
  non-visual interaction/artifact design.
- `PLAN.md`: stable work units, dependencies, risks, and delivery strategy.
- `TEST_PLAN.md`: behavior coverage, fixtures, safe auth paths, CI expectations,
  and browser-QA scope.
- `DECISIONS.md`: accepted decisions, rejected alternatives, assumptions, and
  dated rationale.
- `DELIVERY_STATE.md`: current implementation checkpoint for active work.
- ADRs in `docs/adr/`: durable technical decisions and tradeoffs.
- Other `docs/`: architecture, operations, or domain explanations when the
  detail is too large for README, DECISIONS, or one ADR.

Use existing project conventions first. Do not invent a second doc system when
the repo already has one.

## When To Update

Update durable docs when:

- a new project is created or first organized
- a kickoff decision is accepted or a rejected alternative matters later
- setup, commands, auth, seed data, fixtures, or deployment behavior changes
- a technical decision shapes architecture, data, auth, platform, deployment,
  integration boundaries, or major library/framework choice
- an issue is decomposed from planning artifacts
- long-running implementation reaches a meaningful checkpoint
- a PR introduces behavior, operations, or constraints future agents need
- review or QA finds a decision, risk, or follow-up that should not live only in
  chat
- work pauses, blocks, merges, or hands off to another agent

Do not update docs for transient implementation details that are obvious from
the current diff and unlikely to matter after merge.

## Handoff Packet

Every handoff should answer:

- **Goal**: what the next agent is trying to complete.
- **Current state**: branch, issue, PR, last verified checkpoint.
- **Relevant artifacts**: exact files, sections, issue/PR links, screenshots, or
  commands to read first.
- **Decisions**: accepted direction and rejected alternatives that affect work.
- **Checks**: commands run, results, and known gaps.
- **Blockers**: what is missing, who must decide, and why guessing is unsafe.
- **Next action**: one concrete next step.

Keep handoffs compact. Link to durable artifacts instead of pasting their full
contents.

## DELIVERY_STATE.md

Use `DELIVERY_STATE.md` for active implementation state when work spans sessions,
agents, or PRs.

Suggested shape:

```md
# Delivery State

- Updated: YYYY-MM-DD HH:MM TZ
- Project phase:
- Active issue:
- Branch:
- PR:
- Last verified checkpoint:
- Checks run:
- Browser QA:
- Blockers:
- Next action:
- Notes:
```

Update it before pausing, delegating, opening a PR after long work, merging, or
reporting a blocker. If GitHub state disagrees with `DELIVERY_STATE.md`, trust
GitHub first and update the file.

## Decision Capture

Use `DECISIONS.md` when a broad choice will shape later work:

- product direction
- UX/design direction
- testing/QA strategy
- workflow, scope, operational policy, or non-technical assumptions
- rejected alternatives that are likely to be proposed again

Each entry should include:

- date
- decision
- rationale
- rejected alternatives
- consequences or follow-ups

Do not record every small coding preference. Use the repo's existing formatter,
lint, and conventions for that.

## Architecture Decision Records

Use an ADR when a technical choice would be expensive to rediscover or reverse:

- platform, storage, queue, cache, auth, tenancy, or deployment model
- public API, data model, migration, integration, or boundary shape
- major library/framework/runtime choice
- intentional deviation from local defaults or established project conventions
- rejected architecture alternative likely to be proposed again

Do not create ADRs for routine implementation details, small refactors, naming,
formatting, or choices already obvious from local conventions.

Default location: `docs/adr/NNNN-short-title.md`. Use the repo's existing ADR
location or numbering if present.

Use [references/adr-template.md](references/adr-template.md) when creating a
new ADR. Keep ADRs short enough to review in normal project work.

## PR And Issue Handoffs

PR descriptions should include:

- linked issue
- scope summary
- acceptance criteria covered
- docs or decisions updated
- tests/checks run
- review/QA state
- known blockers or follow-ups

Issue handoffs should include enough context for [[implement-issue]] without
requiring the implementer to infer scope from broad planning docs:

- acceptance criteria
- dependencies
- test scope
- browser-QA/auth/fixture needs
- relevant doc sections
- out-of-scope notes

## Documentation Quality

Good handoff docs are:

- current
- specific
- short enough to read during real work
- grounded in files, issues, PRs, commands, and checks
- explicit about uncertainty and blockers
- free of secrets, private credentials, personal tokens, or production-only
  access details

Avoid:

- chat transcripts as documentation
- vague summaries like "mostly done"
- stale check results without dates
- duplicating implementation details already clear in code
- burying decisions in PR comments only
- adding documentation ceremony to tiny self-contained changes

## Recovery

When resuming stale work:

1. Read GitHub issue/PR state first.
2. Read `DELIVERY_STATE.md` when present.
3. Read only the linked docs or sections needed for the next action.
4. Reconcile conflicts in favor of durable external truth: merged PRs, open PRs,
   issue labels/comments, CI, then local files.
5. Update the handoff artifact after reconciliation.

The output should be one next concrete action or one real blocker, not a broad
archive summary.
