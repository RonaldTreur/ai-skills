# Source Inventory: Community Skill Review Tools

- Source URL: https://skillstore.io/skills/softaworks-skill-judge
- Source URL: https://playbooks.com/skills/softaworks/agent-toolkit/skill-judge
- Source URL: https://skillsmp.com/skills/smykla-skalski-sai-claude-review-skill-skills-review-skill-skill-md
- Source URL: https://github.com/agent-ecosystem/skill-validator
- License: mixed/marketplace sources; used only for comparison
- Commit/tag/release reviewed: live web pages retrieved 2026-05-23
- Retrieved: 2026-05-23 via web search/open
- Reviewer: Merlin
- Local clone/path, if any: none

## Scope Reviewed

- `skill-judge` marketplace and mirrored skill summaries
- `review-skill` marketplace summary
- `skill-validator` repository summary

## Relevant Disciplines

- Skill review
- Skill validation
- Skill publishing checks

## Strong Ideas

- Skill review benefits from severity tiers and an explicit verdict.
- Reviewers should inspect bundled resources, links, safety issues, and token
  waste, not just the `SKILL.md` prose.
- Binary or categorical checks are more actionable than vague commentary.
- Static validation can catch naming, frontmatter, file-link, and packaging
  defects early.

## Adoption Risks

- Numeric scoring can create false precision and reward checklist compliance
  over model behavior.
- Large reviewer skills can themselves become context-heavy.
- Marketplace summaries are weaker evidence than official Claude/Agent Skills
  and Codex guidance.

## Re-Review Trigger

Revisit only when building a stricter automated validator or comparing the
local review skill against mature public skill-review frameworks.
