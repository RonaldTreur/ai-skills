---
name: openclaw-contribution
description: Use when creating or updating OpenClaw GitHub issues or pull requests, especially for openclaw/openclaw. Read the repo's current issue templates, PR template, and CONTRIBUTING rules first; then draft grounded issue or PR bodies and either submit with gh or produce ready-to-paste drafts when authentication is unavailable.
---

# OpenClaw Contribution

Use this skill for contribution work against OpenClaw GitHub repositories.

Default assumption:
- core repo is openclaw/openclaw
- local clone is /Users/merlin/openclaw when it exists

## What this skill covers

- Filing OpenClaw bug reports
- Filing OpenClaw feature requests
- Preparing OpenClaw pull requests
- Updating an existing OpenClaw issue or PR with the right structure

Do not use this skill for generic GitHub work outside the OpenClaw ecosystem.

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

If gh is not authenticated, do not pretend submission succeeded. Produce a ready-to-paste draft instead.

Load [references/openclaw-core.md](references/openclaw-core.md) for the current OpenClaw-specific requirements and canonical file paths.

## Issue workflow

### Bug reports

OpenClaw's bug template is strict:
- keep every answer concise, reproducible, and grounded in observed evidence
- do not speculate beyond the evidence
- if a narrative field cannot be supported, use exactly NOT_ENOUGH_INFO

Minimum bug-report workflow:

1. Gather direct evidence first: repro steps, logs, screenshots, version, OS, install method, model, provider chain.
2. Distill the shortest deterministic repro.
3. Write expected behavior from a known-good version, prior observed behavior, or docs.
4. Write actual behavior using only what was observed.
5. Capture impact in concrete terms: who is affected, severity, frequency, consequence.
6. If evidence is incomplete, use NOT_ENOUGH_INFO exactly where the upstream template requires it.

Never fill gaps with plausible guesses.

### Feature requests

OpenClaw's feature template wants:
- one-line summary
- problem to solve
- proposed solution
- alternatives considered
- impact
- evidence/examples

Prefer concrete use cases and tradeoffs over vague product language.

### Docs-only or small clarifications

If the upstream contribution guide indicates the change is simple enough for a direct PR without an issue, do that instead of opening a low-value issue.

## PR workflow

For PRs, also use git-conventions.

OpenClaw expects:
- focused PR scope
- Conventional Commit style PR title
- linked issue when applicable
- explicit scope boundaries
- real behavior proof for external PRs
- AI-assisted disclosure when AI was used
- bot review conversations handled by the author

Minimum PR workflow:

1. Inspect branch state and keep the diff focused.
2. Fill the current PR template, not a generic one.
3. Include the required Real behavior proof section with human-run evidence from a real setup.
4. Include root cause for bug fixes when known; otherwise say Unknown or N/A as appropriate.
5. Name the smallest reliable regression guardrail.
6. Fill security impact honestly.
7. State what you personally verified and what you did not verify.
8. If the PR is AI-assisted, mark that clearly in the PR title or description.
9. Resolve or reply to bot review conversations you addressed before asking for review again.

Tests, lint, typechecks, and CI are useful, but they do not replace real behavior proof for external OpenClaw PRs.

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
