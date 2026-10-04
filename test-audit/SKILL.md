---
name: test-audit
description: "Judge whether tests earn their place: check whether a new or changed test earns its place, sweep a suite for low-value, duplicated, or implementation-coupled tests, or prune one subsystem's test surface. Use when asked to cull, audit, or question tests; unit-vitest still writes them."
---

# Test Audit

One value bar, three modes:

- **Authoring**: gate every new or changed test before it lands.
- **Audit**: a focused sweep that removes a few high-confidence low-value tests
  and the test-only production seams they keep alive. Ship each sweep as its own
  coherent PR.
- **Campaign**: prune one subsystem's whole test surface. Read `CAMPAIGN.md`
  before starting one.

Optimize for confidence in the suite, not for the number of deleted tests. Read
the repository's root and scoped `AGENTS.md`, `TEST_PLAN.md`, and CI policy
first; project rules about what must stay tested win over this skill's defaults.

Related: [[unit-vitest]] writes tests, [[test-ci-policy]] owns gates and
thresholds, [[code-review]] reviews the result, [[implement-issue]] lands it.

## Authoring gate

Before adding or changing a test, answer all four. A missing answer means the
test is not ready:

1. Which observable behavior, invariant, or independent contract does it
   protect?
2. Which credible regression makes it fail?
3. Why does existing coverage not already catch that? Every contract has one
   primary owner test at its strongest boundary. Another layer earns its own
   test only for a risk the owner cannot reach, such as transport, lifecycle, or
   persistence. Extend a table-driven case or shared fixture before adding a
   near-duplicate, and consolidate duplicated setup in the same change.
4. Does it need a production seam (export, flag, wrapper, injection hook) that
   no production caller needs? Then move the test to the real boundary instead.

Then check it against the junk patterns below. A match fails the gate unless the
retention bar names the contract it independently guards. A test that breaks
under behavior-preserving refactoring asserts implementation; rewrite it at the
owning boundary.

Bug regression tests must fail on the pre-fix code for the intended reason and
pass after the fix at the owner boundary. A regression test that never
demonstrably failed proves the mock, not the fix. One regression at the owner
covers the bug; do not replay the scenario at every layer it crosses.

## Junk patterns

The authoring gate rejects new tests that match one; audits hunt for existing
ones.

Vacuous or circular:

- assertion-free probes that only execute code for coverage;
- self-comparisons, identity copies, or expected values computed by the helper
  or renderer under test;
- mocks that implement the behavior being asserted, or one identical mock
  standing in for different APIs;
- fixtures that hand the owner the receipts, acknowledgements, or callback order
  it is supposed to produce, or persistence asserted against a store the path
  never writes.

Duplicated or misplaced:

- copies of fixtures, inventories, manifests, or export lists;
- private predicate or call-shape tests that duplicate a real boundary;
- repeated invocations of one contract, or provider-local replays of a shared
  helper;
- the same scenario replayed at several layers.

Coupled to implementation:

- exact source, import, or string greps that survive no refactor;
- tests whose only purpose is keeping a test-only export, global, or wrapper
  alive;
- dead production code whose only callers are tests;
- capability or flag tests that restate a declaration instead of exercising what
  the flag promises.

Misleading:

- negative controls that pass for an unrelated reason, such as a different
  guard's denial or a rejection the production path never reaches;
- names or fixtures that promise more than the input exercises.

## Value bar

A test pays for its maintenance by protecting behavior, a credible regression,
or an independently meaningful contract. In an audit, a test that must change
for behavior-preserving source reorganization is suspect, not automatically
deletable; the authoring gate still rejects new ones.

Before judging a candidate, read the complete test and its production owner:
entry point, callers, callees, sibling implementations, overlapping tests, CI
routing, and history. When a test claims dependency-backed behavior, read the
dependency's source or types directly.

## Retention bar

Keep a test that independently enforces a public API, protocol, config,
migration, storage, security, platform, default, generated-output, package,
release, or architecture contract. Also keep:

- call ordering when the order is observable behavior;
- regressions with a credible failure mode;
- source inspection when it is the cheapest independent guard: it fails when the
  user-facing key, byte, or path changes and survives an identifier-only
  refactor;
- a retained test that fails on the baseline: treat it as a possible product
  bug, reproduce it, and repair the owner rather than deleting the test.

Slow or static is not a deletion reason. A test that resembles implementation
may still be the independent contract; prove otherwise before removing it.

## Discovery

Discovery is read-only; report evidence before editing. Outside campaign mode,
prefer a few high-confidence candidates over a long speculative inventory. For
broad scope, split lanes along production owner boundaries (packages, apps,
tooling, and one cross-cutting pattern sweep) and run them in parallel through
[[agent-delegation]] when available.

## Candidate evidence

Record every field before editing; a missing field means the candidate is not
ready:

- exact test name and location;
- the failure it can actually detect;
- non-test callers of the production or support seam it covers;
- the stronger owner-boundary proof that remains, or why none is needed;
- history and the reason the test or seam exists;
- production or test-support deletion it unlocks;
- risk and the focused validation command.

## Edit shape

Work in one coherent owner-boundary batch. Delete obsolete test-only exports,
globals, wrappers, and dead production paths instead of keeping aliases. Move
retained regressions to their canonical owners. Fold repeated package or
dependency assertions into one generic contract. Prefer net-negative production
lines. Do not add replacement tests that restate the same implementation, and do
not turn uncertain candidates into cleanup to raise the deletion count.

## Validation

Never edit source or tests while a Vitest watcher runs in the checkout.

1. Run the smallest owner and sibling tests with the project's runner, for
   example `pnpm exec vitest run <path-or-filter>`.
2. For a removed source-grep or plan assertion, run the executable script or
   dry-run that owns the real contract.
3. Run the formatter on changed files, then `git diff --check`.
4. Run the gate the repository requires for changed files, then the full suite
   its CI policy demands (see [[test-ci-policy]] and `TEST_PLAN.md`).
5. Inspect `git diff --numstat`; report production and tooling lines separately
   from tests and test support.
6. Have the final batch reviewed with [[code-review]].

## Landing

Commit, push, or open a PR only when authorized, through [[implement-issue]]'s
flow: one coherent PR per batch. After landing, refresh from the base branch and
rerun read-only discovery for the next batch. Update `TEST_PLAN.md` when a
suite's scope or strategy changes.

## Handoff

Report the removed low-value categories and their root cause; production owner
simplifications; retained false positives and why they stay; focused and full
proof actually run; production versus test line counts; PR and merge state; and
named follow-ups.
