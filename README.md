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
a time. The old `codex-implementation-cycle/` alias was removed after being
superseded by the implement-issue skill.
