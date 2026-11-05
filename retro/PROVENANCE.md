# Retro Provenance

This document records the source material that shaped `retro/SKILL.md`. It is
outside the runtime skill so attribution does not consume model context.

## Rebuild Recipe

1. A retrospective proposes environment changes; the person decides. The skill
   never applies a change itself.
2. User-invoked (`disable-model-invocation: true`): it fires only when typed, so
   its description costs no context.
3. Read primary sources first and stay read-only until proposals are written.
4. Search eight categories, each with a cue for when it applies: navigation,
   automated checks, review rules, steering files, no-ops, tool economy,
   information access, skills.
5. Mechanical violations become deterministic checks; only judgment calls
   become written review rules.
6. At most five proposals, ordered by severity, with evidence and failure mode.
   Fail closed on credentials, auth, releases, deployments, destructive work and
   out-of-repo files.

## Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `4ae2317ddb22b046e26455e4f9c9b3aaaf62212d` (v1.3.2)
- Reviewed files: `skills/engineering/retro/SKILL.md`,
  `skills/productivity/writing-for-agents/SKILL.md`
- License: MIT

What we took:

- The posture: the retro suggests improvements to the agent's environment and
  presents them; it does not implement them.
- The seven improvement categories with a "use when" cue each, and the rule that
  a mechanical violation gets a check while a judgment call gets a written rule.
- "Read the repo's own check command first": an existing but unwired check is
  the finding, and a repo with no guardrail is itself a finding.
- The observation that the reviewer has the least context pressure and should
  therefore carry the coding standards.
- "Where changes land": steering files hold pointers only; docs are reached by
  pointers; skills are for material the agent must reach itself or for typed
  commands.

How it was adapted:

- Paraphrased throughout; no text copied.
- Added an eighth category, skills, routed through `[[skill-review]]`, because
  this repository maintains its own skill library.
- Replaced the upstream `CODING_STANDARDS.md` convention with "wherever
  `[[code-review]]` reads review rules in this repo", since local repositories
  do not share one standards file.
- Dropped the upstream step that loads `writing-for-agents` as a style guide;
  the equivalent material lives in `skill-review/references/writing-levers.md`
  and is reached through `[[skill-review]]` when a skill change is proposed.
- Added the merged-PR source set (diff, review thread, CI, closing issue) so the
  retro covers the post-merge case the superseded local skill owned.

## Superseded Local Skill

`run-workflow-retrospective` (removed 2026-11-03) was a post-merge PR scorecard
with guarded auto-implementation for the RoundTable scheduler. RoundTable v1 is
decommissioned. The following gates were carried over as taste and safety lines;
the fingerprint, ledger, label and Skill Workshop machinery was deleted:

- start read-only;
- fail closed on credentials, auth, releases, deployments, destructive
  operations and out-of-scope changes;
- at most five actions;
- prefer systemic fixes over prompt patches;
- assign system defects to the system.

## Formal Trail

- `methodology/ADAPTATION_LOG.md` (entries dated 2026-11-03, discipline skill meta)
- `methodology/disciplines/skill-meta-2026-11.md`
- `methodology/disciplines/matt-pocock-rereview-2026-11.md` (open question 5)
- `methodology/sources/matt-pocock-skills.md`

## Local Integration Decision (2026-11-05, skill-review pass)

Trimmed per `methodology/disciplines/skill-review-pass-2026-11.md`: rules
stated once, environment facts the agent can look up removed, branch-only
material moved behind gated references, harness-specific names removed. The
findings and the fixes applied are listed there per skill.
