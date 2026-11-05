# Discipline Review: Skill Meta (November 2026)

- Date: 2026-11-03
- Reviewer: Claude (Fable 5.1), with Ronald
- Branch: `docs/pocock-rereview-2026-11`
- Local files reviewed: `skill-review/`, `skill-maintenance/`,
  `run-workflow-retrospective/`, `external-skill-adaptation/SKILL.md`,
  `gh-pipeline/SKILL.md`, `openclaw-contribution/SKILL.md`, `README.md`,
  `methodology/DISCIPLINES.md`
- External sources reviewed: Matt Pocock Skills at
  `4ae2317ddb22b046e26455e4f9c9b3aaaf62212d` (`writing-for-agents/SKILL.md`,
  `writing-for-agents/SKILL-MECHANICS.md`, `retro/SKILL.md`)
- Status: landed

This is the first slice that acts on the decisions in
`matt-pocock-rereview-2026-11.md`. It covers the "skill meta" row of that
review's overlap map.

## Local Baseline

Four local skills covered what two upstream skills do. `skill-review` (489
words) reviewed one skill; `skill-maintenance` (628 words plus a Ruby audit
script and a Codex interface file) audited a library; both asked whether skill
text earns its context cost but neither named a yardstick.
`run-workflow-retrospective` (1,649 words plus 1,338 in support files) was a
post-merge scorecard with guarded auto-implementation for the RoundTable
scheduler, which is decommissioned. No local skill was user-invoked, so all 33
descriptions loaded every turn.

## Source Comparison

### Matt Pocock Skills

- Source ref: `4ae2317ddb22b046e26455e4f9c9b3aaaf62212d` (v1.3.2, MIT)
- Files reviewed: `skills/productivity/writing-for-agents/SKILL.md`,
  `skills/productivity/writing-for-agents/SKILL-MECHANICS.md`,
  `skills/engineering/retro/SKILL.md`
- Useful patterns: the two loads; the model-relative no-op test settled by
  running; the cache rule; the information hierarchy with branching as the
  disclosure test; leading words and positive phrasing; the model-invoked versus
  user-invoked split; a retro that proposes environment changes in categories
  with cues, and turns mechanical violations into checks.
- Conflicts or risks: upstream strips trigger language from user-invoked
  descriptions, which is unsafe for skills that run in harnesses that ignore the
  flag; upstream assumes `CODING_STANDARDS.md`, which local repositories do not
  carry; upstream `retro` loads `writing-for-agents` by tool call, which would
  name a harness mechanism.
- Adoption recommendation: adapt both, paraphrased; keep descriptions
  trigger-bearing; route skill changes through `[[skill-review]]` instead of a
  tool call.

## Questions For The User

All answered on 2026-11-03 in `matt-pocock-rereview-2026-11.md`, open questions
1, 2 and 5: skills stay harness-agnostic; role scripts go; the retrospective is
replaced.

## Adopted Changes

- `skill-review/SKILL.md` rewritten (750 words) around the two loads as the
  yardstick and a nine-step review order; absorbs the library audit from
  `skill-maintenance`. Entry
  `2026-11-03-skill-meta-writing-for-agents-yardstick`.
- `skill-review/references/writing-levers.md` added (about 550 words), read
  only when writing a skill. Same entry.
- `skill-review/scripts/audit-skills.rb` moved from `skill-maintenance/`; now
  forces UTF-8 so it runs under a plain-ASCII locale. Entry
  `2026-11-03-skill-meta-skill-maintenance-superseded`.
- `skill-maintenance/` removed, including `agents/openai.yaml` (no other local
  skill carries a Codex interface file). Same entry.
- `retro/SKILL.md` added (488 words, user-invoked) with `retro/PROVENANCE.md`.
  Entry `2026-11-03-skill-meta-retro-adapted`.
- `run-workflow-retrospective/` removed with its three support files. Entry
  `2026-11-03-skill-meta-run-workflow-retrospective-superseded`.
