# Discipline Review: design-tokens-css

- Date: 2026-07-07
- Reviewer: Claude (Fable 5), decisions by Ronald
- Branch: main, uncommitted — the skill was drafted in `~/.claude/skills` (session-local) and moved into the ai-skills repo afterwards; methodology artifacts landed in the repo directly via the `~/.claude/skills/methodology` symlink
- Local files reviewed: `css-design-tokens/` (created this pass), `developing-web-projects/SKILL.md` (token-reuse rules)
- External sources reviewed: Buninux GTC article; bunind/gtc-tokens @ bf6c2e4 (see `methodology/sources/gtc-tokens.md`)
- Status: complete

## Local Baseline

Before this pass there was no owner skill for CSS custom-property structure. `developing-web-projects` mandated "reuse the established token system" without defining one. `css-design-tokens` was drafted from the Buninux article earlier the same session, then upgraded against the upstream repo in this review.

## Source Comparison

### bunind/gtc-tokens

- Source ref: bf6c2e4cc526931e9ade3d550425c0013feaa6c2 (MIT)
- Files reviewed: `skill/reference.md`, `skill/SKILL.md`, `README.md`, `template/`
- Useful patterns: non-linear group model; component-never-ships-color; varies-by group selection; factual scale keys; value-is-never-a-level; classifier discipline; mode-name-in-path rule; audit rule pass; semantic role keys.
- Conflicts or risks: entire runtime is DTCG JSON + Python validator + interactive command menu — none of it fits pure-CSS, no-build-step projects; px scale keys conflict with the local rem/em rule; dot separators inexpressible in CSS property names.
- Adoption recommendation: adapt the rulebook into `css-design-tokens`; do not install the upstream skill.

## Questions For The User

Asked and answered 2026-07-07:

1. Scale keys: factual px-equivalent names with rem values, ordinal steps, or factual rem names? → **Factual px-equivalent** (`--global-size-unit-16: 1rem`).
2. Adapt the `:audit` rule pass? → **Yes, as a SKILL.md section** (no validator script for now).
3. Install upstream `/gtc-tokens` alongside? → **No — adapt only**; deferred for JSON/Figma sync needs.

## Adopted Changes

- `css-design-tokens/SKILL.md` + `assets/*.css` rewritten with the upstream rules and factual scale keys — provenance ids `2026-07-07-design-tokens-gtc-rulebook-adapted`.
- Functional-test fixes folded in the same pass (button text theme tokens, base/page-style pattern, dark-duplication warning, scaffold-vs-no-speculation clarification, `:hover:not(:disabled)` guard).

## Skill-Level Attribution

`css-design-tokens/PROVENANCE.md` created (both sources: article + repo).

## Rejections And Deferrals

- Rejected: installing `bunind/gtc-tokens` skill as-is (`2026-07-07-design-tokens-gtc-skill-rejected-as-is`) — JSON runtime doesn't apply, routing overlap.
- Deferred: DTCG/Figma `:sync` workflow and a mechanical CSS token validator script (`2026-07-07-design-tokens-gtc-sync-validator-deferred`) — revisit on a real JSON-sync need or frequent audits.

## Verification Notes

- The dedicated-branch rule was not applied: the skill was drafted outside the repo and moved in afterwards; changes sit uncommitted on main for Ronald to commit. Exception recorded here rather than improvising.
- Fresh-session functional test run against the draft skill (new project, button, dark mode) — findings folded in; re-test run against the adapted version.
- `[[skill-review]]` pass run on the adapted `css-design-tokens/SKILL.md` — result recorded in the session summary (PASS expected; see final report).
