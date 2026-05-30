---
name: openclaw-contribution
description: Use when creating or updating OpenClaw GitHub issues or PRs. Read current templates and CONTRIBUTING first, then submit with gh or draft ready-to-paste text.
---

# OpenClaw Contribution

Use this skill for contribution work against OpenClaw GitHub repositories.

Defaults: core repo `openclaw/openclaw`; local clone `/Users/merlin/openclaw`
when present.

## Scope

Use for OpenClaw bug reports, feature requests, pull requests, and issue/PR
updates. Do not use for generic GitHub work outside OpenClaw.

## Preflight

Before drafting anything:

1. Identify the target repo.
2. Decide whether the artifact is a bug issue, feature request, or PR.
3. Read the current upstream source files from the local clone when available:
   - CONTRIBUTING.md
   - .github/ISSUE_TEMPLATE/bug_report.yml
   - .github/ISSUE_TEMPLATE/feature_request.yml
   - .github/pull_request_template.md
4. Check whether gh is authenticated.

If `gh` is not authenticated, produce a ready-to-paste draft instead of claiming
submission.

Load [references/openclaw-core.md](references/openclaw-core.md) for the current OpenClaw-specific requirements and canonical file paths.

## Issues

OpenClaw's bug template is strict:
- keep every answer concise, reproducible, and grounded in observed evidence
- do not speculate beyond the evidence
- if a narrative field cannot be supported, use exactly NOT_ENOUGH_INFO

Bug workflow:

1. Gather evidence: repro steps, logs, screenshots, version, OS, install method,
   model, provider chain.
2. Distill the shortest deterministic repro.
3. Write expected behavior from a known-good version, prior observation, or docs.
4. Write actual behavior using only what was observed.
5. Capture concrete impact: affected user, severity, frequency, consequence.
6. Use NOT_ENOUGH_INFO exactly where required if evidence is incomplete.

Never fill gaps with plausible guesses.

Feature requests need summary, problem, proposed solution, alternatives, impact,
and evidence/examples.

Prefer concrete use cases and tradeoffs over vague product language.

If the upstream contribution guide indicates the change is simple enough for a direct PR without an issue, do that instead of opening a low-value issue.

## PR workflow

For PRs, also use git-conventions.

OpenClaw expects focused scope, Conventional Commit PR titles, linked issues
when applicable, explicit boundaries, real behavior proof, AI-assisted
disclosure when AI was used, and author-handled bot review conversations.

Minimum PR workflow:

1. Inspect branch state and keep the diff focused.
2. Fill the current PR template, not a generic one.
3. Include Real behavior proof with human-run evidence from a real setup.
4. Include root cause for bug fixes, or Unknown/N/A when appropriate.
5. Name the smallest reliable regression guardrail.
6. Fill security impact honestly.
7. State what you personally verified and what you did not verify.
8. Mark AI-assisted PRs clearly in the title or description.
9. Resolve or reply to bot review conversations you addressed before asking for review again.

Tests, lint, typechecks, and CI do not replace real behavior proof for external
OpenClaw PRs.

## Submission rules

If gh is authenticated:
- create the issue or PR with gh
- keep the body in a temp file first so it can be reviewed before submission

If gh is not authenticated:
- produce a complete draft body
- include the exact title
- say explicitly that submission is blocked on GitHub auth

## Output format

When this skill is used, produce one of:
- submitted issue with URL
- submitted PR with URL
- ready-to-paste issue draft
- ready-to-paste PR draft

Always include:
- target repo
- artifact type
- title
- any blockers
