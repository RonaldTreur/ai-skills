# Phase 2: Discord Bot Interaction Design

## Goal

Explore the bot's interaction model, message tone, permissions, embeds,
commands, and failure states until one design is approved.

## Prerequisites

- Approved `BRIEF.md`
- Current `DECISIONS.md`
- Known Discord server/channel context if relevant

## What "Design" Means

For a Discord bot, design is interaction design:

- command map and permissions
- public vs ephemeral response policy
- embeds and message examples
- button/select/modal flows
- error handling and recovery messages
- scheduled/background behavior
- moderation, audit, or privacy implications

## 1. Interaction Thesis

Before drafting variants, capture:

- **Bot role**: utility, moderator, concierge, analyst, game master, etc.
- **Tone**: terse, warm, playful, formal, operational.
- **Visibility policy**: what is public, ephemeral, DM-only, logged, or silent.
- **Control model**: slash commands, buttons, selects, modals, reactions,
  scheduled messages, or threads.

## 2. Initial Designs

Generate two interaction designs when the decision benefits from comparison.
They should differ in more than wording:

- command shape
- message density
- permission model
- public/private behavior
- recovery/error style
- interaction flow

Each design folder should include:

```text
design-a/
  DESIGN.md
  commands.md
  embeds.md
  flows.md
  examples.md
```

`DESIGN.md` should explain philosophy, tone, visibility, permissions, error
handling, and tradeoffs.

`commands.md` should define every command:

```markdown
## /command-name
- **Description:** [one-liner shown in Discord]
- **Arguments:** [name: type, required/optional, description]
- **Permissions:** [who can run this]
- **Response:** [public, ephemeral, DM, thread, scheduled]
- **Flow:** [what happens step by step]
```

`embeds.md`, `flows.md`, and `examples.md` should show realistic happy paths,
edge cases, permission failures, empty states, and recovery messages.

## 3. Review

Post a concise comparison:

- where both designs agree
- where they differ materially
- which design better fits the target users
- unresolved tradeoffs needing user choice

Do not ask the user to compare giant documents unaided. Surface the important
decision points.

## 4. Feedback Loop

Capture feedback in `<project>/context/round-N-feedback.md` with:

- keep
- change
- reject
- direction

Then revise the existing designs. Do not restart unless the user rejects the
whole direction.

## 5. Finalize

When the user picks a winner:

1. Move the winning `DESIGN.md` to `<project>/DESIGN.md`.
2. Move `commands.md`, `embeds.md`, `flows.md`, and `examples.md` into
   `<project>/docs/`.
3. Remove temporary design folders and stale context files.
4. Update `DECISIONS.md` with interaction decisions and rejected alternatives.

If the project later adds a web UI, run [[phases/phase-2-design]] separately
for that interface.
