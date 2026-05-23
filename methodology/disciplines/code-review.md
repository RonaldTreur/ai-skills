# Discipline Review: code-review

- Date: 2026-05-23
- Reviewer: Merlin
- Branch: `feat/code-review-methodology`
- Local files reviewed: `code-review/SKILL.md`,
  `code-review/references/architecture.md`,
  `code-review/references/security.md`,
  `code-review/references/quality.md`,
  `code-review/references/cloudflare.md`,
  `code-review/references/removal-plan.md`,
  `code-review/templates/review-output.md`
- External sources reviewed:
  - GStack review skill, checklist, and selected specialists at
    `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
  - SuperPowers code-review and subagent-review prompts at
    `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
  - Compound Engineering code-review docs, skill, and selected reviewer agents
    at `5297a9440fa009822ceef8052b9e644e782281e1`
  - Matt Pocock review, architecture, and docs-grilling skills at
    `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Status: adopted

## Local Baseline

The repository already had a useful `code-review` skill with:

- P0-P3 severity levels
- no automatic fixing without approval
- architecture, security, quality, Cloudflare, and removal references
- local web-project convention checks
- a symptom-layering rule for patches that stack workarounds
- spec compliance checks when a ticket or issue exists

The gap was calibration. The skill mixed trigger guidance, review workflow, and
output rules, but did not strongly require reviewers to:

- resolve the review fixed point
- identify the actual spec and local standards before judging
- separate spec compliance from standards and risk
- scan critical risks before broad maintainability comments
- suppress speculative or style-only findings

## Source Comparison

### GStack

- Source ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Files reviewed: `review/SKILL.md`, `review/checklist.md`, selected files in
  `review/specialists/`
- Useful patterns:
  - Two-pass review: critical issues first, informational findings second.
  - High-signal risk categories: SQL/data safety, races, LLM output trust
    boundaries, shell injection, enum completeness, API contracts, migrations,
    performance, and testing.
  - Suppression guidance to avoid harmless redundancy, style-only churn, and
    already-addressed issues.
- Conflicts or risks:
  - The source assumes GStack setup, telemetry, update hooks, and specialist
    runtime behavior.
  - Its fix-first and autofix posture conflicts with the local "do not auto-fix
    without approval" review rule.
- Adoption recommendation:
  - Adopt critical-first scanning and suppression rules. Reject runtime
    machinery and default autofix behavior.

### SuperPowers

- Source ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Files reviewed: `skills/requesting-code-review/SKILL.md`,
  `skills/requesting-code-review/code-reviewer.md`,
  `skills/subagent-driven-development/code-quality-reviewer-prompt.md`,
  `skills/subagent-driven-development/spec-reviewer-prompt.md`
- Useful patterns:
  - Review early and before merge/completion.
  - Pass precise review context instead of full session history.
  - Do not trust implementer reports; read the actual code.
  - Split spec compliance from code-quality review.
- Conflicts or risks:
  - Mandatory subagent review after every task is too heavy for all local work.
- Adoption recommendation:
  - Adopt independent review posture and the spec-vs-quality distinction.
    Keep subagent delegation optional.

### Compound Engineering

- Source ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Files reviewed: `docs/skills/ce-code-review.md`,
  `plugins/compound-engineering/skills/ce-code-review/SKILL.md`, selected
  reviewer agents under
  `plugins/compound-engineering/skills/ce-code-review/agents/`
- Useful patterns:
  - Diff-aware review depth and conditional specialist focus.
  - Confidence gates: drop findings that are not anchored to the actual diff.
  - Severity is separate from autofix/action class.
  - Plan/spec discovery and residual-risk reporting.
- Conflicts or risks:
  - The full pipeline is too heavy for a generic local skill.
  - Autofix/report modes and protected-artifact mechanics are tied to the
    Compound runtime.
- Adoption recommendation:
  - Adopt risk-scaling, evidence gates, and residual-risk notes. Reject the
    multi-agent/autofix machinery as default behavior.

### Matt Pocock Skills

- Source ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Files reviewed: `skills/in-progress/review/SKILL.md`,
  `skills/engineering/grill-with-docs/SKILL.md`,
  `skills/engineering/improve-codebase-architecture/SKILL.md`
- Useful patterns:
  - Two-axis review: standards compliance and spec compliance.
  - Pin a fixed point before diff review.
  - Discover spec sources and standards sources explicitly.
  - Compare implementation against requirements rather than only code quality.
- Conflicts or risks:
  - The two-subagent split is useful on larger work, but too ceremonial as a
    universal requirement.
- Adoption recommendation:
  - Adopt the two-axis framing and discovery steps inside the local workflow.

## Approved Policy

The code-review discipline is now adopted with these rules:

1. Review concrete diffs or snapshots. If there is no stable diff, say so.
2. Identify the base range, spec source, and standards sources before judging.
3. Keep spec compliance, repo standards, and risk/quality as separate axes.
4. Scan critical risks before broad maintainability or polish findings.
5. Require anchored findings: precise location, concrete failure mode,
   importance, and smallest useful fix.
6. Suppress speculative, style-only, unchanged, and already-addressed comments.
7. Scale review depth with risk and blast radius.
8. Do not auto-fix during review without approval.
9. Keep local wiki-style links between skills; they are valid integration
   points.

## Adopted Changes

1. Update `code-review/SKILL.md` with review axes, preflight source discovery,
   critical-first scanning, evidence rules, and risk-scaled depth.
   Provenance entry ids:
   `2026-05-23-code-review-matt-two-axis`
   `2026-05-23-code-review-gstack-critical-first`
   `2026-05-23-code-review-compound-evidence-gate`
2. Keep the existing no-autofix rule and explicitly reject imported autofix
   behavior.
   Provenance entry id:
   `2026-05-23-code-review-autofix-rejected`
3. Add `code-review/PROVENANCE.md` with source influence and a rebuild recipe.
   Provenance entry id:
   `2026-05-23-code-review-provenance`

## Rejections And Deferrals

- Rejected mandatory subagent review for every task.
- Rejected GStack and Compound runtime machinery, setup hooks, telemetry,
  protected-artifact systems, and autofix modes.
- Deferred a separate automated review harness. The runtime skill should work
  manually first.
- Deferred changing the output template beyond this pass; the runtime skill
  contract is the stronger model-facing control.

## Skill-Level Attribution

Created `code-review/PROVENANCE.md`.

No exception is needed: the skill has a sibling provenance artifact at the
required path. Runtime `code-review/SKILL.md` intentionally does not link to it.

## Skill Review Pass

Reviewed `code-review/SKILL.md` with `skill-review` after editing.

Expected trigger tests:

- Should trigger: "Review this PR before merge."
- Should trigger: "Audit this diff for security and architecture risks."
- Should not trigger: "Help me brainstorm possible approaches before any code
  exists."
- Edge case: "This quick typo fix is ready." The skill can run a short focused
  review, but should not require deep ceremony.

Verdict: PASS. The skill has specific activation metadata, compact runtime
workflow, progressive references for deeper checks, explicit safety gates, and
no provenance-only runtime material. Local wiki-style skill links are intended
integration points and were ignored.

## Verification Notes

- Compared GStack, SuperPowers, Compound Engineering, and Matt Pocock Skills
  code-review material.
- Kept source attribution out of runtime `SKILL.md`.
- Preserved the local no-autofix rule.
- Added skill-level provenance at the required path.
