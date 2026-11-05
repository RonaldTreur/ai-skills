---
name: debugging
description: Investigate and fix bugs without guesswork. Use when behavior is broken, a test is failing, a regression appears, or a user asks for debugging help.
---

# Debugging Skill

Default discipline for investigating and fixing active failures.

## Non-negotiables

- Build the smallest reliable repro or feedback loop before non-trivial fixes.
- Fix the cause at the right seam, not the nearest symptom.
- Before declaring success: the original repro passes, not just a nearby test
  or narrower probe; the smallest relevant regression guardrail has run;
  temporary instrumentation, probes and throwaway scripts are removed.

## Fast path for trivial bugs

For obvious low-risk bugs such as typos, missing imports, wrong variables,
clear off-by-ones, broken selectors, or obvious wiring mistakes:

confirm with the smallest practical repro, apply the obvious fix, then meet the
non-negotiables. No hypothesis lists or causal-chain narration.

## Standard workflow

Use this for non-trivial bugs, uncertain causes, flaky failures, repeated
regressions, production issues, or anything high-risk.

### 1. Reproduce

- Isolate one reliable command, test, request, page flow, or script.
- Prefer deterministic loops over broad "run everything" commands.
- Tighten slow or noisy repros before investigating.
- Record the command, steps, inputs, and observed failure.

### 2. Hypothesize only when useful

Use hypotheses for uncertain, high-risk, non-trivial, or first-fix-failed bugs.
Keep them falsifiable, ranked, and tied to the next disconfirming probe. Surface
them to the user only when they affect a decision or explain a stall.

### 3. Probe deliberately

- Before probing, name the assumption the probe is meant to test.
- Add the smallest probe that separates likely causes.
- Prefer targeted logs, focused assertions, binary search, narrow test edits, or
  smaller fixtures.
- Tag temporary instrumentation so it is easy to remove.
- Do not stack speculative fixes just to see what happens.

### 4. Fix the right seam

- Prefer the earliest correct layer in the causal chain.
- Do not hide the bug behind retries, sleeps, defensive conditionals, or
  duplicated workaround logic unless that behavior is intentional.
- If the real issue is product design, interface ambiguity, or architecture,
  say so instead of forcing a fake code-only fix.

### 5. Finish

Claim the fix only when the non-negotiables hold.

## Defense-in-depth is conditional

Add extra guards only when the bug class justifies it: recurring patterns,
auth/security/data-loss/reliability risk, state corruption, or likely nearby
repeats.

Useful guards include regression tests, boundary validation, clearer invariants,
assertions, or small structural cleanup that removes the bug class. Do not
broaden every small fix into a hardening pass.

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

- Use [[testing]], [[unit-vitest]], and [[e2e-playwright]] when a regression
  test should carry the fix forward.
- Use [[code-review]] if the bug history suggests symptom-layering or
  architecture drift rather than a single isolated defect.
