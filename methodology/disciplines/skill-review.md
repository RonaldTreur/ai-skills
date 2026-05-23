# Discipline Review: skill-review

- Date: 2026-05-23
- Reviewer: Merlin
- Branch: `feat/skill-review-methodology`
- Local files reviewed: `README.md`, `external-skill-adaptation/SKILL.md`,
  `debugging/SKILL.md`, `debugging/PROVENANCE.md`, Codex system
  `skill-creator/SKILL.md`
- External sources reviewed:
  - Claude Code skills documentation, live 2026-05-23
  - Claude skill authoring best practices, live 2026-05-23
  - Claude.ai skills overview and custom skill guide, live 2026-05-23
  - Agent Skills overview/specification/description/evaluation docs, live
    2026-05-23
  - Community `skill-judge`, `review-skill`, and `skill-validator` summaries,
    live 2026-05-23
- Status: adopted

## Local Baseline

The repository had skill-authoring guidance in `README.md` and the
`external-skill-adaptation` workflow, but no dedicated way to review a skill as
a model-facing runtime artifact.

Recent debugging work exposed the gap:

- A provenance pointer was added to runtime `debugging/SKILL.md` even though it
  did not help the model debug anything.
- The rewritten debugging skill needed review for verbosity, repetition,
  trigger accuracy, and source fidelity.
- Ronald explicitly prioritized what works for models over local house style.

The local baseline now needs a skill-review owner that can judge:

- whether a skill will activate at the right time
- whether loaded context is worth its token cost
- whether progressive disclosure is being used correctly
- whether the skill guides the model without over-constraining it
- whether provenance and process material stays out of runtime context
- whether behavior is tested with realistic prompts

## Source Comparison

### Claude Agent Skills Documentation

- Source ref: live web documentation retrieved 2026-05-23
- Files reviewed: Claude Code skills, Claude skill authoring best practices,
  Claude.ai skills overview, Claude.ai custom skill guide
- Useful patterns:
  - Skills are discovered through metadata and loaded only when relevant.
  - Descriptions are critical: they must state what the skill does and when to
    use it.
  - Concision matters after activation because every loaded token competes with
    the conversation and other context.
  - Skills should be focused on specific repeatable workflows.
  - Use real usage and iteration to improve skills.
- Conflicts or risks:
  - Claude-specific frontmatter fields and invocation controls should not be
    copied into cross-agent local skills unless needed.
- Adoption recommendation:
  - Treat as primary authority for runtime shape and review criteria.

### Agent Skills Open Standard

- Source ref: live web documentation retrieved 2026-05-23
- Files reviewed: overview, specification, description optimization, output
  evaluation
- Useful patterns:
  - Progressive disclosure is explicit: metadata, body, then resources.
  - `name` and `description` have concrete validity and usefulness criteria.
  - Description quality should be tested with should-trigger and
    should-not-trigger prompts.
  - Output quality should be evaluated with realistic prompts and actual
    behavioral evidence.
- Conflicts or risks:
  - The open spec permits optional fields that not every runtime handles.
  - Formal eval harnesses can be too heavy for small skill edits.
- Adoption recommendation:
  - Use as cross-agent grounding, especially for trigger and behavior review.

### Codex System Skill Creator

- Source ref: local file reviewed 2026-05-23
- Files reviewed:
  `/Users/merlin/.openclaw/agents/main/agent/codex-home/skills/.system/skill-creator/SKILL.md`
- Useful patterns:
  - "Codex is already very smart": remove model-obvious context.
  - Match degrees of freedom to workflow fragility.
  - Use scripts for deterministic repeated operations.
  - Keep `SKILL.md` lean and directly link references when needed.
  - Protect validation integrity with raw artifacts and fresh contexts.
  - Avoid extraneous files that do not directly support runtime skill behavior.
- Conflicts or risks:
  - Codex-specific support files and validation scripts are not universal.
  - Its "no extraneous docs" rule needs a local exception for required
    `PROVENANCE.md` artifacts.
- Adoption recommendation:
  - Treat as primary authority alongside Claude guidance, especially for Codex
    runtime context and validation integrity.

### Community Skill Review Tools

- Source ref: live web pages retrieved 2026-05-23
- Files reviewed: `skill-judge`, `review-skill`, `skill-validator` summaries
- Useful patterns:
  - Severity tiers and final verdicts make review output actionable.
  - Static validation should include links, bundled files, safety, and packaging
    defects.
  - Token waste is a real skill-quality issue.
- Conflicts or risks:
  - Numeric scoring can produce false precision.
  - Large checklist skills may optimize for passing the checklist rather than
    improving model behavior.
- Adoption recommendation:
  - Use as secondary comparison material only.

## Approved Policy

The skill-review discipline is now adopted with these rules:

1. Official Claude/Agent Skills and Codex `skill-creator` guidance outrank local
   style preferences when reviewing skill shape.
2. Review activation metadata first because the body is useless if the model
   never loads it or loads it too often.
3. Treat runtime context as scarce. Remove provenance, process history, repeated
   rules, and model-obvious explanations from `SKILL.md`.
4. Prefer focused skills over broad domain dumps.
5. Use progressive disclosure with direct links from `SKILL.md`; avoid nested
   reference chains.
6. Match instruction specificity to task risk and model variability.
7. Validate with realistic prompts, including should-trigger and
   should-not-trigger cases. Use fresh contexts when practical.
8. Use severity tiers and a final verdict, but avoid numeric scoring by default.
9. Ignore local `[[skill-name]]` references between repository skills. They are
   intended integration points, not portability defects.

## Recommended Adaptations

1. Add a dedicated `skill-review/` skill that reviews skill packages and
   `SKILL.md` files for activation, context cost, progressive disclosure,
   safety, instruction fit, and behavior.
   Provenance entry ids:
   `2026-05-23-skill-review-claude-official-guidance`
   `2026-05-23-skill-review-codex-skill-creator`
2. Add skill-level provenance at `skill-review/PROVENANCE.md`, keeping all
   attribution and rebuild notes outside runtime skill text.
   Provenance entry id:
   `2026-05-23-skill-review-provenance-placement`
3. Use community skill-review sources only for output-shape inspiration:
   Critical/Important/Polish and PASS/NEEDS WORK/FAIL.
   Provenance entry id:
   `2026-05-23-skill-review-community-verdict-shape`
4. Treat Ronald's local integration decision as a standing review exception:
   do not flag wiki-style links to other local skills.
   Provenance entry id:
   `2026-05-23-skill-review-local-wiki-links`

## Rejections And Deferrals

- Rejected numeric scoring as the default review output. It is attractive, but
  behavior evidence matters more than a percentage.
- Rejected a long static checklist in runtime context. The local skill keeps a
  compact review order and trusts the model to apply judgment.
- Deferred automated eval harnesses. They may be valuable later, but the first
  version should work as a human/model review discipline without new tooling.

## Skill-Level Attribution

Created `skill-review/PROVENANCE.md`.

No exception is needed: the skill has a sibling provenance artifact at the
required path. Runtime `skill-review/SKILL.md` intentionally does not link to
it.

## Verification Notes

- Compared official Claude/Agent Skills guidance, the local Codex system
  `skill-creator`, and community skill-review candidates.
- Checked that the runtime skill does not contain source attribution or rebuild
  notes.
- Verified the intended output shape uses issue severity and an actionable
  verdict instead of numeric scoring.
