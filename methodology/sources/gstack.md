# Source Inventory: GStack

- Source URL: https://github.com/garrytan/gstack
- License: MIT
- Commit/tag/release reviewed: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Retrieved: 2026-05-22 via shallow local clone
- Reviewer: Vectrix
- Local clone/path, if any: `/tmp/external-skill-sources/gstack`

## Scope Reviewed

- `AGENTS.md`
- `investigate/SKILL.md`
- `qa/SKILL.md` (debugging and regression-test sections)

## Relevant Disciplines

- Browser QA
- Debugging and investigation
- Review
- Agent orchestration
- Learning capture
- Dispatch tiers

## Strong Ideas

- Treat debugging as an explicit routed discipline instead of an implicit fallback.
- Refuse blind fixes: investigate first, then narrow to a fix with evidence.
- Preserve artifacts for post-mortem work: repro steps, screenshots, console output,
  and regression coverage for verified fixes.
- Stop looping when the same diagnostic path is failing repeatedly; reassess or
  escalate instead of thrashing.

## Adoption Risks

High blast radius if installed wholesale: daemon/tooling assumptions, browser automation, tunneling, telemetry/update behavior, and platform-specific runtime expectations need explicit review before any adaptation.

## Re-Review Trigger

Revisit during each discipline pass and at least every six months while this project remains active.
