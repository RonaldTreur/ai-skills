---
name: skill-review
description: Reviews AI agent skills and SKILL.md files for trigger accuracy, context cost, progressive disclosure, safety, and behavior. Use before publishing, merging, adapting, or rewriting a skill.
---

# Skill Review

Review skills as runtime tools for models, not as human documentation.

Official model-vendor skill guidance wins over local style when they conflict. Community reviewer skills are useful comparison material, but they are not the authority.

## Review Order

1. Identify the intended task, user prompts, target agent/runtime, and whether the skill should trigger automatically or only when invoked directly.
2. Check `name` and `description` first. The description must say what the skill does and when to use it, with enough specific trigger language to select the skill from a large library without being over-broad.
3. Check context value. Remove material the model already knows, setup history, provenance, attribution, changelog notes, repeated rules, and explanations that do not change behavior.
4. Check progressive disclosure. Keep `SKILL.md` focused on the core workflow, but never move default-path instructions out just to reduce line count. The hot file must contain every rule needed for a normal run after activation. If the model would usually need to open a supporting file immediately after activation, the material belongs inline or compressed, not extracted. Move only optional depth, long examples, templates, rare edge cases, provenance, or expanded reference material into directly linked supporting files, with explicit "load this when..." gates.
5. Check instruction freedom. Use broad guidance for judgment-heavy work, explicit checklists for fragile workflows, and scripts for deterministic or repeatedly reimplemented operations.
6. Check file hygiene. Keep only files that directly support the skill at runtime or required repository provenance. Runtime `SKILL.md` files should not link to provenance-only artifacts unless the user explicitly asks. Do not flag local `[[skill-name]]` references between skills in this repository; they are intended integration points.
7. Check safety and scope. Flag secrets, unsafe defaults, hidden external actions, broad tool grants, production-impacting steps, and skills that try to own unrelated workflows.
8. Check behavior with realistic prompts. Use at least one should-trigger case, one should-not-trigger case, and one edge case. Prefer fresh model/session runs when available. Do not leak the expected answer or your diagnosis into validation prompts.

## Findings

Lead with issues, not praise.

Use these severities:

- Critical: likely prevents safe or correct use.
- Important: likely causes wrong activation, context waste, unreliable behavior, or recurring reviewer confusion.
- Polish: improves clarity, naming, examples, or maintainability.

Each finding should include:

- file and line, when available
- the model-facing risk
- the smallest useful fix

## Verdict

End with one verdict:

- PASS: safe to ship; only optional polish remains.
- NEEDS WORK: useful direction, but important issues should be fixed first.
- FAIL: unsafe, misleading, non-functional, or not really a skill yet.

When asked to edit, make the smallest patch that improves model behavior. Do not expand the skill just to satisfy a checklist.
