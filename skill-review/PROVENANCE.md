# Skill Review Skill Provenance

This document records the source material that shaped `skill-review/SKILL.md`.
It is intentionally outside the runtime skill because attribution and rebuild
notes should not consume model context when reviewing a skill.

## Rebuild Recipe

To reconstruct the skill, keep these behaviors:

1. Treat skills as model-facing runtime tools, not human-facing docs.
2. Review activation metadata before body prose because description quality
   controls whether the model sees the skill at all.
3. Treat context as scarce after activation; remove anything that does not
   change model behavior.
4. Enforce progressive disclosure: concise `SKILL.md`, directly linked
   supporting files, no nested reference chains when avoidable.
5. Match instruction specificity to workflow risk and model variability.
6. Use realistic should-trigger, should-not-trigger, and edge-case prompts.
7. Prefer official Claude/Agent Skills and Codex guidance over community taste.
8. Keep provenance outside runtime context unless explicitly requested there.
9. Do not treat local `[[skill-name]]` references as defects; this repository's
   skills are intended to work together.

## Source Influence

### Claude Agent Skills Documentation

- Source: <https://docs.claude.com/en/docs/claude-code/skills>
- Source: <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>
- Source: <https://claude.com/docs/skills/overview>
- Source: <https://claude.com/docs/skills/how-to>
- Reviewed ref: live web documentation retrieved 2026-05-23
- Reviewed material: skill creation, best practices, overview, and custom skill
  guidance
- License: Anthropic documentation terms; used as guidance, not copied

What we took:
- A skill is activated through metadata and then loads its body into context.
- Concision matters because loaded skill text competes with conversation and
  other active context.
- Descriptions must say what the skill does and when to use it.
- Good skills solve specific, repeatable workflows instead of trying to own
  everything.
- Main skill bodies should stay concise, with references and scripts loaded only
  when needed.
- Real usage and iteration beat imagined completeness.

Why:
- Claude is the origin point for the skill design pattern and has the highest
  practical trust rating for how models actually consume skills.

Local adaptation:
- The local review skill makes these into review criteria: activation,
  context value, progressive disclosure, workflow specificity, and realistic
  behavior checks.

### Agent Skills Open Standard

- Source: <https://agentskills.io/>
- Source: <https://agentskills.io/specification>
- Source: <https://agentskills.io/skill-creation/optimizing-descriptions>
- Source: <https://agentskills.io/skill-creation/evaluating-skills>
- Reviewed ref: live web documentation retrieved 2026-05-23
- Reviewed material: overview, specification, description optimization, and
  output-quality evaluation guidance
- License: public documentation; used as guidance, not copied

What we took:
- Skills load in stages: metadata, body, then resources.
- `name` and `description` are required and must be valid, specific, and useful.
- Description review should include should-trigger and should-not-trigger cases.
- Evaluation should use realistic user prompts and compare actual behavior, not
  just static formatting.

Why:
- It captures the cross-agent version of the same design assumptions and keeps
  the local review skill useful beyond one runtime.

Local adaptation:
- The skill review checklist requires both static structure review and behavior
  probes. It avoids numeric scoring because behavior evidence is usually more
  useful than a grade.

### Codex System Skill Creator

- Source: local Codex system skill
- Reviewed ref: `/Users/merlin/.openclaw/agents/main/agent/codex-home/skills/.system/skill-creator/SKILL.md`
- Reviewed material: complete `SKILL.md`
- License: local system-provided instructions; used as internal guidance

What we took:
- "Concise is key" and "Codex is already very smart" as the central context
  hygiene test.
- Match degrees of freedom to task fragility.
- Protect validation integrity by using raw artifacts and not leaking intended
  answers or suspected fixes to validation agents.
- Prefer scripts for deterministic repeated operations.
- Avoid extraneous README, quick-reference, changelog, or process files unless
  they directly support runtime behavior.

Why:
- This is the Codex team's own runtime guidance for making skills that Codex can
  discover and use reliably.

Local adaptation:
- Because this repository intentionally requires skill-level provenance, the
  review skill distinguishes required repository provenance from runtime skill
  context. Provenance is allowed as a sibling artifact, but runtime `SKILL.md`
  should not point at it by default.

### Community Skill Review Tools

- Source: <https://skillstore.io/skills/softaworks-skill-judge>
- Source: <https://playbooks.com/skills/softaworks/agent-toolkit/skill-judge>
- Source: <https://skillsmp.com/skills/smykla-skalski-sai-claude-review-skill-skills-review-skill-skill-md>
- Source: <https://github.com/agent-ecosystem/skill-validator>
- Reviewed ref: live web pages retrieved 2026-05-23
- Reviewed material: `skill-judge`, `review-skill`, and validator summaries
- License: mixed/marketplace sources; used only for comparison

What we took:
- Findings should be tiered by severity.
- Binary or categorical verdicts are easier to act on than vague commentary.
- Check file links, bundled resources, and safety issues, not just prose.
- Token waste and generic model-obvious content are common skill defects.

What we rejected:
- Heavy numeric scoring as the default output. It can look rigorous while hiding
  the more important question: whether the model actually behaves better.
- Large static checklists as runtime context. They risk turning skill review
  into checklist satisfaction instead of model-behavior improvement.

Local adaptation:
- The runtime skill uses Critical/Important/Polish and PASS/NEEDS WORK/FAIL,
  but keeps the checklist compact and behavior-first.

### Local Integration Decision

- Source: user review feedback in `#claw-enhance`
- Reviewed ref: 2026-05-23 conversation
- Reviewed material: instruction to ignore wiki-style references between local
  skills
- License: repository-local decision

What we took:
- Local `[[skill-name]]` references should not be flagged during skill review.

Why:
- These skills are not meant to work in isolation. Wiki-style references are a
  deliberate integration affordance inside this repository.

Local adaptation:
- Added an explicit exception in `skill-review/SKILL.md` so future review passes
  do not produce false positives for local skill references.

## Formal Trail

The fuller methodology record lives in:

- `methodology/disciplines/skill-review.md`
- `methodology/ADAPTATION_LOG.md`
- `methodology/sources/anthropic-agent-skills.md`
- `methodology/sources/codex-system-skill-creator.md`
- `methodology/sources/community-skill-review-tools.md`
