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
- `docs/skills/ce-resolve-pr-feedback.md`
- `plugins/compound-engineering/skills/ce-compound/SKILL.md`

## Relevant Disciplines

- Code review
- Multi-agent review
- Planning
- Worktree workflows
- Learning capture
- Solution documentation

## Strong Ideas

- Debugging gate based on an end-to-end causal chain, not a plausible fix.
- Predictions for uncertain causal links to distinguish root cause from symptom
  masking.
- Assumption audit before testing hypotheses.
- Diagnose-only outcomes and escalation to design work when the "bug" is really
  a product or architecture problem.

## Adoption Risks

The workflow assumes a heavier engineering-organization loop with many specialist agents. Adapt selectively to avoid ceremony and duplication with existing OpenClaw roles.

## Re-Review Trigger

Revisit during each discipline pass and at least every six months while this project remains active.
