# Source Inventory: OpenClaw test-audit skill

- Source URL: https://github.com/openclaw/openclaw/tree/main/.agents/skills/test-audit
- License: MIT
- Commit/tag/release reviewed: `80930af448eb` (2026-09-23, PR #156316 "docs(skills): prevent junk tests and add subsystem test-pruning campaigns")
- Retrieved: 2026-10-04 through the GitHub contents API (`SKILL.md` 7,750 bytes; `CAMPAIGN.md` 5,463 bytes)
- Reviewer: Claude (Fable 5.1), with Ronald
- Local clone/path, if any: session scratchpad only (not vendored)

## Scope Reviewed

- `SKILL.md` — three modes (authoring gate, audit, campaign), junk patterns, value and retention bars, discovery, candidate evidence, edit shape, validation, landing, handoff
- `CAMPAIGN.md` — eight-step subsystem pruning campaign: baseline, lanes, R/F/C/D ledger, layer plan, cutover, preservation review with mutation checks, product defects, reconcile and handoff

## Relevant Disciplines

- Testing and QA (existing owners `unit-vitest`, `test-ci-policy`, `testing-orchestrator`, `test-planning`; new owner for test value and pruning: `test-audit`)
- Code review (overlap with test-risk assessment in `code-review`)

## Strong Ideas

- One value bar shared by authoring and audit: a test must name the behavior it protects, the regression that fails it, why existing coverage misses that failure, and whether it needs a test-only production seam.
- Optimize for confidence, not deletion count; slow or static is not a deletion reason.
- A junk-pattern checklist: assertion-free probes, copied inventories and export lists, source greps, mocks that implement the asserted behavior, negative controls that pass for the wrong reason, names that promise more than the input exercises.
- A retention bar that keeps source inspection when it is the cheapest independent guard of a user-facing key, byte, or path.
- Candidate-evidence fields that must all be filled before a deletion.
- Campaign mechanics: R/F/C/D ledger per declaration, a keeper suite per contract, preservation review with one deliberate production mutation per restored contract, and baseline failures treated as product bugs with a control run.

## Adoption Risks

- Validation and landing are bound to OpenClaw tooling (`scripts/run-vitest.mjs`, `scripts/check-changed.mjs`, `$autoreview`, `$crabbox`, `$openclaw-pr-maintainer`, `scripts/pr`); none exist in local projects.
- The upstream description triggers on every test write; locally that would compete with `unit-vitest` and add friction to ordinary tests.
- Campaign guidance assumes a large monorepo with plugin subsystems and parallel agent lanes; small projects need audit mode only.
- Ledgers and mutation checks are manual; no tooling ships with the skill.

## Re-Review Trigger

- When OpenClaw materially changes `.agents/skills/test-audit/`, or before the next revision of the local testing skills.
