# Frontend Design Provenance

This document records the source material and local decisions that shaped
`frontend-design/SKILL.md`.

## Rebuild Recipe

Keep these behaviors:

1. Own visual frontend exploration separately from project kickoff.
2. Use divergent design variants when visual direction is undecided.
3. Start from context detection and a visual thesis.
4. Compare variants, collect structured feedback, and iterate.
5. Provide shareable preview URLs when practical so review works from another
   computer.
6. Save the approved design as durable project context.

## Local Decisions

### Shareable Design Review

- Date: 2026-05-25
- Source: local workflow discussion

Design variants must be reviewable from another computer when practical.
Localhost-only previews are acceptable for agent/browser inspection, but they
are not enough for human design selection unless the reviewer is on the same
machine.

Local adaptation:

- Prefer the project's existing preview/deploy mechanism.
- Use Cloudflare Pages previews for Cloudflare-first static prototypes when
  available.
- Use temporary tunnels only with explicit approval and safe prototype content.
- Treat screenshots or video as fallback evidence when remote preview is
  blocked, not as an equivalent review surface.

## Source Influence

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `design-shotgun/SKILL.md`, `design-html/SKILL.md`,
  `plan-design-review/SKILL.md`
- License: MIT

What we took:

- Generate multiple divergent variants.
- Use an anti-convergence rule so variants expose real taste and product
  tradeoffs.
- Show variants, collect structured feedback, iterate, and save an approval
  artifact.

Local adaptation:

- Kept the design-shotgun behavior but removed GStack runtime preambles,
  telemetry, home-directory artifact stores, generated command wrappers, and
  design binary assumptions.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-frontend-design.md`
- License: MIT

What we took:

- Detect existing design systems before inventing a new one.
- Write a visual thesis before building.
- Verify visually before claiming design quality.

Local adaptation:

- Added context classification, thesis checkpoints, browser review, and
  project-kickoff/project-manager boundaries.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/subagent-driven-development/SKILL.md`
- License: MIT

What we took:

- Design variant workers need bounded context, clear output paths, and expected
  artifacts.

Local adaptation:

- Variant generation is framed as focused artifact production, not an
  implementation execution pipeline.

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/engineering/grill-with-docs/SKILL.md`
- License: MIT

What we took:

- Ask only when taste, domain language, or product direction needs human
  judgment.

Local adaptation:

- The skill asks concise checkpoint questions for ambiguous design direction,
  while project kickoff keeps broader domain grilling.

## Formal Trail

- `methodology/disciplines/project-kickoff.md`
- `methodology/ADAPTATION_LOG.md`
