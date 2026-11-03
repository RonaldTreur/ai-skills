# Re-review: Matt Pocock Skills (November 2026)

- Date: 2026-11-03
- Reviewer: Claude (Fable 5.1), with Ronald
- Branch: `docs/pocock-rereview-2026-11`
- Scope: research only. Cross-discipline on purpose, at Ronald's request. No runtime skill changed in this pass; adoption decisions are listed as open questions at the end.
- External source: `mattpocock/skills` at `4ae2317ddb22b046e26455e4f9c9b3aaaf62212d` (v1.3.2, 2026-10-31, MIT). Previous review: `b8be62f` (2026-05-22), see `../sources/matt-pocock-skills.md`.
- Local files reviewed: every `*/SKILL.md` in this repo (33 skills), `README.md`, `methodology/DISCIPLINES.md`, `methodology/ADAPTATION_LOG.md`, and the 11 Ockto work skills in `~/.claude/skills` that are not symlinked from this repo (`commit-to-branch`, `create-jira-task`, `create-release`, `create-release-card`, `create-store-release-notes`, `create-wiki`, `pseudonymize-kadaster-pdf`, `read-wiki`, `snyk-findings`, `sonar-findings`, `graphify`).

Three questions drove this pass:

1. Which of Pocock's skills matter for the work Ronald actually does?
2. Where do they overlap with local skills, and what is worth merging?
3. Has model capability moved far enough that the local library should shrink, and how would we know?

## 1. What changed upstream since May

The repo roughly doubled and then got a governance layer. The parts that matter here:

- **Renames.** `diagnose` → `diagnosing-bugs`, `review` → `code-review` (now promoted), `writing-great-skills` → `writing-for-agents`, `CONTEXT.md` → `GLOSSARY.md`. Existing provenance entries that cite the old paths still resolve conceptually but not by path.
- **New promoted skills.** `pr`, `retro`, `implement-spec`, `wizard`, `to-questionnaire`, `wait-what`, `codebase-design`, `domain-modeling`, `prototype`, `research`, `wayfinder`, `triage`, `setup-matt-pocock-skills`, `ask-matt` (a router), `handoff`, `teach`.
- **One deletion with a telling reason.** `resolving-merge-conflicts` was removed in 1.3.0 with the note that nothing replaces it: the agent now handles merge conflicts without a skill. That is the first upstream data point for Ronald's "fewer skills" hypothesis.
- **Invocation split.** Every skill is now either *model-invoked* (description always in context) or *user-invoked* (`disable-model-invocation: true`, zero context cost, reachable only by typing it). 16 of 27 promoted skills are user-invoked. Only about 2.2k characters of description are loaded per turn for the whole promoted set.
- **A closed catalog.** `SCOPE.md` and `.out-of-scope/new-skills.md`: no new skills are accepted; if a behaviour composes from existing skills, it does not get one. Jira is explicitly out of scope as a first-class tracker (`.out-of-scope/mainstream-issue-trackers-only.md`); it goes through a freeform "Other" description.
- **`writing-for-agents` became the theory.** It names the *no-op test* (an instruction the model already obeys by default costs tokens to say nothing, and the test is model-relative, settled by running the document, not by debate), the *cache* rule (a doc that restates `package.json` or `--help` is a cache that goes stale; only cache what the agent cannot look up), *leading words*, and the *two loads* (context load on the model vs cognitive load on the human). `retro` applies these to steering files after every session, with explicit "No-ops" and "Global AGENTS.md" categories.

Size pattern worth noticing: the skills that grew are judgment frameworks (`diagnosing-bugs` 1.4k words, `wayfinder` 2.1k, `writing-for-agents` 1.8k). The skills that shrank or stayed tiny are procedure (`implement` 103 words, `research` 138, `handoff` 144, `grill-me` 22, `wait-what` 60). Procedure is what the model now does unprompted; judgment is what still needs writing down.

## 2. Ordered relevance for Ronald's work

Ranked on four things: fit with Ockto work (Jira, Teams, Sonar/Snyk, white-label SDKs, Web Components, customer financial data) and personal projects (GitHub, OpenClaw, Cloudflare), whether a local owner already exists, adaptation cost, and whether it pushes the library toward smaller rather than larger.

### Tier 1: take now

