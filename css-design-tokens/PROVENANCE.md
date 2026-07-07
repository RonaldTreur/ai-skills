# Provenance: css-design-tokens

Rebuild recipe: read the Buninux GTC article and the gtc-tokens rulebook (below), translate the model to pure CSS custom properties (dots → hyphens, DTCG modes → scoped re-assignment of theme tokens via `data-theme`/inheritance), keep the rem/em and no-build-step rules from [[developing-web-projects]], bundle a two-file starter scaffold (`assets/global.css`, `assets/theme.css`), and adapt the upstream `:audit` rule pass into a CSS audit checklist. Validate with a fresh-session functional test (new project + button + dark mode).

## Source: Buninux — "Design Tokens" article

- URL: https://buninux.com/design-tokens (canonical GTC spec)
- Reviewed: 2026-07-07 (via web fetch; no versioned ref)
- Taken: the GTC three-group model, five-level naming taxonomy (Group → Element → Classifier → Identifier → State), alias direction, mode/scope concept, role-based-naming and anti-filler rules.
- Adapted: dot-path names became hyphenated CSS custom properties; modes became theme-token re-assignment under `[data-theme]` scopes; all guidance rewritten as operational instructions, no copied text.

## Source: bunind/gtc-tokens (GitHub)

- URL: https://github.com/bunind/gtc-tokens — MIT license
- Ref: bf6c2e4cc526931e9ade3d550425c0013feaa6c2 (2026-07-05)
- Files: `skill/reference.md` (primary), `skill/SKILL.md`, `README.md`, `template/`
- Taken (paraphrased/behavioral, no copied text): non-linear siblings framing; "component never ships color tokens"; "where does it go?" varies-by rule; factual scale keys; "the value is never a level" leaf rule; classifier discipline; mode-name-never-in-path rule; semantic role keys (z-index/motion/line-height/letter-spacing); the `:audit` rule-pass checklist (translated to CSS checks, rule names kept close for cross-reference).
- Why it fit: same author as the article, richer and more operational; the taxonomy and audit rules are format-independent.
- How adapted: factual px keys hybridized with the local rem rule (px-equivalent names, rem values, decided by Ronald 2026-07-07); JSON/DTCG mechanics, `$extensions.mode`, and validate.py replaced by CSS-native wiring; interactive command menu dropped in favor of an always-on convention skill.
- Rejected: installing the upstream skill as-is (no JSON token files in pure-CSS projects; trigger overlap). Deferred: DTCG/Figma `:sync` workflow and a mechanical CSS validator script — revisit if a JSON-sync need appears or audits become frequent.

See `methodology/ADAPTATION_LOG.md` (entries dated 2026-07-07) and `methodology/disciplines/design-tokens-css.md`.
