---
name: "run-workflow-retrospective"
description: "Review merged PRs and route findings through trusted, state-verified guarded actions."
---

# Run a Post-Merge Workflow Retrospective

Run after a pull request has merged. Review how the work moved from intake through implementation, QA, independent review, and merge. Learn from primary evidence and close the loop by implementing safe findings through the project's normal guarded workflow.

This skill is post-merge. It is not an in-flight circuit breaker and must never be described as the mechanism that would have stopped work before merge. RoundTable convergence controls are a separate safety system. A retrospective may evaluate whether those controls behaved correctly and may improve them afterward.

## Trigger and scope

Default to one exact merged pull request.

Record:

- owner/repository and PR number;
- source issue or roadmap when present;
- PR creation and merge timestamps;
- final head and merge commit;
- requested outcome and governing specification;
- workflow configuration used during the PR.

Require current GitHub truth proving the PR is merged. Use the stable RoundTable retrospective-event fingerprint when supplied. If the same event or action fingerprint is already recorded, do not repeat analysis, issue creation, implementation, or notification.

A root-roadmap retrospective may aggregate its merged child PR retrospectives, but it does not replace the per-PR review.

## Start read-only

Evidence collection and diagnosis are read-only. Do not mutate repositories, issues, labels, skills, memory, configuration, or production until the report is complete and every proposed action has been classified.

## Gather evidence and build the scorecard

Use raw user handoffs, issue/PR history, exact heads, checks, reviews, merge events, claim/recovery/watchdog state, retries, guard failures, partial mutations, and gate reruns. A unique earliest legacy claim can establish first dispatch from its `startedAt` and first work from immutable comment creation only when it is unedited, unrecovered and ordered with `startedAt` no later than creation. Otherwise use the recorder's retained `stageFirstStartedAt` map only when the whole relevant claim thread carries it. Never backfill an edited, recovered, ambiguous or invalidly ordered legacy claim from its current `startedAt` or comment timestamp, and never promote a later claim to replace missing first-boundary evidence. For a provider- or model-specific review requirement, verify the completed review's resolved provider/model from runtime evidence, not its agent label or requested model. A fallback review may contribute findings but does not satisfy the named-reviewer requirement; an authentication failure is an incomplete review. Keep that requirement open unless a matching completed review is evidenced. Redact private data; mark unavailable evidence rather than estimating it.

Build one timestamped timeline keyed by exact head or claim and collapse duplicates. Report elapsed time, meaningful LOC, implementation heads, QA/review outcomes, repeated findings, handoff latency, recovery failures, gate reruns, and observable quota change. Identify the critical path and avoidable delay.

When building the scorecard, follow [lifecycle validation](references/lifecycle-validation.md) for the recorder's timing contract, missing-evidence branch and adversarial checks. Complete these checks before accepting the report.

## Diagnose and classify

Classify each problem once as specification/intake, implementation/design, QA, independent review, orchestration, or operational cost. Anchor claims in evidence and assign system defects to the system.

For repeated failures, minimize a deterministic red-capable reproduction, rank falsifiable hypotheses, and change one variable per probe. Record an architectural finding when no valid test seam exists. Verify each implementation leaf fits one fresh context, has one independently testable outcome, and declares dependencies. Review spec fidelity separately from engineering quality.

Lead with findings in the product repository. Route a RoundTable pipeline action only for a concrete, reproducible pipeline defect. Repeated missing historical evidence is an aggregate signal, not a reason to open one issue per merged PR.

Report historically whether the separate circuit breaker fired or should have fired under configured limits; route any defect as a normal improvement action.

## Produce bounded findings

Limit the main action list to five high-impact items. Each action must include:

- stable action fingerprint generated with the recorder's `retrospectiveActionFingerprint` from `src/retrospective-event.js`, using the event fingerprint, exact action heading, lowercase classification, exact target and any timing causes; the verified contract uses version 1 without causes, version 2 with one cause, and version 3 with a canonical deduplicated sorted cause set—do not hard-code version 1 for timing investigations;
- target repository/artifact and owner;
- exact behavior to change;
- expected benefit;
- risk and failure mode;
- deterministic verification;
- safety classification;
- dependency or hierarchy metadata;
- whether explicit approval is required.

Prefer systemic fixes and user corrections over prompt patches and one-off tool noise.

Missing lifecycle boundaries keep their exact per-cause disposition rows, but use `Retrospective ledger` as the follow-up. Use the same rolling-ledger route for a recurring systemic excessive-delay cause already visible across reports. Do not create a fingerprinted issue for each historical gap. An unknown stage may use `Investigation required: Action N` only when there is a specific, reproducible hypothesis that a bounded action can test.

## Classify actions

Each action receives exactly one classification.

### Safe automatic implementation

Use when the action is local, reversible, in scope, and does not involve credentials, auth, gateway lifecycle, release/deployment, broad rollout, destructive work, or a product decision.