| # | Skill | Why it fits | Local owner today | Suggested move |
|---|-------|-------------|-------------------|----------------|
| 1 | `writing-for-agents` (+ `SKILL-MECHANICS.md`) | The yardstick for question 3. No-op test, cache rule, leading words, model- vs user-invoked split. Everything else in this review applies it. | `skill-review`, `skill-maintenance` (procedural, no theory) | Adopt as the reference that `skill-review` and `skill-maintenance` judge against. Candidate to merge those two into one skill that cites it. |
| 2 | `retro` | The engine that keeps a library small: after a session, propose environment changes (nav pointers, automated checks, coding standards, delete no-ops), mechanical rules become lint, judgment rules become `CODING_STANDARDS.md`. | `run-workflow-retrospective` (post-merge PR scorecard, OpenClaw-specific, 1.6k words) | Adapt `retro`'s seven categories into `run-workflow-retrospective` or replace it. The "No-ops" and "Global AGENTS.md" categories are the ones missing locally. |
| 3 | `diagnosing-bugs` | Ockto bugs are iframe flows, bank logins, intermittent source journeys: hard to reproduce, full of secrets and PII. The **Redact** section, the *minimise* phase, the hard gate "no red-capable command, no hypotheses", and "no correct seam is itself the finding" are all new since May. | `debugging` (561 words, already adapted the May version) | Keep `debugging` as owner and short. Pull in Redact (mandatory for Ockto data), minimise, and the seam finding. Do not import the 10-item loop catalogue wholesale; the model knows those. |
| 4 | `pr` | Smallest visual that shows the change, before/after evidence, one-way vs two-way door, blast radius. For white-label SDK and iframe changes, "blast radius" maps directly onto which brands and consumers are affected. Also feeds `create-release-card`. | PR body checklists scattered in `implement-issue` and `documentation-handoff` | Adopt as one small model-invoked skill, or fold the template into `documentation-handoff`'s PR section and delete the two checklists. |
| 5 | `grilling` | The interview primitive: rounds, a frontier of askable questions, a recommended answer per question worded so "yes" accepts it, facts are the agent's job and decisions are the user's. Ronald's solution-architecture work (RFCs, Confluence designs, stakeholder trade-offs) is exactly this. | "Grill the domain before planning" is a one-line principle inside `start-new-project`; no primitive | Adopt at its upstream size (about 330 words). Ask in plain chat, as upstream does: the skills must work across harnesses, so no skill names a harness-specific question tool (decided 2026-11-03). |
| 6 | `domain-modeling` | Ockto's vocabulary is overloaded (bron, journey, dossier, consent, brand, white-label, source) and lives in people's heads. One Ockto-wide glossary in the wiki vault (decided 2026-11-03, no per-repo file) plus the three-part ADR test (hard to reverse, surprising without context, a real trade-off) is sharper than the local ADR criteria. Also feeds `create-wiki`. | `documentation-handoff` owns ADRs and `DECISIONS.md`; no glossary discipline | Pull the ADR test and "a glossary is not a spec" into `documentation-handoff`. Add glossary challenge behaviour to `grilling` rather than as its own skill. |

### Tier 2: useful, take selectively

| # | Skill | Why | Local owner | Suggested move |
|---|-------|-----|-------------|----------------|
| 7 | `tdd` (+ `tests.md`, `mocking.md`) | Vertical slices were adopted in May. New: pre-agreed seams confirmed with the user, each seam annotated with what it catches and misses; the *tautological test* anti-pattern; refactoring belongs to review, not the loop. | `unit-vitest`, `testing-orchestrator`, `test-audit` | Add tautological tests to `test-audit`'s junk patterns and seam agreement to `testing-orchestrator`. No new skill. |
| 8 | `codebase-design` | Deep-module vocabulary (module, interface, depth, seam, adapter, leverage, locality), the deletion test, "one adapter is a hypothetical seam, two is a real one". Directly applicable to SDK and Web Component API design. | None (architecture is "owned by lifecycle stage") | A reference doc, not a skill: `references/deep-modules.md` linked from `developing-web-projects` and `code-review`. |
| 9 | `prototype` (LOGIC branch) | A single HTML file that drives a state machine through guided walkthroughs a non-developer can click. Ockto journey state machines (XState) are the obvious target. | `building-xstate-state-machines` (rules, not a prototyping flow) | Add a short "prototype the machine in one HTML file" section to the XState skill. |
| 10 | `to-questionnaire` | Grill the *send*, not the subject: who it goes to, what you need back, then aim questions at the gap. Ronald regularly needs answers from product, security, compliance or brand customers. | None | Adopt as-is, user-invoked. 470 words, standalone. |
| 11 | `code-review` (Fowler smell baseline) | The two-axis split was adopted in May. New: a fixed set of 12 Fowler smells as a baseline that repo standards override, and parallel sub-agents per axis. | `code-review` (967 words hot file, 3.3k total, already heavier than upstream) | Take the smell list as a reference file only if reviews are missing those smells in practice. Otherwise skip; local is already richer. |
| 12 | `to-tickets` (expand–contract) | Wide mechanical refactors (rename a shared type across every brand or consumer) are sequenced as expand, migrate in batches, contract. The rest of the skill is GitHub-tracker plumbing already covered locally. | `project-manager`, `add-feature` | Add the expand–contract rule to `project-manager`'s decomposition step. |
| 13 | `wizard` | Bash wizard for human-only steps (dashboards, secrets, store consoles). | `snyk-findings`, `sonar-findings` already drive dashboards; `managing-aephia-api-keys` | Keep in mind for app-store and Firebase console procedures. Not now. |
| 14 | `handoff` | 144 words: save to temp, "suggested skills" section, reference artifacts instead of duplicating, redact. | `documentation-handoff` (1.1k words) and the desktop app's own session hand-off | Nothing to take except the brevity lesson. |
| 15 | `wait-what` | 60 words. Re-pitch the last message in simplified English using the glossary. | None | Free to add once the Ockto glossary page exists in the wiki vault. |

