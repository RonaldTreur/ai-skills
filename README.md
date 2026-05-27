# Skills

This repository contains Skills I personally created and use to speed up my development workflow.

## What is a Skill?

Skills are modular, filesystem-based capabilities for agents. A Skill packages metadata and instructions in `SKILL.md` and can include optional resources like scripts, templates, or references. Skills load on demand (progressive disclosure) so only the relevant content is pulled into context when a request matches the Skill's description.

## Best practices (summary)

- Use clear, specific names and descriptions that say what the Skill does and when to use it.
- Keep `SKILL.md` concise (under ~500 lines) and move deep reference material into separate files; rely on progressive disclosure.
- Match instruction specificity to task risk: use high-level guidance when multiple approaches are valid and exact scripts when consistency is critical.
- Provide templates or input/output examples when output format matters.
- Prefer utility scripts for deterministic operations and handle errors explicitly; document configuration values and avoid assuming dependencies are installed.
- Test file access patterns and workflows with real requests.

## Sources

- https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview
- https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices

## Methodology Adaptation

The `methodology/` folder tracks discipline-by-discipline reviews of external agent-methodology sources and the attribution trail for ideas adapted into this repository.

Use the `external-skill-adaptation` skill when comparing third-party skills, prompts, or instruction repos against these local skills.

The repo now includes a dedicated `debugging/` skill for investigation-first bug fixing with a trivial-bug fast path and hard verification gates.

The repo also includes a dedicated `skill-review/` skill for reviewing skills as model-facing runtime artifacts: activation accuracy, context cost, progressive disclosure, safety, and realistic behavior checks.

The active implementation lifecycle is split across `project-manager/` for
project/backlog orchestration and `implement-issue/` for one selected issue at
a time.

Browser verification lives in `browser-qa/`: use it for web preview, PR, and
post-merge QA that needs an actual browser pass.

Project-wide test enforcement lives in `test-ci-policy/`: use it for test
scripts, CI entrypoints, coverage thresholds, and local/CI parity. Do not use it
as the default workflow for ordinary feature implementation.

Project shaping lives in `project-kickoff/`: use it for early grounding,
functional brief, product/design direction, `BRIEF.md`, `DESIGN.md`, `PLAN.md`,
and `DECISIONS.md` before `project-manager/` turns the work into testable
issues and implementation slices.

Visual frontend exploration lives in `frontend-design/`: use it for divergent
UI variants, visual thesis, shareable browser previews, feedback rounds, and
approved frontend design artifacts. `project-kickoff/` routes here only when a
project has a visual frontend.

Agent delegation mechanics live in `agent-delegation/`: use it when handing
work to another agent, runtime, or subagent so the task has clear context,
write boundaries, status reporting, and integration review.

GitHub label automation lives in `gh-pipeline/`: use it when GitHub issue labels
drive build, test, review, fix, approved, blocked, and failed states across the
existing project lifecycle skills.

Documentation and continuation state live in `documentation-handoff/`: use it
for README/AGENTS roles, project artifacts, `DELIVERY_STATE.md`, decisions,
PR/issue handoffs, blockers, and recovery summaries.
