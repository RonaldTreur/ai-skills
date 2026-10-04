# Test-pruning campaign

Campaign mode prunes one subsystem's whole test surface in one PR: a package, a
public entry point, a plugin, or one core area. The value bar, retention bar,
candidate evidence, and validation in `SKILL.md` apply to every lane. This file
adds the order of work. Each step ends on its completion criterion; do not start
the next step early.

## 1. Baseline

Pin the base branch SHA. Record the subsystem's test and support line counts and
every in-scope test file's pass/fail state. Keep baseline failures in their own
list: they are often real product bugs, not stale tests.

Done when every in-scope test file has a recorded baseline result.

## 2. Lanes and inventory

Split the surface into lanes along production owner boundaries, not file
prefixes: for example accounts, commands, dispatch, inbound, outbound,
persistence, transport, shared helpers, harness, and live or QA scenarios.
Include the subsystem's cases at shared core boundaries and its QA or live-proof
harness tests.

Done when every test file and QA scenario belongs to exactly one lane.

## 3. Read-only ledger per lane

Give each lane to its own read-only reviewer, a subagent through
[[agent-delegation]] when available. The reviewer reads every assigned test in
full, including parameter tables, plus the production owners, entry points,
callers, history, and CI routing. Every test declaration gets one mark and an
evidence line; an `it.each` is one declaration unless its rows need different
marks.

- `R` retain: name the contract and the bug it catches. A move to a
  better-named file stays `R` with the move noted.
- `F` fix: keep the contract but repair the assertion, such as a vacuous
  negative that passes when only one of several items is missing.
- `C` consolidate: name the owner that absorbs the assertion first, such as a
  sibling table case, a stronger boundary suite, or the shared owner in another
  package.
- `D` delete: name the proof that remains, or why no contract exists.

Judge a test by its assertions, not its name.

Done when every declaration in the lane has a mark and an evidence line.

## 4. Layer plan per lane

The ledger is input, not the edit list. A second read-only pass looks for the
redundant layer: suites that replay one shared component through a mocked
collaborator next to stronger real-boundary suites. Name the keeper suite for
each contract; prefer the real transport boundary with a fake network over a
mocked collaborator. Correct ledger errors this pass finds.

Done when each lane plan names its retired files, its keeper per contract, the
assertions to carry into keepers, and the test-only production seams unlocked.

## 5. Cutover

Edit lane by lane. Serialize changes to shared harnesses and support files
through one owner. With each lane, remove the test-only production seams it
unlocks: injection parameters, getters, reset exports, and indirection layers.
Register moved suites in CI routing and test inventories, and update shrink-only
line-cap baselines. Put durable test-ownership rules in the subsystem's
`AGENTS.md`, drawn from mistakes the campaign actually found.

Done when every lane plan is applied and each lane's keepers pass.

## 6. Preservation review

Before claiming completion, have independent reviewers compare deleted coverage
against the keepers, one reviewer per boundary group. They look for contracts
that lost their only proof and for new assertions that cannot fail. For each
restored contract, make one deliberate mutation of the production owner, confirm
the keeper goes red, then restore the source byte for byte.

Done when every reported gap is restored or rejected with source evidence, and
every restored contract has a caught mutation.

## 7. Product defects

A baseline failure that survives into a keeper is a bug report. Fix it at its
owner in a separate commit and prove it through the real user flow, with a
control run that reverts the fix and shows the old behavior. Record unrelated
discrepancies as follow-ups instead of fixing them in the campaign.

Done when each repaired defect has a failing control and a passing candidate on
the same harness.

## 8. Reconcile and hand off

Campaigns outlive many base-branch commits. Merge the base branch rather than
rebasing a long campaign. When the base modified a file the campaign deleted,
keep the deletion and port the new contract into the keeper; confirm every new
regression the base added still has a home. Rerun the whole subsystem suite, and
repeat live proof when the subsystem has it, on the merged head. Expect review
tooling to truncate very large diffs; record maintainer decisions in the PR
evidence rather than editing gates.

Hand off with the `SKILL.md` report plus: baseline and final test and support
line counts with production counted separately; lanes, retired layers, and
keepers; preservation gaps found and their mutations; and product defects with
control and candidate proof.
