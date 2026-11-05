# Discipline Review: Small Merges (November 2026)

- Date: 2026-11-05
- Reviewer: Claude (Fable 5.1), with Ronald
- Branch: `docs/pocock-rereview-2026-11`
- Local files reviewed: `add-feature/`, `agent-delegation/`,
  `design-prompt-export/`, `project-manager/SKILL.md`,
  `frontend-design/SKILL.md`, every runtime file linking the three,
  `README.md`, `methodology/DISCIPLINES.md`
- External sources reviewed: none new; applies merge candidates 2, 5 and 6 of
  `matt-pocock-rereview-2026-11.md` and upstream's closed-catalog rule
- Status: landed

## Local Baseline

Three skills existed whose behaviour composes from existing owners:

- `add-feature` (339 words) classified an existing-project feature request,
  made the smallest issue, and handed off to `project-manager`. A router with
  one destination.
- `agent-delegation` (789 words) was a packet shape, a status contract, a
  parallel-safety rule and a prompt template. Nothing in it needed a
  description in context; the skills that delegate reached it by link.
- `design-prompt-export` (368 words) exported an approved direction as a
  prompt and said in its own description that it was not the primary design
  workflow.

## Adopted Changes

All under log entry `2026-11-05-small-merges`.

- `project-manager` gained a Feature Intake section (classify, smallest issue
  shape, continue at dependency ordering) and the word "feature intake" in its
  description. `add-feature` is deleted.
- `project-manager/references/delegation.md` (557 words) holds the packet,
  parallel safety, status contract, controller duties and prompt shape, with
  the restraint rule (a protocol, not a reason to delegate) as its first
  paragraph. `project-manager` points at it from the next-work step. The six
  other skills that linked `[[agent-delegation]]` now name the reference by
  relative path; `e2e-playwright` lost a duplicate "related delegation
  workflow" line. `agent-delegation` is deleted.
- `frontend-design` gained a Prompt Export section (the TC-EBC frame, the
  prompt-only rule, the stop when a new direction would be needed) and a
  clause in its description. `design-prompt-export` is deleted.
- `README.md` and `methodology/DISCIPLINES.md` list the new owners;
  `~/.claude/skills` lost the three dangling symlinks.

Dropped as cache: the three skills' ownership and "when to use" lists, which
restated the library's layout and their own descriptions.

Effect on context: the repository holds 27 skills, 22 model-invoked, with about
4,170 characters of always-loaded description text, down from 33 skills and
about 5,800 characters before the first slice. The library is at the size the
re-review predicted (about 24) once `openclaw-contribution` is decided and
the Cloudflare and Solana references are counted as references.

## Skill-Level Attribution

- `project-manager/PROVENANCE.md` gained a dated section recording both folds
  and carrying the four delegation sources (SuperPowers, Compound Engineering,
  GStack, Matt Pocock) and the local restraint decision.
- `frontend-design/PROVENANCE.md` gained a dated section for the prompt
  export fold.

## Rejections And Deferrals

- Rejected: keeping `agent-delegation` as a model-invoked skill with a shorter
  description. No prompt ever triggers it; workflows reach it after deciding
  to delegate.
- Rejected: a user-invoked `design-prompt-export`. Its trigger is a request
  inside a design conversation, where `frontend-design` is already active.
- Deferred: `frontend-design` body size (440 lines), flagged by the audit
  before this slice and unchanged in kind. A trim is its own pass.

## Verification Notes

- `ruby skill-review/scripts/audit-skills.rb --root ~/Development/ai-skills --root ~/.claude/skills`:
  38 skills across two roots; no duplicate names, bodies, overlap or
  superseded names. `frontend-design` and `project-manager` remain on the
  body-bloat list as before.
- No runtime file outside `methodology/` links or paths the three removed
  skills; no dangling symlink in `~/.claude/skills`.
- No em-dashes introduced.
- `[[skill-review]]` pass on the two new sections, the reference and the
  changed hunks, run by a separate agent without this session's reading, with
  a check for dropped gates: see below.

### Review results

A separate agent reviewed the two new sections, the reference and the changed
hunks against the three removed files, without this session's reading.
Verdicts before fixes: NEEDS WORK for `project-manager` and `frontend-design`,
PASS for the reference and the five linking skills conditional on one shared
fix. Findings and what was done:

- Important, `project-manager`: two `add-feature` rules had been dropped.
  "Visual design" and "multiple phases" are back in the route-to-shaping
  branch, and "if the user asked to start and exactly one issue is ready,
  invoke implement-issue on it" is back at the end of Feature Intake, with the
  ADR check of issue decomposition named on the way to dependency ordering.
- Important, `project-manager` description: "feature intake" was the section's
  name, not a user's words, so "add a dark-mode toggle" might not have reached
  it. Now "turning feature requests into issues", also in the ownership line.
- Important, `frontend-design`: Prompt Export sat at line 412 of a skill whose
  intro says "use a divergent-variant workflow", so a model would start asking
  taste questions before learning it should export. One line after Core Idea
  now names the two requests that bypass the variant workflow. The Design
  Inputs section no longer defines a second, shorter prompt frame; it points at
  Prompt Export.
- Important, all linking skills: the `../project-manager/references/...`
  relative path only resolves against the skill file's own folder, which not
  every harness exposes. Every pointer now reads "`references/delegation.md`
  under [[project-manager]]"; the same fix was applied to `test-audit`'s
  junk-pattern pointer from the previous slice.
- Polish applied: the parallel-safety gates and controller duties in the
  reference are lists again; the shaping branch reads "data/auth/deployment
  boundaries" as before.
- Probes: a "the app already works, add CSV export and get it on the board"
  request reaches Feature Intake rather than `implement-issue`; "DESIGN.md is
  approved, write me a prompt for an external generator" reaches Prompt Export
  without variants or questions; "no DESIGN.md yet" falls back to the variant
  workflow.

Verdict after fixes: PASS for every changed file, with the reviewer's findings
applied as written. Descriptions: `project-manager` 188 characters,
`frontend-design` 232 characters.
