---
name: multi-agent-figure8-review
description: Use when Ronald wants implementation plus a figure-8 multi-agent review loop: Vectrix implements and fixes, Vectrix performs the implementation-side review pass, Claude-review performs an independent review-only pass, and the main model merges and dedupes findings before driving fixes and merge.
---

# Multi-Agent Figure-8 Review

Use this skill when Ronald wants a multi-agent implementation and review workflow instead of a single review pass.

This skill defines the choreography.
The main model reads this skill and orchestrates the agents.

## Core roles

### Vectrix

Vectrix is responsible for:

- implementation
- self-verification
- implementation-side review pass
- fixing findings
- final merge work

Vectrix must follow:

- `codex-implementation-cycle`
- `developing-web-projects` for web-project implementation
- any other relevant project/domain skills

### Claude-review

Claude-review is responsible for:

- review only

Claude-review must **not**:

- implement the feature
- fix findings
- merge
- take over the task

Claude-review should perform an independent review using the `code-review` skill.

### Main model

The main model is responsible for:

- orchestrating the workflow
- collecting review outputs
- merging and deduping findings
- deciding the consolidated finding list
- sending the fix list back to Vectrix
- deciding whether the work is ready for merge

Do **not** offload the review-merge/dedupe step to Claude.
That consolidation step belongs to the main model.

## Figure-8 workflow

Run the workflow in this order:

1. **Vectrix implements the requested feature / fix**
2. **Vectrix self-verifies**
   - browser verification when feasible
   - otherwise tests, build, lint, or direct proof
3. **Vectrix performs an implementation-side review pass**
   - use the `code-review` skill
4. **Claude-review performs an independent review pass**
   - use the `code-review` skill
   - Claude-review reviews only
5. **Main model merges and dedupes the findings**
   - remove duplicates
   - combine overlapping findings
   - preserve severity clearly
   - call out disagreements when they matter
6. **Vectrix fixes all consolidated P0-P3 findings**
7. **Vectrix re-verifies after fixes**
8. **Merge**

## Required review policy

Both review passes must be real reviews, not superficial approval.

Review for at least:

- correctness
- regressions
- architecture
- security/privacy
- reliability
- conventions
- hidden edge cases

## Consolidation policy

The main model must produce one consolidated finding list.

That list should:

- dedupe semantically identical findings
- merge overlapping findings into one clearer item when appropriate
- preserve the highest relevant severity
- separate true blockers from nice-to-haves
- explicitly note reviewer disagreement when it changes the decision

Do not just paste both review lists back-to-back.

## Severity policy

Vectrix must fix all consolidated findings in these severities:

- P0
- P1
- P2
- P3

If a finding is rejected, the main model must explain why explicitly.

## Checkpointed execution

For longer work, default to checkpointed execution.

Use these checkpoints unless Ronald asks for different ones:

1. implementation artifact exists
2. self-verification complete
3. Vectrix review complete
4. Claude-review complete
5. main-model consolidation complete
6. P0-P3 fixes applied
7. post-fix verification complete
8. merge complete

If the final callback is missing or suspicious, inspect repo state, transcripts, commits, test evidence, and other artifacts before reporting status.

Report the furthest verified checkpoint reached.

## Runtime expectations

- Vectrix should be used as the implementation agent
- Claude-review should be used only for review
- the main model should stay responsible for orchestration and consolidation
- do not let Claude-review become the implementing agent through drift or convenience

## Definition of done

This workflow is done only when all are true:

- implementation completed by Vectrix
- self-verification completed
- Vectrix review completed
- Claude-review completed
- findings merged/deduped by the main model
- all consolidated P0-P3 findings fixed
- post-fix verification completed
- changes merged
