---
name: add-feature
description: "Turn an existing-project feature request into the smallest useful GitHub issue or issue set, then route delivery through project-manager."
---

# Add Feature

Use this skill when the user asks to add, extend, or change a feature in an
existing project and the work is not already a selected ready issue.

This skill is a short front door for "add this feature" requests. It classifies
the request, creates the minimal backlog shape, and then hands delivery to
[[project-manager]]. It does not own new-project shaping, testing strategy,
implementation, review, or long-running project state.

## Route

1. Inspect the repository, existing issues, and relevant docs before asking
   questions.
2. Classify the request:
   - **Already ready issue:** use [[implement-issue]]; do not create a duplicate.
   - **One issue:** clear feature slice with acceptance criteria; create or
     draft one GitHub issue.
   - **Small issue set:** separable setup, backend, frontend, test, or QA work;
     create the fewest independently mergeable issues.
   - **Needs shaping:** unclear users, scope, product direction, architecture,
     visual design, data/auth/deployment boundaries, or multiple phases; use
     [[start-new-project]].
3. If creating issues would encode a product or architecture decision, ask the
   smallest blocking question instead of guessing.
4. Put acceptance criteria, test/QA scope, dependencies, and out-of-scope notes
   in each issue.
5. After issue creation, invoke [[project-manager]] for ordering and ready-work
   selection. If exactly one issue is ready and the user asked to start,
   [[project-manager]] routes that issue to [[implement-issue]].

## Defaults

- Prefer one issue until the work clearly needs more.
- Split only when slices can be reviewed and merged independently.
- Keep issue text practical; avoid re-briefing the whole project.
- Reuse the repo's existing labels, milestones, and issue style.
- Ask before creating many issues, new labels, milestones, or project-board
  structure.
- Skip GitHub issue creation only when the user explicitly asks for direct local
  implementation or the work already has a ready issue.

## Output

Report:

- classification
- issue or issue set created/drafted
- blocked decisions, if any
- recommended next issue
- next workflow owner
