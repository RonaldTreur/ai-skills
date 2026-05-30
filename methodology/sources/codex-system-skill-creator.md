# Source Inventory: Codex System Skill Creator

- Source URL: local Codex system skill
- License: local system-provided instructions; used as internal guidance
- Commit/tag/release reviewed: current local file on 2026-05-23
- Retrieved: 2026-05-23 via local filesystem
- Reviewer: Merlin
- Local clone/path, if any: `/Users/merlin/.openclaw/agents/main/agent/codex-home/skills/.system/skill-creator/SKILL.md`

## Scope Reviewed

- Complete `skill-creator/SKILL.md`

## Relevant Disciplines

- Skill creation
- Skill review
- Skill validation
- Runtime context hygiene

## Strong Ideas

- Treat context as a public good; include only non-obvious guidance the model
  needs.
- The frontmatter description is the primary trigger and should carry the "when
  to use" information.
- Match degrees of freedom to task fragility.
- Prefer scripts for deterministic repeated operations.
- Keep `SKILL.md` lean and use progressive disclosure for longer material.
- Protect validation integrity by testing in fresh contexts and not leaking the
  intended answer or suspected flaw.
- Avoid extraneous files unless they directly support the skill's runtime use.

## Adoption Risks

- Codex-specific interface metadata and validation scripts are not necessarily
  available in every runtime. Adapt the principles, not every field or tool.
- This repo intentionally keeps `PROVENANCE.md` artifacts for adapted skills.
  That is a repository-level provenance requirement, not runtime skill context.

## Re-Review Trigger

Revisit whenever the local Codex system `skill-creator` changes or before
substantial revisions to the local `skill-review` skill.
