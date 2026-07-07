---
name: css-design-tokens
description: "Structure CSS custom properties as design tokens using the GTC model (Global → Theme → Component). Use whenever starting a new web project's styling, defining colors/spacing/typography as CSS variables, adding dark mode or any theming, auditing or restructuring an existing stylesheet's custom properties, or when a component needs a styling value that doesn't exist as a token yet. Pure CSS only — never SCSS variables or CSS-in-JS."
---

# CSS Design Tokens — the GTC model

The GTC (Global / Theme / Component) token model, expressed as pure CSS custom properties. Canonical spec: https://buninux.com/design-tokens — consult it only if this file is ambiguous. This skill complements [[developing-web-projects]] (semantic CSS, rem/em, modern CSS): where that skill says "reuse the established token system", **this** is the system.

## The three groups

GTC is non-linear: Theme and Component are siblings that both branch from Global — neither sits under the other.

| Group | Question it answers | Holds |
|---|---|---|
| **Global** | "What raw values exist?" | Primitive scales — the *only* place raw values live. Aliases nothing. |
| **Theme** | "How should this look right now?" | Looks and visual modes: surfaces, text, icons, borders, per-component looks (`--theme-button-*`). Every token aliases Global. |
| **Component** | "How is this component built and sized?" | Per-component structure: spacing, gaps, sizes, radius, typography. Aliases Global. |

Pick the group by **what the value varies by**, never by token type:

- Fixed raw value (color, rem, weight…) → global token
- Varies by light/dark or is a semantic look → theme token
- Varies by size, or is per-component structure → component token

Three consequences that keep the system sane:

- **A raw value lives in exactly one place: a Global token.** Theme and Component alias via `var()`. If you're typing a hex/oklch color or a rem value anywhere else, stop and add (or reuse) a global token.
- **Component never ships color tokens.** A component's look — surface, text color, border color, per-state colors — lives entirely in Theme (`--theme-button-primary`, `--theme-button-primary-hover`). Component tokens are structure only. This is what makes dark mode a pure Theme-tier change.
- **The edge case:** a *structural* value that must switch on a theme mode (say, bolder text in light mode) routes through Theme: `--component-button-font-weight: var(--theme-button-font-weight)`.

## Naming convention

Levels in a fixed order, hyphen-separated:

```
--{group}-{element}-{classifier}-{identifier}-{state}
```

1. **Group** — `global` | `theme` | `component`. The only mandatory level, always first.
2. **Element** — the UI thing or value type: `button`, `input`, `surface`, `text`, `color`, `size-unit`.
3. **Classifier** — variant: `primary`, `danger`, `secondary`.
4. **Identifier** — distinguishing tag or property: `page`, `blue`, `font-size`, a scale key.
5. **State** — interaction state, always last: `hover`, `active`, `disabled`.

Rules that matter:

- **Minimum levels.** Add a level only when removing it would leave the token ambiguous. `--component-button-color-background-state-hover` is filler grammar; `--theme-button-primary-hover` says the same thing.
- **The value is never a level.** Whichever level comes last is the leaf that carries the value — there is no separate "property" slot. In `--component-button-font-size`, `font-size` is the Identifier leaf; in `--theme-button-primary-hover`, the State leaf carries it.
- **Classifier discipline.** Use a Classifier only on variant-specific *appearance* tokens (`--theme-button-danger-surface`). Structural tokens stay bare (`--component-button-radius` — geometry is the same across variants), and single-variant components omit it (`--theme-input-surface`).
- **Design role, never screen/feature/layout.** `--theme-text-subtle`, not `--sidebar-text` or `--login-spacing`. Same for modes: `dark`, `high-contrast`, `small` — never `phone`, `marketing`, `dashboard`.
- **A mode name never appears in a token name as switching context.** `dark` may only appear when it names the token's own look (a dark palette variant), never the mode that switches it.
- **Separator caveat.** In the spec, dots separate levels and hyphens join words *inside* a level (`size-unit`). CSS property names can't contain dots, so both collapse to hyphens and level boundaries become implicit — accept that, keep level words short, and don't invent exotic separators like `--theme-surface--page`.

## Scale keys are factual

The key in a token's name IS the value, so nobody ever guesses. Sizes are named by px-equivalent but **valued in rem** (per [[developing-web-projects]]):

```css
--global-size-unit-16: 1rem;        /* 16px-equivalent */
--global-font-size-14: 0.875rem;
--global-radius-8: 0.5rem;
--global-color-opacity-8: 0.08;     /* opacity nests under color; keys are percent */
```

Color: neutral ramp `--global-color-base-0…10` (light → dark), hue ramps (`accent`, `red`, …) run `1…5` with `3` the mid/base hue. Where numbers don't describe the value, use semantic role keys: z-index (`base, dropdown, sticky, overlay, modal, toast, tooltip`), motion (`duration-fast/normal/slow`, `easing-out`, `easing-in-out`), line-height and letter-spacing (`title/text/label`), font-weight (`regular/medium/bold`), shadow/blur (`1…3`, elevation roles), and `radius-full` (pill) — all exempt from the factual rule.

## CSS wiring

### Files, layers, scaffold

```
styles/
  tokens/
    global.css     /* all global tokens on :root */
    theme.css      /* theme tokens on :root + mode overrides */
  components/…     /* component tokens live with their component's CSS */
```

