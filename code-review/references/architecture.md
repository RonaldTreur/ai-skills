# Architecture & Conventions Checklist

Use this checklist to review architecture quality and convention compliance in TypeScript/web projects.

## SOLID Checks

### SRP — Single Responsibility Principle
- Does each module/class/function do one thing?
- Flag god objects and kitchen-sink utilities.
- Flag files mixing transport, business logic, persistence, and view concerns.

### OCP — Open/Closed Principle
- Can behavior be extended without modifying core decision logic?
- Flag `switch`/`if` chains that grow with every new type.
- Prefer registry/strategy patterns where extension frequency is high.

### LSP — Liskov Substitution Principle
- Do subtypes preserve expected behavior and contracts?
- Flag overrides that narrow accepted inputs or change return guarantees unexpectedly.
- Verify error behavior remains compatible.

### ISP — Interface Segregation Principle
- Are interfaces focused on consumer needs?
- Flag broad interfaces (e.g., 10+ methods) where consumers use 2–3.
- Recommend splitting by capability.

### DIP — Dependency Inversion Principle
- Do high-level modules depend on abstractions instead of concrete implementations?
- Flag direct imports of low-level concrete adapters in orchestration logic.
- Prefer boundary interfaces + injected adapters.

## Web Convention Enforcement ([[developing-web-projects]])

### Architecture
- MPA over SPA.
- Real HTML documents for pages.
- Standard navigation via links/forms.
- No client-side router libraries.

### Framework and CSS rules
- No framework imports (React, Vue, Angular, Svelte).
- No utility CSS frameworks (Tailwind, UnoCSS).
- No CSS reset packages (`reset.css`, `normalize.css`).
- Use vanilla CSS with semantic class names.

### Web Components checks (if present)
- Shadow DOM used appropriately.
- Attribute/property behavior is explicit and consistent.
- `observedAttributes` and lifecycle callbacks are used correctly.
- Event listeners are attached/cleaned safely.

### HTML-first quality
- Semantic elements preferred over generic wrappers.
- Accessible forms and labels.
- Proper heading hierarchy.

### Modern CSS expectations
- Encourage modern features where useful:
  - Nesting
  - `:has()`
  - Container queries
  - Logical properties

## Refactor guidance
- Prefer small, low-risk, incremental refactors.
- Avoid broad rewrites unless there is a clear and immediate risk justification.
- Document tradeoffs and migration path when deferring larger cleanup.
