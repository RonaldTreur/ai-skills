# Runtime Skill Maintenance - PR #20

- Review date: 2026-05-29
- Branch under maintenance: `feat/external-skill-adaptation`
- Maintenance branch: `chore/progressive-disclosure-runtime-skills`
- Command: `ruby skill-maintenance/scripts/audit-skills.rb --root .`

## Rule Applied

`SKILL.md` must keep every rule needed for the default run of the skill. References are for optional depth, examples, templates, provenance, rare branches, or expanded material. If a model would usually need to open a support file immediately after activation, inline or compress the material instead.

## Inventory Result

- Skills checked in current root: 27
- Duplicate names: none
- Identical bodies: none
- Long descriptions: none above threshold
- Description overlap: none above threshold
- Superseded names visible in current root: none

## Cleanup Applied

- `code-review/SKILL.md`: compressed the default review workflow inline and removed the large-section audit finding without moving default-path checks into references.
- `building-xstate-state-machines/SKILL.md`: compressed verbose taxonomy and implementation rules inline, preserving XState v5 defaults and naming rules.
- `developing-web-projects/SKILL.md`: removed repeated separators and tightened prose while keeping web defaults, CSS hygiene, Cloudflare defaults, and monorepo policy inline.
- `generating-web-components/SKILL.md`: removed tutorial-style example prose and compressed decorator/component rules while preserving generator behavior.
- `external-skill-adaptation/SKILL.md`: compressed workflow prose inline and reduced the large-section finding.
- `skill-review/SKILL.md` and `skill-maintenance/SKILL.md`: added the explicit default-path test so future maintenance does not repeat fake slimming.

## Keep Despite Cost

The audit still flags body size in these skills. They were inspected and kept because the flagged material is default-path operating procedure, safety policy, or domain-specific rules:

- `frontend-design/SKILL.md`: divergent variants, visual thesis, preview, browser review, feedback, and finalization are core behavior.
- `project-kickoff/SKILL.md`: phase flow, grounding, routing, and handoff rules are default kickoff behavior.
- `gh-pipeline/SKILL.md`: labels, transitions, locks, stage ownership, and failure handling are the pipeline state machine.
- `solana-dev/SKILL.md`: safety guardrails, stack defaults, MCP/docs policy, and Solana reference routing are domain-critical.
- `documentation-handoff/SKILL.md`: artifact roles, handoff packet shape, decision capture, ADRs, and recovery are core handoff behavior.

## Remaining Audit Noise

`external-skill-adaptation > Workflow` still appears as a large section at a lower size. It remains inline because the workflow is the skill's default execution path.
