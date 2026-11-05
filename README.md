# Skills

This repository contains Skills I personally created and use to speed up my development workflow.

## What is a Skill?

Skills are modular, filesystem-based capabilities for agents. A Skill packages metadata and instructions in `SKILL.md` and can include optional resources like scripts, templates, or references. Skills load on demand (progressive disclosure) so only the relevant content is pulled into context when a request matches the Skill's description.

## Best practices (summary)

- Use clear, specific names and descriptions that say what the Skill does and when to use it.
- Keep `SKILL.md` concise enough to use, but not at the expense of the normal execution path. The hot file must contain every rule needed for the default run of the Skill. Move only optional depth, long examples, templates, provenance, rare edge cases, and expanded reference material into separate files, with explicit "load this when..." gates.
- Match instruction specificity to task risk: use high-level guidance when multiple approaches are valid and exact scripts when consistency is critical.
- Provide templates or input/output examples when output format matters.
- Prefer utility scripts for deterministic operations and handle errors explicitly; document configuration values and avoid assuming dependencies are installed.
- Test file access patterns and workflows with real requests.

## Sources

- https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview
- https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices

## Methodology Adaptation

The `methodology/` folder tracks discipline-by-discipline reviews of external agent-methodology sources and the attribution trail for ideas adapted into this repository.

Use the `external-skill-adaptation` skill when comparing third-party skills, prompts, or instruction repos against these local skills.

The current methodology taxonomy is split by workflow ownership, not by source repo. Each skill should have recognizable trigger cases, reduce duplication, and say what it does not own.

Core lifecycle owners:

- `start-new-project/`: early grounding, brief, product/design direction, `BRIEF.md`, `DESIGN.md`, `PLAN.md`, and `DECISIONS.md`.
- `project-manager/`: repo/project setup, readiness, feature intake, issue decomposition, backlog ordering, status, and next-work selection; `references/delegation.md` holds the packet and status contract for work sent to another agent.
- `implement-issue/`: one ready issue or backlog slice through branch, tests, implementation, review, PR, merge, and post-merge QA.
- `documentation-handoff/`: README/AGENTS roles, project artifacts, `DELIVERY_STATE.md`, `DECISIONS.md`, ADRs, PR/issue handoffs, blockers, and recovery summaries.

Specialist owners:

- `debugging/`: investigation-first bug fixing with a trivial-bug fast path and hard verification gates.
- `code-review/`: architecture, security, maintainability, correctness, convention, and test-risk review.
- `skill-review/`: one skill or a whole library: activation accuracy, context cost, no-op instructions, progressive disclosure, safety, and the read-only inventory audit script.
- `retro/`: user-invoked retrospective on a session or merged PR that proposes environment changes (pointers, checks, review rules, deleted no-ops) for the person to approve.

Testing and QA owners:

- `testing/`: test strategy (`TEST_PLAN.md`), outside-in sequencing, the authoring gate every new test must clear, safe auth and test data, and CI parity with coverage thresholds.
- `unit-vitest/`: behavior-focused Vitest unit and integration tests.
- `e2e-playwright/`: durable Playwright E2E tests, fixtures, locators, storage state, and E2E artifacts.
- `browser-qa/`: web preview, PR, and post-merge QA that needs an actual browser pass.
- `test-audit/`: user-invoked pruning of existing tests: focused audits of low-value or implementation-coupled tests, and one-subsystem pruning campaigns.

Design and frontend owners:

- `frontend-design/`: divergent UI variants, visual thesis, shareable browser previews, feedback rounds, approved frontend design artifacts, and prompt export for external UI generators.
- `developing-web-projects/`: web architecture and implementation conventions.
- `generating-web-components/`: repository-patterned Web Component generation.

GitHub label automation lives in `gh-pipeline/`. It is dormant infrastructure unless a repo is actually using labels to drive build, test, review, fix, approved, blocked, and failed states across the lifecycle skills.

Research and discovery does not have a standalone runtime skill. The useful behavior is folded into `start-new-project/` as "Grounding Before Shaping"; web and social search, deep research reports, repo context, and the harness's memory and session history are used only when they can change the brief, design direction, platform choice, backlog, or setup decision.
