---
name: generating-web-components
description: Use when generating new Web Components. Produces ready-to-drop-in component folders that exactly follow the user's real BaseComponentElement, decorators, conventions, and example patterns.
---

# Web Component Generator Skill

This skill is a focused production tool for generating Web Components that match the user's real codebase with high fidelity.

When this skill is active:
- Prioritize correctness over discussion
- Do not explore alternatives unless explicitly asked
- Do not invent APIs
- Do not introduce frameworks
- Do not ask many questions

Behave like a senior engineer generating components inside this exact codebase.

## Authoritative Sources (Must Be Used)

This skill folder includes real implementation files. They are the only source of truth:

- `base-component.ts`
  - Defines the real `BaseComponentElement`
  - Defines the real decorators:
    - `@customElement`
    - `@bindTemplateElement`
    - `@bindAttribute`
  - Defines lifecycle expectations and constructor usage
  - You must not invent additional decorators or APIs

- `examples/staratlas-profile/`
  - A real production component
  - Represents the canonical reference for:
    - File naming
    - Folder structure
    - Template usage
    - CSS structure
    - TypeScript style
    - Binding patterns
    - Method naming (e.g. `setProfileData`)
    - Render logic patterns

If unsure, copy patterns from the example rather than guessing.

## Required Architecture Pattern

Every generated component must:

- Extend `BaseComponentElement`
- Use `@customElement('tag-name')`
- Call `super(template, style)` in the constructor
- Import:
  - HTML via `?raw`
  - CSS via `?inline`
- Bind DOM elements using `@bindTemplateElement('#selector')`
- Implement:
  - `protected render(): void`
- Store state in private fields
- Expose explicit setter methods (e.g. `setData(...)`) rather than reactive frameworks.

Do not:

- override `connectedCallback()` unless unavoidable
- introduce reactivity systems
- introduce frameworks such as Lit, React, or Vue
- introduce templating libraries

## Decorators (Required, API-locked)

Use only the decorators defined in `base-component.ts`.

- `@customElement('tag-name')`: registers every component class.
- `@bindTemplateElement('#selector')`: used on class fields; selector resolves inside the component ShadowRoot; fields initialize to `null` and use precise types such as `HTMLElement | null`, `HTMLImageElement | null`, or `HTMLTemplateElement | null`.

Example pattern (mirror this style):

```ts
@bindTemplateElement('#profile-name')
private profileNameEl: HTMLElement | null = null;
```

- `@bindAttribute('attr-name', { type, required })`: optional; use only when attributes are genuinely part of the component API; apply to accessors, not fields; use the correct `AttributeType`; do not invent behavior beyond `base-component.ts`.

Never use legacy decorator syntax.  
This codebase uses the official 2023-11 decorators model.

## Mandatory Component Structure

Every generated component must output:

```
<component-name>/
  <prefix>-<name>.ts
  <prefix>-<name>.html
  <prefix>-<name>.css
  index.ts
```

Follow the example component for:

- Prefix conventions (`astral-`, `staratlas-`, etc.)
- Folder naming
- File naming
- Export style in `index.ts`
- Import structure in the TS file

The output must be **ready to drop into a real project**.

## File Responsibilities

### `<prefix>-<name>.ts`

- Contains:
  - class definition
  - bindings
  - state
  - logic
- Must:
  - Extend `BaseComponentElement`
  - Use decorators correctly
  - Follow the example’s import style
- Keep files small and readable (roughly 100–400 lines preferred)
- Avoid inline HTML/CSS

### `<prefix>-<name>.html`

- Contains:
  - semantic markup
  - structural layout
  - `<template>` blocks for repeated UI fragments
- Prefer templates over string-built DOM
- Use IDs and class naming patterns similar to the example

### `<prefix>-<name>.css`

- Semantic class names
- No Tailwind / no utility-class soup
- Modern CSS allowed (nesting, etc.)
- Mirrors the structure style of the example

### `index.ts`

- Re-exports the component
- Consumers import the folder, not internal files

## Rendering Model

Assume:

- Components are typically:
  - constructed
  - connected once
  - rendered once
- Data is passed via explicit setter methods (e.g. `setProfileData(...)`)
- This is **not** a reactive framework architecture

However:
- It is acceptable to include defensive clearing for dynamic lists:
  - `container.innerHTML = ''` before appending
- Do this pragmatically and quietly without introducing architectural changes

Do not introduce reactive state systems, observers, signals, stores, or render loops.

## Output Style Expectations

When generating components:

- Provide:
  - The folder structure
  - Full contents of all files
- Keep explanations minimal
- Prioritize production-ready output
- Match the tone and style of real-world project code

This skill is a **generator**, not a tutor.
