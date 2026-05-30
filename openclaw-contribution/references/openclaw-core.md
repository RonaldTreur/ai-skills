# OpenClaw core contribution reference

Canonical local sources for openclaw/openclaw:
- /Users/merlin/openclaw/CONTRIBUTING.md
- /Users/merlin/openclaw/.github/ISSUE_TEMPLATE/bug_report.yml
- /Users/merlin/openclaw/.github/ISSUE_TEMPLATE/feature_request.yml
- /Users/merlin/openclaw/.github/pull_request_template.md

Canonical upstream pages:
- <https://github.com/openclaw/openclaw/blob/main/CONTRIBUTING.md>
- <https://github.com/openclaw/openclaw/blob/main/.github/ISSUE_TEMPLATE/bug_report.yml>
- <https://github.com/openclaw/openclaw/blob/main/.github/ISSUE_TEMPLATE/feature_request.yml>
- <https://github.com/openclaw/openclaw/blob/main/.github/pull_request_template.md>
- <https://docs.openclaw.ai/security/CONTRIBUTING-THREAT-MODEL> for one confirmed docs-site example of OpenClaw contributor guidance

## Bug issue requirements

Bug reports are evidence-first.

Required shape:
- Bug type
- Beta release blocker
- Summary
- Steps to reproduce
- Expected behavior
- Actual behavior
- OpenClaw version
- Operating system
- Install method
- Model
- Provider / routing chain
- Additional provider or model setup details
- Logs, screenshots, and evidence
- Impact and severity
- Additional information

Critical rule:
- if a narrative field cannot be grounded, respond with exactly NOT_ENOUGH_INFO

## Feature request requirements

Required shape:
- Summary
- Problem to solve
- Proposed solution
- Alternatives considered
- Impact
- Evidence or examples
- Additional information

## PR requirements

The current PR template requires:
- summary bullets
- change type
- scope
- linked issue or PR
- real behavior proof
- root cause
- regression test plan
- user-visible changes
- diagram for non-trivial flows when helpful
- security impact
- repro and verification
- evidence
- human verification
- review conversation ownership
- compatibility or migration
- risks and mitigations

Important contribution rules from CONTRIBUTING.md:
- external PRs must include real behavior proof from a real OpenClaw setup
- screenshots are encouraged; terminal screenshots and copied live output count
- AI-assisted PRs are welcome but must be marked as AI-assisted
- keep PRs focused
- use American English
- do not edit security-owned CODEOWNERS paths unless explicitly asked or already under review
- authors must resolve or reply to bot review conversations they addressed

## Practical gh pattern

When authenticated, prefer:

~~~bash
gh issue create --repo openclaw/openclaw --title "$TITLE" --body-file /tmp/openclaw-issue.md
gh pr create --repo openclaw/openclaw --title "$TITLE" --body-file /tmp/openclaw-pr.md
~~~

When unauthenticated:
- keep the same body format
- return a ready-to-paste draft and call out the auth blocker
