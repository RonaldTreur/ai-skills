# Discipline Review: debugging

- Date: 2026-05-22
- Reviewer: Vectrix
- Branch: `feat/external-skill-adaptation`
- Local files reviewed: `e2e-playwright/guides/debugging.md`, `e2e-playwright/roles/healer.md`, `testing-orchestrator/SKILL.md`, `test-planning/SKILL.md`, `unit-vitest/SKILL.md`, `openclaw-contribution/SKILL.md`, `project-manager/SKILL.md`
- External sources reviewed:
  - GStack `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
  - SuperPowers `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
  - Compound Engineering `5297a9440fa009822ceef8052b9e644e782281e1`
  - Matt Pocock Skills `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Status: adopted

## Local Baseline

The repo has strong debugging-adjacent guidance, but it is fragmented.

- `e2e-playwright/guides/debugging.md` already pushes single-test isolation,
  trace-first investigation, and avoiding blind sleeps.
- `e2e-playwright/roles/healer.md` requires root-cause analysis per failing test
  and allows `test.fixme()` only for likely app defects.
- `openclaw-contribution/SKILL.md` enforces evidence-first bug reporting:
  shortest deterministic repro, logs, screenshots, and explicit root cause when
  known.
- `test-planning`, `unit-vitest`, and `testing-orchestrator` enforce test-first
  and regression-oriented workflows around implementation.

What is missing is a repo-level debugging owner that unifies these pieces for
non-Playwright bugs, general test failures, and "something is broken" requests.
There is no current hard gate for:

- building a reproducible feedback loop before hypothesizing
- stating and testing explicit hypotheses
- distinguishing root-cause fixes from symptom masking
- cleaning up temporary instrumentation before declaring success

## Source Comparison

### GStack

- Source ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Files reviewed: `AGENTS.md`, `investigate/SKILL.md`, `qa/SKILL.md`
- Useful patterns:
  - Treat bugs as a routed discipline: `/investigate` instead of casual
    debugging.
  - Capture strong evidence for repro and verification, especially in UI work.
  - Write regression tests after a verified fix when the framework exists.
  - Stop repeated failed diagnostics and reassess instead of compounding guesses.
- Conflicts or risks:
  - The skill bundles telemetry, hooks, project learnings, browser assumptions,
    and commit-per-fix workflow that do not fit this repo as-is.
  - Some QA rules are intentionally browser-specific and should not become a
    general debugging rule.
- Adoption recommendation:
  - Adapt the investigation-first stance and evidence discipline.
  - Reject clean-tree/atomic-commit requirements as part of the generic
    debugging discipline.

### SuperPowers

- Source ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Files reviewed: `README.md`, `skills/systematic-debugging/SKILL.md`, `skills/systematic-debugging/defense-in-depth.md`, `skills/dispatching-parallel-agents/SKILL.md`, `skills/test-driven-development/SKILL.md`
- Useful patterns:
  - Hard "no fixes without root cause investigation first" gate.
  - Strong anti-thrashing language for multi-fix guesses, skipped repros, and
    assumptions.
  - Clear trigger to question architecture after repeated failed fixes.
  - Conditional defense-in-depth once the true root-cause pattern is known.
  - Parallel investigation guidance for independent failures.
- Conflicts or risks:
  - The tone is intentionally rigid; forcing it everywhere may create friction
    for trivial fixes or conversational debugging.
  - The architecture-escalation threshold may be too blunt for Ronald's normal
    iteration style unless softened.
- Adoption recommendation:
  - High-value source for a local debugging skill's guardrails.
  - Keep a trivial-bug fast path and make architecture escalation advisory
    rather than automatic.

### Compound Engineering

- Source ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Files reviewed: `README.md`, `docs/skills/ce-debug.md`, `docs/skills/ce-resolve-pr-feedback.md`, `plugins/compound-engineering/skills/ce-compound/SKILL.md`
- Useful patterns:
  - Require an end-to-end causal chain before proposing a fix.
  - For uncertain links, make a prediction that can disconfirm a symptom-level
    explanation.
  - Perform an assumption audit before testing hypotheses.
  - Permit diagnosis-only outcomes and escalate to design work when the bug is
    actually a product/interface problem.
- Conflicts or risks:
  - The surrounding workflow assumes heavier PR, branch, and specialist-agent
    machinery than this repo needs.
  - Full causal-chain narration may be too ceremonial for small local failures
    unless scoped carefully.
- Adoption recommendation:
  - Adapt the causal-chain, prediction, and assumption-audit concepts.
  - Do not import the larger workflow or auto-PR behavior into the discipline.

### Matt Pocock Skills

- Source ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Files reviewed: `README.md`, `skills/engineering/README.md`, `skills/engineering/diagnose/SKILL.md`, `skills/engineering/tdd/SKILL.md`
- Useful patterns:
  - Best articulation of the core debugging job: build a fast deterministic
    feedback loop before theorizing.
  - Treat the repro loop itself as something to optimize for speed, precision,
    and determinism.
  - Generate several falsifiable hypotheses before probing.
  - Tag debug logs and remove them at the end.
  - If no correct seam exists for a regression test, record that as an
    architectural finding instead of faking confidence.
- Conflicts or risks:
  - The process expects more explicit user-visible hypothesis checkpoints than
    Ronald may want on routine debugging passes.
  - Some suggestions assume a richer project context layer (`CONTEXT.md`, ADRs)
    than every repo will have.
- Adoption recommendation:
  - Strongest source for the local debugging spine.
  - Adapt hypothesis ranking and loop-building as defaults; decide with Ronald
    whether user-visible hypothesis lists should be mandatory or internal.

## Approved Policy

The debugging discipline is now approved for local adoption with these rules:

1. Create a dedicated `debugging/` skill as the repo-level owner for bug
   investigation and repair.
2. Keep a trivial-bug fast path: no needless paperwork for obvious low-risk
   bugs, but still verify the original issue is fixed.
3. Surface explicit hypotheses only when useful: non-trivial bugs, uncertainty,
   failed first fix, production or high-risk situations, or when a user
   decision is needed.
4. Make rerunning the original repro and cleaning temporary debug
   instrumentation hard completion gates.
5. Make defense-in-depth conditional rather than universal: use it for
   recurring or high-impact bug classes, auth/security/data-loss/reliability
   risks, or likely nearby repeats.
6. After 3 failed fix attempts, stop and ask by default unless the user
   explicitly said to continue or stopping would leave the system in a bad
   half-fixed state.

## Recommended Adaptations

1. Add a dedicated debugging skill with this skeleton:
   feedback loop → reproduce → targeted hypotheses when useful → targeted probes
   → fix at the correct seam → rerun original repro → cleanup instrumentation.
   Intended local target: new `debugging/` skill.
   Provenance entry ids:
   `2026-05-22-debugging-matt-feedback-loop`
   `2026-05-22-debugging-superpowers-root-cause-gate`
   `2026-05-22-debugging-compound-causal-chain`
2. Encode hard completion gates in that skill:
   rerun the original repro, run the smallest useful regression guardrail, and
   remove temporary instrumentation before finishing.
   Intended local target: `debugging/SKILL.md`.
   Provenance entry ids:
   `2026-05-22-debugging-matt-feedback-loop`
   `2026-05-22-debugging-superpowers-root-cause-gate`
3. Add a narrow defense-in-depth note for recurring or high-impact bug classes
   rather than every bug fix.
   Intended local target: `debugging/SKILL.md`.
   Provenance entry id:
   `2026-05-22-debugging-superpowers-defense-in-depth`
4. Encode a stop-and-ask default after 3 failed fix attempts, with an exception
   when the user explicitly wants continued work or stopping would leave a bad
   half-fixed state.
   Intended local target: `debugging/SKILL.md`.
   Provenance entry ids:
   `2026-05-22-debugging-superpowers-root-cause-gate`
   `2026-05-22-debugging-compound-causal-chain`

## Rejections And Residual Constraints

- Rejected for the generic debugging discipline:
  - GStack's clean-tree, per-fix atomic commit loop, telemetry, and project
    learnings hooks. Useful in their system, too invasive here.
  - Full browser-QA evidence requirements as a universal rule. Keep them scoped
    to browser-facing workflows.
- Not adopted as default behavior:
  - Mandatory user-visible hypothesis dumps for routine debugging. Keep that
    conditional.
  - Automatic architecture-escalation ceremonies after repeated failed fixes.
    Stop and ask after 3 failed attempts instead.

## Verification Notes

- Reviewed upstream source files at pinned HEAD SHAs using shallow clones in
  `/tmp/external-skill-sources/`.
- Compared the proposed debugging practices against current local skills and
  instructions, then promoted the approved policy into a dedicated local skill.
- The adoption intentionally stays scoped to a new debugging owner skill plus
  provenance/docs updates. It does not yet rewrite adjacent testing skills.
