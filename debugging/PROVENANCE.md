# Debugging Skill Provenance

This document records the external source material that shaped
`debugging/SKILL.md`. It is intentionally concise: enough attribution and
rationale to rebuild the skill close to its current form without rereading the
full methodology folder.

The local policy was approved on 2026-05-22 after comparing these sources
against the repository's existing testing, Playwright, contribution, and project
management skills.

## Rebuild Recipe

To reconstruct the skill, keep these behaviors:

1. Start with a fast deterministic repro or feedback loop before fixing.
2. Allow a lightweight fast path for obvious low-risk bugs.
3. Use explicit hypotheses only when the bug is non-trivial, uncertain,
   high-risk, or the first fix fails.
4. Probe deliberately and fix the root cause at the correct seam.
5. Always rerun the original repro and remove temporary debug instrumentation
   before declaring success.
6. Add defense-in-depth only for recurring or high-impact bug classes.
7. After 3 failed fix attempts, stop and ask by default unless told otherwise.
8. Keep activation guidance in the frontmatter description rather than
   duplicating it in the loaded runtime body.

## Source Influence

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/diagnose/SKILL.md`,
  `skills/engineering/tdd/SKILL.md`, `skills/engineering/README.md`
- License: MIT

What we took:
- The main debugging spine: build a fast, deterministic feedback loop before
  theorizing or fixing.
- Treat the repro loop as something to optimize for speed, precision, and
  determinism.
- Use falsifiable hypotheses for non-trivial bugs.
- Tag and remove temporary debug logs or probes.
- If no good regression seam exists, surface that as an architectural finding
  instead of pretending the bug is fully guarded.

Why:
- This was the clearest reusable default for day-to-day debugging. It improves
  correctness without importing a heavy project-management workflow.

Local adaptation:
- Hypotheses are not always shown to the user. They are surfaced when useful:
  uncertainty, high risk, failed first fix, or user decision needed.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/systematic-debugging/SKILL.md`,
  `skills/systematic-debugging/defense-in-depth.md`,
  `skills/dispatching-parallel-agents/SKILL.md`,
  `skills/test-driven-development/SKILL.md`
- License: MIT

What we took:
- Root-cause investigation before fixes for non-trivial bugs.
- Anti-thrashing guardrails: do not stack speculative fixes, skip repros, or
  keep guessing after repeated failures.
- Stop and reassess after repeated failed fixes.
- Conditional defense-in-depth once a real bug pattern is known.

Why:
- This source contributed the strongest operational guardrails against the
  classic agent failure mode: guessing at code until tests happen to pass.

Local adaptation:
- The local skill keeps a trivial-bug fast path for obvious low-risk issues.
- Defense-in-depth is conditional, not mandatory for every fix.
- After 3 failed fix attempts, the default is stop and ask unless the user
  explicitly asked the agent to continue or stopping would leave the system in a
  bad half-fixed state.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-debug.md`,
  `docs/skills/ce-resolve-pr-feedback.md`,
  `plugins/compound-engineering/skills/ce-compound/SKILL.md`
- License: MIT

What we took:
- Causal-chain thinking before non-trivial fixes.
- Make predictions for uncertain links so probes can disconfirm bad
  explanations.
- Audit assumptions before committing to a fix path.
- Allow diagnosis-only outcomes when the issue is product design, interface
  ambiguity, or architecture rather than a local code defect.

Why:
- This adds rigor for hard bugs without turning every small mistake into a
  formal investigation.

Local adaptation:
- The skill uses this as lightweight guidance for targeted hypotheses,
  deliberate probes, and correct-seam fixes. It does not require a written
  causal-chain report for trivial bugs.

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `AGENTS.md`, `investigate/SKILL.md`, `qa/SKILL.md`
- License: MIT

What we took:
- Treat investigation as its own discipline instead of casual edit-and-retry.
- Preserve evidence for repro and verification.
- Add regression tests after a verified fix when the project has a suitable
  testing seam.
- Reassess when diagnostics repeatedly fail.

Why:
- The evidence-first posture fits the local debugging skill and complements the
  existing contribution and Playwright debugging skills.

What we rejected:
- Clean-tree requirements as a generic debugging rule.
- Per-fix atomic commit loops.
- Telemetry and project-learnings hooks.
- Browser-QA artifact requirements as a universal debugging standard.

Local adaptation:
- GStack influenced the investigation-first stance, but its heavier workflow
  machinery remains out of scope for this repository's generic debugging skill.

### Skill Review Discipline

- Source: local `skill-review/SKILL.md`
- Reviewed ref: `feat/external-skill-adaptation` on 2026-05-23
- Reviewed material: `skill-review/SKILL.md`, first skill-review pass on
  `debugging/SKILL.md`
- License: repository-local process

What we took:
- Runtime skill bodies should avoid duplicate trigger guidance once the
  frontmatter description already covers activation.
- Local `[[skill-name]]` references are valid integration points and should not
  be treated as portability defects.

Why:
- This keeps the debugging skill focused on behavior after activation while
  preserving cross-skill integration.

Local adaptation:
- Removed the loaded-body "Use this skill when" section.
- Kept the integration links to `[[testing-orchestrator]]`, `[[unit-vitest]]`,
  `[[e2e-playwright]]`, and `[[code-review]]`.

## Existing Local Baseline

The external sources did not replace the repository's existing skills. They
filled a gap between them.

Already covered locally:
- Playwright debugging and healing: trace-first investigation, single-test
  isolation, no blind sleeps, root-cause analysis for failing UI tests.
- Contribution workflows: shortest deterministic repro, logs, screenshots, and
  evidence-backed bug reports.
- Testing workflows: test-first and regression-oriented implementation using
  `testing-orchestrator`, `unit-vitest`, and `e2e-playwright`.

Added by the debugging skill:
- A repo-level owner for general bug investigation.
- A unified feedback-loop -> repro -> hypotheses when useful -> probes -> fix
  -> original repro -> cleanup workflow.
- Explicit completion gates for original repro verification and debug
  instrumentation cleanup.
- A stop-and-ask default after 3 failed fix attempts.

## Formal Trail

The fuller methodology record lives in:

- `methodology/disciplines/debugging.md`
- `methodology/ADAPTATION_LOG.md`
- `methodology/sources/gstack.md`
- `methodology/sources/superpowers.md`
- `methodology/sources/compound-engineering.md`
- `methodology/sources/matt-pocock-skills.md`
