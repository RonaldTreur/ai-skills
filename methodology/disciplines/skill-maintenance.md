# Skill Maintenance

- Date: 2026-05-27
- Branch: `feat/skill-maintenance-audit`
- Local files reviewed: `README.md`, `methodology/DISCIPLINES.md`,
  `skill-review/SKILL.md`, `external-skill-adaptation/SKILL.md`, current skill
  roots
- External source reviewed: Steipete Agent Scripts

## Goal

Add a maintenance pass for the skill ecosystem before integrating the large
external-source adaptation branch. It must first audit skill bloat, duplicate
visibility, superseded skills, and prompt-budget pressure, then support focused
cleanup when explicitly requested.

## Source Review

### Steipete Agent Scripts

- Reviewed ref: `737040cf3a196b1a11aeb1c1c7508ce721545745`
- Useful patterns:
  - inventory skills across multiple roots
  - detect duplicate names and duplicate bodies
  - flag long descriptions as model-visible context cost
  - include disabled/config state and recent-log usage where available
  - recommend cleanup without immediately applying it
- Local fit:
  - Strong fit for post-adaptation hygiene and pre-integration checks.
  - Distinct from `skill-review`: multi-skill inventory and bloat cleanup, not
    semantic review of one skill.
  - Distinct from `external-skill-adaptation`: maintaining local skill shape,
    not importing external methodology.
- Risks:
  - The source implementation is Codex-environment-specific.
  - Usage logs are only heuristic and can undervalue rare safety skills.
  - Automatic deletion would be too risky for this workspace.

## Local Adoption

Created `skill-maintenance/` as a dormant meta-maintenance skill:

- `skill-maintenance/SKILL.md`
  - defines audit and explicit cleanup modes
  - trims repeated prose while preserving triggers, boundaries, safety gates,
    and tool-specific commands
  - routes semantic single-skill quality review to `[[skill-review]]`
  - routes external-source adaptation to `[[external-skill-adaptation]]`
- `skill-maintenance/scripts/audit-skills.rb`
  - local Ruby script
  - no external dependencies
  - scans caller-provided roots only
  - reports root counts, long descriptions, duplicate names, identical bodies,
    body bloat, near-body duplicates, large sections, repeated headings,
    description overlap, cleanup recommendations, and superseded names
- `skill-maintenance/PROVENANCE.md`
  - records Steipete source influence and rejected material
- `skill-maintenance/agents/openai.yaml`
  - adds UI-facing metadata for the new skill

Updated:

- `README.md`
- `methodology/DISCIPLINES.md`
- `methodology/sources/steipete-agent-scripts.md`
- `methodology/ADAPTATION_LOG.md`

## Read-Only Audit Run

Command:

```bash
skill-maintenance/scripts/audit-skills.rb \
  --root . \
  --root ~/Development/skills \
  --root ~/.openclaw/workspace-main/skills \
  --root ~/.openclaw/skills \
  --root ~/.openclaw/agents/main/agent/codex-home/skills/.system
```

Summary:

- Roots checked: 5
- Skills found: 83
- Duplicate names: 19 groups
- Identical bodies: 8 groups
- Body bloat: reported by line/character thresholds
- Near-body duplicates: reported by fuzzy body-word overlap
- Description overlap above 0.55: none
- Superseded skill still visible:
  `~/Development/skills/enforcing-test-coverage-vitest-playwright/SKILL.md`

Notable long descriptions:

- `imagegen`: 570 chars, system skill
- `issue-driven-delivery-loop`: 453 chars, personal skill
- `external-skill-adaptation`: 450 chars, repo skill
- `project-manager`: 405 chars, repo skill
- `browser-qa`: 379 chars, repo skill
- `implement-issue`: 368 chars, repo skill
- `e2e-playwright`: 364 chars, repo skill
- `project-kickoff`: 345 chars, repo skill

Interpretation:

- Duplicate names are expected while this adaptation branch exists beside
  active workspace/personal skill roots. They become a real routing problem only
  after integration if old copies remain installed.
- The superseded `enforcing-test-coverage-vitest-playwright` skill is the
  strongest cleanup candidate, but removing or disabling it is outside this
  read-only audit slice.
- No high-similarity description overlap was found at the configured threshold,
  so the new taxonomy does not appear to create obvious routing collisions.
- Some descriptions are long but intentionally specific. Tightening them should
  be a separate description-polish pass, not mixed into inventory setup.

## Cleanup Pass Against This PR

Ronald challenged the first adaptation because it only audited instead of
cleaning. The PR was updated before merge:

- `skill-maintenance/SKILL.md` now has audit and cleanup modes.
- The description was tightened from 262 to 153 characters while adding cleanup
  trigger terms.
- Twenty repo skill descriptions were compressed below the 230-character audit
  threshold without changing skill bodies.
- The audit script now flags body bloat and near-body duplicate scores, matching
  the useful body-analysis part of the source without auto-rewriting bodies.
- The audit script now reports large sections, repeated headings, and body
  cleanup recommendations.
- All audit categories run by default; flags only tune thresholds.
- `project-manager`, `implement-issue`, and `project-kickoff` were compressed;
  operational lists were kept as lists where scanning matters more than raw line
  count.
- The runtime skill now says how to trim bloated skills: compress descriptions,
  remove repeated purpose prose, move provenance out of runtime, and keep gates,
  permissions, commands, verification steps, and stop conditions in list form.
- This methodology document and provenance now describe cleanup instead of
  repeating "read-only only" language.

## Adoption Decision

Adopted: a new dormant `skill-maintenance` owner for inventory audits and
explicit cleanup passes.

Rejected:

- importing the external TypeScript analyzer wholesale
- automatic skill deletion or disabling without naming the kept replacement
- treating recent usage as a removal decision
- folding this into `skill-review`, because this is multi-skill inventory
  hygiene rather than one-skill semantic review

## Verification

- Local audit script: pass.
- Frontmatter parse for `skill-maintenance/SKILL.md`: pass.
- `git diff --check`: pass.
- Runtime source/provenance leakage scan: pass. External-source names and
  provenance fields stay out of runtime `SKILL.md` files outside
  `external-skill-adaptation/SKILL.md`.
- `[[skill-review]]` for `skill-maintenance/SKILL.md`: PASS. The skill has a
  distinct trigger, read-only default, bounded output shape, and clear boundaries
  with `skill-review` and `external-skill-adaptation`.

## Follow-Up Recommendations

1. After integration, run `skill-maintenance` against the active installed roots
   without the adaptation repo root.
2. Decide whether to remove, disable, or replace
   `enforcing-test-coverage-vitest-playwright` in `~/Development/skills`.
3. Consider a narrow description-polish pass only for skills whose descriptions
   are both long and over-triggering in practice.
