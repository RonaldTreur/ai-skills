# External Skill Adaptation Skill Provenance

This document records the source material and local decisions that shaped
`external-skill-adaptation/SKILL.md`. It is intentionally outside runtime skill
context.

## Rebuild Recipe

To reconstruct the skill, keep these behaviors:

1. Review external methodology sources by discipline, not wholesale.
2. Record source URL, license, reviewed ref, reviewed files, and review date.
3. Adapt useful ideas into local skills with explicit provenance.
4. Keep rejected and deferred ideas in the adaptation log.
5. Put skill-level attribution in `<skill>/PROVENANCE.md`, not runtime
   `SKILL.md`.
6. End every created or changed runtime skill with a `[[skill-review]]` pass.
7. Ignore local `[[skill-name]]` references during skill review because this
   repository's skills are designed to work together.
8. In discipline reviews, record implemented changes under `Adopted Changes`.
   Use rejections/deferrals for ideas that are not implemented yet.

## Source Influence

### Local ai-skills Adaptation Workflow

- Source: this repository's methodology adaptation process
- Reviewed ref: `feat/external-skill-adaptation` as of 2026-05-23
- Reviewed material: `methodology/`, source inventories, discipline reviews,
  adaptation log, and local skill changes
- License: repository-local process

What we took:
- Discipline-by-discipline adaptation.
- Mandatory source inventories and adaptation-log entries.
- Sibling `<skill>/PROVENANCE.md` artifacts for created or changed skills.
- Keeping provenance out of runtime skill bodies.

Why:
- The repo needs a durable public trail for borrowed, adapted, rejected, and
  superseded methodology ideas without polluting runtime context.

### Skill Review Discipline

- Source: `skill-review/SKILL.md`
- Reviewed ref: merged on `feat/external-skill-adaptation` 2026-05-23
- Reviewed material: `skill-review/SKILL.md`,
  `skill-review/PROVENANCE.md`, and
  `methodology/disciplines/skill-review.md`
- License: repository-local process

What we took:
- End skill creation/adaptation with a review of trigger accuracy, context cost,
  progressive disclosure, safety, and behavior.
- Treat local wiki-style skill links as valid integration points, not defects.

Why:
- The user explicitly prioritized what works for models over local style and asked
  for skill review to become part of this workflow.

### Implementation Lifecycle Discipline

- Source: local implementation-lifecycle consolidation
- Reviewed ref: `feat/implementation-lifecycle-methodology` on 2026-05-23
- Reviewed material: `methodology/disciplines/implementation-lifecycle.md`,
  `project-manager/SKILL.md`, `implement-issue/SKILL.md`, and
  `external-skill-adaptation/templates/discipline-review.md`
- License: repository-local process

What we took:
- The discipline review template now uses `Adopted Changes` for changes that
  have actually landed.
- Future recommendations belong under rejections/deferrals as `deferred`.

Why:
- The user noticed that `Recommended Adaptations` was ambiguous after an
  adaptation had already been implemented. The new wording makes the audit trail
  clearer.

## Formal Trail

The fuller methodology record lives in:

- `methodology/disciplines/skill-review.md`
- `methodology/disciplines/implementation-lifecycle.md`
- `methodology/ADAPTATION_LOG.md`
- `skill-review/PROVENANCE.md`