### Tier 3: low fit, read for ideas only

- `to-spec`, `implement`, `implement-spec`, `triage`, `wayfinder`, `setup-matt-pocock-skills`, `ask-matt`: built around a GitHub/GitLab/local-markdown tracker with Jira explicitly excluded. Ockto work runs on Jira; personal work is already covered by `project-manager`, `add-feature`, `implement-issue`, `agent-delegation`. The ideas (tracer-bullet tickets with blocking edges, a frontier, decision tickets, "plan, don't do") are mostly adapted already. `implement` at 103 words is the benchmark for how short a procedural skill can be.
- `research`, `teach`, `loop-me`, `writing-*`, `chief-of-staff`, `software-factory`, `scaffold-exercises`, `setup-pre-commit`, `git-guardrails-claude-code` (Claude Code permission rules cover this now), `migrate-to-shoehorn` (TypeScript test fixtures; mildly relevant, but `fromPartial` is a one-line suggestion, not a skill).
- `setup-ts-deep-modules` (dependency-cruiser entry-point rules) could matter for the pnpm monorepos, but it is in-progress upstream.
- `improve-codebase-architecture`: a nice periodic survey; user-invoked; defer until `codebase-design` vocabulary exists locally.

## 3. Overlap map and merge candidates

### Pocock ↔ local, by discipline

| Discipline | Pocock | Local | Verdict |
|------------|--------|-------|---------|
| Debugging | `diagnosing-bugs` 1.4k | `debugging` 0.6k | Local is the right size; patch in Redact, minimise, seam finding. |
| Code review | `code-review` 1.1k | `code-review` 1.0k hot, 3.3k total | Local is broader (security, CSS, design drift, autoreview). Keep local. |
| Testing | `tdd` 0.6k + 2 refs | 7 skills, about 5k hot words (`test-planning`, `testing-orchestrator`, `unit-vitest`, `e2e-playwright`, `test-ci-policy`, `test-audit`, `browser-qa`) | Biggest merge opportunity. See below. |
| Planning / shaping | `grilling` + `domain-modeling` + `to-spec` + `wayfinder` | `start-new-project` 1.2k + 3.7k in phases | Local is a process; Pocock's is a primitive plus artifacts. Adopt the primitive, keep the process only where it adds gates. |
| Backlog / tickets | `to-tickets`, `triage`, `implement`, `implement-spec` | `project-manager`, `add-feature`, `implement-issue`, `agent-delegation`, `gh-pipeline` (about 4.7k hot words) | Local is heavy on OpenClaw role choreography. See below. |
| Docs / handoff | `handoff`, `pr`, `domain-modeling` | `documentation-handoff` 1.1k | Fold `pr` template and the ADR test in; otherwise keep. |
| Skill meta | `writing-for-agents`, `retro` | `skill-review`, `skill-maintenance`, `external-skill-adaptation`, `run-workflow-retrospective` (about 3.6k hot words) | Four local skills doing what two upstream skills do. See below. |
| Architecture | `codebase-design`, `improve-codebase-architecture`, `setup-ts-deep-modules` | none | Gap. Fill with a reference, not a skill. |
| Design / frontend | none | `frontend-design` 2.3k, `css-design-tokens` 1.6k, `developing-web-projects` 1.3k, `design-prompt-export`, `use-lucide-icons`, `generating-web-components` | Not Pocock territory. Out of scope here. |
| Platform refs | none | Cloudflare ×3, Solana, XState, Aephia, OpenClaw | Reference material; costs nothing until loaded. Leave. |

