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

Contributing rules the templates do not state:
- screenshots are encouraged; terminal screenshots and copied live output count as proof
- use American English
- do not edit security-owned CODEOWNERS paths unless explicitly asked or already under review

## Practical gh pattern

When authenticated, prefer:

~~~bash
gh issue create --repo openclaw/openclaw --title "$TITLE" --body-file /tmp/openclaw-issue.md
gh pr create --repo openclaw/openclaw --title "$TITLE" --body-file /tmp/openclaw-pr.md
~~~
