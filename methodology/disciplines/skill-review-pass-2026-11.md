# Skill Review Pass over the November 2026 Branch

- Date: 2026-11-05
- Branch: `docs/pocock-rereview-2026-11` at `5054c41`
- Method: the nine-step review order of the rewritten `skill-review` skill,
  applied by three separate agents to the final text of every skill the
  branch added or changed, without this session's reading. The audit script
  was not rerun (clean at the previous commit).
- Status: applied on 2026-11-05 in three commits (testing and QA group, lifecycle group, meta group); see Applied below

## Verdicts

| Skill | Verdict | Findings introduced by this branch |
| --- | --- | --- |
| skill-review | PASS | "fresh sessions" asks for what one session cannot do |
| retro | PASS | line 9 restates the fail-closed list |
| test-audit | PASS | none |
| unit-vitest | PASS | none |
| testing | NEEDS WORK | plan sentence caches the template headings; junk families in two places |
| external-skill-adaptation | NEEDS WORK | none (pre-existing duplication) |
| gh-pipeline | NEEDS WORK | none (pre-existing size) |
| project-manager | NEEDS WORK | "judge from the artifact" stated three times; issue field list three times |
| implement-issue | NEEDS WORK | review-from-artifact rule stated four times |
| code-review | NEEDS WORK | none (dead references, cached rules, pre-existing) |
| frontend-design | NEEDS WORK | TC-EBC defined three times (Prompt Export added a third) |
| start-new-project | NEEDS WORK | none (pre-existing role scripts in phases, wiki-link form for files) |
| browser-qa | NEEDS WORK | none (duplicated auth paragraph, visual mode inline) |
| debugging | NEEDS WORK | none (four rules stated three times) |
| developing-web-projects | NEEDS WORK | none (defaults stated three times, trigger says "creating" only) |
| e2e-playwright | NEEDS WORK | none (`tests/` versus `tests/e2e/` mismatch) |
| openclaw-contribution | NEEDS WORK | none (names a skill that does not exist; `gh` create without approval gate) |

No Critical finding anywhere. No harness-specific tool name in runtime text.
Every `[[link]]` resolves and no model-invoked skill links a user-invoked one.

## Findings by skill

### skill-review

- Polish, L26: "in fresh sessions where possible" asks for something the agent
  cannot do inside one session. Fix: hand the three prompts to the person.
- Polish, L30-36: Library audit branch inline at 7 lines; acceptable.

### retro

- Polish, L9: "the classes named in step 4 need approval per item" restates
  L24. Delete the clause.

### testing

- Important, L12: the sentence listing what `TEST_PLAN.md` names restates the
  template's headings; a cache that drifts. Fix: "from `templates/test-plan.md`;
  fill every section or mark it not applicable" and drop the list.
- Polish, L3: description carries identity the body owns.
- Polish, L40-47 versus `references/junk-patterns.md`: two sources of truth;
  shrink the inline block to four family names with one example each.
- Polish, `templates/test-plan.md:12`: "(default 100% unit thresholds)"
  restates Enforcement.

### test-audit

- Polish, L20 and L33: "implementation-shaped test is suspect, not deletable"
  twice. Keep L33.
- Polish, L31: the baseline-failing test is an instruction, not a retention
  criterion; move out of the "Also keep" list.
- Polish, L55: bare prohibition; "Stop any Vitest watcher before editing".

### external-skill-adaptation

- Important, L13-25 versus L29-92: Core Rules 2, 4, 7, 8, 9, 11 are restated
  by Workflow steps. Keep rules 1, 3, 5, 6, 10; delete the rest.
- Important, L92: step 8 is one semicolon sentence of seven gates; make it a
  list; "run validation when available" names nothing; the `[[link]]`
  exception is now skill-review's own rule.
- Polish: intro restates the description; "prefer debugging first" is a
  snapshot; References list repeats pointers; template hardcodes four source
  names and restates rules a third time.

### gh-pipeline

- Important: 232 lines, over the body threshold, with Setup (L202-217) only
  some runs reach. Move Setup to `references/setup.md`.
- Polish: L9-10 restate the description; L12-19 duplicate Stage Ownership;
  diagram duplicates the transition list; "ask before creating labels in
  bulk" twice; description has no trigger sentence.

### project-manager

- Important, L75-96: Repo Intake is cache plus choreography (three git
  commands, a 13-path list). Fix: one sentence naming the planning docs.
- Important, L42-53, L207-208, `delegation.md:58`: "judge from the branch, PR
  and checks, not a report" three times. Keep Merge Gate.
- Important, L118-124, L152, L184-192: the issue field list three times. Define
  once under Issue decomposition.
- Polish: "Compact prompt this skill should satisfy" is documentation for a
  person; `.github/copilot-instructions.md` is harness-specific (also
  implement-issue L54).

### implement-issue

- Important, L49-52, L63-68: git-state commands are no-ops; L66-68 restates
  step 4.
- Important, L105-106, L125-126, L131-134, L154-155: the independent review
  from the artifact rule four times. Keep step 5 and the Merge list.
- Important, L163-182: Phase Heads-Ups lists ten phases the model announces
  anyway; keep the three-line template.
- Polish: `agents/openai.yaml` is a harness manifest whose text says "dev
  merge" while L72-74 forbid creating `dev`; Delegation section inline when
  the pointer suffices.

### code-review

- Important: `references/architecture.md`, `quality.md`, `security.md`,
  `removal-plan.md` are never pointed at from SKILL.md. Gate them at the
  matching steps or delete them.
- Important, L45 versus `architecture.md:32-44`: the developing-web-projects
  rules cached twice; replace with "enforce [[developing-web-projects]]".
