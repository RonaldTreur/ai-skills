---
name: ui-design-prompt
description: Interactive UI design prompt builder using the TC-EBC framework. Asks targeted questions, assembles a structured prompt, then generates production-ready UI code. Use when designing new pages, components, or layouts.
---

# UI Design Prompt Builder (TC-EBC Framework)

Generates high-quality UI code by walking the user through the **Task–Context–Examples–Behavior–Constraints** framework, then assembling a structured prompt for code generation.

## Linked Skills

This skill **defers to the user's web development conventions**. Before generating code, read and follow:

- `/Users/merlin/Development/skills/developing-web-projects/SKILL.md` — architecture, styling, platform, and tooling defaults

If the UI involves **Web Components**, also read:

Do NOT repeat conventions from that skill here. It is the source of truth.

## Step 1: Gather TC-EBC Inputs

Ask the user up to 5 questions — one per dimension. Keep them short and specific. Skip dimensions the user already answered in their initial request.

### T — Task
> What are we building? (page type, component, layout)

Examples: "analytics dashboard", "settings page", "pricing section", "login form"

### C — Context
> Who is this for? What's the product/brand?

Useful context: target audience, existing product, brand personality (playful/corporate/minimal), platform (desktop-first, mobile-first, both).

### E — Examples
> Any reference sites, screenshots, or styles to match?

Accept: URLs, screenshots (analyze with image tool), style keywords ("like Linear", "like Stripe docs", "brutalist", "glassmorphism"). If none provided, skip — don't force it.

### B — Behavior
> Any interactions, states, or responsive requirements?

Examples: hover states, modals, form validation, animations, breakpoints, dark/light mode toggle, loading states.

### C — Constraints
> Hard requirements or boundaries?

Examples: must match existing color palette, specific typography, accessibility level (WCAG AA), max viewport, specific data shape.

**Smart defaults** — if the user skips a dimension, use sensible defaults:
- Color: neutral palette with one accent color
- Typography: system font stack, rem-based scale
- Spacing: consistent scale (0.25rem increments)
- Responsive: mobile-first, works down to 320px
- Mode: light mode (add dark if requested)
- Architecture/styling/platform: whatever `developing-web-projects` specifies

**Be efficient.** If the user gives a detailed initial request, you might only need 1–2 clarifying questions. Don't ask 5 questions if the answers are obvious.

## Step 2: Assemble the Structured Prompt

Combine the user's answers into a single structured prompt block. Format:

```
## Task
[What we're building — specific and concrete]

## Context
[Who it's for, brand/product context]

## Examples
[Reference styles, sites, screenshots — or "none specified"]

## Behavior
[Interactions, states, responsive rules]

## Constraints
[Hard requirements + defaults applied]

## Technical Stack
[From developing-web-projects skill — DO NOT hardcode here, read from the linked skill]
```

Show this assembled prompt to the user for confirmation before generating. Let them tweak it.

## Step 3: Generate the UI Design

**Model:** Always spawn a sub-agent with `opus` for this step. Design is a one-time investment — getting it right matters more than saving tokens.

Pass the assembled TC-EBC prompt to the sub-agent along with instructions to:

1. Read `/Users/merlin/Development/skills/developing-web-projects/SKILL.md` for stack conventions
2. Generate **all pages** needed to fulfill the design — not just one. Think through the full user flow and create every page that's required (home, dashboard, settings, detail views, error pages, etc.)
3. **Plain HTML and CSS only** — no TypeScript, no JavaScript, no Web Components. Repeated HTML is fine; Codex will refactor into components later.
4. No business logic, no API calls, no state management — purely what it looks like
5. Include all visual states mentioned in Behavior (hover, active, loading, empty, dark/light)
6. Use realistic placeholder content (not "Lorem ipsum") so the design reads like a real product
7. Set up a **Vite project** with proper structure — pages and styles go where they belong in a real project
8. Split CSS into multiple files where it makes sense (global styles, per-page styles, component-level styles) — use good judgment

The sub-agent delivers:

### Vite project with pages
- Proper Vite project scaffolding (package.json, vite.config, etc.)
- **One HTML file per page** in the appropriate location
- Pages share common elements (nav, header, footer) — repeated HTML is fine, Codex will refactor later

### Styles
- Split CSS logically — a global stylesheet for shared styles (colors, typography, resets, layout primitives) and per-page or per-section stylesheets where it keeps things clean

### Design document
- **`DESIGN.md`** (project root) — design philosophy and decisions:
  - Overall design direction and why
  - Page map: what pages exist and their purpose
  - Color palette with rationale
  - Typography choices and scale
  - Spacing system
  - Layout decisions per page (why this grid/flex structure)
  - Navigation structure
  - Responsive strategy
  - Visual state explanations (hover, focus, loading, empty, dark/light)
  - Anything a developer implementing this later needs to understand the *intent*, not just the code

`DESIGN.md` serves as the long-term design reference. When Codex takes over implementation, it reads this file to understand the reasoning behind visual choices — so it can make consistent decisions for new pages/components without re-running this skill.

## Step 4: Review and Iterate

Present the generated design to the user. Ask: "Want me to adjust anything — colors, spacing, layout?"

Iterate with the same Opus sub-agent until the user is satisfied.

This skill's job ends at design approval.
