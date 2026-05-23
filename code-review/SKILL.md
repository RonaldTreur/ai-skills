---
name: code-review
description: Review code changes for architecture, security, quality, and convention compliance. Use after implementing features, before merging PRs, or when auditing an existing codebase.
---

# Code Review Skill

Opinionated review workflow for TypeScript-first projects.

This skill is a **quality gate**:
- [[testing-orchestrator]] verifies behavior with tests
- [[code-review]] verifies architecture, security, maintainability, and conventions
- [[developing-web-projects]] conventions are enforced during review

## Review posture

- Be direct and specific
- Prefer incremental refactors over rewrites
- Do **not** auto-fix without approval
- Always classify findings by severity (P0–P3)
- Include exploitability + impact for security findings
- Enforce project conventions from [[developing-web-projects]]
- Separate the review axes: **spec compliance**, **repo standards**, and **risk/quality**. A pass on one axis does not excuse a miss on another.
- Scale review depth with risk: small isolated diffs get a focused pass; auth, data, migrations, public APIs, shell execution, LLM output handling, and broad refactors get a deeper pass.
- Watch for **layering over symptoms**: repeated narrow patches, geometric/event hacks, defensive conditionals, or duplicated interaction logic that mask the real cause instead of fixing it
- When you detect symptom-layering, explicitly say so and recommend backing up to the last clean design point before more fixes pile on

## Evidence Rules

Report only findings you can anchor to the code or the governing spec/standard.

Every finding needs:
- `file:line` or the closest precise anchor available
- the concrete failure mode or violated requirement
- why it matters
- the smallest useful fix

Suppress:
- speculative best-practice notes without a real failure mode
- unchanged pre-existing issues unless the diff makes them worse
- style-only preferences not backed by project standards
- findings already addressed elsewhere in the diff

## Workflow

### 1) Preflight Context

Understand exactly what changed before judging quality.

Commands:
- `git status -sb`
- `git diff --stat`
- `git diff`
- `git log --oneline <base>..HEAD` when reviewing a branch
- `rg` / `grep` for related modules and dependencies

Checklist:
- Identify the base range or fixed point for the review
- Identify the spec source: issue, PR description, ticket, design doc, `TEST_PLAN.md`, or user request
- Identify standards sources: `AGENTS.md`, `README.md`, `CONTRIBUTING.md`, ADRs, package scripts, lint/test config, and relevant local skills
- Identify entry points and critical paths (auth, payments, data writes)
- Verify whether `TEST_PLAN.md` exists
- Verify tests exist for the change
- If tests or `TEST_PLAN.md` coverage are missing, flag at least **P1**

### 2) Critical-First Scan

Before broad maintainability review, look for merge-blocking risk:

- security vulnerabilities and auth/authz gaps
- data loss, schema drift, unsafe migrations, or missing rollback paths
- public API contract breaks
- command injection, shell interpolation, and secret exposure
- LLM or external-output trust boundary mistakes
- concurrency, race, and TOCTOU bugs
- incomplete enum/value handling and impossible states
- missing negative-path tests for high-risk behavior

Only continue into polish after the dangerous paths are understood.

### 3) Spec Compliance

When the change implements a specific issue, ticket, or spec:

1. Read the issue/spec (e.g. `gh issue view <number>`)
2. For each acceptance criterion or requirement, verify the implementation actually delivers it
3. Flag any **missing**, **incomplete**, or **divergent** behavior as at least **P1**
4. Pay attention to intent, not just literal text. If the spec says "tag users" and the code adds mentions that will not render, that is still a miss.
5. If the spec references a conversation or original feedback, check that too; specs can lose nuance from the original request.

This catches the gap between "code works" and "code does what was asked."

### 4) Architecture & Conventions

Load: `references/architecture.md`

Check:
- SOLID violations (SRP, OCP, LSP, ISP, DIP)
- Violations of [[developing-web-projects]] conventions:
  - No React/Vue/Angular imports
  - No Tailwind/utility CSS
  - No CSS resets (`normalize.css`, `reset.css`)
  - No SPA routing / client-side routers
  - Semantic CSS class names
  - MPA architecture with real HTML documents and normal navigation
  - Web Components follow proper patterns (Shadow DOM, attribute/property discipline, lifecycle)

Output expectation:
- Propose **incremental** refactor steps with clear risk/benefit

### 5) Removal Candidates

Load: `references/removal-plan.md`

Find:
- Unused imports
- Dead code paths
- Redundant abstractions
- Expired feature-flag branches

Classify as:
- Safe delete now
- Defer with plan (with blocker + target date)

### 6) Security & Reliability

Load: `references/security.md`

Check:
- XSS vectors (`innerHTML`, unsanitized template input)
- Injection risk (SQL string concat, command injection)
- AuthN/AuthZ gaps
- Secret exposure (hardcoded keys/tokens)
- Race conditions / TOCTOU
- CSRF protection on state-changing flows

Always report:
- Exploitability
- Impact
- Minimal mitigation path

### 7) Code Quality

Load: `references/quality.md`

Check:
- Error handling issues (silent catches, unhandled rejections)
- Performance issues (N+1, large imports, missing pagination)
- Boundary issues (null/undefined, empty collections, coercion)
- TypeScript quality (`any`, loose generics, missing return types)
- Symptom-layering smells:
  - multiple small patches in the same interaction flow without simplifying the design
  - document-level listeners added to compensate for broken local event handling
  - coordinate or bounding-box hit testing used where DOM/event-path semantics should decide behavior
  - duplicated close/open/restore-focus logic spread across handlers
  - tests that only prove synthetic handler invocation while the real browser interaction path remains unverified

If these appear, treat them as a maintainability/correctness risk, not just style. Usually this is at least **P1** when the patch changes behavior, and **P2** when it mainly increases fragility.

### 8) Output

Use template: `templates/review-output.md`

Rules:
- Use P0–P3 severities
- Do not auto-fix without approval
- Lead with findings, then open questions, then secondary summary
- End with numbered next-step options when action is needed

## Severity Levels

| Level | Name | Description | Action |
|-------|------|-------------|--------|
| P0 | Critical | Security vulnerability, data loss risk, correctness bug | Must block merge |
| P1 | High | Logic error, significant SOLID violation, performance regression, missing tests | Should fix before merge |
| P2 | Medium | Code smell, maintainability concern, minor convention violation | Fix in PR or follow-up |
| P3 | Low | Style, naming, minor suggestion | Optional improvement |

## Integration Notes

- Link and align with [[testing-orchestrator]] for coverage expectations
- Enforce standards from [[developing-web-projects]]
- Apply Cloudflare checks when relevant via `references/cloudflare.md` and [[architecting-cloudflare-systems]]

## Output Contract

A complete review must include:
1. Scope summary (files/lines)
2. Prioritized findings (P0–P3)
3. Spec compliance assessment when applicable
4. Standards/convention compliance assessment
5. Test coverage assessment
6. Risk/depth notes for critical paths reviewed
7. Symptom-layering assessment when relevant (is this fixing a cause or stacking workarounds?)
8. Actionable next-step options
