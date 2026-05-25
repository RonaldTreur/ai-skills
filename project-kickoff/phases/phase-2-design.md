# Phase 2: Web UI Design

## Goal

Explore meaningfully different UI directions, iterate with user feedback, and
promote one approved design to `src/` with `DESIGN.md`.

## Prerequisites

- Approved `BRIEF.md`
- Current `DECISIONS.md`
- [[developing-web-projects]]
- Browser tooling sufficient to preview prototypes

## 1. Design Context Detection

Before generating designs, inspect for existing design constraints:

- brand assets, logos, product screenshots, or imagery
- existing `DESIGN.md`, CSS variables, tokens, component patterns, or UI docs
- target audience and work context from `BRIEF.md`
- comparable products or visual references supplied by the user

Classify the design situation:

- **Existing system**: follow it; variants explore layout/flow rather than new
  visual identity.
- **Partial system**: preserve known constraints; use variants to fill gaps.
- **Greenfield**: variants should diverge strongly.
- **Ambiguous**: ask one concise question with a recommended default.

## 2. Thesis Checkpoint

Before writing prototype files, define:

- **Visual thesis**: mood, material, density, and energy.
- **Content plan**: what appears first, what gets detail, what can be omitted.
- **Interaction plan**: navigation model, key states, and meaningful motion.

If using two competing designs, each concept needs its own thesis. The concepts
must not be cosmetic siblings.

## 3. Prototype Setup

For web applications, scaffold a lightweight preview:

```text
<project>/
  package.json
  vite.config.ts
  design-a/
    index.html
  design-b/
    index.html
```

Use the project's conventions where they exist. For new local prototypes, plain
HTML and CSS are enough; only add JavaScript when it is needed to demonstrate
interaction states.

## 4. Initial Designs

Generate two designs only when the decision benefits from comparison. For small
or heavily constrained projects, one design plus critique may be enough.

Each design folder should include:

- navigable HTML for key pages or views
- CSS split only as much as clarity requires
- realistic content, not placeholder filler
- important empty, loading, error, and permission states
- responsive behavior for mobile and desktop
- `DESIGN.md` with thesis, rationale, palette, typography, layout, states, and
  tradeoffs

Anti-convergence rule:

- Design A and Design B should differ in product framing, layout strategy,
  visual language, interaction density, or information architecture.
- If the user could swap the headline text between them and they still feel like
  the same design, regenerate one direction before review.

## 5. Browser Review

Start the preview server and inspect both designs in a browser.

Before asking the user to choose, check:

- first screen communicates the product and primary action
- hierarchy is scan-friendly
- responsive layouts do not collapse awkwardly
- text fits and does not overlap
- contrast and focus states are acceptable
- console has no relevant errors

Use [[browser-qa]] for a focused pass when the prototype has interactive or
responsive behavior worth verifying.

## 6. Feedback Loop

Capture user feedback in:

```text
<project>/context/round-N-feedback.md
```

Structure:

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

- Iterate existing designs; do not restart unless the concept is rejected.
- Show what changed and why.
- Confirm your understanding of feedback before saving final approval.
- Stop when the user chooses a winner or explicitly asks for another round.

## 7. Finalize

When the user picks a winner:

1. Move the winning design to `<project>/src/`.
2. Move its `DESIGN.md` to `<project>/DESIGN.md`.
3. Remove temporary design folders and stale context files.
4. Update `DECISIONS.md` with design choices and rejected alternatives.
5. Leave the project previewable for Phase 3 planning.
