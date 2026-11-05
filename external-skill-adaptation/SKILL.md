---
name: external-skill-adaptation
description: Compare external agent skills, prompts, instructions, or methodology repos against this ai-skills repository, adapt useful local improvements, and maintain attribution/provenance.
disable-model-invocation: true
---

# External Skill Adaptation

The goal is not to vendor external skills. The goal is to compare sources by discipline, decide what fits the user's workflow, adapt the useful parts into local conventions, and leave a provenance trail clear enough for credit, future re-review, and public explanation.

## Core Rules

1. Work on a dedicated branch.
2. Prefer paraphrased/adapted guidance over copied text unless copying is explicitly needed and license-compatible.
3. Keep rejected ideas. A future re-review needs to know why something did not land.
4. Do one discipline at a time unless the user explicitly asks for a broader pass.
5. Do not install or activate third-party skills, hooks, daemons, telemetry, or auto-update systems as part of this workflow.

## Workflow

### 1. Establish Scope

Identify the target discipline, sources to compare, local skills or instructions affected, and whether the output is research only, draft skill text, or a ready-to-merge skill change.

If the user has not named a discipline, recommend the one with no review yet in `methodology/disciplines/`.

### 2. Inventory Sources

For each external source, record a source entry using `templates/source-inventory-entry.md`: source name, URL, license, reviewed ref, reviewed files, review date, applicability, and risks or adoption constraints.

Store entries under `methodology/sources/`.

### 3. Compare by Discipline

Create or update `methodology/disciplines/<discipline>.md` using `templates/discipline-review.md`.

For each source, capture useful practices, exact source locations, fit with current ai-skills conventions, conflicts or risks, questions for the user, and adoption recommendation.

Keep source quotes short. Summarize and link to exact files/commits wherever possible.

### 4. Decide With The User

Before changing existing local skills, ask targeted questions for decisions that depend on preference or operating style.

Good questions are concrete:

- "Should this become a hard gate or advisory guidance?"
- "Should this apply to every project, or only to the ones that opt in?"
- "Is the extra planning artifact worth the friction for this class of task?"

Avoid broad questions like "What do you think?"

### 5. Adapt Locally

When adopting an idea, fit it into the existing owner skill or create a focused skill only if no owner exists. Preserve local tone, remove external runtime assumptions, include the minimum procedural detail needed for reliable behavior, keep triggers conservative, and keep runtime `SKILL.md` text operational. Move rebuild notes and source-by-source attribution into the adjacent source-influence artifact.

### 6. Add Skill-Level Attribution

When a discipline produces or materially changes a local skill, create or update `<skill>/PROVENANCE.md`. This path is mandatory.

If a local skill cannot have a sibling `PROVENANCE.md` because of repository structure, do not improvise another location silently. Record the exception and the chosen path in the discipline review before closing the task.

The skill-level provenance artifact must include a short rebuild recipe, one concise section per source, source URL/ref/files/license when known, what was taken, why it fit, how it was adapted, important rejected material, and pointers back to `methodology/ADAPTATION_LOG.md` and the discipline review.

Keep this artifact concise enough to read quickly, but complete enough to rebuild the skill close to its current form without rereading every external source.

### 7. Update Provenance

Every adoption, rejection, or deferred decision gets an entry in `methodology/ADAPTATION_LOG.md`.

Use the schema in `references/provenance-schema.md`.

Categories:

- `adopted`: landed in local skill text or supporting docs
- `adapted`: concept changed materially before landing
- `inspired`: influenced structure or behavior without traceable text
- `rejected`: reviewed and intentionally not used
- `deferred`: useful but not ready, blocked, or needs more evidence
- `superseded`: old local guidance replaced by a better source or internal lesson

### 8. Verify

Before closing:

- run [[skill-review]] against every created or changed runtime `SKILL.md`;
- inspect `git diff` for copied text, missing attribution, or unrelated changes;
- confirm every changed skill has a matching log entry and `<skill>/PROVENANCE.md` or a documented exception, and no provenance notes in runtime `SKILL.md`;
- summarize branch, files changed, reviewed refs, and open questions.

## Output Shape

For a complete discipline pass, produce:

- source inventory updates in `methodology/sources/`
- one discipline review in `methodology/disciplines/`
- provenance entries in `methodology/ADAPTATION_LOG.md`
- a concise skill-level source-influence artifact at `<skill>/PROVENANCE.md` for every adopted local skill
- skill changes or draft skill files when adoption is approved
- a concise summary with recommended next discipline
