# Discipline Review: Frontend Design Source Integration

- Date: 2026-06-04
- Reviewer: Merlin
- Branch: `feat/design-source-integration`
- Local files reviewed: `frontend-design/SKILL.md`,
  `browser-qa/SKILL.md`, `code-review/SKILL.md`, adjacent provenance files
- External sources reviewed: Impeccable, Hallmark refresh
- Status: implemented

## Local Baseline

The local skill system already uses `frontend-design` as the owner for visual
direction, `browser-qa` for rendered browser verification, and `code-review` for
diff-level quality and standards review. The default-path rule requires normal
design, QA, and review behavior to stay inline in `SKILL.md`.

## Source Comparison

### Impeccable

- Source ref: `1d5d745823aae7019044e8b0a621af4366dae224`
- Files reviewed: `.agents/skills/impeccable/SKILL.md`,
  `reference/brand.md`, `reference/product.md`, `reference/audit.md`,
  `reference/critique.md`, `cli/engine/registry/antipatterns.mjs`
- Useful patterns: brand/product register split, deterministic anti-pattern
  detector, critique/audit distinction, sharper anti-AI-slop vocabulary
- Conflicts or risks: command surface overlaps local skills, detector can
  false-positive on product UI, `PRODUCT.md` duplicates local artifacts, live
  overlay mode is tool-specific
- Adoption recommendation: adapt register language and optional detector
  evidence; reject wholesale skill/command adoption

### Hallmark Refresh

- Source ref: `df5498f7f64102f559ccd1cb693d95136dd95b97`
- Files reviewed: `skills/hallmark/SKILL.md`, `references/structure.md`,
  `references/macrostructures.md`, `references/slop-test.md`,
  `references/verbs/audit.md`
- Useful patterns: pre-flight scan, component-scope routing, macrostructure
  catalogue, study/redesign safety rails, mobile non-negotiables, honest-copy,
  locked-token, and fake-chrome gates
- Conflicts or risks: full theme catalogue, stamps, `.hallmark` state, and
  "always ask" policy are too tool-specific or too high-friction for the local
  workflow
- Adoption recommendation: adapt compact operational checks into existing owner
  skills; reject new Hallmark runtime skill

## Questions For The User

Ronald already approved integrating the useful aspects of both sources. No
remaining taste-policy question blocks this pass.

## Adopted Changes

- `frontend-design/SKILL.md`: added pre-flight scan, brand/product register,
  design-context checkpoint, expanded macrostructure vocabulary, component
  scope, anti-reflex checks, reference safety, honest-copy, fake-chrome,
  locked-token, imagery, and product/brand guardrails.
- `browser-qa/SKILL.md`: added `visual` mode, concrete mobile viewport checks,
  clickable-text and overflow checks, state inspection, visible anti-pattern
  defects, and optional Impeccable detector evidence.
- `code-review/SKILL.md`: added UI review checks for design-system drift,
  invented proof, fake chrome, mobile CTA risk, missing states, and detector
  evidence handling.
- `browser-qa/references/impeccable-detector.md`: added optional command notes
  for narrow detector use.

Provenance entry id: `2026-06-04-impeccable-hallmark-design-integration`.

## Skill-Level Attribution

Updated:

- `frontend-design/PROVENANCE.md`
- `browser-qa/PROVENANCE.md`
- `code-review/PROVENANCE.md`

## Rejections And Deferrals

- Rejected full Impeccable and Hallmark skill installation.
- Rejected Impeccable `PRODUCT.md` as a new artifact.
- Rejected Hallmark theme catalogue, stamp system, and `.hallmark` state as
  default local requirements.
- Deferred live/browser overlay workflows until OpenClaw-specific safety and
  browser integration justify them.
- Deferred making `impeccable detect` a hard gate; it remains optional evidence.

## Verification Notes

Checks run:

- `git diff --check`: pass
- frontmatter presence check: pass
- `ruby skill-maintenance/scripts/audit-skills.rb --root .`: pass for duplicate
  names, identical bodies, description overlap, and superseded names; still
  flags `frontend-design`, `browser-qa`, and other hot-path skills as large

Manual `[[skill-review]]` result for changed runtime skills:

- `frontend-design/SKILL.md`: PASS. The added material is default-path design
  behavior, not provenance. Residual risk is body size; keep despite cost
  because normal greenfield/design-review runs need these gates inline.
- `browser-qa/SKILL.md`: PASS. Detector use is optional, narrow, and safe-gated
  around external package execution. The reference file is loaded only for
  command details.
- `code-review/SKILL.md`: PASS. UI review additions stay anchored to code,
  rendered behavior, or approved design artifacts and preserve P0-P3 severity.
