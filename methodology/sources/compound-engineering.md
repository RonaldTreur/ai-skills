# Source Inventory: Compound Engineering

- Source URL: https://github.com/everyinc/compound-engineering-plugin
- License: MIT
- Commit/tag/release reviewed: `5297a9440fa009822ceef8052b9e644e782281e1`
- Retrieved: 2026-05-22 via shallow local clone
- Reviewer: Vectrix
- Local clone/path, if any: `/tmp/external-skill-sources/compound-engineering-plugin`

## Scope Reviewed

- `README.md`
- `docs/skills/ce-debug.md`
- `docs/skills/ce-code-review.md`
- `docs/skills/ce-frontend-design.md`
- `docs/skills/ce-plan.md`
- `docs/skills/ce-resolve-pr-feedback.md`
- `plugins/compound-engineering/skills/ce-compound/SKILL.md`
- `plugins/compound-engineering/skills/ce-code-review/SKILL.md`
- Selected reviewer agents under
  `plugins/compound-engineering/skills/ce-code-review/agents/`

## Relevant Disciplines

- Code review
- Multi-agent review
- Planning
- Worktree workflows
- Learning capture
- Solution documentation
- Agent orchestration and delegation

## Strong Ideas

- Debugging gate based on an end-to-end causal chain, not a plausible fix.
- Predictions for uncertain causal links to distinguish root cause from symptom
  masking.
- Assumption audit before testing hypotheses.
- Diagnose-only outcomes and escalation to design work when the "bug" is really
  a product or architecture problem.
- Diff-aware code review depth based on risk and blast radius.
- Confidence-gated review synthesis: drop unanchored findings, dedupe findings,
  and separate severity from action ownership.
- Plans should capture guardrails, decisions, scope, units, risks, and test
  scenarios, not brittle implementation choreography.
- Stable implementation-unit identity and clear planning-time vs
  implementation-time decisions prevent stale plans from breaking execution.
- Frontend design should detect existing systems, state a visual thesis before
  building, and verify visually before claiming quality.

## Adoption Risks

The workflow assumes a heavier engineering-organization loop with many
specialist agents. Adapt selectively to avoid ceremony and duplication with
existing OpenClaw roles.

## Re-Review Trigger

Revisit during each discipline pass and at least every six months while this project remains active.
