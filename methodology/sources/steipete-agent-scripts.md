# Source Inventory: Steipete Agent Scripts

## Source

- Name: Steipete Agent Scripts
- URL: <https://github.com/steipete/agent-scripts>
- License: MIT
- Reviewed ref: `737040cf3a196b1a11aeb1c1c7508ce721545745`
- Review date: 2026-05-27

## Reviewed Files

- `skills/skill-cleaner/SKILL.md`
- `skills/skill-cleaner/scripts/skill-cleaner.ts`
- `LICENSE`

## Applicability

High for meta-maintenance of skill inventories. The source addresses a real
post-adaptation problem: skill sprawl, duplicate visibility, prompt-budget cost,
and stale skills that remain available after taxonomy changes.

## Useful Ideas

- Audit skills with a deterministic tool rather than manual guessing.
- Check duplicate names and identical bodies across roots.
- Treat long frontmatter descriptions as visible context cost.
- Use recent session/log usage as a heuristic, not a deletion authority.
- Suggest cleanup before editing.

## Risks Or Adoption Constraints

- The analyzer is tailored to Codex paths, plugin cache layout, model cache, and
  session logs.
- Running external code directly inside the workspace is unnecessary for the
  local use case.
- Usage detection can miss important but rare safety/policy skills.
- Delete/disable recommendations need explicit human review.

## Local Decision

Adapt the concept into a local read-only `skill-maintenance` skill and a small
repository script. Do not import the external TypeScript implementation or make
automatic cleanup decisions.
