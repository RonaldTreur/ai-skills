# Source Inventory: Impeccable

- Source URL: https://github.com/pbakaus/impeccable
- License: Apache-2.0
- Commit/tag/release reviewed: `1d5d745823aae7019044e8b0a621af4366dae224`
- Retrieved: 2026-06-03 and 2026-06-04
- Reviewer: Merlin
- Local clone/path, if any: `/tmp/impeccable.qMGItG`

## Scope Reviewed

- `.agents/skills/impeccable/SKILL.md`
- `.agents/skills/impeccable/reference/brand.md`
- `.agents/skills/impeccable/reference/product.md`
- `.agents/skills/impeccable/reference/audit.md`
- `.agents/skills/impeccable/reference/critique.md`
- `cli/engine/registry/antipatterns.mjs`
- `package.json`

## Relevant Disciplines

- frontend design
- browser QA
- code review
- visual anti-pattern detection

## Strong Ideas

- Brand vs product register split keeps marketing design and task-focused UI
  from sharing the same aesthetic expectations.
- Deterministic anti-pattern detection can provide evidence for visual QA and
  review when used narrowly.
- Critique/audit flows separate design judgment from measurable technical
  quality.
- Strong anti-AI-slop vocabulary catches repeated templates, weak typography,
  fake proof, gradient text, nested cards, and overused aesthetic defaults.

## Adoption Risks

- The full command surface overlaps local lifecycle skills.
- Detector findings are not always context-aware; product UI can legitimately
  use familiar fonts, restrained palettes, one family, and standard affordances.
- Live/browser overlay mode is tool-specific and injection-heavy.
- `PRODUCT.md` would duplicate local `BRIEF.md`, `DESIGN.md`, and
  `DECISIONS.md` artifacts.

## Re-Review Trigger

Revisit before making detector usage mandatory, adding a design-audit skill, or
adopting live/overlay workflows.

