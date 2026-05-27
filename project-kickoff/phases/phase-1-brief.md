# Phase 1: Functional Brief

## Goal

Turn the user's rough idea into an approved `BRIEF.md` with clear product
scope, target users, flows, data, constraints, and open questions.

## Process

### 1. Gather Existing Context

Read the user's project description and any linked notes, sketches, docs, repo
files, prior decisions, or market references already available.

Do not ask for information that can be discovered from local context. If the
project is in an existing repo, inspect the relevant docs and code before
asking.

Run a lightweight grounding pass when outside context could change the brief:

- current market, social, or tool signal
- prior art, competitors, or adjacent products
- existing repo/project/memory context
- user-supplied URLs, artifacts, or references

Keep the result compact. Capture only decision-relevant findings, weak signals,
and implications for the brief.

### 2. Resolve Only Blocking Ambiguity

Generate clarifying questions only for decisions that affect scope, data,
permissions, user flows, technical feasibility, or design direction.

Question rules:

- Group related questions into one concise checkpoint.
- Recommend defaults where possible.
- Explain the tradeoff in outcome terms.
- Max two follow-up rounds unless the user explicitly wants deeper shaping.
- If terms are ambiguous, propose canonical meanings and ask the user to choose.

Good question shape:

```markdown
I can draft the brief with these assumptions:

- [assumption + consequence]
- [assumption + consequence]

The only blocking choices are:

1. [question with recommended default]
2. [question with recommended default]
```

### 3. Optional Independent Review

Use sub-agents when the idea is large, fuzzy, or high-stakes:

- one product/UX lens: audience, motivation, flows, edge cases
- one engineering lens: data, integrations, constraints, failure modes

Ask each to produce questions, assumptions, and scope risks. Merge their output
before showing the user. Do not post duplicate or generic questions.

### 4. Draft `BRIEF.md`

Use this structure:

```markdown
# [Project Name] - Functional Brief

## Overview
[What this project is and why it exists.]

## Target Users
[Who uses this, what they already know, and what job they need done.]

## Core Use Cases
[Numbered list of primary user goals.]

## User Flows
[Key journeys, including happy path and important edge/error paths.]

## Data And State
[Entities, relationships, persistence, ownership, lifecycle, and privacy notes.]

## Grounding
[Research value, sources checked, strongest findings, weak/conflicting signals, and implications.]

## Surfaces
[Pages, views, commands, notifications, background jobs, or integrations.]

## Scope Boundaries
[What v1 explicitly includes and excludes.]

## Constraints
[Technical, operational, design, schedule, budget, platform, or policy constraints.]

## Open Questions
[Questions that remain unresolved, with recommended default when possible.]
```

### 5. Update `DECISIONS.md`

Record meaningful decisions immediately:

```markdown
## [Topic]
- **Decision:** [choice]
- **Why:** [reasoning]
- **Rejected:** [alternatives and why they lost]
- **User input:** [direct user steering if any]
```

Do not record noise. Capture decisions a future implementer would otherwise
need to rediscover.

### 6. User Confirmation

Post or summarize the draft for review. The phase exits only when the user
approves the brief or gives enough concrete edits to finalize it.
