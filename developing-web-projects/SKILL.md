---
name: developing-web-projects
description: Use when creating websites or web applications. Enforces the user's personal web development philosophy: vanilla web, MPAs, semantic CSS, and minimal frameworks.
---

# Personal Web Development Skill

This skill represents the user's personal approach to web development.  
When active, you should default to these principles unless the user explicitly requests otherwise.

You should **not** ask many exploratory questions.  
Instead, you should confidently proceed using these defaults, just as the user would.

---

## Architecture Philosophy

### Multi Page Applications (MPA)
- Prefer **Multi Page Applications**, not Single Page Applications.
- Each page is a real HTML document.
- Navigation uses standard browser navigation.
- Use **CSS View Transitions API** to create smooth transitions between pages where appropriate.
- Avoid client-side routers and SPA frameworks.

If the user asks for an "app", assume MPA unless explicitly requesting an SPA.

---

## Styling (CSS)
- Use **plain CSS**, not Tailwind.
- Use CSS as a semantic styling language:
  - Clear, descriptive class names
  - No utility-class soup
- Prefer modern CSS features:
  - Nesting
  - `:has()`
  - Container queries
  - Logical properties
  - Modern selectors
- Keep styles readable and maintainable.
- Avoid CSS-in-JS.

---

## Optional Skill Delegation

If the work involves **Web Components**, use the dedicated skill:

- `generating-web-components/SKILL.md`

That skill is the source of truth for the base component, decorators, file structure, and examples. Only apply it when the task actually includes Web Components.

Unless the user explicitly asks not to, create tests and run them. For test coverage standards and tooling, also use:

- `enforcing-test-coverage-vitest-playwright/SKILL.md`

## TypeScript Preferences
- TypeScript is the default
- Avoid `any`
- Prefer explicit types
- Favor clarity over cleverness
- Prefer small, readable files
- No massive abstractions unless justified

## Indentation

For new projects, always use tabs (width 4) for indentation. Otherwise follow the existing project style. If in doubt, use tabs.

---

## Default Behavior When Starting Projects

When the user asks to build a new site/app/tool:

You should:
1. Assume MPA architecture
2. Scaffold files following the user's conventions
3. Use vanilla browser APIs by default
4. Only introduce frameworks if the user explicitly asks

Do **not**:
- Suggest React/Vue/Svelte automatically
- Introduce Tailwind
- Introduce SPA routers
- Over-engineer architecture

Proceed as if you are implementing *your own project* using the user's style.

---

## Tone & Approach
- Act like a senior engineer who understands the user's philosophy
- Be confident and opinionated
- Avoid excessive caveats
- Favor clean, pragmatic solutions

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

When the user says things like:
- “Start a new project”
- “Build a web app”
- “Create a tool”
- “Design an architecture”

You should automatically assume:
- Cloudflare Pages (frontend)
- Cloudflare Workers (backend)
- And add only the Cloudflare services that are actually needed.

If the work involves Cloudflare implementation or architecture decisions, also use:

- `architecting-cloudflare-systems/SKILL.md`

---

## Monorepo Defaults (PNPM, no Nx)

If the user asks for a monorepo — or if a monorepo is clearly beneficial — default to:

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

---

## Default Assumption Policy

You should proceed with these defaults confidently:

- Assume Cloudflare unless told otherwise  
- Assume PNPM workspaces for monorepos  
- Assume MPA architecture  
- Assume semantic CSS  
- Assume vanilla browser APIs  

It is **always acceptable to ask clarifying questions** when:
- Requirements are ambiguous
- A decision meaningfully affects architecture
- There are conflicting constraints

However, avoid questions like:
- “What platform are we using?”
- “Do you want a monorepo?”
- “Should we use Cloudflare?”
when the defaults above already answer those.

Proceed by default. Ask only when clarity is genuinely needed.
