# Phase 1: Functional Brief

## Goal

Turn the user's initial project idea into a clear, complete functional specification (`BRIEF.md`).

## Process

### Step 1: User Describes the Project

The user posts their project idea in the Discord thread. Can be rough — a few sentences, a paragraph, bullet points. Whatever they have.

### Step 2: Independent Clarifying Questions

Spawn both models as sub-agents. Each independently reads the user's description and produces clarifying questions.

**Prompt for each:**
```
You are helping define a new project. Here's what the user described:

[user's description]

Read the web development conventions: /Users/merlin/Development/skills/developing-web-projects/SKILL.md

Generate 5-10 clarifying questions that would help produce a complete functional spec. Focus on:
- User flows and interactions
- Data model and persistence
- Edge cases and error states
- Target audience and context
- Scope boundaries (what's NOT included)

Be specific, not generic. Don't ask questions the description already answers.
```

### Step 3: Merge and Post

Merge both sets of questions. Remove duplicates. Group by theme. Post to the thread:

```
📋 Merlin: Both models have questions before we write the brief:

**User Flows:**
- 🔧 [Codex question]
- 🧠 [Opus question]

**Data & Persistence:**
- 🔧 [Codex question]
- 🧠 [Opus question]
...
```

### Step 4: User Answers

User answers in the thread. Can answer all at once or in batches. Can also add new requirements.

### Step 5: Follow-up Round (if needed)

If answers reveal new ambiguities, either model can generate follow-up questions. Max 2 follow-up rounds — then we write the brief with what we have.

### Step 6: Draft BRIEF.md

Spawn one model (Opus — better at synthesis) to draft `BRIEF.md`:

```markdown
# [Project Name] — Functional Brief

## Overview
[What this project is, in 2-3 sentences]

## Target Audience
[Who uses this and why]

## Core Features
[Numbered list of features with brief descriptions]

## User Flows
[Key user journeys, step by step]

## Data Model
[What data exists, relationships, persistence approach]

## Pages / Views / Commands
[For web: list of pages with their purpose]
[For Discord bot: list of slash commands with their purpose]
[For both: list both]

## Scope Boundaries
[What is explicitly NOT included in v1]

## Open Questions
[Anything still unresolved]
```

### Step 7: User Confirms

Post the draft to the thread. User reviews, requests changes, or approves.

**Exit condition:** User says the brief is good → save final `BRIEF.md` → proceed to Phase 2.
