---
name: skill-maintenance
description: "Audit and trim skill libraries for prompt-budget bloat, duplicate skills, superseded skills, long descriptions, repeated instructions, and noisy routing."
---

# Skill Maintenance

Keep a skill ecosystem small, sharp, and easy to route. Owns multi-skill
hygiene; use [[skill-review]] for one skill and [[external-skill-adaptation]]
when importing outside ideas.

## Modes

Start with audit mode. Clean only when the user asks to apply findings.

### Audit Mode

Do not delete, disable, rename, or rewrite skills. Report:

- skill count by root
- duplicate names or identical bodies
- long descriptions and prompt-budget pressure
- body bloat by line/character count
- near-body duplicate scores for substantial skills
- large heading sections that should become references or shorter checklists
- repeated section headings across skills
- body cleanup recommendations
- likely overlap from similar names or descriptions
- superseded skills still visible in loaded roots
- cleanup candidates grouped by risk

Treat "unused" or "duplicate" as evidence, not a verdict.

### Cleanup Mode

Make one focused patch. Prefer the smallest real context-cost reduction:

- compress frontmatter descriptions while preserving trigger nouns
- delete purpose prose already covered by the description
- replace duplicated workflow narration with a checklist
- move provenance, source review, examples, and long rationale out of `SKILL.md`
- split large conditional sections into directly linked references
- preserve bullet/numbered lists for gates, permissions, handoff packets,
  commands, verification, and stop conditions
- remove or disable superseded skills only after naming the kept replacement

Do not flatten operational lists into dense comma prose for tiny savings.

## When To Use

Use for:

- pre-integration audits after a large skill branch
- periodic skill-library maintenance
- checking whether new skills made routing noisy
- trimming wordy skills after bulk edits
- finding old/superseded skills still visible to agents

Do not use during ordinary implementation, testing, review, or debugging unless
the task is skill inventory health.

## Audit Workflow

1. Identify relevant roots for the current agent/runtime.
2. Run the read-only inventory script. The default report includes descriptions,
   body bloat, exact duplicates, near-body duplicates, description overlap, and
   superseded names:

   ```bash
   ruby skill-maintenance/scripts/audit-skills.rb \
     --root . \
     --root ~/Development/skills \
     --root ~/.openclaw/workspace-main/skills \
     --root ~/.openclaw/skills \
     --root ~/.openclaw/agents/main/agent/codex-home/skills/.system
   ```

   Use threshold flags only when the report is too noisy or quiet.

3. Separate findings into:
   - **Safe now**: description tightening, repeated boilerplate, stale docs.
   - **Needs decision**: disabling/removing loaded skills, changing trigger
     semantics, moving skills between roots.
   - **Keep despite cost**: rare but safety-critical or domain-critical skills.
4. If cleanup is requested, make one focused patch and rerun the audit.

## Cleanup Checklist

For each target:

1. Preserve frontmatter `name` and essential trigger terms.
2. Reduce the description to one direct sentence.
3. Keep only instructions that change agent behavior.
4. Replace repeated body sections with one boundary or checklist.
5. Move long examples, source notes, and rationale to references/provenance.
6. Merge near-duplicate body sections only after checking both skills' triggers.
7. Keep independently actionable items as lists, especially gates and commands.
8. Verify the skill still says when not to use it.

## Output

Use this shape:

```markdown
## Skill Inventory Audit

- **Roots checked:** ...
- **Skill count:** ...
- **High-signal findings:** ...
- **Recommended cleanup:** ...
- **Keep despite cost:** ...
- **Needs human decision:** ...
- **No-action items:** ...
```

For maintenance PRs, include the command and full report path in the PR body.
