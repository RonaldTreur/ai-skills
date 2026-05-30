# Discipline Review: Research and Discovery

- Date: 2026-05-27
- Reviewer: Merlin
- Branch: `feat/research-discovery-adaptation`
- Local files reviewed: `methodology/DISCIPLINES.md`,
  `/Users/merlin/.openclaw/workspace-main/skills/last30days/SKILL.md`,
  `/Users/merlin/.openclaw/workspace-main/skills/deep-research/SKILL.md`
- External sources reviewed: GStack, SuperPowers, Compound Engineering, Matt
  Pocock Skills
- Status: implemented

## Local Baseline

Research currently exists as tool-specific skills rather than a project-lifecycle
discipline.

- `last30days` researches current discussion across Reddit, X, and web search,
  then writes prompt-ready or recommendation-style output.
- `deep-research` expands that into a slower report workflow across Reddit, X,
  Hacker News, Bluesky, and Brave-powered web search.
- OpenClaw also has newer `x_search` access through Grok and Brave-backed
  `web_search`, but no shared policy decides when to use social search, web
  search, repo discovery, chat/memory search, or a full research report.

The gap is not a missing search tool. The gap is routing, source weighting,
stopping rules, and output shape.

## Source Comparison

### GStack

- Source ref: `61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c`
- Files reviewed: `investigate/SKILL.md`, `scrape/SKILL.md`,
  `browse/SKILL.md`, `learn/SKILL.md`
- Useful patterns:
  - Treat investigation as a phased workflow instead of a single search.
  - Preserve reusable learnings and query them before assuming a problem is new.
  - Separate browser/page extraction from broader research.
  - Make explicit triggers for when to investigate, scrape, browse, or learn.
- Conflicts or risks:
  - Much of the value is tangled with GStack runtime preambles, telemetry,
    update checks, and its memory system.
  - `investigate` is mainly debugging, which this repo already covered.
  - The generated preambles are too heavy for local ai-skills runtime text.
- Adoption recommendation:
  - Adopt the router idea and the "check prior learnings first" habit.
  - Do not import GStack runtime machinery or split research into many tiny
    tool-wrapper skills.

### SuperPowers

- Source ref: `f2cbfbefebbfef77321e4c9abc9e949826bea9d7`
- Files reviewed: `skills/brainstorming/SKILL.md`,
  `skills/brainstorming/spec-document-reviewer-prompt.md`,
  `skills/writing-plans/SKILL.md`
- Useful patterns:
  - Explore project context before asking clarifying questions.
  - Ask one question at a time after doing discoverable context work.
  - Propose multiple approaches with tradeoffs before settling.
  - Review specs for ambiguity before turning them into plans.
- Conflicts or risks:
  - The hard gate requiring brainstorming before every creative or behavior
    change is too ceremonial for Ronald's workflow.
  - The source pushes spec/plan artifacts early; local skills already distribute
    those responsibilities across kickoff, project-manager, and handoff.
- Adoption recommendation:
  - Adopt the ordering: context scan first, then questions, then alternatives.
  - Reject mandatory brainstorming as the default research gate.

### Compound Engineering

- Source ref: `5297a9440fa009822ceef8052b9e644e782281e1`
- Files reviewed: `plugins/compound-engineering/skills/ce-ideate/SKILL.md`,
  `plugins/compound-engineering/skills/ce-slack-research/SKILL.md`,
  `plugins/compound-engineering/skills/ce-product-pulse/SKILL.md`,
  `plugins/compound-engineering/agents/ce-web-researcher.md`,
  `plugins/compound-engineering/agents/ce-repo-research-analyst.md`
- Useful patterns:
  - Research is mode-dependent: repo-grounded, elsewhere-software, and
    elsewhere-non-software need different context gathering.
  - "Surprise me" can be a real mode when the repo or supplied artifact gives
    the agent enough substance.
  - External web research should return a compact grounding digest with a
    research-value rating, prior art, adjacent solutions, market signals,
    cross-domain analogies, and sources actually used.
  - Use broad search for vocabulary first, then narrower queries, then
    gap-filling only when a claim is load-bearing.
  - Warn and proceed when research tools fail; do not block ideation on one
    unavailable source.
  - Separate constraints from background context so noisy research does not
    override the user's actual ask.
- Conflicts or risks:
  - The full `ce-ideate` flow dispatches many agents and is too expensive as a
    default for normal Merlin chat.
  - Slack-specific workflows do not map directly to Discord/OpenClaw memory.
  - Some scratch/cache behavior is too platform-specific to import as-is.
- Adoption recommendation:
  - Strongest source for this slice.
  - Adapt a lightweight research router and compact digest contract.
  - Keep multi-agent ideation optional and explicit, not default.

### Matt Pocock Skills

