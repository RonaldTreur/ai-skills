---
name: ui-design-prompt
description: Export approved UI direction into a copy-paste prompt for external UI generators or one-off design workers; do not use as the primary design workflow.
---

# UI Design Prompt Export

Export an approved or nearly-approved UI direction into a structured prompt.
This is a helper, not the primary design workflow.

Use [[frontend-design]] for product UI direction, divergent variants,
macrostructure, feedback, preview, and `DESIGN.md`. Use this skill only when the
requested output is a prompt artifact for another model/tool or a tightly
scoped one-off design worker.

## When To Use

Use for:

- turning `BRIEF.md` and `DESIGN.md` into a copy-paste prompt for an external
  UI generator
- preparing a bounded prompt for a one-off design worker
- converting a chosen design direction into a prompt that preserves constraints
- summarizing TC-EBC inputs for a small component or page when design direction
  is already settled

Do not use for:

- project kickoff
- choosing visual direction
- generating competing variants
- approval of a design
- implementation work after `DESIGN.md` is approved

## Inputs

Read existing artifacts first:

- `BRIEF.md`
- `DESIGN.md`
- `DECISIONS.md`
- relevant screenshots, references, or brand assets
- [[developing-web-projects]] when stack or implementation conventions matter

If a required input is missing, do not restart design discovery here. Either
infer from approved artifacts or route back to [[frontend-design]].

## TC-EBC Export Frame

Assemble the prompt with:

```
## Task
[What to generate, specific and bounded]

## Context
[Audience, product, workflow frequency, brand tone]

## Examples
[References to preserve, translate, or avoid]

## Visual Thesis
[Macrostructure, tone, type roles, density, motion stance, color anchors]

## Behavior
[Interactions, states, permissions, responsive rules]

## Constraints
[Stack, accessibility, data shape, viewport, existing tokens, hard boundaries]

## Output Contract
[Files, fidelity, states, prompt-only vs code, what not to invent]
```

## Output Rules

- Produce the prompt artifact only unless the user explicitly asks to run it.
- Keep approved macrostructure, visual thesis, tokens, and anti-pattern notes
  intact.
- State which source artifacts the prompt was built from.
- Mark unknowns clearly instead of inventing proof, metrics, brand assets, or
  implementation details.
- If the prompt would require choosing a new design direction, stop and route
  back to [[frontend-design]].
