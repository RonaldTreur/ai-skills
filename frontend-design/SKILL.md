---
name: frontend-design
description: "Explore and refine visual frontend direction for web apps, dashboards, landing pages, and UI-heavy features. Use when a project needs UI design concepts, GStack-style divergent variants, visual thesis, prototype comparison, or frontend design approval before implementation."
---

# Frontend Design

Use this skill when a project has a visual frontend and needs a deliberate UI
direction before implementation.

This skill owns visual frontend exploration and approval. It does not own
overall product kickoff, backend architecture, issue decomposition, or active
implementation.

## Related Skills

- [[project-kickoff]] detects whether a project has a visual frontend and routes
  here when needed.
- [[developing-web-projects]] owns web stack and implementation conventions.
- [[browser-qa]] owns real browser verification of prototypes.
- [[project-manager]] consumes approved design artifacts later for issue slicing.

## Core Idea

Use the GStack `design-shotgun` pattern locally:

1. Understand the design context.
2. Generate meaningfully divergent variants.
3. Compare them side by side.
4. Capture structured feedback.
5. Iterate until one direction is approved.
6. Save the approved design as durable project context.

The goal is not "two versions of the same page." The goal is to expose real
tradeoffs in information architecture, density, hierarchy, tone, and visual
language.

## When To Use

Use for:

- landing pages
- web apps
- dashboards
- admin panels
- product websites
- UI-heavy feature redesigns
- companion web UIs for bot/backend projects

Do not use for:

- Discord bot-only interaction design
- backend-only tools
- API design
- implementation after design approval
- tiny copy or CSS tweaks where no design direction is being chosen

## Context Detection

Before generating variants, inspect:

- `BRIEF.md`, `DECISIONS.md`, and existing `DESIGN.md`
- brand assets, logos, screenshots, or product imagery
- existing CSS variables, design tokens, component patterns, or UI docs
- user audience, workflow frequency, data density, and device context
- comparable products or visual references supplied by the user

Classify the design situation:

- **Existing system**: follow it; variants explore layout, flow, and emphasis.
- **Partial system**: preserve known constraints; use variants to fill gaps.
- **Greenfield**: variants should diverge strongly.
- **Ambiguous**: ask one concise question with a recommended default.

## Visual Thesis

Before building prototype files, write a short thesis for each concept:

- **Visual thesis**: mood, material, density, and energy.
- **Content plan**: what appears first, what gets detail, what can be omitted.
- **Interaction plan**: navigation model, key states, and meaningful motion.

For greenfield work, do not default to generic SaaS design. Pick a direction
that fits the domain.

## Divergent Variants

Generate two variants by default. Use one variant plus critique for small or
heavily constrained work. Use three only when the choice space is genuinely
wide.

Variants must differ in at least two of:

- information architecture
- page/layout strategy
- visual language
- density and scanning model
- navigation model
- interaction emphasis
- content hierarchy

Anti-convergence rule:

- If the user could swap the headline text between variants and they would still
  feel like the same design, regenerate one direction before review.

## Prototype Shape

For kickoff prototypes, plain HTML and CSS are enough. Add JavaScript only when
needed to demonstrate interaction states.

Typical folder shape:

```text
<project>/
  design-a/
    index.html
    styles.css
    DESIGN.md
  design-b/
    index.html
    styles.css
    DESIGN.md
```

Each variant should include:

- key pages or views linked through real navigation
- realistic content, not filler
- empty, loading, error, and permission states when relevant
- mobile and desktop responsive behavior
- `DESIGN.md` with thesis, rationale, palette, typography, layout, states, and
  tradeoffs

## Browser Review

Start the preview and inspect variants in a browser before asking the user to
choose.

Check:

- first screen communicates product and primary action
- hierarchy is scan-friendly
- text fits without overlap
- responsive layouts hold up
- contrast and focus states are acceptable
- console has no relevant errors

Use [[browser-qa]] when the prototype includes meaningful interaction or
responsive behavior.

## Feedback Loop

Capture user feedback in:

```text
<project>/context/round-N-feedback.md
```

Use this structure:

```markdown
# Round N Feedback

## Keep
[What should survive.]

## Change
[What needs to move.]

## Reject
[What should not return.]

## Direction
[The next-round thesis.]
```

Iteration rules:

- confirm your understanding before applying broad feedback
- iterate existing designs instead of restarting by default
- show what changed and why
- stop when the user approves a direction or explicitly asks for another round

## Finalize

When the user picks a winner:

1. Move the winning design to `<project>/src/` or the project-specific approved
   prototype location.
2. Move its `DESIGN.md` to `<project>/DESIGN.md`.
3. Remove temporary design folders and stale context files.
4. Update `DECISIONS.md` with design choices and rejected alternatives.

The approved design becomes input for [[project-kickoff]] Phase 3 or
[[project-manager]] issue decomposition, depending on where the project is in
the lifecycle.
