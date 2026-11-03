# Skill Review Provenance

This document records the source material that shaped `skill-review/SKILL.md`,
`skill-review/references/writing-levers.md` and
`skill-review/scripts/audit-skills.rb`. It is outside the runtime skill because
attribution and rebuild notes should not consume model context.

## Rebuild Recipe

1. Treat skills as model-facing runtime tools, not human-facing docs.
2. One skill for one skill and for a library: the same bar applies to both, and
   the library audit script finds which skills to review.
3. Review in this order: invocation choice, the description as an always-loaded
   pointer, no-ops (model-relative, settled by running), cache of environment
   facts, information hierarchy with the default-path test, leading words,
   instruction specificity, hygiene and safety, realistic behaviour prompts.
4. Name the two loads (context load, cognitive load) as the yardstick and spend
   each where it belongs.
5. Classify instructions when trimming: capability substitutes and choreography
   shrink as models improve; preferences, environment facts and gates stay.
6. Findings tiered Critical, Important, Polish; one verdict PASS, NEEDS WORK or
   FAIL; smallest patch when editing.
7. Keep provenance outside runtime context. Local `[[skill-name]]` references
   are intended integration points, not defects.
8. Keep the audit script read-only; treat "unused" or "duplicate" as evidence.
9. Keep the skill harness-agnostic: a user-invoked skill still carries a
   one-sentence trigger-bearing description because other harnesses ignore
   the flag.

## Source Influence

### Matt Pocock Skills (2026-11-03)

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `4ae2317ddb22b046e26455e4f9c9b3aaaf62212d` (v1.3.2)
- Reviewed files: `skills/productivity/writing-for-agents/SKILL.md`,
  `skills/productivity/writing-for-agents/SKILL-MECHANICS.md`, `SCOPE.md`,
  `.out-of-scope/*.md`, `CHANGELOG.md`
- License: MIT

What we took:

- The two loads (context load, cognitive load) as the single yardstick for every
  line and pointer.
- The model-relative no-op test, settled by running the document rather than by
  debate, and deleting the whole failing sentence.
- The cache rule: the environment is a source of truth, and a document that
  restates it goes stale.
- The information hierarchy (in-file step, in-file reference, disclosed
  reference), branching as the disclosure test, co-location, and sprawl as the
  failure mode.
- Leading words as a compression and anchoring lever, and positive phrasing
  over prohibition.
- The invocation choice: model-invoked when the agent or another skill must
  reach the skill, otherwise `disable-model-invocation: true`; router skills for
  many user-invoked skills.
- The closed-catalog stance: no new skill when the behaviour composes from
  existing ones.

How it was adapted:

- Paraphrased throughout. The runtime body turns the levers into review checks;
  the fuller lever text became `references/writing-levers.md`, reached only when
  writing rather than reviewing.
- Added a local rule that user-invoked skills keep a one-sentence trigger-bearing
  description, because the local skills run in several harnesses and some ignore
  the flag.
- Added the five-kind classification (capability substitute, choreography,
  preference, environment fact, gate) from the local November 2026 re-review so
  trimming has a rule for what shrinks and what stays.
- Added harness-specific tool names to the safety checks, following the
  2026-11-03 decision that skills stay harness-agnostic.

Rejected material:

- Upstream's practice of stripping trigger language from user-invoked
  descriptions entirely. Correct for a single harness; unsafe here.
- Upstream's `GLOSSARY.md` and `CODING_STANDARDS.md` file conventions. Local
  repositories do not carry them.

### Peter Steinberger Agent Scripts (2026-05-27, via the former `skill-maintenance`)

- Source: <https://github.com/steipete/agent-scripts>
- Reviewed ref: `737040cf3a196b1a11aeb1c1c7508ce721545745`
- Reviewed files: `skills/skill-cleaner/SKILL.md`,
  `skills/skill-cleaner/scripts/skill-cleaner.ts`
- License: MIT

What we took:

- Skill inventory should be tool-backed, not intuition.
- Audit duplicate names, duplicate bodies, long descriptions, visible prompt
  cost, and superseded skills; flag body bloat and near-copy bodies before
  cleanup.
- Suggest before editing; apply small grouped rewrites only when asked.

How it was adapted:

- A repository-local Ruby script (`scripts/audit-skills.rb`) so the audit runs
  without installing or executing external code. It adds body thresholds,
  fuzzy body-overlap scoring, large-section and repeated-heading output, and
  treats character cost as the stronger bloat signal.
- Cleanup stays model-driven because trimming must preserve behavioural intent
  and scannable operational lists.
- "Unused" and "duplicate" are leads for a person, not deletion instructions.

Rejected material:

- Running the external TypeScript analyzer directly.
- Automatic delete or disable without naming the kept replacement.
- Treating "unused in recent logs" as enough evidence to remove a skill.

### Claude Agent Skills Documentation (2026-05-23)

- Source: <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>
  and the related overview and how-to pages
- License: Anthropic documentation terms; used as guidance, not copied

What we took: a skill is activated through metadata and then loads its body;
loaded text competes with the conversation; descriptions say what the skill does
and when to use it; good skills solve specific repeatable workflows; bodies stay
concise with references loaded only when needed; real usage beats imagined
completeness.

### Agent Skills Open Standard (2026-05-23)

- Source: <https://agentskills.io/specification> and the description and
  evaluation guidance pages
- License: public documentation; used as guidance, not copied

What we took: skills load in stages (metadata, body, resources); `name` and
`description` are required and must be specific; description review includes
should-trigger and should-not-trigger cases; evaluation uses realistic prompts
and compares behaviour, not formatting.

### Codex System Skill Creator (2026-05-23)

- Source: local Codex system skill (`skill-creator/SKILL.md`)
- License: local system-provided instructions; used as internal guidance

What we took: "concise is key" and "the model is already very smart" as the
central hygiene test; match degrees of freedom to task fragility; keep intended
answers out of validation prompts; prefer scripts for deterministic repeated
operations; no extraneous README, changelog or process files.

### Community Skill Review Tools (2026-05-23)

- Sources: `skill-judge`, `review-skill`, `skill-validator` summaries
  (marketplace and GitHub pages)
- License: mixed; used only for comparison

What we took: findings tiered by severity; categorical verdicts; check links,
bundled resources and safety, not just prose.

What we rejected: heavy numeric scoring as the default output, and large static
checklists as runtime context.

### Local Integration Decisions

- 2026-05-23: local `[[skill-name]]` references are not defects (user review
  feedback in `#claw-enhance`).
- 2026-11-03: `skill-maintenance` merged into this skill; the audit script moved
  to `skill-review/scripts/`. Its Codex interface file `agents/openai.yaml` was
  dropped because no other local skill carries one.
- 2026-11-03: skills stay harness-agnostic (no harness-specific tool names).

## Formal Trail

- `methodology/ADAPTATION_LOG.md`
- `methodology/disciplines/skill-review.md`
- `methodology/disciplines/skill-maintenance.md`
- `methodology/disciplines/skill-meta-2026-11.md`
- `methodology/disciplines/matt-pocock-rereview-2026-11.md`
- `methodology/sources/matt-pocock-skills.md`
- `methodology/sources/steipete-agent-scripts.md`
- `methodology/sources/anthropic-agent-skills.md`
- `methodology/sources/codex-system-skill-creator.md`
- `methodology/sources/community-skill-review-tools.md`
