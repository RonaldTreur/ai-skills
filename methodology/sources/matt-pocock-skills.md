# Source Inventory: Matt Pocock Skills

- Source URL: https://github.com/mattpocock/skills
- License: MIT
- Commit/tag/release reviewed: `4ae2317ddb22b046e26455e4f9c9b3aaaf62212d` (v1.3.2, 2026-10-31)
- Previously reviewed: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c` (2026-05-22, reviewer Vectrix)
- Retrieved: 2026-11-03 via shallow local clone
- Reviewer: Claude (Fable 5.1), with Ronald
- Local clone/path, if any: session scratchpad only; not kept

## Scope Reviewed (2026-11-03)

Full read of every `SKILL.md` in `skills/engineering/`, `skills/productivity/`, `skills/in-progress/` and `skills/misc/`, plus `README.md`, `SCOPE.md`, `CLAUDE.md`, `CHANGELOG.md` (1.2.0 to 1.3.2), `.out-of-scope/*.md`, `.agents/writing-docs.md`, `.agents/adr/*.md`, `skills/productivity/writing-for-agents/SKILL-MECHANICS.md`, and `skills/engineering/tdd/{tests,mocking}.md`.

Findings and the ranked relevance list live in `../disciplines/matt-pocock-rereview-2026-11.md`.

## Scope Reviewed (2026-05-22)

- `README.md`
- `skills/engineering/README.md`
- `skills/engineering/diagnose/SKILL.md` (now `diagnosing-bugs`)
- `skills/engineering/tdd/SKILL.md`
- `skills/in-progress/review/SKILL.md` (now `engineering/code-review`)
- `skills/engineering/grill-with-docs/SKILL.md`
- `skills/engineering/improve-codebase-architecture/SKILL.md`

## Relevant Disciplines

- Diagnosis
- Test-driven development
- Architecture review and deep-module design
- Code review
- Planning by interview (grilling), domain modelling, ADRs
- PR authoring
- Session retrospectives and environment improvement
- Skill writing and library governance
- Documentation and handoff

## Strong Ideas

From the May review, still current:

- Build a fast, deterministic feedback loop before theorizing; treat the loop as a product (faster, sharper, more deterministic).
- Falsifiable hypotheses and targeted probes; tagged debug logs; rerun the original repro; name the winning hypothesis in the commit.
- Review along separate axes (standards vs spec) with a pinned fixed point.
- TDD in vertical slices, one failing test at a time.
- Planning conversations resolve discoverable facts themselves and only ask the user for decisions.

New since May:

- A model-relative **no-op test** for every instruction, settled by running the document rather than arguing about it (`writing-for-agents`).
- The **cache** rule: a doc that restates what the environment already states is a cache and goes stale; cache only what the agent cannot look up.
- **Leading words**: one pretrained token (tight, red, seam, tracer bullet) in place of a restated sentence.
- **Model-invoked vs user-invoked** split with `disable-model-invocation: true`, so typed-only skills cost no context.
- A **closed catalog**: no new skills if the behaviour composes from existing ones; one `.out-of-scope/` note per rejected concept.
- `retro` as the loop that turns session failures into environment changes (navigation pointers, automated checks, coding standards, deleted no-ops).
- `pr` body shape: smallest visual, before/after evidence, one-way or two-way door, blast radius.
- `diagnosing-bugs` **Redact** section and *minimise* phase; "no correct seam for the regression test is itself the finding".
- Three-part ADR test: hard to reverse, surprising without context, a real trade-off.
- Expand–contract sequencing for wide mechanical refactors (`to-tickets`).
- Deep-module vocabulary and the deletion test (`codebase-design`).

## Adoption Risks

- Upstream is built around GitHub, GitLab or local-markdown trackers; Jira is explicitly out of scope. Work projects use a tracker upstream does not support, so tracker-bound skills (`to-spec`, `to-tickets`, `triage`, `wayfinder`, `implement-spec`) transfer as ideas only.
- Upstream rejects the harness question tool for grilling. Local skills must run in several harnesses, so they ask in plain chat and never name a harness-specific question tool (decided 2026-11-03).
- Upstream skills assume a per-repo `GLOSSARY.md` and `docs/adr/`. Decided 2026-11-03: one organisation-wide glossary in the cross-project wiki instead of per-repo files; ADR conventions remain unset.
- Several upstream skills are long (1.4k to 2.1k words). Adopt the gates and vocabulary, not the full text.

## Re-Review Trigger

Upstream ships monthly point releases. Re-review when a promoted skill this repo adapted from (`diagnosing-bugs`, `tdd`, `code-review`, `grilling`, `writing-for-agents`, `retro`, `pr`) changes behaviour per `CHANGELOG.md`, and at least every six months.
