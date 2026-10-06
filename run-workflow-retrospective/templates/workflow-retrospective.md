# Workflow Retrospective — <merged PR>

## Outcome

- **Repository / PR:**
- **Requested outcome:**
- **Merged outcome:**
- **Final head / merge commit:**
- **Elapsed time:**
- **Avoidable delay:**
- **Usage impact:**
- **Current health:** healthy | degraded | blocked

## Executive finding

<One candid paragraph separating implementation/design from orchestration.>

## Scorecard

- Elapsed wall-clock time:
- Implementation heads:
- QA pass/fail:
- Independent review pass/fail:
- Complete successful routes:
- Repeated finding families:
- Scheduler/recovery failures:
- Full-gate reruns:
- Handoff latency:
- Quota/usage delta:

## Critical-path timeline

- `<timestamp>` — <event, exact head/claim, significance>

## Timing analysis

<Insert the exact timing structure from the target checkout's docs/retrospective-timing-analysis.md. Follow references/lifecycle-validation.md: include all lifecycle boundaries, exclusive stage accounting, merge-to-retrospective wait and per-cause delay dispositions. Preserve unknowns and route missing evidence to fingerprinted investigations; do not fill gaps with estimated timestamps.>

## What worked

- <evidence-backed success>

## What failed

### <failure>

- **Domain:** specification | intake | implementation | design | qa | independent review | orchestration | operational cost
- **Evidence:**
- **Impact:**
- **Proximate cause:**
- **Systemic root cause:**
- **Safeguard result:**

## Separate convergence-control assessment

- **Configured limits:**
- **Actual trigger:**
- **Expected trigger:**
- **Control defect, if any:**

## Spec fidelity

<Pass/fail and findings.>

## Engineering quality

<Pass/fail and findings.>

## Prioritized improvements

### 1. <action>

- **Action fingerprint:**
- **Classification:** safe automatic | approval required | no action
- **Target/owner:**
- **Timing cause / Timing causes:** <For timing actions, choose the singular exact cause or plural JSON cause set; omit for non-timing actions. Compute the fingerprint with the recorder helper after this choice.>
- **Change:**
- **Benefit:**
- **Risk:**
- **Verification:**
- **Dependencies / parent:**
- **Result:** `GitHub: https://github.com/OWNER/REPO/issues/N` | `GitHub: https://github.com/OWNER/REPO/pull/N` | `No action: <reason>`

## Validation outcome

- <evidence that each implemented or queued action is safe, deduplicated, and falsifiable>

## Remaining risks

- <risk and owner>

## Event completion

- **Retrospective event fingerprint:**
- **Report marker:**
- **Action states:** <Separate queued investigations, implemented/verified remedies and approval blockers.>
- **Proof markers:** each GitHub result contains `<!-- roundtable-retrospective-action:<fingerprint> -->`
