# Phase 3: Implementation Guardrails

## Goal

Produce an approved `PLAN.md` that gives [[project-manager]] enough structure to
set up the project and decompose implementation work without freezing brittle
code-level choreography too early.

## Prerequisites

- Approved `BRIEF.md`
- Approved `DESIGN.md`
- `src/` for web prototypes or `docs/` for bot interaction artifacts
- Current `DECISIONS.md`
- [[developing-web-projects]] for web projects

## 1. Draft The Plan

Draft `PLAN.md` from `BRIEF.md`, `DESIGN.md`, `DECISIONS.md` and `src/` or
`docs/`, covering:

- architecture and platform fit
- data model and integrations
- work units with stable IDs
- likely files/areas
- dependency ordering
- test scenarios and browser-QA needs
- risks, unknowns, and setup blockers
- explicit non-goals

## 2. Critique And Resolve

For a large or risky project, obtain the critique described under Independent
Critique in `SKILL.md` (architecture and platform fit, scope and sequencing,
design-to-implementation risk, testability and operations). Compare draft and
critique by decision quality, not volume: where they agree, where they
disagree, the real tradeoff, which recommendation you prefer and why, and what
user choice is still needed.

If a disagreement can be resolved from `BRIEF.md`, `DESIGN.md`, existing code,
or [[developing-web-projects]], resolve it directly and record the decision.
Ask the user only for product, taste, cost, or scope choices.

## 3. `PLAN.md` Structure

Use this structure:

```markdown
# [Project Name] - Implementation Plan

## Goal
[One paragraph.]

## Guardrails
[Decisions, constraints, non-goals, and quality bars.]

## Architecture
[High-level structure and platform choices.]

## Data And Integrations
[Entities, persistence, APIs, queues, auth, external systems.]

## Work Units

### U1 - [Stable unit name]
- **Outcome:** [What is true when complete.]
- **Scope:** [Included work.]
- **Likely files/areas:** [Paths or areas, not brittle line-by-line changes.]
- **Dependencies:** [Other U-IDs or setup work.]
- **Tests:** [Unit, integration, E2E, browser QA, manual verification.]
- **Risks:** [Known risks and mitigations.]

## Setup And Readiness
[Repo, CI, scripts, safe auth/test data, seed/reset, preview, deployment.]

## Test Strategy
[What [[testing]] should turn into TEST_PLAN.md.]

## Issue Decomposition Notes
[How [[project-manager]] should slice issues and what must happen first.]

## Open Questions
[Remaining questions, recommended default, and owner.]
```

## 4. Update `DECISIONS.md`

Record:

- architecture choices
- dependency decisions
- data model decisions
- design-to-implementation tradeoffs
- rejected plan alternatives
- user steering

## 5. Final Approval

The phase exits when the user approves `PLAN.md`.

Do not hand directly to implementation; hand off to [[project-manager]] as in
`SKILL.md`.