- Source ref: `b8be62ffacb0118fa3eaa29a0923c87c8c11985c`
- Files reviewed: `skills/engineering/grill-with-docs/SKILL.md`,
  `skills/productivity/grill-me/SKILL.md`,
  `skills/engineering/to-prd/SKILL.md`,
  `skills/engineering/to-issues/SKILL.md`
- Useful patterns:
  - If a question can be answered from the codebase/docs, answer it there
    instead of asking the user.
  - Challenge ambiguous or overloaded domain terms against existing glossary
    and ADRs.
  - Turn resolved understanding into downstream PRDs/issues when appropriate.
  - Prefer vertical slices when turning researched plans into work.
- Conflicts or risks:
  - The source is more about interrogation and product shaping than external
    research.
  - Inline documentation updates during questioning are useful but can become
    intrusive if applied to casual exploration.
- Adoption recommendation:
  - Adopt question discipline and domain-language sharpening.
  - Route durable decisions through `documentation-handoff`; do not make
    research responsible for PRDs/issues.

## Questions For The User

- Should "Research and discovery" become a new runtime owner skill, or should
  it be folded into the project lifecycle?
  Decision: fold it into `project-kickoff`, with a narrow `project-manager`
  recovery/backlog note.
- Should the default output be a short grounding digest, with saved full reports
  only when the user explicitly asks for deep research?
  Decision: yes. Kickoff gets a compact digest; `deep-research` remains the
  saved-report path.
- Should "surprise me" be a first-class mode only when there is enough local
  substance: repo, artifact, URL, memory topic, or current social/web topic?
  Decision: yes.

## Adopted Changes

- `project-kickoff/SKILL.md`
  - Provenance entry: `2026-05-27-research-discovery-folded-into-kickoff`
  - Added "Grounding Before Shaping" as the owner workflow for early
    research/discovery inside kickoff.
- `project-kickoff/phases/phase-1-brief.md`
  - Provenance entry: `2026-05-27-research-discovery-folded-into-kickoff`
  - Added a lightweight grounding pass and a `BRIEF.md` grounding section.
- `project-manager/SKILL.md`
  - Provenance entry: `2026-05-27-research-discovery-folded-into-kickoff`
  - Added a narrow intake/recovery rule: refresh repo, issue, PR, memory, or
    external context only when it can change backlog or next-work decisions.
- `README.md`
  - Provenance entry: `2026-05-27-research-discovery-folded-into-kickoff`
  - Clarified that early grounding lives in project kickoff.

## Skill-Level Attribution

No new runtime skill was created. Source influence was added to:

- `project-kickoff/PROVENANCE.md`
- `project-manager/PROVENANCE.md`

## Rejections And Deferrals

- Rejected creating a new runtime skill for now; the direct use case belongs in
  `project-kickoff`.
- Rejected importing GStack preambles, telemetry, update checks, and memory
  machinery.
- Rejected mandatory SuperPowers-style brainstorming before every creative or
  product change.
- Rejected Compound's always-heavy multi-agent ideation as a normal default.
- Deferred any Slack-specific research adaptation; OpenClaw should map this to
  Discord/session memory only if a concrete workflow needs it.

## Local Shape

Research/discovery is a kickoff behavior, not a standalone scraper.

Trigger cases inside kickoff:

- "research X before we decide"
- "what is the current state of X?"
- "what are people saying about X?"
- "surprise me with opportunities in this repo/topic"
- "find prior art / competitors / adjacent patterns for X"
- "look through our memory/docs/issues before planning X"

Routing:

- Current/social signal: `last30days`, `x_search`, Reddit, Brave web search.
- Deep report: `deep-research`.
- Repo discovery: local file search, README/AGENTS/STRATEGY/docs, issue
  patterns.
- User or channel history: OpenClaw memory/session search when relevant.
- Product shaping: fold findings into `project-kickoff`.
- Active backlog/project decisions: refresh through `project-manager` only when
  it changes next-work or issue decisions.
- Durable state: route decisions into `documentation-handoff`.

Default grounding digest:

- research value: high / moderate / low / unavailable
- what was searched
- strongest findings
- contradictions or weak signals
- direct implications for the current decision
- sources actually used
- next action or blocker

## Verification Notes

- Reviewed local current-research skills and four external sources.
- Runtime source/provenance leakage scan passed.
- YAML frontmatter parse passed for changed runtime skills.
- `[[skill-review]]`: PASS for `project-kickoff`.
  - Trigger remains scoped to greenfield or major project starts.
  - Grounding guidance is inside kickoff and has explicit skip rules, so it does
    not turn every research request into project kickoff.
- `[[skill-review]]`: PASS for `project-manager`.
  - Research/discovery language is narrow and tied to backlog, scope, setup, and
    next-work decisions.
  - It does not create a second research workflow or compete with kickoff.