Do not stop at a recommendation. Route it into the normal guarded implementation loop:

- deduplicate by the action fingerprint across open and closed issues/PRs;
- update an existing exact-scope issue or create one implementation-ready leaf with retrospective provenance;
- give the leaf concrete acceptance criteria, one fast red-capable command, explicit boundaries, dependencies, and parentage;
- mark valid product-repository leaves `roundtable:reviewed`, never bulk `agent:ready`;
- let the deterministic planner select one at a time;
- use the normal Vectrix → QA → independent Claude review → Gatekeeper path;
- place the exact standalone `<!-- roundtable-retrospective-action:<fingerprint> -->` marker in the created/reused issue or PR;
- record the durable GitHub result as `GitHub: https://github.com/OWNER/REPO/issues/N` or `GitHub: https://github.com/OWNER/REPO/pull/N` on the retrospective event.

For RoundTable's own repository, use a focused branch and PR to `main`, the complete repository check, independent review, and the authorized guarded merge lane. Never edit the live scheduler worktree directly.

### Approval-required action

Fail closed for:

- product or maintainer decisions;
- credentials, auth, permissions, or secrets;
- gateway lifecycle;
- releases or deployments;
- broad rollout;
- destructive operations;
- changes outside the approved repository scope.

Create or update a narrow `needs:*` decision item with the exact standalone action marker and evidence. Record its durable GitHub URL using the same `GitHub: ...` result format. Do not implement it automatically.

### Skill lifecycle action

Route skill changes through Skill Workshop as pending proposals. Never apply a generated proposal automatically. Classify the finding as `approval required`, create or update a marked `needs:maintainer` GitHub decision issue containing the proposal ID, record that issue's `GitHub: ...` result, and wait for explicit user approval.

### No action

Record why no implementation is justified using `No action: <reason>`. The event still completes once and becomes silent on repeated scans.

## Validate automatic implementation

A finding is not complete until its change is falsifiably tested.

Prefer:

- a regression reproducing the workflow defect;
- historical planner/state-machine replay;
- old versus new planner output on captured truth;
- focused tests plus the repository's complete gate;
- a bounded canary on the next eligible item.

After implementation, verify the exact PR merged and the intended behavior is live. If implementation fails its configured convergence control, stop there and let the separate circuit-breaker flow handle the active item.

## Idempotency and event completion

The retrospective event ledger is append-only.

Record:

- retrospective-event fingerprint;
- report marker;
- each action fingerprint and classification;
- created or reused issue/PR identifiers;
- implementation state and final merged commit when applicable;
- validation outcome;
- approval blockers or pending Skill Workshop proposal IDs.

The rolling retrospective ledger is separate from the exact-event ledger. Missing lifecycle evidence and recurring systemic timing causes remain visible there without becoming duplicate per-event GitHub actions. Refresh the one trusted ledger issue through the target RoundTable checkout's `retrospective-ledger` command; create it once, then update that exact issue. Never substitute an ad hoc historical-gap issue.

Before recording the terminal event marker, recompute every action fingerprint, reject duplicates, and verify every safe/approval GitHub result exists and contains a trusted matching action marker. Safe issue results must be closed or carry `roundtable:reviewed`/`agent:*`; safe PR results must be non-draft and target `main` or `develop`. Approval results must be open issues with a `needs:*` label and no active `agent:*` label. Classification-specific result formats are mandatory; prose such as "queued issue #N" is not evidence.

Repeated scans must not rerun a recorded report or recreate an action. New work is permitted only for a new merged PR event or an explicitly versioned replacement action.

The retrospective is complete only when every action is one of:

- implemented and verified;
- queued in the guarded implementation path;
- blocked on explicit approval;
- recorded as no action.

## Report format

Use `templates/workflow-retrospective.md`.

Lead with the merged outcome and the dominant learning. Be candid about abnormal performance. State whether the workflow is healthy now.

The report must include:

- verified timeline and scorecard;
- failure-domain separation;
- root causes tied to evidence;
- historical assessment of the separate circuit breaker;
- no more than five actions;
- action fingerprints and classifications (`safe automatic`, `approval required`, or `no action`);
- rolling-ledger dispositions for lifecycle gaps and recurring systemic timing causes;
- validation plan or outcome;
- implementation/queue/proposal identifiers;
- remaining risks.

Persist the report in the established retrospective event ledger. Keep repeated scheduler scans silent after recording.

## Completion criteria

A retrospective is complete when:

- the exact merged PR is verified;
- the report is recorded once;
- every safe finding has entered or completed guarded implementation;
- missing lifecycle evidence and recurring systemic timing causes are routed to the rolling retrospective ledger instead of per-event issues;
- unsafe actions fail closed;
- skill changes remain pending proposals;
- duplicate scans create nothing;
- implementation outcomes are traceable to the originating retrospective event.
