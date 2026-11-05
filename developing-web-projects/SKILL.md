---
name: developing-web-projects
description: "Use when creating or changing websites or web applications. Enforces the user's personal web development philosophy: vanilla web, MPAs, semantic CSS, and minimal frameworks."
---

# Personal Web Development Skill

Use the user's default web-development approach unless he explicitly requests otherwise. Do not ask many exploratory questions; proceed confidently from these defaults.

## Scope Boundary

This skill owns web implementation defaults: architecture, platform, HTML/CSS, TypeScript style, dependencies, documentation expectations, and when a web decision needs human approval.

It does not own GitHub issue sequencing, branch/PR mechanics, review gates, or long-running implementation state. Use [[project-manager]] for project lifecycle, [[implement-issue]] for active per-issue implementation, and [[documentation-handoff]] for durable docs and continuation state.

## Architecture Philosophy

### Multi Page Applications (MPA)

- Prefer **Multi Page Applications**, not Single Page Applications.
- Each page is a real HTML document.
- Navigation uses standard browser navigation.
- Use **CSS View Transitions API** to create smooth transitions between pages where appropriate.
- Avoid client-side routers and SPA frameworks.

If the user asks for an "app", assume MPA unless explicitly requesting an SPA.

## Styling (CSS)

- Use **plain CSS**, not Tailwind.
- Use CSS as a semantic styling language:
  - Clear, descriptive class names
  - No utility-class soup
- Do **not** use `reset.css`, `normalize.css`, or any global CSS reset package.
- Start from browser defaults and style deliberately from there.
- Prefer modern CSS features:
  - Nesting
  - `:has()`
  - Container queries
  - Logical properties
  - Modern selectors
- Always use `rem` and `em` over `px`.
- Keep styles readable and maintainable.
- Avoid CSS-in-JS.

CSS hygiene rules:

- CSS must be explainable from rendered markup and actual interactive states.
- Do not add speculative or future-facing selectors, states, tokens, or layout hooks that the current markup does not render.
- Prefer semantic selectors tied to page, component, and document structure over loose presentational naming.
- When markup changes, remove selectors for removed structure in the same patch.
- Treat pruning as part of CSS editing, not optional cleanup after the feature is "done".
- Review for duplicate or immediately overridden declarations while editing; do not leave additive-only CSS patches that silently stack dead rules.
- Reuse the established token system. Do not freelance new colors, spacing, or custom properties unless the design direction actually changed and the new token is used deliberately. Token structure and naming follow [[css-design-tokens]].

Design direction comes from [[frontend-design]]; implementation reuses its
`DESIGN.md` tokens, state inventory and anti-pattern notes.

## HTML First

Prefer standard HTML semantics over JS when possible. Example: use an `<a href="...">` for navigation instead of a JS click handler.

---

## Optional Skill Delegation

If the work involves **Web Components**, use the dedicated skill:

- [[generating-web-components]]

That skill is the source of truth for the base component, decorators, file structure, and examples. Only apply it when the task actually includes Web Components.

If the work involves **CSS custom properties as design tokens**: new-project styling foundations, theming/dark mode, or adding token values: use [[css-design-tokens]]. It is the source of truth for token naming, tiering (Global, Theme, Component), and the starter scaffold.

Unless the user explicitly asks not to, create tests and run them. For test coverage standards and tooling, also use:

- [[testing]] for test strategy, sequencing and CI policy

## TypeScript Preferences
- TypeScript is the default
- Avoid `any`
- Prefer explicit types
- Use single quotes for JS/TS strings by default (for example, `'text'`), unless project tooling enforces a different style
- Favor clarity over cleverness
- Prefer small, readable files
- No massive abstractions unless justified

## Indentation

For new projects, always use tabs (width 4) for indentation. Otherwise follow the existing project style. If in doubt, use tabs.

## Defaults

Assume MPA, vanilla browser APIs, semantic CSS, Cloudflare, and PNPM
workspaces for monorepos; introduce a framework, Tailwind or an SPA router only
when the user asks. Do not ask platform or monorepo questions these defaults
answer; ask when requirements are ambiguous, a decision meaningfully affects
architecture, or constraints conflict.

## Documentation & Workflow Defaults

Use [[documentation-handoff]] for README/AGENTS roles and handoff state.

- For new projects, always create `README.md` and `AGENTS.md` if they do not exist.
- For existing projects, after making changes, update `README.md` and `AGENTS.md` when those files already exist.
- Treat `README.md` as documentation for humans.
- Treat `AGENTS.md` as instructions for AI assistants.
- For standalone web implementation requests, provide a short outline before editing and wait for approval.
- Inside an approved [[implement-issue]] run, the short outline is a checkpoint/status update rather than a blocking approval request unless the work would deviate from these web defaults or change user-visible scope beyond the issue/spec.

---

## Platform Defaults: Cloudflare-first

By default, the user builds new projects on **Cloudflare’s ecosystem**.

Unless the user explicitly requests otherwise, you must assume a **Cloudflare-native architecture** and choose Cloudflare services first.

- Do **not** suggest Vercel, Netlify, AWS, GCP, or traditional servers by default.
- Do **not** propose Dockerized backends unless explicitly asked.
- If multiple Cloudflare options exist, choose the simplest service that fits the requirements.
- Only deviate from Cloudflare when:
  - The user explicitly requests another platform, or
  - The requirements truly cannot be met on Cloudflare (rare).  
In such cases, explain the smallest possible deviation.

For new projects, web apps, tools, and architecture requests, assume Cloudflare Pages for frontend, Cloudflare Workers for backend, and only the additional Cloudflare services actually needed.

If the work involves Cloudflare implementation or architecture decisions, also use:

- [[architecting-cloudflare-systems]]

---

## Monorepo Defaults (PNPM, no Nx)

If the user asks for a monorepo, or one is clearly beneficial, default to:

- Package manager: **PNPM**
- Workspace system: **pnpm workspaces**
- Tooling: **minimal**, no Nx unless explicitly requested

Rules:
- Do **not** introduce Nx by default.
- Only use Nx if:
  - The user explicitly asks for Nx, or
  - The user gives constraints that strongly imply Nx-style orchestration.
- Prefer:
  - simple workspace scripts
  - shared packages
  - clear folder boundaries
over heavy tooling.

Default structure suggestion (adapt when appropriate):

```
/apps
  /web        (Pages frontend)
  /api        (Workers backend)
/packages
  /ui
  /types
  /utils
  /config
```
