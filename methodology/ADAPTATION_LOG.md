# Adaptation Log

This log records how external agent-methodology sources influence this repository.

Use one entry for each material adoption, adaptation, inspiration, rejection, deferral, or supersession.

## Entry Template

```yaml
id:
date:
discipline:
status:
source:
source_url:
source_ref:
source_path:
license:
local_target:
influence_type:
summary:
local_adaptation:
rationale:
credit_note:
reviewer:
next_review:
```

## Entries

```yaml
id: 2026-05-22-debugging-matt-feedback-loop
date: 2026-05-22
discipline: debugging
status: adopted
source: Matt Pocock Skills
source_url: https://github.com/mattpocock/skills
source_ref: b8be62ffacb0118fa3eaa29a0923c87c8c11985c
source_path: skills/engineering/diagnose/SKILL.md
license: MIT
local_target: debugging/SKILL.md
influence_type: structural
summary: Build a fast deterministic feedback loop before hypothesizing or fixing.
local_adaptation: Adopted as the local debugging spine: build a fast deterministic repro loop before fixing, then verify with the original repro and a regression guardrail.
rationale: This is the clearest reusable default for non-trivial debugging and fits the approved policy without importing source-specific workflow baggage.
credit_note: Inspired by Matt Pocock's diagnose loop, adapted for ai-skills.
reviewer: Vectrix
next_review: When the repo decides whether adjacent testing skills should inherit the same completion gates
```

```yaml
id: 2026-05-22-debugging-superpowers-root-cause-gate
date: 2026-05-22
discipline: debugging
status: adapted
source: SuperPowers
source_url: https://github.com/obra/superpowers
source_ref: f2cbfbefebbfef77321e4c9abc9e949826bea9d7
source_path: skills/systematic-debugging/SKILL.md
license: MIT
local_target: debugging/SKILL.md
influence_type: behavioral
summary: No fixes without root-cause investigation first; reject multi-fix thrash and skipped repros.
local_adaptation: Adapted into a root-cause-first rule with a trivial-bug fast path, conditional hypothesis surfacing, and a stop-and-ask default after 3 failed fix attempts.
rationale: The source guardrails are valuable, but they needed lighter activation and clearer exceptions to fit normal ai-skills debugging work.
credit_note: Adapted from SuperPowers systematic-debugging guardrails.
reviewer: Vectrix
next_review: When adjacent test-healing skills are aligned with the same stop conditions
```

```yaml
id: 2026-05-22-debugging-superpowers-defense-in-depth
date: 2026-05-22
discipline: debugging
status: adapted
source: SuperPowers
source_url: https://github.com/obra/superpowers
source_ref: f2cbfbefebbfef77321e4c9abc9e949826bea9d7
source_path: skills/systematic-debugging/defense-in-depth.md
license: MIT
local_target: debugging/SKILL.md
influence_type: structural
summary: After finding a real root-cause pattern, consider entry, business, environment, and debug-layer defenses.
local_adaptation: Adapted into conditional defense-in-depth guidance for recurring or high-impact bug classes, auth/security/data-loss/reliability risks, and likely nearby repeats.
rationale: The prevention pattern is useful, but only when the bug class justifies the extra work.
credit_note: Influenced by SuperPowers defense-in-depth validation guidance.
reviewer: Vectrix
next_review: When the repo adds more explicit guidance on choosing regression seams
```

```yaml
id: 2026-05-22-debugging-compound-causal-chain
date: 2026-05-22
discipline: debugging
status: adapted
source: Compound Engineering
source_url: https://github.com/everyinc/compound-engineering-plugin
source_ref: 5297a9440fa009822ceef8052b9e644e782281e1
source_path: docs/skills/ce-debug.md
license: MIT
local_target: debugging/SKILL.md
influence_type: structural
summary: Require a causal-chain explanation, predictions for uncertain links, and an assumption audit before a non-trivial fix.
local_adaptation: Adapted into lightweight rules for targeted hypotheses, deliberate probes, correct-seam fixes, and explicit stop-and-ask behavior after repeated failed attempts.
rationale: The causal-chain discipline helps on hard bugs, but the local version keeps it optional for trivial fixes and avoids the source's heavier workflow machinery.
credit_note: Inspired by Compound Engineering's ce-debug investigation model.
reviewer: Vectrix
next_review: When the repo decides whether to require more explicit causal-chain writeups for production incidents
```

