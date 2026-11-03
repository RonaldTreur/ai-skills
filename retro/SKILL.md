---
name: retro
description: Retrospective on a coding session or merged PR that proposes changes to the agent's environment. Use when asked for a retro, post-mortem or lessons from an agent session or merged PR.
disable-model-invocation: true
---

# Retro

A retrospective proposes changes to the **environment** the agent works in, so the next run goes better. Propose only. Apply a proposal after the person approves it; the classes named in step 4 need approval per item.

## Steps

1. Read the primary sources: the session the user names (default: the current one), and for a merged PR its diff, review thread, CI results and the issue it closed.
2. Look for candidates in these categories. Each carries the cue that makes it apply.
   - **Navigation.** The agent took long to find a file, a dependency or a convention. Propose a navigation pointer in the repo's agent instructions, not an explanation.
   - **Automated checks.** The agent made a mistake a lint, type, test or filesystem check would have caught. Read the repo's own check command and CI first: a check that exists but is unwired or silently broken is the finding. A repo with no guardrail at all is a finding.
   - **Review rules.** The reviewer missed something. Classify the violation first: a mechanical one (a pattern, a banned API, a file location) gets a deterministic check in the linter, hook or CI; only a genuine judgment call becomes a written rule for the reviewer. The reviewer carries the rules, since it reads a diff and has the least context pressure.
   - **Steering files.** The repo or global agent instructions carry rules a check or the reviewer could own.
   - **No-ops.** An instruction in a skill or steering file the model would follow anyway. Propose deleting the sentence.
   - **Tool economy.** An expensive or token-heavy tool call, CLI or MCP that a cheaper path replaces.
   - **Information access.** Something the agent needed and could not reach: logs, a service, a dashboard. Propose read-only access.
   - **Skills.** A skill that fired wrongly, failed to fire, or carried dead weight. Route the change through [[skill-review]].
3. Assign system defects to the system, not the person running it. Prefer one systemic fix over several prompt patches.
4. Present at most five proposals in order of severity, each with the change, the evidence line that justifies it, and its failure mode. Fail closed: anything touching credentials, auth, releases, deployments, destructive operations or files outside the repo is a proposal that needs explicit approval, never an action.

## Where changes land

- Repo and global agent instructions: pointers only; they load every turn.
- Checks: the repo's linter, hooks or CI, in that order of cheapness.
- Review rules: wherever [[code-review]] reads them in this repo.
- Docs: reference files reached by a pointer.
- Skills: for material the agent must reach on its own, or for commands a person types. Follow [[skill-review]].
