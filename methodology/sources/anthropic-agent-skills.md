# Source Inventory: Anthropic and Agent Skills Documentation

- Source URL: https://docs.claude.com/en/docs/claude-code/skills
- Source URL: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
- Source URL: https://claude.com/docs/skills/overview
- Source URL: https://claude.com/docs/skills/how-to
- Source URL: https://agentskills.io/
- Source URL: https://agentskills.io/specification
- Source URL: https://agentskills.io/skill-creation/optimizing-descriptions
- Source URL: https://agentskills.io/skill-creation/evaluating-skills
- License: public documentation; used as design guidance, not copied text
- Commit/tag/release reviewed: live web documentation retrieved 2026-05-23
- Retrieved: 2026-05-23 via web search/open
- Reviewer: Merlin
- Local clone/path, if any: none

## Scope Reviewed

- Claude Code skills documentation
- Claude skill authoring best practices
- Claude.ai skills overview and custom skill guide
- Agent Skills overview, specification, description optimization, and
  evaluation guidance

## Relevant Disciplines

- Skill review
- Skill creation
- Skill adaptation
- Description/trigger optimization
- Skill evaluation

## Strong Ideas

- Skills use progressive disclosure: metadata first, then `SKILL.md`, then
  resources as needed.
- The description is the activation surface and must include what the skill does
  and when to use it.
- Concise skill bodies matter because loaded skill text competes with other
  context.
- Keep detailed reference material outside `SKILL.md` and link it directly.
- Test skill descriptions and behavior with realistic prompts, including
  should-trigger and should-not-trigger cases.
- Skills should solve specific repeatable workflows rather than broad domains.

## Adoption Risks

- Claude Code supports fields and invocation modes that may not exist in every
  compatible runtime. Keep local guidance cross-agent unless a skill is
  intentionally runtime-specific.
- Claude.ai imposes a shorter description limit than the open specification.
  Local skills should prefer concise descriptions even when the local runtime
  allows more.

## Re-Review Trigger

Revisit before revising `skill-review`, `external-skill-adaptation`, or any
repo-wide skill authoring rules, and at least every six months while this
repository remains active.
