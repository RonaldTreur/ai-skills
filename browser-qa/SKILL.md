---
name: browser-qa
description: "Run browser QA for web apps: preview smoke tests, PR/post-merge checks, user-visible behavior, UI, routing, forms, and responsive verification. Use e2e-playwright for durable E2E tests."
---

# Browser QA

Use this skill to verify web behavior in a browser like a careful user and
report defects with evidence.

## Ownership Boundary

- `browser-qa` owns browser-based exploratory verification, smoke checks,
  post-merge QA, defect evidence, and QA summaries.
- [[e2e-playwright]] owns durable automated Playwright test creation and repair.
- [[testing-orchestrator]] owns larger test-planning and test-generation cycles.
- [[debugging]] owns root-cause investigation for non-trivial defects.
- [[implement-issue]] calls this skill before merge for user-visible browser
  changes and after merge for preview or `dev` QA.

## Modes

Choose the smallest mode that fits the request.

- `quick`: homepage or changed entry point, top navigation, obvious interactive
  controls, console errors, and visible layout breakage.
- `focused`: changed routes, affected flows, linked acceptance criteria,
  responsive checks, and regression-prone neighboring behavior.
- `visual`: significant visual, CSS, responsive, or design-system change where
  layout, states, anti-patterns, and mobile behavior matter more than broad
  route coverage.
- `post-merge`: merged `dev` or preview URL smoke check plus issue creation for
  defects found.
- `full`: broader exploratory pass across reachable pages when the user
  explicitly asks for complete QA.

Do not call a pass "QA" if no browser was opened. If browser access is blocked,
say that QA was not run and report the blocker.

## Setup

1. Identify the target:
   - URL, local dev server, preview, PR build, or merged `dev`
   - branch, PR, issue, and acceptance criteria when available
   - changed routes, components, forms, and user flows
2. Prefer the project's existing build/preview/dev commands.
3. Use a built preview when the project convention supports it; use dev mode
   when hot reload or framework behavior requires it.
4. Use the active agent's own controlled browser profile unless the user
   explicitly instructs otherwise. In OpenClaw, this means the OpenClaw-managed
   browser profile. Avoid switching to personal or project-specific profiles by
   default; missing extensions, permissions, or profile state can break
   automated flows and can expose unrelated private context.
5. Do not use production accounts, secrets, billing flows, or destructive user
   actions unless the user explicitly authorizes them.
6. If login, CAPTCHA, paid services, or missing data blocks the pass, ask for
   the narrow unblocker or record the blocked coverage.

## Auth And Test Accounts

Authenticated QA needs a safe, repeatable auth path. Do not depend on the user's
personal browser session or production credentials as the default way to test.

Preferred order:

1. Use the project's documented QA/test account, seeded local user, fixture, or
   preview-environment auth path.
2. Read credentials only from approved local secret stores, environment
   variables, or repo-documented secret names. Never print, commit, screenshot,
   or summarize passwords, tokens, cookies, or magic links.
3. Use local-only browser storage state when the project already supports it.
   Keep generated auth state out of git.
4. Use a developer-only login bypass or seeded session only when it is clearly
   disabled in production and documented by the project.
5. If CAPTCHA, 2FA, missing seed data, account approval, or external identity
   provider state blocks coverage, record the blocked flows and ask for the
   narrow unblocker.

If a project has protected areas but no safe QA auth path, report that as a QA
infrastructure blocker. Recommend a follow-up issue for a non-production test
account, seed script, fixture, or documented preview auth workflow.

When QA runs during [[implement-issue]], treat missing auth setup for changed or
new protected behavior as an implementation blocker, not a normal deferred QA
finding.

## Browser Pass

Prefer browser/DOM inspection before screenshots. Use screenshots when visual
evidence matters or when reporting a defect.

For each tested page or flow:

1. Load the page and check that the primary content appears.
2. Inspect console errors after load and after major interactions.
3. Exercise the user path, not only the happy button:
   - navigation and deep links
   - forms, validation, empty states, loading states, and error states
   - browser back/forward for routed apps
   - keyboard focus and basic accessibility affordances where relevant
4. Check at least one narrow mobile viewport for user-visible layout changes.
5. Record defects immediately with reproduction steps and evidence.

For `focused` mode, bias coverage toward changed behavior and nearby regression
risks. For `quick` mode, stop after the highest-signal smoke checks.

For `visual` mode or significant visual changes:

1. Check desktop plus 320, 375, 414, and 768 px widths when practical.
2. Fail horizontal scrolling unless the design intentionally owns a horizontal
   interaction and makes it obvious.
3. Check that CTA, nav, tab, breadcrumb, and footer link text does not wrap into
   awkward two-line clickable affordances.
4. Check long display words and headings for overflow or overlap.
5. For image-bearing grid tracks, inspect that images do not force the grid
   wider than the viewport.
6. Check focus-visible, active, disabled, loading, error, and success states
   when the changed component exposes those states.
7. Treat fake browser/device/IDE chrome, invented proof stats, token drift, and
   generic AI layout tells as design defects when they are visible in scope.

Optional detector evidence:

- When the project is Node-capable and the target is narrow, run
  the project's pinned Impeccable command, or `npx impeccable detect <target>
  --json` only when external package execution is already acceptable for the
  task.
- Load `references/impeccable-detector.md` only when command examples or output
  interpretation details are needed.
- Treat detector output as evidence, not authority. Product UI may legitimately
  use familiar fonts or one family; brand surfaces need more distinctiveness.
- Do not block QA on detector installation, network access, or broad scans.
  Report detector coverage as skipped when unavailable.

For significant CSS cleanup or visual changes:

1. Inspect the rendered DOM and the states the CSS claims to style before
   deleting selectors.
2. Check responsive viewports, not just desktop, because dead-looking rules can
   still be active in narrow layouts.
3. Where browser tooling makes it available, gather CSS coverage or equivalent
   unused-rule evidence to support deletions.
4. Do not justify CSS removal by guesswork alone; back it with DOM, state, or
   coverage evidence.

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
