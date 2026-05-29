---
name: frontend-design
description: "Explore and refine visual frontend direction for web apps, dashboards, landing pages, and UI-heavy features through concepts, variants, prototypes, and approval."
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
- [[agent-delegation]] owns delegation mechanics when variant or critique agents
  are used.

## Core Idea

Use a divergent-variant workflow:

1. Understand the design context.
2. Generate meaningfully divergent variants.
3. Compare them side by side.
4. Publish or expose a shareable preview when practical.
5. Capture structured feedback.
6. Iterate until one direction is approved.
7. Save the approved design as durable project context.

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

## Design Inputs

Before building variants, make sure these inputs are clear enough to design
from. This is an appropriate phase to ask taste, reference, and workflow
questions that would materially change the design direction; resolve them here
so implementation agents can work from `DESIGN.md` later.

- **Task**: page type, component, layout, or flow being designed.
- **Context**: product, audience, brand tone, workflow frequency, and device
  priorities.
- **Examples**: reference sites, screenshots, product imagery, or styles to
  match or avoid.
- **Behavior**: interactions, states, responsive requirements, permissions, and
  meaningful motion.
- **Constraints**: existing palette, typography, accessibility target, data
  density, framework/project conventions, and hard boundaries.

When the user has already provided an input, use it. When an input is missing
but inferable from project context, record the inference in the variant thesis
instead of asking.

If multiple inputs are missing, group them into one design-discovery checkpoint
with recommended defaults. Avoid low-value preference surveys; ask questions
that change macrostructure, density, content hierarchy, interaction stance,
visual tone, or non-goals.

Use TC-EBC as the compact input frame when preparing a design brief, variant
brief, or prompt for a design worker:

- **Task**: the exact page, component, layout, or flow.
- **Context**: audience, product, brand, platform, and workflow frequency.
- **Examples**: references, screenshots, sites, or styles to match or avoid.
- **Behavior**: interactions, states, responsive behavior, permissions, and
  motion.
- **Constraints**: stack, accessibility, data shape, existing tokens, viewport,
  and hard boundaries.

When a worker or external tool needs a prompt, assemble it from these inputs
plus the chosen macrostructure, visual thesis, content plan, and interaction
plan. The prompt is an execution artifact; it does not replace `DESIGN.md` or
human approval of the direction.

## Visual Thesis

Before building prototype files, write a short thesis for each concept:

- **Macrostructure**: the page or app shape chosen before palette, components,
  or decoration.
- **Visual thesis**: mood, material, density, and energy.
- **Content plan**: what appears first, what gets detail, what can be omitted.
- **Interaction plan**: navigation model, key states, and meaningful motion.

For greenfield work, do not default to generic SaaS design. Pick a direction
that fits the domain.

Macrostructure-first rule:

- Pick the surface shape before choosing color, card style, or component polish.
- Name the shape explicitly in the variant thesis so tradeoffs stay legible.
- Useful starting shapes: **workbench** for tool-first flows,
  **index-first** for navigation-heavy surfaces, **catalogue** for browse and
  compare, **long document** for editorial rhythm, **stat-led** for KPI-first
  scan order, **component playground** for state comparison, and
  **manifesto/letter** for voice-led pages.

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

Anti-AI-design gates:

- Reject default SaaS hero-plus-feature-grid composition unless the product
  genuinely needs it.
- Do not fall back to three-card feature rows by reflex.
- Avoid fake browser chrome, emoji feature icons, invented proof, gradient text
  as the whole idea, nested cards with no information value, token freelancing,
  and unreadable mobile CTAs.

If a concept trips two or more gates, redesign it before review instead of
adding polish to a weak structure.

## Reference Study

When the user provides a screenshot, website, or visual reference, study it for
design DNA rather than cloning pixels.

Extract:

- structure and macrostructure
- type roles and hierarchy
- density and whitespace rhythm
- color anchors and restraint
- interaction stance such as playful, quiet, tactile, editorial, or operational

Then state:

- what to preserve
- what to translate into the local product context
- what to avoid copying literally

Good adaptation preserves stance and structure while changing content,
constraints, and implementation details to fit the actual project.

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
- enough pages or states to judge the full relevant user flow, not just one
  attractive screen
- realistic content, not filler
- empty, loading, error, and permission states when relevant
- mobile and desktop responsive behavior
- `DESIGN.md` with macrostructure, visual thesis, page map, tokens, type roles,
  density, motion stance, states, applied constraints, rejected alternatives,
  and anti-pattern notes

Prototype CSS discipline:

- Prototype only the pages, components, and states that the variant actually
  renders.
- Do not pad prototypes with speculative selectors, future states, or unused
  token definitions.
- Keep selectors semantic and tied to the rendered structure so later pruning is
  straightforward.
- In `DESIGN.md`, preserve the chosen tokens, state inventory, and any styling
  anti-patterns or rejected directions so implementation can extend or prune the
  CSS without guessing intent.

## Shareable Preview

Human review must be possible from another computer. Do not assume `localhost`
is enough.

Before asking the user to choose a direction, publish or expose the variants
through a shareable preview URL when practical:

- prefer the project's existing preview or deploy mechanism
- for Cloudflare-first static prototypes, use a Cloudflare Pages preview or
  branch deployment when available
- for other stacks, use the repository's normal preview environment
- use a temporary tunnel only when the user approves and the content is safe to
  expose
- if remote preview is blocked, state the blocker and provide screenshots or
  video as a fallback; do not treat that as equivalent to hands-on review

Preview safety:

- use static or sanitized prototype data
- do not publish secrets, personal sessions, production data, private tokens, or
  internal-only URLs
- keep design variants accessible until feedback or approval is complete
- include direct links to each variant and, when possible, a comparison page

## Browser Review

Start the preview and inspect variants in a browser before asking the user to
choose. When a shareable preview exists, inspect that URL too; a local-only pass
does not prove the review link works.

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
