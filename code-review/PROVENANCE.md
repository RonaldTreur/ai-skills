# Code Review Skill Provenance

This document records the external source material that shaped
`code-review/SKILL.md`. It is intentionally concise: enough attribution and
rationale to rebuild the skill close to its current form without rereading the
full methodology folder.

The local policy was adopted on 2026-05-23 after comparing code-review guidance
from GStack, SuperPowers, Compound Engineering, and Matt Pocock Skills against
the repository's existing `code-review` skill.

## Rebuild Recipe

To reconstruct the skill, keep these behaviors:

1. Review concrete diffs or snapshots, not vague intent.
2. Resolve the fixed point, spec source, and standards sources before judging.
3. Keep spec compliance, repo standards, and risk/quality as separate review
   axes.
4. Scan critical risks first: security, data, migrations, API contracts, shell
   execution, LLM trust boundaries, concurrency, and impossible states.
5. Require anchored findings with `file:line`, failure mode, impact, and the
   smallest useful fix.
6. Suppress speculative or style-only comments unless backed by a real failure
   mode or local standard.
7. Do not auto-fix during review without approval.
8. End skill changes with a `[[skill-review]]` pass and ignore local wiki-style
   skill links during that review.
9. For UI diffs, review design-system drift, token freelancing, fake proof,
   fake chrome, missing states, mobile CTA risk, and approved-design mismatch.

## Source Influence

### Matt Pocock Skills

- Source: <https://github.com/mattpocock/skills>
- Reviewed ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Reviewed material: `skills/in-progress/review/SKILL.md`,
  `skills/engineering/grill-with-docs/SKILL.md`,
  `skills/engineering/improve-codebase-architecture/SKILL.md`
- License: MIT

What we took:
- Separate standards review from spec compliance review.
- Identify the fixed point before diff review.
- Find spec sources and standards sources explicitly before judging the code.
- Compare implementation against the real requested behavior, not only general
  code quality.

Why:
- This source contributed the clearest protection against a common review miss:
  code that is clean but does not satisfy the issue, or code that satisfies the
  issue while violating local standards.

Local adaptation:
- The local skill keeps this as review axes inside one workflow instead of
  requiring multiple subagents by default.

### SuperPowers

- Source: <https://github.com/obra/superpowers>
- Reviewed ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Reviewed material: `skills/requesting-code-review/SKILL.md`,
  `skills/requesting-code-review/code-reviewer.md`,
  `skills/subagent-driven-development/code-quality-reviewer-prompt.md`,
  `skills/subagent-driven-development/spec-reviewer-prompt.md`
- License: MIT

What we took:
- Review early and before completion/merge.
- Give reviewers precise context instead of dumping session history.
- Do not trust implementation reports; read the actual diff.
- Treat spec compliance and code quality as distinct review jobs.

Why:
- This reinforces code review as an independent quality gate rather than a
  summary of the implementer's claims.

Local adaptation:
- The local skill uses the source's review discipline but does not require a
  subagent handoff for every review.

### Compound Engineering

- Source: <https://github.com/everyinc/compound-engineering-plugin>
- Reviewed ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Reviewed material: `docs/skills/ce-code-review.md`,
  `plugins/compound-engineering/skills/ce-code-review/SKILL.md`,
  selected reviewer agents under
  `plugins/compound-engineering/skills/ce-code-review/agents/`
- License: MIT

What we took:
- Scale review depth to diff size and risk.
- Use confidence/evidence gates before surfacing findings.
- Separate severity from action ownership.
- Include plan/spec discovery and residual-risk notes.

Why:
- The source is strong on preventing noisy review output and on adapting review
  depth to the actual change.

What we rejected:
- Multi-agent reviewer machinery as a default runtime requirement.
- Autofix modes and mode parsing in the generic local skill.
- Protected-artifact mechanics tied to the Compound plugin runtime.

Local adaptation:
- The local skill adopts the confidence and risk-scaling ideas while preserving
  the existing rule: do not auto-fix without approval.

### GStack

- Source: <https://github.com/garrytan/gstack>
- Reviewed ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Reviewed material: `review/SKILL.md`, `review/checklist.md`, selected
  reviewer specialists under `review/specialists/`
- License: MIT

What we took:
- Critical-first scan before broad review.
- High-value risk categories: data safety, races, LLM trust boundaries, shell
  injection, enum/value completeness, API contracts, migrations, performance,
  and testing.
- Suppression rules for harmless, speculative, or already-addressed findings.

Why:
- This source is useful for reviewer calibration: it biases attention toward
  issues that actually block safe merge and away from checklist noise.

What we rejected:
- GStack-specific setup, telemetry, update hooks, and specialist runtime
  assumptions.
- Default autofix behavior as part of review.

Local adaptation:
- The local skill includes a compact critical-first scan and evidence rules,
  leaving the rest as reference material rather than runtime machinery.

### Skill Review Discipline

- Source: local `skill-review/SKILL.md`
- Reviewed ref: `feat/external-skill-adaptation` on 2026-05-23
- Reviewed material: `skill-review/SKILL.md`
- License: repository-local process

What we took:
- Keep runtime skill bodies focused on behavior after activation.
- Avoid provenance and source-by-source rebuild notes in runtime `SKILL.md`.
- Ignore local `[[skill-name]]` references as valid integration points.

Why:
- Code review needs cross-skill integration while staying compact enough to
  load during real review work.

## Existing Local Baseline

Already covered locally:
- P0-P3 severity levels.
- No automatic fixing during review.
- Security, architecture, quality, removal, and convention reference files.
- Strong local web-project conventions and Cloudflare-specific review hooks.
- Symptom-layering detection for patches that mask root causes.

Added or sharpened by this pass:
- Spec/standards/risk as explicit separate axes.
- Fixed-point, spec-source, and standards-source discovery.
- Critical-first risk scan.
- Evidence and suppression rules to reduce noisy findings.
- Skill-level provenance for `code-review`.
- CSS review guidance for selector/markup consistency, orphaned states,
  duplicate or overridden declarations, stale custom properties, and additive-
  only CSS patches.

### Impeccable and Hallmark Visual Review Additions

- Sources: <https://github.com/pbakaus/impeccable>,
  <https://github.com/Nutlope/hallmark>
- Reviewed refs: Impeccable `1d5d745823aae7019044e8b0a621af4366dae224`,
  Hallmark `df5498f7f64102f559ccd1cb693d95136dd95b97`
- Reviewed paths: Impeccable detector registry and audit/critique references;
  Hallmark `SKILL.md`, `references/slop-test.md`, `references/structure.md`,
  `references/verbs/audit.md`
- Licenses: Apache-2.0 and MIT

What we took:

- review UI diffs for design-system drift and token freelancing
- flag invented metrics, testimonials, logos, and fake proof as trust problems
- flag fake browser/device/IDE chrome and unreadable mobile affordances
- treat missing component states as a review concern
- use detector output as evidence that still needs code/rendered confirmation

Local adaptation:

- Kept findings anchored to code, rendered behavior, or approved design docs.
- Did not make Impeccable or Hallmark detector/gate output an automatic merge
  blocker.
- Preserved local P0-P3 severity instead of adopting Hallmark
  critical/major/minor labels.

## Formal Trail

The fuller methodology record lives in:

- `methodology/disciplines/code-review.md`
- `methodology/ADAPTATION_LOG.md`
- `methodology/sources/gstack.md`
- `methodology/sources/superpowers.md`
- `methodology/sources/compound-engineering.md`
- `methodology/sources/matt-pocock-skills.md`
