# Source Inventory: GStack

- Source URL: https://github.com/garrytan/gstack
- License: MIT
- Commit/tag/release reviewed: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Retrieved: 2026-05-22 via shallow local clone; `qa/SKILL.md` re-read via raw
  GitHub at the reviewed commit on 2026-05-23
- Reviewer: Vectrix
- Local clone/path, if any: `/tmp/external-skill-sources/gstack`

## Scope Reviewed

- `AGENTS.md`
- `investigate/SKILL.md`
- `qa/SKILL.md` (debugging and regression-test sections)
- `qa/SKILL.md` (browser QA workflow, modes, defect evidence, severity, and
  report/fix boundaries)
- `review/SKILL.md`
- `review/checklist.md`
- Selected files in `review/specialists/`: API contract, data migration,
  maintainability, performance, red team, security, and testing
- `autoplan/SKILL.md`
- plan review skill family: `plan-ceo-review`, `plan-design-review`,
  `plan-devex-review`, `plan-eng-review`, `plan-tune`
- `design-shotgun/SKILL.md`
- `design-html/SKILL.md`
- selected design tooling files under `design/src/` for brief, variants,
  iteration, and feedback flow

## Relevant Disciplines

- Browser QA
- Debugging and investigation
- Review
- Agent orchestration
- Agent orchestration and delegation
- Learning capture
- Dispatch tiers

## Strong Ideas

- Treat debugging as an explicit routed discipline instead of an implicit fallback.
- Refuse blind fixes: investigate first, then narrow to a fix with evidence.
- Preserve artifacts for post-mortem work: repro steps, screenshots, console output,
  and regression coverage for verified fixes.
- Stop looping when the same diagnostic path is failing repeatedly; reassess or
  escalate instead of thrashing.
- Review critical risks before informational findings: data safety, races, LLM
  trust boundaries, shell injection, enum completeness, API contracts,
  migrations, performance, and testing.
- Suppress speculative, style-only, harmless, or already-addressed review
  comments.
- Plan-review pipelines can surface close calls and decision points before work
  proceeds.
- Design exploration benefits from divergent variants, structured feedback, and
  a clear approval artifact before finalization.

## Adoption Risks

High blast radius if installed wholesale: daemon/tooling assumptions, browser
automation, tunneling, telemetry/update behavior, generated preambles, local
session stores, and platform-specific runtime expectations need explicit review
before any adaptation.

## Re-Review Trigger

Revisit during each discipline pass and at least every six months while this project remains active.