- Important, L79: `impeccable detect` is an external tool only some
  environments have.
- Important, L89-100: Output Contract duplicates step 8 and the template.
- Polish: "be direct", "always classify by severity" are no-ops; git and rg
  commands are no-ops; Integration Notes repeat L12-14; the template's
  web-only convention checklist applies to every review.

### frontend-design

- Important, hierarchy: Component Scope, Reference Study, Prompt Export and
  the feedback template are branch-only and inline; about 120 lines could
  move behind gated references.
- Important, L113-121, L146-152, L420-427: TC-EBC defined three times.
- Important, L85-92, L123-141: three overlapping question policies; one rule.
- Polish: When To Use restates the description; 17-item macrostructure
  vocabulary where seven carry the idea.

### start-new-project

- Important: `[[phases/phase-1-brief]]` uses the wiki-link form for files;
  resolves to nothing. Write the path.
- Important, default path: `phases/phase-1-brief.md` opens on every run, so it
  belongs inline; `phase-2-design.md` restates frontend-design.
- Important, role scripts: L181-194, phase-1 L59-67, phase-3 L31-50 name
  performers ("one product/UX lens, one engineering lens", "each planner").
  State the gate; leave who performs it to the harness.
- Important: Ground Rules and Start Defaults say the same things twice;
  Handoff repeats phase-3.
- Polish: four-way research taxonomy is choreography; the Discord phase is a
  cache of one past project.

### browser-qa

- Important, L60-84: auth section duplicates `testing` L53.
- Important, L106-144: `visual` mode and the CSS block are branch-only inline.
- Important, L121-133 versus `references/impeccable-detector.md`: the
  reference restates the body.
- Polish: "prefer the project's build commands", "check content appears" are
  defaults; the profile rule explains itself to a person.

### debugging

- Important, L10-15, L22-25, L66-69: the same four rules three times.
- Polish, L101: "follow repo git rules" is a no-op; L97-100 backtick the links.

### developing-web-projects

- Important, L3: trigger says "creating" but L127-131 govern changes; add "or
  changing".
- Important, L8, L96-113, L115-120, L191-214: the defaults three times and a
  Tone section that is pure no-op; about 45 lines.
- Important, L56-61: design guidance duplicates `frontend-design`.
- Polish: plain `x/SKILL.md` paths where the repo uses `[[x]]`.

### e2e-playwright

- Important: SKILL.md L18 and the generator say `tests/`; SKILL.md L56 and
  unit-vitest say `tests/e2e/`. The generator writes to the wrong folder.
- Important, L47-52: auth rules duplicate `testing`.
- Polish: L30 changes nothing; healer hardcodes `npx playwright test` against
  the CI guide's "identical scripts"; "without asking follow-up questions"
  sits against the blocker routing.

### unit-vitest

- Polish: coverage rule duplicates `testing`; model defaults (AAA, behaviour
  over implementation, avoid `any`); gate the Cloudflare guide with "read when
  the target is a Worker".

### openclaw-contribution

- Important, L65: "also use git-conventions" names a skill that exists
  nowhere.
- Important, L88-90: `gh issue create` and `gh pr create` post publicly to a
  third-party repo with no approval gate. Add "show the body and wait for the
  user's go-ahead".
- Important, reference L16-69: the template field lists cache files Preflight
  already reads from source.
- Polish: NOT_ENOUGH_INFO, unauthenticated `gh` and PR expectations each
  appear three times; the description carries a second sentence of body.

## Cross-cutting

- The safe-auth paragraph (seeded users, secrets out of git and reports,
  CAPTCHA and 2FA mark coverage blocked, setup via project-manager) is written
  out in `testing`, `browser-qa` and `e2e-playwright`. Keep it once.
- The five lifecycle skills each open with a 10-15 line Ownership Boundary
  block restating the others. One routing table in `project-manager` with
  one-line pointers elsewhere would remove about 50 always-loaded lines.
- The pattern across the thirteen NEEDS WORK verdicts is the same: a rule
  stated two to four times inside one skill or across siblings, and branch-only
  material inline. Both are what the cache and hierarchy checks exist to find.

## Applied

Every finding above was applied on 2026-11-05, with these judgment calls:

- The five lifecycle Ownership Boundary blocks: `project-manager` keeps the
  routing table as the hub; `implement-issue`, `browser-qa` and `gh-pipeline`
  now open with one pointer line; `start-new-project` and `frontend-design`
  keep theirs because every entry is a link the body uses.
- The safe-auth paragraph lives in `testing`; `browser-qa` keeps only the
  browser-specific rules and `e2e-playwright` one pointer.
- `start-new-project` Phase 1 was inlined and compressed rather than kept as a
  file opened on every run; `phase-1-brief.md` and `phase-2-design.md` are
  deleted. Phase 3 and the Discord phase stay as gated files.
- `frontend-design` moved Component Scope, Reference Study and Prompt Export
  behind references and went from 447 to 321 lines; the feedback template is
  one sentence.
- `code-review` gates its four reference checklists at the matching workflow
  steps instead of deleting them.
- `implement-issue/agents/openai.yaml` was deleted, as `skill-maintenance`'s
  was; the earlier claim that no other skill carried a Codex manifest was
  wrong, and now none does.
- `openclaw-contribution` gained the approval gate before `gh` creates
  anything public; its reference keeps only paths and the contributing rules
  the templates do not state.
- `openclaw-contribution` had no `PROVENANCE.md`; one was created.

A second fresh-eyes pass over the trimmed text follows in the same discipline
review.
