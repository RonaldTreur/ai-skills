# Phase 2: Visual Frontend Design

## Goal

Route visual frontend work to [[frontend-design]] when the project includes a
web UI, dashboard, landing page, or other visual browser surface.

Project kickoff should detect that a visual frontend is needed and preserve the
resulting approved design artifact. It should not duplicate the frontend design
workflow.

## When This Phase Applies

Use this phase for:

- websites
- web apps
- dashboards
- admin panels
- landing pages
- companion web UIs for bot/backend projects
- UI-heavy browser tools

Skip this phase for:

- Discord bot-only projects
- backend-only services
- CLI-only tools
- pure API work
- automation with no visual frontend

For non-visual projects, use the relevant interaction/artifact design phase
instead, such as [[phases/phase-2-design-discord]].

## Inputs

Before invoking [[frontend-design]], make sure these exist:

- `<project>/BRIEF.md`
- `<project>/DECISIONS.md`
- any brand assets, sketches, screenshots, or reference links already provided
- any existing design system files if the project is not greenfield

## Delegation

Invoke [[frontend-design]] with:

```text
Project kickoff has approved the functional brief and this project needs a
visual frontend design.

Read:
1. <project>/BRIEF.md
2. <project>/DECISIONS.md
3. any existing brand/design assets in <project>/

Produce an approved visual frontend direction using your divergent-variant
workflow. Save the approved output as:
- <project>/DESIGN.md
- <project>/src/ or the approved prototype location
- shareable preview URLs for variant review when practical, with any blocker
  and fallback noted
- DECISIONS.md updates for chosen/rejected design directions

The approved `DESIGN.md` must preserve:

- chosen macrostructure and why it fits
- visual thesis and interaction stance
- tokens/color anchors and type roles
- density and motion stance
- rejected alternatives
- anti-patterns or do-not-repeat notes discovered during review
```

## Exit Condition

This phase is complete when [[frontend-design]] has produced an approved
`DESIGN.md` and prototype/design artifact suitable for Phase 3 planning.
