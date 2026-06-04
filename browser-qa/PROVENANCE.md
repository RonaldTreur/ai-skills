# Browser QA Provenance

This artifact records the source influences behind `browser-qa/SKILL.md`.
Runtime attribution belongs here, not in the skill body.

## Rebuild Recipe

1. Review GStack `qa/SKILL.md` for browser-first QA workflow, evidence capture,
   severity triage, and fix/report boundaries.
2. Compare against local `e2e-playwright`, `testing-orchestrator`,
   `debugging`, and `implement-issue` ownership.
3. Keep browser verification as a focused runtime skill. Leave durable
   Playwright test creation to [[e2e-playwright]] and larger test orchestration
   to [[testing-orchestrator]].
4. Keep runtime text concise: target, mode, browser pass, defect handling, and
   output shape.
5. Treat authenticated QA as a first-class runtime concern: prefer safe
   non-production auth paths and report missing auth setup as QA infrastructure.
6. Use the agent's own controlled browser profile by default so QA automation
   is repeatable and does not depend on personal profile extensions or state.
7. For significant visual changes, verify concrete mobile widths and clickable
   affordance behavior, and treat optional detector output as evidence rather
   than authority.

## GStack

- Source: https://github.com/garrytan/gstack
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed path: `qa/SKILL.md`
- License: MIT

Adopted ideas:

- QA should open a browser and test real user behavior instead of substituting
  unit or static checks.
- QA depth should scale by mode: quick smoke, focused/diff-aware, full, and
  regression/post-change passes.
- Console errors, screenshots, responsive checks, and reproduction steps are
  useful evidence for browser defects.
- QA findings should be triaged by severity before deciding whether to fix or
  defer.
- Auth blockers should be handled explicitly; protected flows need a way to
  authenticate before meaningful QA can be complete.

Local adaptation:

- Removed GStack-specific preambles, telemetry, update checks, generated
  artifacts, command aliases, auto-commit loops, and one-commit-per-fix policy.
- Split browser verification from automated Playwright test authoring.
- Added a local auth hierarchy: documented QA account or seeded local user
  first, approved secret stores only, local ignored storage state when supported,
  production-disabled login bypasses only when documented, and explicit blocker
  reporting otherwise.
- Post-merge QA creates follow-up issues instead of continuing to mutate a
  merged branch by default.
- Kept screenshots optional for evidence rather than mandatory for every page,
  matching local cost discipline.
- Extended browser evidence guidance for CSS cleanup: inspect DOM/state,
  responsive viewports, and use browser coverage or equivalent unused-rule
  evidence when available before deleting selectors.

Rejected material:

- Health-score rubric and large persistent QA report tree by default.
- Automatic test-framework bootstrap during QA.
- Mandatory clean-tree gate and per-fix commits as universal behavior.
- Reliance on personal browser sessions or production credentials as the
  default QA auth path.
- Hard requirement to show every screenshot inline.

## SuperPowers

- Source: https://github.com/obra/superpowers
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed path: `skills/test-driven-development/SKILL.md`
- License: MIT

Useful comparison:

- Reinforces that lasting fixes should get regression coverage, but this skill
  only reports or verifies browser behavior. Regression-test creation remains
  with implementation, debugging, and Playwright skills.

## Matt Pocock Skills

- Source: https://github.com/mattpocock/skills
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed path: `skills/engineering/tdd/SKILL.md`
- License: MIT

Useful comparison:

- Reinforces behavior-first verification through public interfaces. Browser QA
  applies that idea by checking visible user flows rather than implementation
  internals.

## Compound Engineering

- Source: https://github.com/everyinc/compound-engineering-plugin
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed path: `docs/skills/ce-debug.md`
- License: MIT

Useful comparison:

- Reinforces escalation to root-cause debugging when a browser defect is not
  trivial. The local skill routes non-trivial defects to [[debugging]] rather
  than embedding a full investigation workflow.

## CSS Evidence Notes

- Sources: GStack, Compound Engineering

What we took:

- defects and cleanup decisions should be backed by browser-observable evidence
- probe the rendered system before assuming the cause or safety of a deletion

Local adaptation:

- CSS cleanup guidance is phrased as DOM/state/coverage verification rather than
  a separate heavyweight audit workflow.

## Impeccable and Hallmark Visual QA

- Sources: https://github.com/pbakaus/impeccable,
  https://github.com/Nutlope/hallmark
- Reviewed refs: Impeccable `1d5d745823aae7019044e8b0a621af4366dae224`,
  Hallmark `df5498f7f64102f559ccd1cb693d95136dd95b97`
- Reviewed paths: Impeccable detector registry and audit/critique references;
  Hallmark `SKILL.md`, `references/slop-test.md`, `references/structure.md`
- Licenses: Apache-2.0 and MIT

What we took:

- optional anti-pattern detector evidence for narrow Node-capable targets
- mobile visual QA widths: 320, 375, 414, and 768 px
- no horizontal scroll as a default visual QA expectation
- no awkward two-line clickable CTA/nav/tab/breadcrumb/footer text
- visible checks for fake chrome, invented proof, token drift, missing states,
  and generic AI layout tells

Local adaptation:

- Kept detector use optional and non-blocking.
- Added a small command reference at `references/impeccable-detector.md`.
- Routed broad durable E2E coverage to [[e2e-playwright]] and kept this skill
  focused on browser-observed QA evidence.

## Local Browser Profile Policy

- Source: user review feedback in `#claw-enhance`
- Reviewed ref: 2026-05-24 conversation
- Reviewed material: instruction to default QA runs to the agent-controlled
  browser profile unless told otherwise
- License: repository-local decision

What we took:

- Browser QA should use the active agent's own controlled browser profile by
  default. In OpenClaw, that means the OpenClaw-managed browser profile.

Why:

- The controlled profile is available to automation. Personal or
  project-specific profiles may depend on extensions, permissions, logged-in
  state, or private context that automated flows cannot safely assume.

## Cross-References

- Adaptation log: `methodology/ADAPTATION_LOG.md`
- Discipline review: `methodology/disciplines/browser-qa.md`
- Design source review:
  `methodology/disciplines/frontend-design-impeccable-hallmark.md`