### Local ↔ local merges worth considering

These reduce skill count and always-loaded descriptions without losing a gate.

1. **Testing: 7 → 3.** Merge `test-planning`, `testing-orchestrator`, `test-ci-policy` and `test-audit` into one `testing` skill: strategy, outside-in order, value bar, CI policy. Keep `unit-vitest` and `e2e-playwright` as tool-specific references (they are already mostly reference files). Keep `browser-qa` separate because it is a different activity (exploratory, not authoring). Upstream manages the same ground with `tdd` plus two reference files.
2. **Lifecycle front door: `add-feature` into `project-manager`.** `add-feature` is a 339-word router whose entire job is "classify, make the smallest issue, call project-manager". That is one paragraph in `project-manager`.
3. **Skill meta: `skill-review` + `skill-maintenance` → one skill, with `writing-for-agents` as its yardstick.** One reviews a skill, the other reviews a library; both are "is this skill text earning its context cost". The audit script stays. `external-skill-adaptation` stays separate (it is a provenance process) but should become user-invoked: it fires a few times a year.
4. **Retrospective: `run-workflow-retrospective` ⇄ `retro`.** Local is a PR-scorecard with guarded auto-actions for OpenClaw. Upstream is an environment retro. Two skills for "look back and improve the environment" is one too many; see open question 5 for the recommendation to replace the local one.
5. **`agent-delegation` → a reference file.** It is a packet shape, a status contract and a prompt template. Nothing in it needs a description in context; the skills that delegate (`implement-issue`, `project-manager`, `start-new-project`) can link `references/delegation-packet.md`. Note that the Claude desktop app now has its own session hand-off, task list and side-session mechanics that cover half of what the packet describes.
6. **`design-prompt-export` into `frontend-design`.** 368 words whose description already says "do not use as the primary design workflow". That is a section, not a skill.

Net effect if all six land: 33 → about 24 skills, and the always-loaded description text drops by roughly a third before any individual description is tightened.

### The Ockto work skills (not in this repo)

The 11 personal skills are a separate problem and a bigger one for context cost. Their descriptions are the longest on the machine: `sonar-findings` 741 characters, `create-wiki` 679, `snyk-findings` 664, `create-store-release-notes` 511. Together they add about 4k characters per turn on top of this repo's 5.8k. Most of them are user-driven commands (`/create-release`, `/create-wiki`, `/pseudonymize-kadaster-pdf`, `/read-wiki`) and should be user-invoked with a one-line description. `snyk-findings` and `sonar-findings` are the two that genuinely need model triggering, and even those descriptions can lose their "even if they don't say X" clauses: the model matches on "Snyk" and "CVE" without being told it may.

## 4. The "smarter models need fewer skills" hypothesis

### What the evidence says

Supporting:

- Upstream deleted `resolving-merge-conflicts` because the agent no longer needs it, and keeps `implement` at 103 words.
- Upstream refuses new skills on the ground that behaviour composes from existing ones.
- `writing-for-agents` makes the point structurally: the no-op test is model-relative, so every model generation moves some instructions from "load-bearing" to "costs tokens to say nothing". A library that is never re-tested against the current model accumulates sediment.
- Locally, the heaviest text is procedure the model does unprompted: intake checklists (`git status -sb`, `git remote -v`, read `AGENTS.md`), "write the failing test, confirm it fails, make it pass", "report scope summary then findings". `implement-issue` and `project-manager` spend most of their 1.1k and 1.3k words on this plus OpenClaw role choreography.

Not supporting, or at least complicating:

- Upstream's judgment skills got *longer*, not shorter. `diagnosing-bugs` doubled. The hard gate ("no red-capable command, no Phase 2") exists because a capable model still jumps to a hypothesis under time pressure. Capability does not remove the pull toward premature completion; it only makes the agent faster at it.
- Preferences do not shrink with capability. Vanilla web, no Tailwind, `rem` not `px`, Conventional Commits with `Refs CFS-XXXX` in the body, Dutch and English store notes with every internal detail removed: no model infers these. They just need to be stated as facts, not as procedures.
- Environment facts (which tracker, which labels, which brands, which dashboard) are the same size regardless of model, but the *cache* rule says most of them should live in the environment, not the skill.

