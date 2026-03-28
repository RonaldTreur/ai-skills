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

## When to use

Use this skill when:
- A feature/refactor is implemented and ready for review
- Before opening/merging a PR
- Auditing an existing codebase for risk and debt
- Performing targeted security or architecture checks

## Avoid when

Avoid this skill when:
- You are still rapidly prototyping throwaway code
- Requirements are still being discovered and code is intentionally temporary
- There is no concrete diff/snapshot to review yet

In those cases, move to this skill once changes stabilize.

## Review posture

- Be direct and specific
- Prefer incremental refactors over rewrites
- Do **not** auto-fix without approval
- Always classify findings by severity (P0–P3)
- Include exploitability + impact for security findings
- Enforce project conventions from [[developing-web-projects]]

## 6-Step Workflow

### 1) Preflight Context

Understand exactly what changed before judging quality.

Commands:
- `git status -sb`
- `git diff --stat`
- `git diff`
- `rg` / `grep` for related modules and dependencies

Checklist:
- Identify entry points and critical paths (auth, payments, data writes)
- Verify whether `TEST_PLAN.md` exists
- Verify tests exist for the change
- If tests or `TEST_PLAN.md` coverage are missing, flag at least **P1**

### 2) Architecture & Conventions

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

### 3) Removal Candidates

Load: `references/removal-plan.md`

Find:
- Unused imports
- Dead code paths
- Redundant abstractions
- Expired feature-flag branches

Classify as:
- Safe delete now
- Defer with plan (with blocker + target date)

### 4) Security & Reliability

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

### 5) Code Quality

Load: `references/quality.md`

Check:
- Error handling issues (silent catches, unhandled rejections)
- Performance issues (N+1, large imports, missing pagination)
- Boundary issues (null/undefined, empty collections, coercion)
- TypeScript quality (`any`, loose generics, missing return types)

### 6) Output

Use template: `templates/review-output.md`

Rules:
- Use P0–P3 severities
- Do not auto-fix without approval
- End with numbered next-step options

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
3. Test coverage assessment
4. Convention compliance checklist
5. Actionable next-step options
