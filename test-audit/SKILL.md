---
name: test-audit
description: Prune a test suite: sweep a folder, package or repo for low-value, duplicated or implementation-coupled tests, or run a subsystem pruning campaign. Use when asked to cull, audit or question existing tests.
disable-model-invocation: true
---

# Test Audit

Remove tests that do not earn their place, and the test-only production seams they keep alive. Optimize for confidence in the suite, not for the number of deleted tests. Writing new tests is the `testing` skill's authoring gate; this skill judges tests that already exist.

Two modes:

- **Audit**: a focused sweep that removes a few high-confidence low-value tests. Ship each sweep as its own coherent PR.
- **Campaign**: prune one subsystem's whole test surface. Read `references/pruning-campaign.md` before starting one.

Read the repository's root and scoped `AGENTS.md`, `TEST_PLAN.md` and CI config first; project rules about what must stay tested win over this skill's defaults. The junk patterns to hunt for are in `references/junk-patterns.md` under [[testing]].

## Value bar

A test pays for its maintenance by protecting behavior, a credible regression, or an independently meaningful contract.

Before judging a candidate, read the complete test and its production owner: entry point, callers, callees, sibling implementations, overlapping tests, CI routing and history. When a test claims dependency-backed behavior, read the dependency's source or types.

## Retention bar

Keep a test that independently enforces a public API, protocol, config, migration, storage, security, platform, default, generated-output, package, release or architecture contract. Also keep:

- call ordering when the order is observable behavior;
- regressions with a credible failure mode;
- source inspection when it is the cheapest independent guard: it fails when the user-facing key, byte or path changes and survives an identifier-only refactor.

A retained test that fails on the baseline is a possible product bug: reproduce it and repair the owner rather than deleting the test. Slow or static is not a deletion reason. A test that resembles implementation may still be the independent contract; prove otherwise before removing it.

## Discovery and evidence

Discovery is read-only; report evidence before editing. Outside a campaign, prefer a few high-confidence candidates over a long speculative inventory. For broad scope, split lanes along production owner boundaries and run them in parallel with the packet and status contract in `references/delegation.md` under [[project-manager]].

Record every field before editing; a missing field means the candidate is not ready:

- exact test name and location;
- the failure it can actually detect;
- non-test callers of the production or support seam it covers;
- the stronger owner-boundary proof that remains, or why none is needed;
- history and the reason the test or seam exists;
- production or test-support deletion it unlocks;
- risk and the focused validation command.

## Edit shape

Stop any Vitest watcher in the checkout before editing. Work in one coherent owner-boundary batch. Delete obsolete test-only exports, globals, wrappers and dead production paths instead of keeping aliases. Move retained regressions to their canonical owners. Fold repeated package or dependency assertions into one generic contract. Prefer net-negative production lines. Add no replacement tests that restate the same implementation, and turn no uncertain candidate into cleanup to raise the count.

## Validation and landing

1. Run the smallest owner and sibling tests with the project's runner.
2. For a removed source-grep or plan assertion, run the executable script or dry-run that owns the real contract.
3. Run the formatter on changed files, then `git diff --check`.
4. Run the gate the repository requires for changed files, then the full suite its CI policy demands.
5. Inspect `git diff --numstat`; report production and tooling lines separately from tests and test support.
6. Have the batch reviewed with [[code-review]].

Commit, push or open a PR only when authorized, through [[implement-issue]]: one coherent PR per batch. After landing, refresh from the base branch and rerun discovery for the next batch. Update `TEST_PLAN.md` when a suite's scope or strategy changes.

Hand off with: removed low-value categories and their root cause; production owner simplifications; retained false positives and why they stay; focused and full proof actually run; production versus test line counts; PR and merge state; named follow-ups.
