---
name: ui-design-prompt
description: Interactive UI design prompt builder using the TC-EBC framework. Asks targeted questions, assembles a structured prompt, then generates production-ready UI code. Use when designing new pages, components, or layouts.
---

# UI Design Prompt Builder (TC-EBC Framework)

Build a UI generation prompt with **Task, Context, Examples, Behavior, and
Constraints**, then generate the approved design.

## Linked Skills

Before generating code, read and follow:

- `/Users/merlin/Development/skills/developing-web-projects/SKILL.md`

## Step 1: Gather TC-EBC Inputs

Ask up to 5 short questions, one per missing dimension. Skip answers already
present in the request.

- **Task:** page/component/layout to build.
- **Context:** audience, product, brand, platform.
- **Examples:** URLs, screenshots, references, or style keywords.
- **Behavior:** interactions, states, responsiveness, mode support.
- **Constraints:** palette, typography, accessibility, viewport, data shape.

**Smart defaults** — if the user skips a dimension, use sensible defaults:
- Visual thesis: pick a concrete stance that fits the domain, not "clean modern"
- Macrostructure: choose a page/app shape before styling
- Typography: choose named type roles or an intentional pairing, not a fallback
  system stack unless the context already demands it
- Density: choose relaxed, balanced, or compact based on the workflow
- Motion: choose restrained, assertive, or nearly static motion on purpose
- Color: choose restrained anchors that support the thesis rather than a
  generic neutral-plus-accent recipe
- Responsive: mobile-first, works down to 320px
- Mode: light mode (add dark if requested)
- Architecture/styling/platform: whatever `developing-web-projects` specifies

If the initial request is detailed, ask only 1-2 questions.

## Step 2: Assemble the Structured Prompt

Combine the user's answers into a single structured prompt block. Format:

```
## Task
[What we're building — specific and concrete]

## Context
[Who it's for, brand/product context]

## Examples
[Reference styles, sites, screenshots — or "none specified"]

## Visual Thesis
[Macrostructure, tone, type roles, density, motion stance]

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

Pass the assembled TC-EBC prompt to the sub-agent. Require:

- read `developing-web-projects` for stack conventions
- choose and name a visual thesis before writing code
- choose macrostructure before color/components
- if references are supplied, extract structure, type roles, density, rhythm,
  color anchors, and interaction stance without cloning
- generate all pages needed for the full flow
- plain HTML and CSS only; no TypeScript, JavaScript, or Web Components
- no business logic, API calls, or state management
- include requested visual states
- use realistic content, not Lorem Ipsum
- set up a Vite project with proper file structure
- split CSS logically

The sub-agent delivers:

- Vite project scaffolding
- one HTML file per page
- shared repeated HTML where useful
- global and page/section CSS files
- `DESIGN.md` with macrostructure, visual thesis, page map, tokens, type roles,
  density, motion stance, visual states, rejected alternatives, and anti-pattern
  notes

## Step 4: Review and Iterate

Present the generated design to the user. Ask: "Want me to adjust anything — colors, spacing, layout?"

Iterate with the same Opus sub-agent until the user is satisfied.

This skill's job ends at design approval.