### A classification to trim by

Every instruction in a skill falls into one of five kinds. Only two of them shrink as models improve; the other three change shape instead.

| Kind | Example | As models improve | Keep? |
|------|---------|-------------------|-------|
| Capability substitute | "Run `git diff --stat` first", "write the test before the fix", "lead with findings" | Becomes a no-op | Delete after a no-op test |
| Process choreography | Merlin routes, Vectrix implements, Claude-review gates; loop-evidence fields; phase heads-up template; label state machines | Harness features absorb it (sessions, worktrees, PR monitoring, auto-review) | Delete or move to the harness config; keep only the gate |
| Preference / taste | MPA, plain CSS, Conventional Commits scope rule, store-note tone | Unchanged | Keep, as short declarative facts; `CLAUDE.md` or a reference beats a skill |
| Environment fact | Sonar project key, Jira board, brand list, release-card columns | Unchanged | Keep only when the lookup is expensive; otherwise point at the source |
| Gate / guardrail | Rerun the original repro before "fixed"; ask before merging to `main`; redact secrets in shown output; no red-capable command, no hypotheses | Unchanged or more important | Keep, phrased positively, as a short list |

Applying this to the local library, the cut lands almost entirely on the first two kinds, which is where `implement-issue`, `project-manager`, `agent-delegation`, `gh-pipeline`, `testing-orchestrator` and `run-workflow-retrospective` spend their words. The gates inside them are a few lines each and survive.

### How to know instead of guess

Pocock's rule is "settle it by running the document, not by debate". A cheap version for this repo:

1. Pick three skills that are used often and are long: `debugging`, `implement-issue`, `code-review`.
2. For each, write a trimmed variant that keeps only the preference, environment and gate lines (kinds 3 to 5 above). Expect 20 to 40 percent of the current length.
3. Run two or three real, recent tasks against each variant in fresh sessions (the same prompts, current model). Compare on the gates: did it reproduce before fixing, did it rerun the original repro, did it redact, did it ask before the destructive step, did it report findings with anchors.
4. Where the trimmed variant holds, ship it. Where it drops a gate, put that one sentence back and nothing else.
5. Record what was cut and why in the skill's `PROVENANCE.md` so the next re-test starts from evidence.

The `skill-maintenance` audit script already reports body bloat and long descriptions; it cannot run the no-op test, which is a behavioural comparison, so the above has to be done by hand or with `claude plugin eval` if that becomes convenient.

Two structural changes cost nothing and should happen regardless of the experiment:

- **Mark user-driven skills user-invoked.** This repo has zero skills with `disable-model-invocation: true`; upstream has 16 of 27. `external-skill-adaptation`, `skill-maintenance`, `run-workflow-retrospective`, `gh-pipeline`, `start-new-project`, and most of the Ockto `/create-*` skills are typed, never triggered. That removes their descriptions from every turn.
- **Cut descriptions to one sentence of trigger nouns.** Upstream averages about 200 characters per model-invoked description; several local ones run 400 to 740. The audit threshold of 230 characters already exists; apply it.

### Role-script removal (decided 2026-11-03)

The runtime text that names agents or OpenClaw paths, with the line count to cut:

