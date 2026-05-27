# Skill Maintenance Provenance

This document records the source material that shaped
`skill-maintenance/SKILL.md`.

## Rebuild Recipe

1. Review the local skill taxonomy after the external-source adaptation branch.
2. Compare it against Peter Steinberger's `skill-cleaner` skill and analyzer.
3. Keep the useful inventory audit behavior and explicit cleanup follow-up.
4. Remove Codex-specific assumptions that do not belong in a portable local skill
   runtime contract.
5. Add a small local script for deterministic inventory checks.

## Peter Steinberger Agent Scripts

- Source: <https://github.com/steipete/agent-scripts>
- Reviewed ref: `737040cf3a196b1a11aeb1c1c7508ce721545745`
- Reviewed files:
  - `skills/skill-cleaner/SKILL.md`
  - `skills/skill-cleaner/scripts/skill-cleaner.ts`
- License: MIT

Useful ideas:

- Skill inventory should be tool-backed, not based on intuition.
- Audit duplicate names, duplicate bodies, long descriptions, visible prompt
  cost, and stale/superseded skills.
- Flag body bloat and near-copy skill bodies before cleanup.
- Usage signals from logs are useful but should be treated as heuristics.
- Cleanup should suggest before editing, then apply small grouped rewrites when
  explicitly requested.

Local adaptation:

- Kept the audit framing and added an explicit cleanup mode.
- Added a repository-local Ruby script so the audit can run without installing
  or executing external code.
- Added body line/character thresholds and fuzzy body-overlap scoring for
  substantial skills.
- Added large-section, repeated-heading, and body-cleanup recommendation output.
- Enabled all audit categories by default; options only tune thresholds.
- Tuned body-bloat defaults to treat character cost as the stronger signal,
  because compact lists are often better runtime instructions than dense prose.
- Removed Codex-specific cache, plugin, model-cache, history, and disabled-config
  assumptions from the runtime skill.
- Treated duplicate or unused findings as leads requiring human review, not
  automatic deletion instructions.
- Made cleanup model-driven rather than script-driven because trimming a skill
  requires preserving behavioral intent and scannable operational lists, not only
  cutting text.

Rejected material:

- Running the external TypeScript analyzer directly in this workspace.
- Automatic delete/disable behavior without naming the kept replacement.
- Treating "unused in recent logs" as enough evidence to remove a skill.

See also:

- `methodology/ADAPTATION_LOG.md`
- `methodology/disciplines/skill-maintenance.md`
