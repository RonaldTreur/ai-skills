---
name: browser-qa
description: "Run browser QA for web apps: preview smoke tests, PR/post-merge checks, user-visible behavior, UI, routing, forms, and responsive verification. Use e2e-playwright for durable E2E tests."
---

# Browser QA

Use this skill to verify web behavior in a browser like a careful user and
report defects with evidence.

Owns exploratory browser verification, smoke checks, post-merge QA and defect
evidence. [[e2e-playwright]] owns durable tests; [[debugging]] owns root cause;
[[implement-issue]] calls this skill before and after merge.

## Modes

Choose the smallest mode that fits the request.

- `quick`: homepage or changed entry point, top navigation, obvious interactive
  controls, console errors, and visible layout breakage.
- `focused`: changed routes, affected flows, linked acceptance criteria,
  responsive checks, and regression-prone neighboring behavior.
- `visual`: significant visual, CSS, responsive, or design-system change where
  layout, states, anti-patterns, and mobile behavior matter more than broad
  route coverage.
- `post-merge`: merged integration branch or preview URL smoke check plus issue
  creation for defects found.
- `full`: broader exploratory pass across reachable pages when the user
  explicitly asks for complete QA.

Do not call a pass "QA" if no browser was opened. If browser access is blocked,
say that QA was not run and report the blocker.

## Setup

1. Identify the target:
   - URL, local dev server, preview, PR build, or merged integration branch
   - branch, PR, issue, and acceptance criteria when available
   - changed routes, components, forms, and user flows
2. Use the harness's own controlled browser profile unless the user explicitly
   instructs otherwise.
3. Do not use production accounts, secrets, billing flows, or destructive user
   actions unless the user explicitly authorizes them.
4. If login, CAPTCHA, paid services, or missing data blocks the pass, ask for
   the narrow unblocker or record the blocked coverage.

## Auth

Authenticated QA follows the auth and test-data rules in [[testing]]. In the
browser: read credentials only from approved local secret stores or
repo-documented secret names, and never print, screenshot or summarize
passwords, tokens, cookies or magic links; use a developer login bypass only
when it is disabled in production and documented. A protected area with no safe
QA auth path is a QA infrastructure blocker, and during [[implement-issue]] it
blocks implementation for changed protected behavior.

## Browser Pass

Prefer browser/DOM inspection before screenshots. Use screenshots when visual
evidence matters or when reporting a defect.

For each tested page or flow:

1. Inspect console errors after load and after major interactions.
2. Exercise the user path, not only the happy button:
   - navigation and deep links
   - forms, validation, empty states, loading states, and error states
   - browser back/forward for routed apps
   - keyboard focus and basic accessibility affordances where relevant
3. Check at least one narrow mobile viewport for user-visible layout changes.
4. Record defects immediately with reproduction steps and evidence.

For `focused` mode, bias coverage toward changed behavior and nearby regression
risks. For `quick` mode, stop after the highest-signal smoke checks.

For `visual` mode, or when the change touches CSS, read
`references/visual-pass.md`.

## Defect Handling

Use P0-P3 as defect priority:

- `P0`: data loss, security/privacy issue, app unusable, or production-blocking
- `P1`: core user flow broken or severe regression
- `P2`: important behavior wrong with a workaround
- `P3`: polish, minor visual issue, copy, or low-risk inconsistency

Before merge, fix valid defects in the active branch when they are in scope for
the current issue. Use [[debugging]] for non-trivial root-cause work.

After merge, do not silently keep expanding the merged work. Create follow-up
issues for defects with priority, reproduction steps, affected URL/build, and
evidence. Return to [[project-manager]] for the next work decision.

## Output

Report:

- target URL/build/branch and mode
- flows and viewports checked
- console/network errors observed
- detector or visual anti-pattern evidence when used
- defects found, each with priority, repro steps, expected/actual behavior, and
  screenshot or DOM/console evidence when useful
- coverage not tested and why
- ship/readiness summary or follow-up issue list

If no defects were found, say what was actually checked. Do not imply broad
coverage from a narrow smoke pass.
