---
name: debugging
description: Investigate and fix bugs without guesswork. Use when behavior is broken, a test is failing, a regression appears, or a user asks for debugging help.
---

# Debugging Skill

Default bug-fixing discipline for this repository.

Use this skill when:
- A bug report needs investigation
- A failing test needs diagnosis
- A regression appears after a change
- The request is "debug this", "find the cause", or "why is this broken?"

Do not use this skill for:
- Pure code review with no active failure
- Brand-new feature work with no observed bug
- Broad refactors unless debugging has already shown the design is the problem

## Core stance

- Build the fastest deterministic repro or feedback loop you can before proposing fixes.
- Fix the cause at the right seam, not the nearest symptom.
- Verify against the original repro before declaring success.
- Remove temporary debug instrumentation before finishing.

## Fast path for trivial bugs

Use a lightweight path when the bug is obvious and low-risk:
- typo, missing import, wrong variable, clear off-by-one, broken selector, obvious wiring mistake

For these bugs:
1. Confirm the bug with the smallest practical repro.
2. Apply the obvious fix.
3. Re-run the original repro to prove it is fixed.
4. Remove any temporary instrumentation.

Do not force extra paperwork, formal hypothesis lists, or causal-chain narration for trivial fixes.

## Standard workflow

Use the full workflow for non-trivial bugs, uncertain causes, flaky failures, repeated regressions, production issues, or anything high-risk.

### 1. Reproduce

- Isolate the failure to the smallest reliable loop: one command, one test, one request, one page flow, one script.
- Prefer deterministic repros over broad "run everything" loops.
- If the current repro is slow or noisy, spend time tightening it first.
- Record the exact command, steps, inputs, and observed failure.

### 2. Form hypotheses only when useful

Surface explicit hypotheses when:
- the bug is non-trivial
- the cause is uncertain
- the first fix failed
- the bug is in production or otherwise high-risk
- the user needs to choose between plausible paths

When you do surface hypotheses:
- keep them falsifiable
- rank them by likelihood
- name the next probe that would disprove each one

Do not invent a hypothesis ceremony for obvious bugs.

### 3. Probe deliberately

- Add the smallest probe that can separate likely causes.
- Prefer targeted logs, focused assertions, binary search through the flow, narrow test edits, or a smaller fixture.
- Tag temporary instrumentation so it is easy to remove.
- Avoid stacking speculative fixes just to "see if it works".

### 4. Fix the right seam

- Prefer the earliest correct layer in the causal chain.
- Do not hide the bug behind retries, sleeps, defensive conditionals, or duplicated workaround logic unless the workaround is the intended product behavior.
- If the real issue is product design, interface ambiguity, or architecture, say so instead of forcing a fake code-only fix.

### 5. Verify hard gates

These are completion gates:
- Re-run the original repro, not just a nearby test or a narrower probe.
- Run the smallest relevant regression guardrail available.
- Remove temporary debug instrumentation, probes, and throwaway scripts before finishing.

Do not claim the bug is fixed until the original repro passes again.

## Defense-in-depth is conditional

Add extra guards only when the bug class justifies it:
- recurring or likely-to-repeat bug pattern
- auth, security, data loss, reliability, or state-corruption risk
- nearby code strongly suggests the same mistake may exist elsewhere

Defense-in-depth can include:
- regression tests at the right seam
- validation at boundaries
- clearer invariants or assertions
- small structural cleanup that removes the bug class

Do not add ceremony or broad hardening for every tiny bug.

## Three failed attempts rule

After 3 failed fix attempts, stop and ask by default.

Exceptions:
- the user explicitly told you to keep going
- stopping would leave the system in a bad half-fixed state

When you stop, summarize:
- current repro
- failed attempts
- strongest remaining hypotheses
- what decision or help is needed

## Integration notes

- Attribution and rebuild notes live in `PROVENANCE.md`.
- Use `[[testing-orchestrator]]`, `[[unit-vitest]]`, and `[[e2e-playwright]]` when a regression test should carry the fix forward.
- Use `[[code-review]]` if the bug history suggests symptom-layering or architecture drift rather than a single isolated defect.
- Follow repo git rules and keep debug-only changes out of final commits.