| File | Lines | What it does today | Replacement |
| --- | --- | --- | --- |
| `project-manager/SKILL.md` | 46 to 60, 152 to 153, 195 | Fixed Merlin, Vectrix, Claude-review split; loop-evidence precondition before review | One gate: "an issue is not ready for merge until an independent review has run on the PR diff and valid P0 to P3 findings are fixed". Who reviews is the harness's choice. |
| `implement-issue/SKILL.md` | 102, 106 to 117, 138, 146 | Prefer Vectrix; loop-evidence report fields; Codex/OpenClaw subagent naming | "Verify the artifact, not the report": branch, commits, test output, PR. The harness shows the diff, so the report fields are a cache of what the environment already states. |
| `agent-delegation/SKILL.md` | 49, 109 | Loop-evidence fields in delegate reports | Same artifact rule; the file becomes a reference under `project-manager` per merge candidate 5. |
| `run-workflow-retrospective/SKILL.md` | 84 | Named Vectrix to QA to Claude review to Gatekeeper path | Delete the line; the retro asks which gate failed, not which agent. |
| `skill-maintenance/SKILL.md` | 71 to 73 | OpenClaw `--root` paths in the audit example | Replace with the two roots that exist now (`~/Development/ai-skills`, `~/.claude/skills`). |
| `start-new-project/SKILL.md`, `browser-qa/SKILL.md` | 86, 50 | OpenClaw memory and browser tooling pointers | Say "the harness's memory" and "the harness's browser"; both exist here. |
| `external-skill-adaptation/SKILL.md` | 44, 55 | OpenClaw conventions; a Merlin/Vectrix example question | Drop the names from the example. |
| `e2e-playwright/roles/*.md` | headers | "OpenClaw adaptation" labels and tool pointers | Keep the roles (planner, generator, healer are work roles, not agent names); drop the OpenClaw framing. |
| `openclaw-contribution/` | whole skill | Contribution workflow for the OpenClaw repo | Keep only if Ronald still contributes there; otherwise delete. |

Why the roles can go entirely. They existed to choreograph trust between agents that could not see each other's work. The desktop app now gives every participant the same diff, PR, CI result and review thread, so a report that lists "active skills used, tests run, review done" restates what the environment already shows. Pocock's cache rule applies: delete the restatement, keep the gate. The gates that survive are three sentences: no merge without an independent review of the PR diff; no review until tests ran on the branch; no "done" without the artifact that proves it.

Methodology files keep their history unchanged; they are provenance, not runtime text.

## 5. Open questions for Ronald

Decisions that depend on preference or operating style rather than correctness:

1. **Decided 2026-11-03:** `grilling` asks in plain chat, as upstream does. The skills run in several harnesses, so no skill may depend on one harness's question tool. A harness that offers a picker may still use it for a decision the skill has already narrowed to fixed options, but the skill text stays tool-agnostic.
2. **Decided 2026-11-03:** the OpenClaw role scripts (Merlin, Vectrix, Claude-review, loop evidence) go. Skills describe the work and its gates, never who performs them. Where an agent must be named, use a role (coordinator, implementer, independent reviewer), and prefer a gate stated as a required artifact so that no agent needs naming at all. See "Role-script removal" below.
3. **Decided 2026-11-03:** `test-audit` has paid for itself and splits into two parts along the model-invoked/user-invoked line rather than folding into `testing` whole.
   - **Authoring gate** (the four questions, the regression-test rule, a link to the junk patterns) goes into the merged `testing` skill body. It is model-invoked because it must fire whenever tests are being written.
   - **Clean-up** (audit sweep and campaign) stays a skill of its own, run on a folder, package or repo, with `disable-model-invocation: true`. Its description then costs nothing per turn, and the campaign order stays as its reference file, trimmed to the R/F/C/D ledger marks, the keeper-per-contract layer plan, the preservation review with one mutation per restored contract, and the control-run rule for baseline failures. The junk-pattern list becomes a shared reference both parts link, and the greppable patterns (assertion-free tests, test-only exports, source greps) are lint candidates.
   - Testing therefore goes 7 → 4: `testing`, the user-invoked clean-up skill, `browser-qa`, and `unit-vitest` plus `e2e-playwright` as tool references. Harnesses that ignore the frontmatter flag simply see one more model-invoked skill, so the split is harness-safe.
4. **Decided 2026-11-03:** no per-repo `GLOSSARY.md`. One Ockto-wide glossary, kept in the cross-project wiki vault that `create-wiki` builds, is canonical. `domain-modeling` and `wait-what` ideas therefore read the vault glossary, not a repo file; `create-wiki` gains the glossary page as a first-class output.
5. **Decided 2026-11-03:** replace `run-workflow-retrospective` with a user-invoked `retro` at about 400 words that proposes environment changes and lets the person decide. RoundTable v1 is decommissioned, so the fingerprint, ledger, label and Skill Workshop contract is deleted outright, support files included; nothing moves to another repository. Keep the gates: start read-only; fail closed on credentials, auth, releases, destructive work and out-of-scope changes; at most five actions; prefer systemic fixes and deleted no-ops over prompt patches; assign system defects to the system.

## 6. Recommended next discipline

Skill meta first: adopt `writing-for-agents` as the yardstick, merge `skill-review` and `skill-maintenance`, flip the user-driven skills to user-invoked, and run the three-skill trim experiment. Everything else in this review gets cheaper once that lens is in place.
