---
name: skill-review
description: Review or trim one skill, a skill library or an agent instruction file for trigger accuracy, context cost, no-op instructions and safety. Use when creating, editing, merging, auditing or deleting skills, or trimming CLAUDE.md or AGENTS.md.
---

# Skill Review

A skill is a runtime document for a model, not documentation for a person. Judge every line by whether it changes what the agent does, and at what cost. Official model-vendor guidance wins over local style.

Scope is one skill, a library, or an agent instruction file. For a library, run the audit first (see Library audit) and review the skills it flags. Read `references/writing-levers.md` when writing or rewriting a document rather than reviewing one.

## The yardstick

Every line spends one of two loads. **Context load** is paid every turn by anything always in the window: a skill description, a line in the repo's agent instructions. **Cognitive load** is paid by the person who must remember a skill exists. Material behind a pointer escapes context load for the price of the pointer's own line. Spend cognitive load where human judgment matters; spend context load only where the agent must reach the material on its own.

## Review order

1. **Invocation.** Does anything other than a person typing its name need to reach this skill, including another skill? If not, set `disable-model-invocation: true`; its description then costs nothing. Keep the description one trigger-bearing sentence anyway, because other harnesses ignore the flag.
2. **Pointer.** The description is the skill's always-loaded pointer. Leading word first, one trigger per distinct branch, no identity the body already carries. A description over the audit script's description threshold is a finding.
3. **No-ops.** Test every sentence: does it change behaviour against the current model's default? The test is model-relative. Settle disagreement by running the document in a fresh session, not by debate, and delete the whole failing sentence. Two kinds shrink as models improve: substitutes for a capability the model now has, and choreography of steps it would take anyway. Three kinds stay: preferences, environment facts the agent cannot look up, and gates.
4. **Cache.** The environment is a source of truth too: scripts, config, directory layout, `--help` output. A skill that restates it is a cache that goes stale. Keep only what the agent cannot find by looking: the unwritten convention, the reason behind a choice, the gotcha no config confesses.
5. **Hierarchy.** Steps in order first; reference the agent consults on demand next; material only some branches reach goes behind a pointer with a "read this when" gate. Default-path test: if the agent would open a supporting file right after activation on a normal run, that material belongs inline. Keep a concept's definition, rules and caveats under one heading.
6. **Leading words.** Replace three adjectives with the one pretrained word they stand for (tight, red, seam). State the target behaviour positively; a prohibition earns its place only as a hard guardrail, paired with the positive form.
7. **Specificity.** Broad guidance for judgment work, checklists for fragile workflows, scripts for deterministic repeated operations. Keep gates, commands, permissions and stop conditions as lists.
8. **Hygiene and safety.** Only files the skill uses at runtime plus repository provenance, and runtime text links only the runtime files. Flag secrets, hidden external actions, broad tool grants, production-impacting steps, harness-specific tool names, and skills that claim unrelated workflows. Local `[[skill-name]]` links are intended integration points, not defects.
9. **Behaviour.** One should-trigger, one should-not-trigger and one edge prompt, in fresh sessions where possible, without leaking the expected answer.

## Library audit

Run the read-only inventory before touching anything:

```bash
ruby <this skill's folder>/scripts/audit-skills.rb --root <skill root> [--root <another root>]
```

Pass every root the agent under review loads; `--help` lists the threshold flags. Sort findings into three groups: safe now (descriptions, repeated boilerplate, stale text), needs a decision (deleting or disabling a skill, changing triggers, moving between roots), and keep despite cost (rare but safety- or domain-critical). "Unused" or "duplicate" is evidence, not a verdict. Delete or merge a skill only after naming the kept replacement and repointing every `[[link]]` to it.

## Findings and verdict

Lead with issues. Severity is Critical (prevents safe or correct use), Important (wrong activation, context waste, unreliable behaviour) or Polish. Each finding names file and line, the model-facing risk, and the smallest fix. End with one verdict: PASS, NEEDS WORK or FAIL. When asked to edit, make the smallest patch that improves behaviour; never grow a skill to satisfy the checklist.
