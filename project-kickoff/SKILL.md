---
name: project-kickoff
description: Three-phase project kickoff: brief clarification, competitive UI design, and implementation planning. Two AI models work independently, debate, and iterate — with the user steering. Final output hands off to Vectrix for implementation.
---

# Project Kickoff

Orchestrates the full kickoff of a new web project in three phases, all visible in a dedicated Discord thread.

## Linked Skills

- `/Users/merlin/Development/skills/developing-web-projects/SKILL.md` — stack, architecture, conventions
- `/Users/merlin/.openclaw/workspace-main/skills/ui-design-prompt/SKILL.md` — TC-EBC design framework

Read these before starting. They define the constraints both AIs work within.

## The Two Models

- **Model A — Codex** (`openai-codex/gpt-5.3-codex`): engineering-first, pragmatic
- **Model B — Opus** (`anthropic/claude-opus-4-6`): design-first, holistic

Both are spawned as sub-agents. Neither knows which "letter" they are — they just see the project files and the other's work.

## Discord Setup

All phases happen in a **Discord thread** inside `#🏗️project-kickoff` (or whatever channel the user specifies). Create the thread at the start with the project name.

Prefix every posted message with the source:
- `**🔧 Codex:**` for Model A output
- `**🧠 Opus:**` for Model B output
- `**📋 Merlin:**` for orchestration notes
- User messages are their own

## Project Folder Structure

Create at the start of Phase 1:

**Web application:**
```
<project-name>/
  BRIEF.md              ← Phase 1 output (functional spec)
  DECISIONS.md          ← Progressive, updated across all phases
  design-a/             ← Codex's design (Phase 2)
  design-b/             ← Opus's design (Phase 2)
  vite.config.ts        ← Multi-page Vite config serving /a/ and /b/
  package.json          ← Vite project scaffolding
```

**Discord bot:**
```
<project-name>/
  BRIEF.md              ← Phase 1 output (functional spec)
  DECISIONS.md          ← Progressive, updated across all phases
  design-a/             ← Codex's interaction design (Phase 2)
  design-b/             ← Opus's interaction design (Phase 2)
```

After Phase 2, winning design promotes:
- **Web:** design files → `src/`, loser deleted
- **Discord bot:** design docs → `docs/`, loser deleted

After Phase 3:
```
<project-name>/
  BRIEF.md
  DESIGN.md             ← From winning design
  PLAN.md               ← Winning implementation plan
  DECISIONS.md          ← All decisions with rationale
  src/                  ← Promoted design files (web) or empty (bot)
  docs/                 ← commands.md, embeds.md, flows.md, examples.md (bot)
```

## DECISIONS.md — The Living Record

Updated progressively across ALL phases. Every significant decision gets recorded:

```markdown
## [Topic]: [Choice A] vs [Choice B]
- **Decision:** [What was chosen]
- **Why:** [Reasoning from the debate]
- **Rejected:** [What was rejected and why]
- **User input:** [Any steering from Ronald]
```

This is the key context document for Vectrix's handoff. It captures the *why*, not just the *what*.

## Project Type Detection

Before starting Phase 1, determine the project type. If the user's description doesn't make it clear, ask:

> **What are we building?**
> 🌐 **Web application** — user-facing website or admin panel
> 🤖 **Discord bot** — bot with slash commands, embeds, interactions
> 🌐+🤖 **Both** — bot with companion web UI(s)

The project type determines which Phase 2 variant to use. Phase 1 and Phase 3 are the same for all types.

For **"Both"** projects: run the Discord bot Phase 2 first (interaction design), then run the web UI Phase 2 separately for each web interface. Each gets its own design competition.

## Phase Flow

### Phase 1: Functional Brief → [[phases/phase-1-brief]]
Clarify requirements through interactive Q&A with both models.
**Entry:** User describes the project.
**Exit:** `BRIEF.md` is complete and user confirms.

### Phase 2: Design (branched by project type)

**Web application** → [[phases/phase-2-design]]
Competitive UI/UX design with HTML/CSS prototypes served by Vite.
**Entry:** Approved `BRIEF.md`.
**Exit:** User picks a winning design, promoted to `src/`.

**Discord bot** → [[phases/phase-2-design-discord]]
Competitive interaction design: commands, embeds, flows, message examples.
**Entry:** Approved `BRIEF.md`.
**Exit:** User picks a winning interaction design, docs moved to `docs/`.

**Both** → Run [[phases/phase-2-design-discord]] first, then [[phases/phase-2-design]] for each web UI.

### Phase 3: Implementation Planning → [[phases/phase-3-planning]]
Architecture debate between both models.
**Entry:** Approved `BRIEF.md` + `DESIGN.md`.
**Exit:** `PLAN.md` selected, ready for Vectrix handoff.

## Vectrix Handoff

After Phase 3, hand the project to Vectrix with:

```
Read these files in order:
1. BRIEF.md — what we're building
2. DESIGN.md — what it looks like (and why)
3. PLAN.md — how to build it
4. DECISIONS.md — every decision and its rationale
5. /Users/merlin/Development/skills/developing-web-projects/SKILL.md — conventions

Your first task: write IMPLEMENTATION_PLAN.md in your own words.
Break it into ordered tasks, file-by-file. If anything is unclear, ask before writing code.
```

Vectrix rewrites the plan to internalize it. This is intentional — it forces understanding rather than blind execution.

## Sub-Agent Pattern

Each round spawns a fresh sub-agent. The project folder IS the persistent state.

```
Spawn: "Read <project>/BRIEF.md, <project>/DECISIONS.md, 
  <project>/design-b/ (the other's design), and 
  <project>/context/round-N-feedback.md.
  Revise your design in <project>/design-a/."
```

Sub-agent reads everything, has full context, produces output, completes. No persistent sessions needed.