- `disable-model-invocation: true` set on `external-skill-adaptation`,
  `openclaw-contribution`, `gh-pipeline` and `retro`. Only skills with no
  inbound `[[links]]` were flipped; `start-new-project` stays model-invoked
  because three skills reach it. Entry `2026-11-03-skill-meta-user-invoked-flip`.
- `external-skill-adaptation/SKILL.md`: two lines that named OpenClaw and the
  Merlin/Vectrix roles reworded, per decision 2 of the re-review. The rest of
  the role-script removal is a separate slice.
- `README.md` and `methodology/DISCIPLINES.md` updated to the new owners.

Context-cost effect: always-loaded description text in this repository went
from 33 skills and about 5,800 characters to 28 model-invoked skills and about
5,000 characters. Runtime words removed: about 4,100 (two skills and their
support files) against about 1,800 added.

## Skill-Level Attribution

- `skill-review/PROVENANCE.md` rewritten: adds the Pocock section, folds in the
  Steinberger section from the removed `skill-maintenance/PROVENANCE.md`, keeps
  the May 2026 sources.
- `retro/PROVENANCE.md` created, including the gates carried over from the
  superseded local skill.

## Rejections And Deferrals

- Rejected: stripping trigger language from user-invoked descriptions
  (harness-agnostic rule).
- Rejected: upstream `CODING_STANDARDS.md` and `GLOSSARY.md` conventions as
  local requirements.
- Deferred: the three-skill trim experiment (`debugging`, `implement-issue`,
  `code-review`) from the re-review. It needs real tasks run in fresh sessions
  and is its own piece of work.
- Deferred: the same user-invoked pass over the Ockto work skills in
  `~/.claude/skills`; those live outside this repository.

## Verification Notes

- `ruby skill-review/scripts/audit-skills.rb --root ~/Development/ai-skills --root ~/.claude/skills`:
  43 skills across two roots; no duplicate names, no identical or near-duplicate
  bodies, no superseded names; neither new skill is flagged for description
  length or body bloat. The script failed on first run under the session's
  ASCII locale and was patched to force UTF-8.
- No runtime file outside `methodology/` references `skill-maintenance`,
  `run-workflow-retrospective` or RoundTable.
- Frontmatter parses on all five changed runtime skills; descriptions are 122 to
  182 characters.
- `[[skill-review]]` pass on `skill-review/SKILL.md` and `retro/SKILL.md`,
  run by a separate agent without this session's reading: see below.

### Review results

A separate agent reviewed both skills against the nine checks without this
session's reading. Verdicts before fixes: NEEDS WORK for both. Findings and
what was done:

- `skill-review/SKILL.md`, Important: the audit command hard-coded two machine
  paths and a cwd-relative script path (a cache of the environment, and the
  skill's own check 4). Fixed: script pathed from the skill folder, roots
  supplied by the reviewer.
- `skill-review/SKILL.md`, Important: the sentence listing what the script
  reports cached `--help`. Deleted.
- Both files, Important: the no-op test and the cache rule appeared in the body
  and in `writing-levers.md`. The reference now points at checks 3 and 4.
- `retro/SKILL.md`, Important: three sentences gave three different write
  boundaries. Replaced with one: propose only, apply after approval, step 4's
  classes need approval per item.
- Polish items applied: description of `skill-review` widened to agent
  instruction files (the edge probe "my CLAUDE.md is bloated" did not select
  it); `retro` description gained a "use when" clause so a harness that ignores
  the flag does not match "merged PR" loosely; one duplicated steering-file rule,
  one undefined threshold reference, one bare prohibition and one no-op sentence
  removed.
- Probes: both should-trigger prompts select the right skill; both should-not
  prompts select another skill; both edge cases are now covered by the
  descriptions.
- No harness-specific tool names, hidden actions or secrets; all `[[links]]`
  resolve.

Verdict after fixes: PASS for both, with the reviewer's findings applied as
written. Final sizes: `skill-review/SKILL.md` 750 words, description 239
characters; `retro/SKILL.md` 488 words, description 183 characters;
`writing-levers.md` 551 words.
