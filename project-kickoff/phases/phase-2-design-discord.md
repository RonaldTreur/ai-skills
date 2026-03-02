# Phase 2 (Discord Bot): Interaction Design

## Goal

Two competing interaction designs for a Discord bot, iterated with user feedback, until one is chosen. Output: approved design with `DESIGN.md`.

## Prerequisites

- Approved `BRIEF.md` from Phase 1
- Read `/Users/merlin/Development/skills/developing-web-projects/SKILL.md` for stack conventions (still applies to bot backend)

## What "Design" Means for a Discord Bot

There's no visual UI to browse. Instead, the deliverables are:

1. **Command Map** — every slash command, its arguments, permissions, and what it does
2. **Embed Mockups** — markdown representations of Discord embeds (title, fields, colors, thumbnails, footers)
3. **Interaction Flows** — button/select menu sequences, multi-step flows, ephemeral vs public responses
4. **Message Examples** — realistic mock messages showing what the bot says in key scenarios
5. **Component Layouts** — how buttons, select menus, and modals are arranged per command

## Round 1: Initial Designs

Spawn both models. Each reads `BRIEF.md` and creates a complete interaction design.

**Prompt for each (adapt folder name):**
```
You are designing the interaction model for a Discord bot.

Read these files:
- <project>/BRIEF.md — the functional spec
- /Users/merlin/Development/skills/developing-web-projects/SKILL.md — conventions (for backend architecture)

Create a complete interaction design in <project>/design-[a|b]/:

### Files to create:

**design-[a|b]/DESIGN.md** — your design rationale:
- Design philosophy (minimal vs rich embeds, playful vs utilitarian tone)
- Color scheme for embeds (hex values with reasoning)
- Tone of voice for bot messages
- Error handling approach (ephemeral errors, friendly messages)
- Permission model (who can use what)

**design-[a|b]/commands.md** — every command:
```markdown
## /command-name
- **Description:** [one-liner shown in Discord]
- **Arguments:** [name: type (required/optional) — description]
- **Permissions:** [who can run this]
- **Response:** [ephemeral/public/DM]
- **Flow:** [what happens step by step]
```

**design-[a|b]/embeds.md** — embed mockups in markdown:
```markdown
## [Scenario Name]
> **Embed Title**
> 
> Description text goes here.
>
> **Field 1:** value
> **Field 2:** value
>
> 🟢 Button: [Label] | 🔴 Button: [Label]
> 
> _Footer text · timestamp_
```
Use emoji and formatting to approximate Discord's rendering. Include color indicators (🟦 blue, 🟩 green, etc.)

**design-[a|b]/flows.md** — multi-step interaction flows:
```markdown
## [Flow Name]
1. User runs `/command`
2. Bot responds with embed + buttons [Confirm] [Cancel]
3. User clicks [Confirm]
4. Bot updates embed to show result
5. After 60s, buttons are disabled
```

**design-[a|b]/examples.md** — realistic example messages:
Full mock conversations showing the bot in action across key scenarios. Use Discord markdown formatting. Show both happy path and error cases.

Make it feel GOOD. The bot's personality comes through in its messages. This is a design competition.
```

### Post to Discord

After both complete:
1. Post key differences in interaction philosophy
2. Show side-by-side embed mockups for the same scenario
3. Highlight different approaches to the same user flow

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
[user's overall guidance]
```

### Spawning Next Round

Each model gets:
- The feedback file
- Access to the OTHER model's design folder
- Their own previous design (iterate, don't restart)

**Prompt:**
```
Read the user's feedback: <project>/context/round-N-feedback.md
Review the competing design: <project>/design-[other]/
Review your current design: <project>/design-[yours]/

Revise your interaction design based on the feedback. The user wants you to move in this direction:
[paste the "Direction for next round" section]

Update all your design files. Don't start from scratch — evolve what you have.
```

### Decision Points

After each round, ask the user:
- **"Continue iterating?"** → next round
- **"Pick a winner?"** → finalize
- **"Merge specific elements?"** → instruct both models what to take from each other, one more round

## Finalizing

When the user picks a winner:

1. Move winning design docs to project root:
   - `DESIGN.md` (design rationale)
   - `commands.md`, `embeds.md`, `flows.md`, `examples.md` into `docs/`
2. Remove both design folders and context files
3. Update `DECISIONS.md` with interaction design decisions

The project now has a complete, approved interaction design — ready for Phase 3 planning and Vectrix implementation.

## Note: Future Web UIs

If the project later adds a web interface (admin panel, user-facing site), run Phase 2 again using the standard [[phases/phase-2-design]] workflow for that specific UI. The bot interaction design and web UI design are separate phases.
