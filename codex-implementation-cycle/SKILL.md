---
name: codex-implementation-cycle
description: Compatibility alias for the per-issue implementation cycle now governed by issue-driven-delivery-loop. Use issue-driven-delivery-loop for Vectrix-first implementation, checkpointed verification, Codex review loops, Claude-review, and merge into dev.
---

# Codex Implementation Cycle

This skill has been merged into `issue-driven-delivery-loop`.

When this skill is invoked, load and follow:

`/Users/merlin/Development/skills/issue-driven-delivery-loop/SKILL.md`

Use that skill with scope limited to the named feature, fix, issue, or PR when Ronald asks for a single implementation cycle.

Important defaults now live there:

- Vectrix is the preferred implementation runtime, not ACP.
- PRs target `dev`; create `dev` from the default branch if needed.
- Codex performs a review/fix loop until no P0-P3 findings remain.
- Claude-review performs one final review.
- Codex evaluates and fixes valid Claude-review findings.
- Completion means merged into `dev` plus post-merge QA unless Ronald explicitly asks to stop earlier.
