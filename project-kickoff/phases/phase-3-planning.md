# Phase 3: Implementation Planning

## Goal

Two competing implementation plans, debated and refined, until one is selected. Output: `PLAN.md` ready for Vectrix handoff.

## Prerequisites

- Approved `BRIEF.md` from Phase 1
- Approved `DESIGN.md` + `src/` from Phase 2
- Read `/Users/merlin/Development/skills/developing-web-projects/SKILL.md` for stack conventions

## Round 1: Independent Plans

Spawn both models. Each reads all project files and produces an implementation plan.

**Prompt for each:**
```
You are planning the implementation of a web project.

Read these files:
- <project>/BRIEF.md — functional requirements
- <project>/DESIGN.md — approved design and rationale
- <project>/src/ — the approved HTML/CSS design files
- <project>/DECISIONS.md — decisions made so far
- /Users/merlin/Development/skills/developing-web-projects/SKILL.md — conventions

Produce a detailed implementation plan covering:

## Architecture
- Overall structure, routing approach, build pipeline
- How the existing HTML/CSS design translates to the production architecture

## Data Model
- Entities, relationships, storage approach
- Schema design (if applicable)

## Component Breakdown
- Which parts of the HTML become Web Components
- Shared vs page-specific components
- Component hierarchy

## Dependencies
- Runtime dependencies (with justification for each)
- Dev dependencies
- What can be done WITHOUT a dependency

## API Design (if applicable)
- Endpoints, methods, request/response shapes
- Auth approach

## File Structure
- Proposed directory layout with every file listed
- Clear mapping from design pages to production files

## Build & Deploy
- Build pipeline, hosting, CI/CD approach
- Environment configuration

## Implementation Order
- Ordered list of tasks, with dependencies between them
- What can be parallelized
- What blocks what

Be specific and opinionated. Justify your choices. Call out trade-offs.
Write your plan to <project>/plan-[a|b].md
```

### Post to Discord

Post both plans to the thread, highlighting key differences:
- Where they agree (likely the right answer)
- Where they diverge (the interesting debates)

## Debate Rounds (max 3, extendable)

### How Debate Works

Each model reviews the OTHER's plan and produces a critique + revised version of their own plan.

**Prompt:**
```
Read the competing implementation plan: <project>/plan-[other].md
Read your current plan: <project>/plan-[yours].md
Read all project context: BRIEF.md, DESIGN.md, DECISIONS.md

1. Critique the other plan: what's strong, what's weak, what would you change?
2. Revise YOUR plan based on anything you learned from the other's approach.
3. If you changed your mind on anything, explain why.

Write your critique to <project>/context/round-N-[yours]-critique.md
Update your plan in <project>/plan-[yours].md
```

### Posting Each Round

Post to the thread:
- Each model's critique of the other's plan
- Key changes they made to their own plan
- Where they converged vs. still disagree

### After Each Round

Ask the user:
- **"Another round?"** → continue (default up to 3)
- **"One more round"** → user can extend beyond 3
- **"Pick a winner"** → finalize
- **"Merge X from plan A into plan B"** → targeted instruction, one more round

## Updating DECISIONS.md

After each round, update `DECISIONS.md` with new decisions that emerged:
- Architecture choices
- Dependency selections
- Data model decisions
- Any trade-offs the user weighed in on

## Finalizing

When the user picks a winner:

1. Move winning plan to `<project>/PLAN.md`
2. Remove `plan-a.md`, `plan-b.md`, and `context/` round files
3. Final update to `DECISIONS.md`
4. Confirm with user: "Ready to hand off to Vectrix?"

## Vectrix Handoff

Spawn Vectrix (or instruct the user to engage Vectrix) with:

```
New project ready for implementation.

Read these files in order:
1. <project>/BRIEF.md — what we're building and why
2. <project>/DESIGN.md — approved visual design and rationale
3. <project>/PLAN.md — approved implementation plan
4. <project>/DECISIONS.md — every decision with rationale and rejected alternatives
5. <project>/src/ — the approved design files (working Vite project)
6. /Users/merlin/Development/skills/developing-web-projects/SKILL.md — development conventions

Your first task: write <project>/IMPLEMENTATION_PLAN.md in your own words.
- Break it into ordered, concrete tasks
- For each task: which files to create/modify, what they contain
- Flag anything that's unclear or seems contradictory
- Do NOT start coding until I approve your implementation plan
```
