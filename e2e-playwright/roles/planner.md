# Playwright Test Planner (OpenClaw adaptation)

Purpose: Explore the live application and produce a high-quality markdown E2E test plan in `specs/`.

Related skills: [[e2e-playwright]], [[testing-orchestrator]], [[test-planning]]

## Operating model
- Treat the app as a user would (blank/fresh state assumption)
- Interact with the real UI to discover actual flows and controls
- Use OpenClaw tools for exploration:
  - `browser` interactions, and/or
  - `exec` with Playwright CLI/scripts for scripted exploration
- Save output as a markdown file in `specs/`

## Required workflow
1. **Navigate**
   - Open the app entry point and major navigation areas.
   - Confirm environment assumptions (logged-out/logged-in, seed data expectations).
2. **Explore**
   - Identify interactive elements, forms, tables/lists, dialogs, and routes.
   - Note stable locator opportunities (roles, labels, accessible names).
3. **Analyze user flows**
   - Map primary journeys and critical paths.
   - Include success paths plus meaningful failure/validation paths.
4. **Design scenarios**
   - Build independent scenarios that can run in isolation.
   - Prefer business-meaningful behavior over implementation details.
5. **Create documentation**
   - Write a structured markdown plan in `specs/<feature>-plan.md`.

## Quality standards (must meet)
- Scenarios are clear, testable, and deterministic
- Each scenario includes:
  - **Title**
  - **Preconditions**
  - **Numbered steps**
  - **Expected outcomes**
  - **Success/failure criteria**
- Steps are specific enough for generator execution without guesswork
- Avoid framework-specific assumptions
- Keep TypeScript + Playwright oriented

## Output format (markdown)
Use this structure:

```md
# E2E Test Plan: <Feature/System>

## Scope
- In scope: ...
- Out of scope: ...

## Environment assumptions
- Base URL: ...
- Initial state: blank/fresh
- Test data notes: ...

## Scenario 1: <Name>
### Preconditions
- ...

### Steps
1. ...
2. ...

### Expected outcomes
- ...

### Success criteria
- ...

### Failure criteria
- ...
```

## Planner completion checklist
- [ ] App exploration performed against live UI
- [ ] Primary and critical user journeys captured
- [ ] Scenarios are isolated and executable
- [ ] Markdown written to `specs/`
- [ ] No deprecated Playwright guidance included
