# Source Inventory: gtc-tokens (Buninux GTC design tokens)

- Source URL: https://github.com/bunind/gtc-tokens (canonical spec: https://buninux.com/design-tokens)
- License: MIT
- Commit/tag/release reviewed: bf6c2e4cc526931e9ade3d550425c0013feaa6c2 (2026-07-05, no releases)
- Retrieved: 2026-07-07
- Reviewer: Claude (Fable 5), with Ronald
- Local clone/path, if any: session scratchpad only (not vendored)

## Scope Reviewed

- `skill/SKILL.md` — the upstream `/gtc-tokens` Claude Code skill (`:audit` / `:create` / `:new` / `:sync` commands)
- `skill/reference.md` — the GTC rulebook written for AI agents (taxonomy, modes, alias direction, scale keys)
- `README.md` — repo overview and install instructions
- `template/` + `skill/template/` — DTCG JSON starter token set (global/theme/component folders)
- `validate.py` — mechanical GTC validator for the JSON format (skimmed via reference.md description)

## Relevant Disciplines

- design-tokens-css (new; owner skill: `css-design-tokens`)
- frontend-design (light overlap: token-system reuse rules)

## Strong Ideas

- Non-linear model framing: Theme and Component are siblings branching from Global, not a chain.
- "Component never ships color tokens" — a component's look lives entirely in Theme (`theme.button.*`); Component holds only structure.
- "Where does it go?" decision table: pick the group by *what the value varies by*, not by token type.
- Factual numeric scale keys: the key IS the value (`size-unit.12` = 12px), so an agent never guesses.
- Separator rule: dot separates levels, hyphen joins words inside one level (`size-unit` vs `surface.page`).
- "The value is never a level" — the last level present is the leaf that carries the value; no dedicated property slot.
- Classifier discipline: only on variant-specific appearance tokens; structural tokens stay bare; single-variant components omit it.
- Mode names never appear in a token path as switching context (`dark` as context is a mode key, not a name segment).
- `:audit` rule-pass checklist with short rule names (name order, separators, classifier use, theme routing, role-based names).
- Semantic role keys where numbers don't help: z-index (`base…tooltip`), motion (`fast/normal/slow`), line-height (`title/text/label`).

## Adoption Risks

- Entire runtime is built around DTCG JSON files (`$type`/`$value`/`$extensions.mode`) plus a Python validator — Ronald's projects are pure CSS custom properties with no build step; the JSON pipeline does not apply as-is.
- Interactive command menu (AskUserQuestion-driven `:audit`/`:create`/`:sync`/`:new`) duplicates what a leaner always-on convention skill does; installing it verbatim would create routing overlap with `css-design-tokens`.
- Factual px-based scale keys conflict with the local rem/em-only rule; needs a px-name/rem-value hybrid if adopted.
- Dot-level separators cannot be expressed in CSS custom property names; hyphen-only names lose level-boundary information (`surface-page` is exactly what upstream flags).

## Re-Review Trigger

Revisit on a new upstream release/major rulebook change, or if a project needs Figma/DTCG JSON sync (upstream `:sync` would then be worth a second look).
