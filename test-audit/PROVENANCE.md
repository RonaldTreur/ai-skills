# Provenance: test-audit

Rebuild recipe: read the OpenClaw `test-audit` skill and its `CAMPAIGN.md` (below); keep the three-mode structure (authoring gate, audit sweep, subsystem campaign), the four authoring questions with the one-owner-per-contract rule, the junk-pattern checklist, the value and retention bars, the candidate-evidence fields, the net-negative edit shape, and the eight campaign steps with the R/F/C/D ledger; replace every OpenClaw runtime reference (`scripts/run-vitest.mjs`, `scripts/check-changed.mjs`, `$autoreview`, `$crabbox`, `$openclaw-pr-maintainer`, `scripts/pr`) with the local owners (`unit-vitest`, `test-ci-policy`, `code-review`, `implement-issue`, `agent-delegation`, `TEST_PLAN.md`); drop the Telegram campaign anecdotes; group the junk patterns by failure family; narrow the description so ordinary test writing still routes to `unit-vitest`.

## Source: openclaw/openclaw — `.agents/skills/test-audit`

- URL: https://github.com/openclaw/openclaw/tree/main/.agents/skills/test-audit — MIT license
- Ref: `80930af448eb` (2026-09-23, "docs(skills): prevent junk tests and add subsystem test-pruning campaigns (#156316)")
- Files: `SKILL.md`, `CAMPAIGN.md`; reviewed 2026-10-04 through the GitHub contents API
- Taken (paraphrased and structural; no copied prose beyond short terms such as the `R`/`F`/`C`/`D` marks): three modes under one value bar; the four authoring questions and the owner-boundary rule; the junk-pattern checklist; "optimize for confidence, not deletion count"; the retention bar, including source inspection as the cheapest independent guard; the candidate-evidence fields; the net-negative production edit shape; the campaign order (baseline, lanes, ledger, layer plan, cutover, preservation review with mutations, product defects, reconcile).
- Why it fit: the local testing skills say "test behavior, not implementation" but had no procedure for deciding whether an existing test earns its place or for pruning a suite safely. This source supplies exactly that, with evidence fields that match the local preference for proof over narration.
- How adapted: OpenClaw commands, sandbox rules, PR tooling, and `$`-prefixed skill references replaced by local skill owners and a plain `pnpm exec vitest run` example; validation routed through `TEST_PLAN.md` and `test-ci-policy`; campaign anecdotes removed; junk patterns regrouped into vacuous, duplicated, coupled, and misleading families; description narrowed so `unit-vitest` stays the default for writing tests.
- Rejected: installing the upstream skill verbatim (runtime coupling to OpenClaw scripts and sandbox, always-on trigger); the mandatory `$autoreview` final step (replaced by `code-review`).
- Deferred: automation for ledgers and mutation checks; a repository-level shrink-only line-cap gate (belongs to `test-ci-policy` if adopted).

See `methodology/ADAPTATION_LOG.md` (entries dated 2026-10-04) and `methodology/disciplines/testing-test-audit.md`.
