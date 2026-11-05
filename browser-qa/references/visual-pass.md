# Visual pass

Read this for `visual` mode, or when the change touches CSS.

## Checks

1. Check desktop plus 320, 375, 414 and 768 px widths when practical.
2. Fail horizontal scrolling unless the design intentionally owns a horizontal interaction and makes it obvious.
3. Check that CTA, nav, tab, breadcrumb and footer link text does not wrap into awkward two-line clickable affordances.
4. Check long display words and headings for overflow or overlap.
5. For image-bearing grid tracks, inspect that images do not force the grid wider than the viewport.
6. Check focus-visible, active, disabled, loading, error and success states when the changed component exposes them.
7. Treat fake browser, device or IDE chrome, invented proof stats, token drift and generic AI layout tells as design defects when they are visible in scope.

## CSS cleanup

Before deleting selectors, inspect the rendered DOM and the states the CSS claims to style, at narrow viewports as well as desktop, since dead-looking rules can still be active in narrow layouts. Where the browser tooling offers it, gather CSS coverage or equivalent unused-rule evidence. Back every removal with DOM, state or coverage evidence.

## Detector evidence

Run the project's pinned Impeccable command (an npm design anti-pattern detector: a package script, checked-in dependency or repo-documented invocation) when one exists. Run an ad-hoc `npx impeccable` only with the user's explicit approval for external package execution or a repo allowlist; otherwise report detector coverage as skipped. Never block QA on detector installation, network access or broad scans.

Treat detector output as evidence, not authority: confirm each finding against rendered behavior, code or the approved design artifact before reporting it. Product UIs may legitimately use familiar fonts, one family, restrained palettes and standard patterns; brand surfaces carry a higher distinctiveness bar. Say why a false positive is one and move on.

Command and report shapes are in `impeccable-detector.md`.