```yaml
id: 2026-05-22-debugging-gstack-debug-workflow-overhead
date: 2026-05-22
discipline: debugging
status: rejected
source: GStack
source_url: https://github.com/garrytan/gstack
source_ref: 61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c
source_path: investigate/SKILL.md; qa/SKILL.md
license: MIT
local_target: generic debugging discipline
influence_type: comparison-only
summary: Clean-tree requirements, per-fix commit loops, telemetry/learnings hooks, and browser-QA artifact rules were reviewed for possible generic debugging adoption.
local_adaptation: None; only the investigation-first and evidence habits remain candidates.
rationale: These behaviors are too tied to GStack's own runtime, storage, and QA workflow to make sense as default ai-skills debugging rules.
credit_note: Reviewed GStack for debugging ideas; rejected its heavier workflow overhead for ai-skills.
reviewer: Vectrix
next_review: Revisit only if Ronald wants a browser-first QA/debugging discipline
```

```yaml
id: 2026-05-23-skill-review-claude-official-guidance
date: 2026-05-23
discipline: skill-review
status: adopted
source: Claude Agent Skills Documentation and Agent Skills Open Standard
source_url: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
source_ref: live documentation retrieved 2026-05-23
source_path: Claude Code skills docs; Claude skill authoring best practices; Claude.ai skills docs; agentskills.io overview/spec/evaluation docs
license: public documentation; guidance only
local_target: skill-review/SKILL.md
influence_type: structural
summary: Review skills according to model-facing activation, concise runtime context, progressive disclosure, focused workflows, and realistic behavior testing.
local_adaptation: Adopted as the top-level review order for activation, context value, progressive disclosure, instruction freedom, safety, and realistic prompt probes.
rationale: Claude and the Agent Skills standard are the highest-trust sources for how skill metadata and runtime bodies are consumed by models.
credit_note: Based on official Claude/Agent Skills authoring and evaluation guidance.
reviewer: Merlin
next_review: When official Claude or Agent Skills guidance changes materially
```

```yaml
id: 2026-05-23-skill-review-codex-skill-creator
date: 2026-05-23
discipline: skill-review
status: adopted
source: Codex system skill-creator
source_url: local Codex system skill
source_ref: local file reviewed 2026-05-23
source_path: /Users/merlin/.openclaw/agents/main/agent/codex-home/skills/.system/skill-creator/SKILL.md
license: local system-provided instructions; guidance only
local_target: skill-review/SKILL.md
influence_type: behavioral
summary: Treat context as scarce, assume Codex is already capable, match instruction specificity to task fragility, and protect validation integrity.
local_adaptation: Adopted as context-value review, instruction-freedom review, validation prompt hygiene, and the rule against expanding skills just to satisfy checklists.
rationale: This is Codex's own guidance for creating skills Codex can discover and use reliably.
credit_note: Adapted from the local Codex system skill-creator guidance.
reviewer: Merlin
next_review: When the Codex system skill-creator changes materially
```

```yaml
id: 2026-05-23-skill-review-provenance-placement
date: 2026-05-23
discipline: skill-review
status: adapted
source: Codex system skill-creator plus local external-skill-adaptation policy
source_url: local Codex system skill and local repository policy
source_ref: local files reviewed 2026-05-23
source_path: skill-creator/SKILL.md; external-skill-adaptation/SKILL.md
license: mixed local guidance
local_target: skill-review/SKILL.md; skill-review/PROVENANCE.md
influence_type: structural
summary: Avoid extraneous runtime files while preserving required adaptation provenance outside SKILL.md.
local_adaptation: Created skill-level `PROVENANCE.md`, but kept all attribution and rebuild notes out of the runtime skill text.
rationale: Provenance is necessary for this repository's adaptation workflow, but it does not help the model perform skill review during activation.
credit_note: Local adaptation of Codex file-hygiene guidance to ai-skills provenance requirements.
reviewer: Merlin
next_review: When repository provenance policy changes
```

```yaml
id: 2026-05-23-skill-review-community-verdict-shape
date: 2026-05-23
discipline: skill-review
status: adapted
source: Community skill review tools
source_url: https://skillstore.io/skills/softaworks-skill-judge
source_ref: live web pages retrieved 2026-05-23
source_path: skill-judge summaries; review-skill summary; skill-validator repository summary
license: mixed/marketplace sources; comparison only
local_target: skill-review/SKILL.md
influence_type: output-shape
summary: Use severity tiers and a categorical verdict to make skill review findings actionable.
local_adaptation: Adopted Critical/Important/Polish severities and PASS/NEEDS WORK/FAIL verdicts while rejecting default numeric scoring.
rationale: Severity and verdicts help actionability; numeric scoring risks false precision and checklist gaming.
credit_note: Inspired by community skill-review tools, subordinated to official Claude/Codex guidance.
reviewer: Merlin
next_review: If the repo adds an automated skill validator or eval harness
```