For a new project, copy `assets/global.css` and `assets/theme.css` from this skill as the starting scaffold, then **prune whole categories the design doesn't use and retune values** — the scaffold is the sanctioned starting breadth. When there is no design yet, keep the scaffold as-is and prune what remains unreferenced once the first real components exist. The no-speculation rule applies to what you *add* afterwards: never invent tokens, scale steps, or states ahead of a real use. Scaffold-shipped per-state tokens (hover/active/disabled) follow the same logic — once the component exists, consume them with matching selectors or prune them. Optionally order with `@layer tokens, components;`.

### Modes = re-assigning theme tokens per scope

A mode is a theme token picking a different global depending on context. Custom properties inherit, so an attribute on any element re-themes that subtree — modes are scoped for free:

```css
:root {
	color-scheme: light dark;
	--theme-surface-page: var(--global-color-base-0);
	--theme-text-default: var(--global-color-base-9);
}

[data-theme='dark'] {
	color-scheme: dark;
	--theme-surface-page: var(--global-color-base-10);
	--theme-text-default: var(--global-color-base-1);
}
```

Pin `color-scheme` inside each forced-theme scope (`dark` above, `light` in a `[data-theme='light']` rule) — the `:root` value `light dark` lets the UA follow the OS, so without the pin, form controls and scrollbars ignore a forced theme.

Only theme tokens change between modes — globals and component structure stay untouched. (`light-dark()` can serve simple two-mode color cases, but re-assignment generalizes to high-contrast and other modes, so prefer it.)

CSS alone cannot read the OS preference into an attribute, so pick an activation strategy deliberately. **Default to a few lines of head JS** that set `data-theme` on `<html>` from `prefers-color-scheme` plus a stored user override — it supports an in-page toggle and keeps every dark value in one block. The CSS-only alternative (repeating the dark re-assignments inside `@media (prefers-color-scheme: dark) { :root:not([data-theme='light']) { … } }`) works when no toggle is needed, but the duplicated block must be kept in sync by hand for every new theme token — a real maintenance cost once the set grows.

### Base/page styles

Page-level rules (`body`, headings, base text) consume **theme tokens for look** and **global tokens directly for structure** — no `--component-page-*` tier is needed:

```css
body {
	background: var(--theme-surface-page);
	color: var(--theme-text-default);
	font-family: var(--global-font-family-sans);
	font-size: var(--global-font-size-16);
	line-height: var(--global-line-height-text);
}
```

"Globals are never applied directly" guards *look* (color, shadow — always via theme, so modes work); structural globals may be consumed directly wherever a component-specific token would add nothing. Typography — including `font-family` — counts as structure; route it through theme only if it actually switches on a theme mode.

### Component tokens: structure only, scoped to the component

Define component tokens on the component's root selector, aliasing globals. Color comes straight from theme tokens — per-state colors are *theme* tokens; component state selectors only re-point structure (if anything):

```css
.button {
	--component-button-radius: var(--global-radius-8);
	--component-button-padding-inline: var(--global-size-unit-16);
	--component-button-font-size: var(--global-font-size-16);

	background: var(--theme-button-primary);
	color: var(--theme-button-primary-text);
	border-radius: var(--component-button-radius);
	padding-inline: var(--component-button-padding-inline);
	font-size: var(--component-button-font-size);
	transition: background var(--global-motion-duration-fast) var(--global-motion-easing-out);
}

.button:hover:not(:disabled) {
	background: var(--theme-button-primary-hover);
}

.button:focus-visible {
	outline: var(--global-border-2) solid var(--theme-border-focus);
}

.button:disabled {
	background: var(--theme-button-primary-disabled);
	color: var(--theme-button-primary-text-disabled);
}

/* size modes: swap which globals the structural tokens point at */
.button[data-size='small'] {
	--component-button-padding-inline: var(--global-size-unit-8);
	--component-button-font-size: var(--global-font-size-14);
}
```

Guard interactive state selectors against disabled (`:hover:not(:disabled)`) — a bare `:hover` restyles disabled controls.

## Checklist when adding any styling value

1. Raw value? → Global token (or reuse one). Factual key.
2. Varies with visual mode, or is a look (color, shadow, opacity)? → Theme token aliasing a global.
3. Structural and component-specific? → Component token aliasing a global (via theme only if it switches on a theme mode).
4. Name: group-first, levels in order, minimum levels, role-based? → Done.

## Auditing an existing token set

When asked to review or audit token CSS, check every custom property against these rules and report findings ranked (breaks resolution → breaks the model → breaks the taxonomy → style), each with the token, file:line, rule name, and a suggested fix. Read-only — offer to fix on request.

- `resolution` — every `var()` reference resolves to a defined token; no cycles.
- `raw values` — no raw value outside a global token; globals alias nothing.
- `component color` — no color/look tokens under `--component-*`; looks live in theme.
- `name order` — starts with a group; level order Group → Element → Classifier → Identifier → State.
- `classifier use` — only on variant-specific appearance tokens; absent on structural tokens and single-variant components.
- `mode name in path` — no mode-as-context in any token name.
- `theme routing` — structural values alias global directly; route through theme only when they switch on a theme mode.
- `factual keys` — numeric scale keys match their values (px-equivalent names, rem values); role keys where numbers don't help.
- `role-based names` — no screen/feature/layout names (`sidebar-text`, `login-spacing` → flag).

Don't retrofit an entire existing codebase to GTC uninvited — audit and report first; migrate as a separate, agreed step.
