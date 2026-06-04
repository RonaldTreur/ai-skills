# Source Inventory: Hallmark Refresh

- Source URL: https://github.com/Nutlope/hallmark
- License: MIT
- Commit/tag/release reviewed: `df5498f7f64102f559ccd1cb693d95136dd95b97`
- Retrieved: 2026-06-03 and 2026-06-04
- Reviewer: Merlin
- Local clone/path, if any: `/tmp/hallmark.l3vnRJ`

## Scope Reviewed

- `skills/hallmark/SKILL.md`
- `skills/hallmark/references/structure.md`
- `skills/hallmark/references/macrostructures.md`
- `skills/hallmark/references/slop-test.md`
- `skills/hallmark/references/verbs/audit.md`
- selected reference indexes under `skills/hallmark/references/`
- `README.md`

## Relevant Disciplines

- frontend design
- browser QA
- code review
- component design

## Strong Ideas

- Pre-flight scans make design runs accountable to existing font, palette,
  motion, spacing, and framework signals.
- Component-scope routing avoids applying page-level machinery to small UI
  elements.
- Macrostructure-first selection creates structural variety rather than
  palette-only variation.
- Study/redesign safety rails preserve design DNA without copying pixels or
  bulldozing existing implementation boundaries.
- Mobile non-negotiables provide concrete viewport and clickable-text checks.
- Honest-copy, locked-token, and fake-chrome gates catch common AI design tells.

## Adoption Risks

- Full theme catalogue and stamp system are specific to Hallmark and can date or
  drift quickly.
- "Always ask" would add friction to the local workflow; local policy should
  keep one compact checkpoint and allow visible inference when the user says to
  proceed.
- Hallmark's command system overlaps local lifecycle skills.
- Requiring stamps or `.hallmark` state would introduce tool-specific artifacts
  into general projects.

## Re-Review Trigger

Revisit when Hallmark releases a major version, when a local project needs
theme/catalogue machinery, or if the local frontend-design skill starts
producing structurally repetitive outputs again.
