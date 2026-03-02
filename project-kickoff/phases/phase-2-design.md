# Phase 2: UI/UX Design

## Goal

Two competing designs, iterated with user feedback, until one is chosen. Output: approved design promoted to `src/` with `DESIGN.md`.

## Prerequisites

- Approved `BRIEF.md` from Phase 1
- Read `/Users/merlin/.openclaw/workspace-main/skills/ui-design-prompt/SKILL.md` for the TC-EBC framework
- Read `/Users/merlin/Development/skills/developing-web-projects/SKILL.md` for stack conventions

## Setup: Vite Project

Before spawning designers, scaffold the project:

```
<project>/
  package.json          ← Vite + dev dependencies
  vite.config.ts        ← Multi-page: /a/ serves design-a/, /b/ serves design-b/
  design-a/
    index.html
  design-b/
    index.html
```

Configure Vite for multi-page serving so the user can navigate both designs in-browser at `localhost:5173/a/` and `localhost:5173/b/`.

Start the dev server and keep it running throughout Phase 2.

## Round 1: Initial Designs

Spawn both models. Each reads `BRIEF.md` and creates a full multi-page design in their folder.

**Prompt for each (adapt folder name):**
```
You are designing the UI/UX for a new web project.

Read these files:
- <project>/BRIEF.md — the functional spec
- /Users/merlin/Development/skills/developing-web-projects/SKILL.md — conventions
- /Users/merlin/.openclaw/workspace-main/skills/ui-design-prompt/SKILL.md — design framework

Create a complete, navigable design in <project>/design-[a|b]/:
- One HTML file per page, all linked together (real navigation)
- CSS files split however makes sense
- Plain HTML + CSS only. No JS, no TypeScript, no Web Components.
- Repeated HTML is fine — this is a design, not production code
- Use realistic placeholder content, not Lorem ipsum
- Include all visual states mentioned in the brief

Also create <project>/design-[a|b]/DESIGN.md with your design rationale:
- Design direction and why
- Color palette with reasoning
- Typography and spacing system
- Layout decisions per page
- Responsive strategy

Make it look GOOD. This is a design competition.
```

### Post to Discord

After both complete:
1. Take screenshots of key pages from each design
2. Post to thread with links: "Browse Codex's design at localhost:5173/a/ and Opus's at localhost:5173/b/"
3. Highlight key differences between the approaches

## Iteration Rounds

### Collecting Feedback

User comments in the thread. Capture feedback as `<project>/context/round-N-feedback.md`:

```markdown
# Round N Feedback

## What I like about Design A:
[user's comments]

## What I like about Design B:
[user's comments]

## What needs to change:
[user's comments]

## Direction for next round:
[user's overall guidance — e.g., "Move closer to B's layout but keep A's colors"]
```

### Spawning Next Round

Each model gets:
- The feedback file
- Access to the OTHER model's design folder (they can read it)
- Their own previous design (they iterate, not restart)

**Prompt:**
```
Read the user's feedback: <project>/context/round-N-feedback.md
Review the competing design: <project>/design-[other]/
Review your current design: <project>/design-[yours]/

Revise your design based on the feedback. The user wants you to move in this direction:
[paste the "Direction for next round" section]

Update your HTML/CSS files and DESIGN.md. Don't start from scratch — evolve what you have.
```

### Decision Points

After each round, ask the user:
- **"Continue iterating?"** → next round
- **"Pick a winner?"** → finalize
- **"Merge specific elements?"** → instruct both models what to take from each other, one more round

## Finalizing

When the user picks a winner:

1. Move winning design to `<project>/src/`:
   ```bash
   mv <project>/design-[winner]/* <project>/src/
   ```
2. Move winning `DESIGN.md` to project root
3. Remove both design folders and context files
4. Update Vite config to serve from `src/`
5. Update `DECISIONS.md` with design decisions that emerged

The project now has a working, approved design served by Vite — ready for Vectrix to build on.
