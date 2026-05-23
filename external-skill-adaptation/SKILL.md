---
name: external-skill-adaptation
description: Compare external agent skills, prompts, instructions, or methodology repos against this ai-skills repository and adapt useful ideas into local skills with explicit attribution. Use when reviewing third-party agent methodology sources, revisiting previously reviewed sources after updates, creating discipline-by-discipline skill improvements, or maintaining provenance logs for borrowed, paraphrased, inspired, rejected, or superseded external ideas.
---

# External Skill Adaptation

Use this skill to turn external agent-methodology sources into durable, attributed improvements to this repository.

The goal is not to vendor external skills. The goal is to compare sources by discipline, decide what fits Ronald's workflow, adapt the useful parts into local conventions, and leave a provenance trail clear enough for credit, future re-review, and public explanation.

## Core Rules

1. Work on a dedicated branch.
2. Record source repo, URL, license, commit or release, source file path, and review date before adapting ideas.
3. Prefer paraphrased/adapted guidance over copied text unless copying is explicitly needed and license-compatible.
4. Track every material influence in `methodology/ADAPTATION_LOG.md`.
5. Keep rejected ideas. A future re-review needs to know why something did not land.
6. Do one discipline at a time unless Ronald explicitly asks for a broader pass.
7. Ask Ronald discipline-specific questions before finalizing adoption choices when the tradeoff is taste, workflow friction, or behavior policy rather than a clear technical correctness issue.
8. When a discipline produces or changes a local skill, add a concise source-influence artifact at `<skill>/PROVENANCE.md`.
9. Keep attribution and rebuild notes out of runtime `SKILL.md` files unless Ronald explicitly asks for them there.
10. Do not install or activate third-party skills, hooks, daemons, telemetry, or auto-update systems as part of this workflow.

## Workflow

### 1. Establish Scope

Identify:

- target discipline, such as debugging, implementation planning, testing, review, design, documentation, orchestration, or meta-behavior
- sources to compare
- local skills or instructions affected
- whether the output is research only, draft skill text, or a ready-to-merge skill change

If the user has not named a discipline, recommend one vertical slice. Prefer debugging first because it has clear observable failure modes and high reuse.

### 2. Inventory Sources

For each external source, record a source entry using `templates/source-inventory-entry.md`.

Required fields:

- source name
- repository or document URL
- license
- commit SHA, tag, or release
- reviewed files
- review date
- high-level applicability
- risks or adoption constraints

Store entries under `methodology/sources/`.

### 3. Compare by Discipline

Create or update `methodology/disciplines/<discipline>.md` using `templates/discipline-review.md`.

For each source, capture:

- useful practices
- exact source locations
- fit with current ai-skills and OpenClaw conventions
- conflicts or risks
- questions for Ronald
- adoption recommendation

Keep source quotes short. Summarize and link to exact files/commits wherever possible.

### 4. Decide With Ronald

Before changing existing local skills, ask targeted questions for decisions that depend on preference or operating style.

Good questions are concrete:

- "Should this become a hard gate or advisory guidance?"
- "Should this apply to Merlin/main, Vectrix, or only project-specific agents?"
- "Is the extra planning artifact worth the friction for this class of task?"

Avoid broad questions like "What do you think?"

### 5. Adapt Locally

When adopting an idea:

- fit it into the existing local skill that owns the discipline, or create a new focused skill if no owner exists
- preserve local tone and conventions
- remove assumptions that belong to the external tool, platform, or agent runtime
- include only the minimum procedural detail needed for reliable behavior
- keep activation triggers conservative enough that routine work does not become ceremonial
- keep runtime skill text operational; move rebuild notes and source-by-source attribution into the adjacent source-influence artifact, not into `SKILL.md`

### 6. Add Skill-Level Attribution

When a discipline produces or materially changes a local skill, create or update
`<skill>/PROVENANCE.md`. This path is mandatory.

If a local skill cannot have a sibling `PROVENANCE.md` because of repository
structure, do not improvise another location silently. Record the exception and
the chosen path in the discipline review before closing the task.

The skill-level provenance artifact must include:

- a short rebuild recipe for the adopted behavior
- one concise section per external source
- source URL, reviewed ref, reviewed file paths, and license when known
- what was taken from that source
- why those ideas fit locally
- how the idea was adapted to Ronald's conventions
- important rejected material when the rejection explains the final shape
- a pointer back to `methodology/ADAPTATION_LOG.md` and the relevant discipline review

Keep this artifact concise enough to read quickly, but complete enough to rebuild
the skill close to its current form without rereading every external source.

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

Before closing the task:

- run basic skill validation for new or changed skills when available
- inspect `git diff` for accidental copied text, missing attribution, or unrelated changes
- ensure every changed local skill has a matching log entry
- ensure every changed local skill has `<skill>/PROVENANCE.md`, or the discipline review records the structural exception and chosen path
- ensure runtime `SKILL.md` files do not contain provenance-only notes
- summarize branch, files changed, source commits reviewed, and open questions

## Output Shape

For a complete discipline pass, produce:

- source inventory updates in `methodology/sources/`
- one discipline review in `methodology/disciplines/`
- provenance entries in `methodology/ADAPTATION_LOG.md`
- a concise skill-level source-influence artifact at `<skill>/PROVENANCE.md` for every adopted local skill
- skill changes or draft skill files when adoption is approved
- a concise summary with recommended next discipline

## References

- `references/provenance-schema.md`
- `templates/discipline-review.md`
- `templates/source-inventory-entry.md`
