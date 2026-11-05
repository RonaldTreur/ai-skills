# Discipline Review: Role-Script Removal (November 2026)

- Date: 2026-11-03
- Reviewer: Claude (Fable 5.1), with Ronald
- Branch: `docs/pocock-rereview-2026-11`
- Local files reviewed: `project-manager/SKILL.md`, `implement-issue/SKILL.md`,
  `agent-delegation/SKILL.md`, `code-review/SKILL.md`,
  `start-new-project/SKILL.md`, `browser-qa/SKILL.md`,
  `e2e-playwright/roles/*.md`, `external-skill-adaptation/templates/discipline-review.md`,
  `README.md`, `methodology/DISCIPLINES.md`
- External sources reviewed: none new; applies decisions 1 and 2 of
  `matt-pocock-rereview-2026-11.md`
- Status: landed

This slice is cross-cutting by design: it applies one rule to every runtime
skill rather than reworking one discipline. The rule, decided on 2026-11-03:
skills describe the work and its gates, never who performs them, and name no
harness-specific tool.

## Local Baseline

Nine runtime files carried text from the OpenClaw era:

- `project-manager` had a Default Agent Roles section (Merlin coordinates,
  Vectrix implements, Claude-review gates) and blocked review until a delegate
  report listed seven "loop evidence" fields.
- `implement-issue` preferred Vectrix, demanded the same seven report fields,
  named Codex/OpenClaw subagents, defaulted to Claude-review, and let
  `code-review` use the OpenClaw `autoreview` executable.
- `agent-delegation` required the loop-evidence fields in every return packet.
- `code-review` had an Executable Helper section built around `autoreview` and
  its `--parallel-tests` flag.
- `start-new-project` routed grounding through `last30days`, `x_search`,
  `deep-research`, Brave search and OpenClaw memory.
- `browser-qa` named the OpenClaw-managed browser profile.
- The three `e2e-playwright` role files were headed "OpenClaw adaptation" and
  the planner listed OpenClaw tools.

The role scripts built trust between agents that could not see each other's
work. The harness now shows every participant the same diff, PR and CI, so a
report that restates them is a cache of the environment.

## Adopted Changes

All under log entry `2026-11-03-role-script-removal`.

- `project-manager`: the roles section became a Merge Gate with three required
  artifacts: the branch carries implementation, tests and the implement-issue
  verification; an independent review ran on the PR diff with valid P0-P3
  findings fixed and targeted verification rerun; the PR links the issue. The
  compact prompt and the delegate-return rule lost their role names.
- `implement-issue`: delegation verifies the artifact a report points to
  (branch, commits, test output, PR); the review loop uses one independent
  review of the PR diff; the gate starts from a branch whose checks ran and a
  PR with the diff. The `autoreview` reference is gone.
- `agent-delegation`: return packets name the branch, PR and verification that
  ran; the controller inspects those before routing to an independent reviewer.
- `code-review`: Executable Helper became Automated Helper and describes any
  helper the harness or repository provides, advisory only, skipped for trivial
  diffs.
- `start-new-project`: harness-neutral grounding bullets (web and social
  search, a commissioned research report, the harness's memory and session
  history).
- `browser-qa`: the harness's own controlled browser profile, with the reason
  kept.
- `e2e-playwright/roles/*`: headers and the planner's tool list made neutral;
  planner, generator and healer stay as work roles.
- `README.md`, `methodology/DISCIPLINES.md` and the discipline-review template:
  the same wording change.

Kept on purpose: `openclaw-contribution`. It is a contribution workflow for one
external repository, now user-invoked, so it costs nothing until typed. It still
names a local clone path on another machine. Decided 2026-11-05: it stays; it
serves the OpenClaw machine and costs nothing here.

Runtime lines: 115 added, 91 removed across 20 files, with the removed lines
denser. The six changed skills now total about 6,400 words.

## Skill-Level Attribution

Each of the seven changed skills (`project-manager`, `implement-issue`,
`agent-delegation`, `start-new-project`, `browser-qa`, `e2e-playwright`,
`code-review`) gained a dated Local Integration Decision section in its
`PROVENANCE.md` naming what was removed and what replaced it.

## Rejections And Deferrals

- Rejected: keeping the roles under neutral names (coordinator, implementer,
  reviewer). The gates can be stated as artifacts, so no role needs naming.
- Rejected: moving the loop-evidence fields to a reference file. They were a
  cache of what the PR and CI show, not optional depth.
- Deferred: deleting or relocating `openclaw-contribution`; Ronald's call.
- Deferred: the merge of `agent-delegation` into a reference under
  `project-manager` (merge candidate 5 of the re-review). This slice only
  neutralised its text.

## Verification Notes

- `ruby skill-review/scripts/audit-skills.rb --root ~/Development/ai-skills --root ~/.claude/skills`:
  no duplicate names, no identical bodies, no superseded names; body-bloat list
  unchanged from the skill-meta slice.
- A grep over every runtime `*.md` outside `methodology/` and the PROVENANCE
  files for Merlin, Vectrix, Claude-review, OpenClaw, Codex, loop evidence,
  RoundTable, autoreview, last30days, x_search and deep-research returns only
  `openclaw-contribution/`.
- No em-dashes introduced.
- `[[skill-review]]` pass on the changed hunks, run by a separate agent without
  this session's reading: see below.

### Review results

A separate agent reviewed the staged hunks against the skill-review order
without this session's reading. Verdicts before fixes: NEEDS WORK for
`agent-delegation`, `project-manager`, `implement-issue` and the generator role;
PASS for `code-review`, `browser-qa`, `start-new-project`, planner and healer.
Findings and what was done:

- Critical, `agent-delegation` prompt template: the old seven-field return
  contract survived in the Return block and contradicted the edited packet.
  Replaced with "branch, PR, and the verification that ran".
- Important, `implement-issue`: the new gate ("a branch whose checks ran and a
  PR with the diff") was weaker than the old one, which blocked review until
  browser QA and the self-review loop had reported. The gate now requires a PR
  whose body records the checks, browser QA and review findings listed under PR
  And Merge, and the Merge only when list gained the independent review.
- Important, `project-manager` labels: `agent:vectrix` and `agent:merlin`
  reintroduced role assignment. Deleted.
- Important, generator role: `browser` and `exec` tool names remained.
  Reworded to match the planner.
- Polish applied: branch and PR added to the delegation packet's expected
  report; the no-op sentence "who implements and who reviews is the harness's
  choice" deleted; the deep-research bullet now says "the harness's
  deep-research tool, if one exists"; the `.codex/*` instruction path in
  `implement-issue` and `project-manager` became "any other agent instruction
  file the repo carries".
- A case-insensitive sweep afterwards for every removed name returns nothing
  outside `openclaw-contribution/`.

Verdict after fixes: PASS for every changed file, with the reviewer's findings
applied as written.
