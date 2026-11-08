---
name: code-review
description: Review code changes for architecture, security, quality, and convention compliance. Use after implementing features, before merging PRs, or when auditing an existing codebase.
---

# Code Review Skill

Opinionated review workflow for TypeScript-first projects. [[testing]] owns
coverage expectations; this skill enforces the project's conventions, and
[[developing-web-projects]] for web projects.

## Review Posture

- Prefer incremental refactors over rewrites.
- Do not auto-fix without approval.
- Include exploitability and impact for security findings.
- Separate review axes: **spec compliance**, **repo standards**, and **risk/quality**. A pass on one axis does not excuse a miss on another.
- Scale review depth with risk. Small isolated diffs get a focused pass; auth, data, migrations, public APIs, shell execution, LLM output handling, and broad refactors get a deeper pass.
- Watch for **layering over symptoms**: repeated narrow patches, geometric/event hacks, defensive conditionals, or duplicated interaction logic that mask the real cause. When you see it, say so and recommend backing up to the last clean design point before more fixes pile on.

## Evidence Rules

Report only findings anchored to code or the governing spec/standard.

Every finding needs:

- `file:line` or the closest precise anchor
- concrete failure mode or violated requirement
- why it matters
- smallest useful fix

Suppress speculative best-practice notes, unchanged pre-existing issues unless the diff worsens them, style-only preferences not backed by project standards, and findings already addressed elsewhere in the diff.

## Workflow

1. **Preflight context**: identify review range, spec source, standards sources, entry points, critical paths, and test coverage. If tests or `TEST_PLAN.md` coverage are missing for risky behavior, flag at least **P1**.
2. **Critical-first scan**: check security/auth gaps, data loss, unsafe migrations, public API breaks, command injection, secret exposure, LLM or external-output trust boundaries, concurrency/race/TOCTOU bugs, incomplete enum handling, impossible states, and missing negative-path tests.
3. **Spec compliance**: read the issue, PR description, ticket, design doc, or user request. Verify every acceptance criterion. Flag missing, incomplete, or divergent behavior as at least **P1**. Preserve intent, not just literal wording; if the spec references prior feedback, check that context too.
4. **Architecture and conventions**: check SOLID concerns (checklist: `references/architecture.md`) and enforce [[developing-web-projects]]. Propose incremental refactors with risk/benefit.
5. **Removal candidates**: find unused imports, dead code paths, redundant abstractions, and expired feature-flag branches. Classify as safe-delete-now or defer-with-plan (plan shape: `references/removal-plan.md`).
6. **Security and reliability**: check XSS, injection, auth/authz, secret exposure, race/TOCTOU, and CSRF (checklist: `references/security.md`; for Workers, bindings or edge config also `references/cloudflare.md` and [[architecting-cloudflare-systems]]). Always report exploitability, impact, and minimal mitigation.
7. **Code quality**: check error handling, performance, boundaries, TypeScript quality, CSS hygiene, and symptom-layering (checklist: `references/quality.md`). CSS findings include stale selectors, duplicate/overridden declarations, token freelancing, orphaned states, and additive-only CSS patches. For UI diffs, also check design-system drift, invented metrics/testimonials/logos, fake browser/device/IDE chrome, unreadable mobile CTAs, missing component states, and visual changes that contradict an approved `DESIGN.md`. Symptom-layering is usually **P1** when behavior changes and **P2** when it mainly adds fragility.
8. **Output**: use `templates/review-output.md`. Lead with findings, then open questions, then secondary summary. End with numbered next-step options when action is needed.

## Automated Helper

`code-review` owns review policy, severity, evidence rules, and final judgment.
When the harness or repository provides an automated review helper, run it on
every non-trivial diff as a closeout and treat its output as advisory: verify
each finding against the code and the governing spec before reporting or fixing
it. Skip it only for typo-only, comment-only, formatting-only or metadata-only
diffs.

After review-triggered fixes, rerun the smallest focused verification that can
catch regressions.

## Severity Levels

| Level | Name | Description | Action |
|-------|------|-------------|--------|
| P0 | Critical | Security vulnerability, data loss risk, correctness bug | Must block merge |
| P1 | High | Logic error, significant SOLID violation, performance regression, missing tests | Should fix before merge |
| P2 | Medium | Code smell, maintainability concern, minor convention violation | Fix in PR or follow-up |
| P3 | Low | Style, naming, minor suggestion | Optional improvement |

CSS severity guidance:

- User-visible breakage from selector/state mismatch is usually **P1** and can be **P0** if it makes the interface unusable.
- Dead, stale, or overridden CSS is usually **P2** unless it creates active behavior, cascade, or responsive-layout risk.
- Design-system drift, token freelancing, fake proof, or fake chrome in a UI diff
  is usually **P2**; raise to **P1** when it breaks approved design direction,
  accessibility, trust, or primary mobile usability.

