# Discipline Map

Use this map to review external sources against the real project-development routine.

## Current Runtime Owners

- Start new project: `start-new-project`
- Project lifecycle monitoring and backlog management: `project-manager`
- Active implementation: `implement-issue`
- Documentation and handoff: `documentation-handoff`
- Debugging: `debugging`
- Code review: `code-review`
- Skill review, library audit and cleanup: `skill-review`
- Session and post-merge retrospectives: `retro`
- Agent orchestration and delegation: `project-manager/references/delegation.md`
- GitHub label automation: `gh-pipeline`
- Browser QA: `browser-qa`
- Test strategy, sequencing, authoring gate and CI policy: `testing`
- Unit and integration tests: `unit-vitest`
- Playwright E2E tests: `e2e-playwright`
- Test pruning (user-invoked): `test-audit`
- Frontend design: `frontend-design`
- Web architecture and implementation conventions: `developing-web-projects`
- Design prompt export: `frontend-design` (Prompt Export section)
- Web Component generation: `generating-web-components`

## Folded Or Deferred Disciplines

- Research and discovery: folded into `start-new-project` as grounding before
  shaping. Use web and social search, deep research reports, repo discovery,
  and the harness's memory and session history only when they can change
  project shaping, backlog, scope, setup, or next-work decisions.
- Product thinking and non-visual design: owned by `start-new-project`.
- Architecture: owned by the relevant domain skill when one exists, otherwise by
  `start-new-project`, `project-manager`, `implement-issue`, and `code-review`
  according to lifecycle stage.
- Learning capture: handled through `skill-review`,
  `external-skill-adaptation`, and repo-local provenance artifacts rather than a
  general learning skill.

## Meta-Behavior Disciplines

- When to slow down
- When to ask the user
- When to act without asking
- When to delegate
- When to stop digging and answer
- How to preserve attribution and provenance
- How to revisit external sources after they change

## Completed Adaptation Slices

- Debugging
- Research and discovery
- Skill maintenance and cleanup
- Skill review
- Code review
- Implementation lifecycle
- Browser QA
- Project lifecycle monitoring
- Testing and QA
- Start new project
- Frontend design
- Agent orchestration and delegation
- GitHub issue automation
- Documentation and handoff
- Final taxonomy cleanup
- Skill meta (November 2026): writing-for-agents yardstick, skill-review and skill-maintenance merge, retro, user-invoked flip
- Role-script removal (November 2026): agent names and OpenClaw tool names replaced by artifact gates across the lifecycle skills
- Testing merge (November 2026): test-planning, testing-orchestrator and test-ci-policy merged into testing; test-audit split into the authoring gate (in testing) and a user-invoked pruning skill
- Small merges (November 2026): add-feature into project-manager, agent-delegation into a project-manager reference, design-prompt-export into frontend-design

## Rejected Or Superseded Runtime Owners

- Standalone `research-discovery`: rejected for now. The repeated value is early
  project grounding, so the behavior belongs in `start-new-project`.
- `enforcing-test-coverage-vitest-playwright`: superseded in May 2026 by
  `test-ci-policy` and the other testing skills, which are in turn superseded by
  `testing` (2026-11-05).
- `test-planning`, `testing-orchestrator`, `test-ci-policy`: superseded by
  `testing` (2026-11-05); templates moved to `testing/templates/`.
- `add-feature`: folded into `project-manager` (Feature Intake, 2026-11-05).
- `agent-delegation`: now `project-manager/references/delegation.md`
  (2026-11-05).
- `design-prompt-export`: folded into `frontend-design` (Prompt Export,
  2026-11-05).
- `skill-maintenance`: superseded by `skill-review` (2026-11-03); the audit script moved to `skill-review/scripts/`.
- `run-workflow-retrospective`: superseded by `retro` (2026-11-03); RoundTable v1 is decommissioned and its scorecard machinery was deleted.
- Broad external-source runtime imports: rejected. External sources stay in
  methodology/provenance artifacts; runtime skills keep local operational
  language.
