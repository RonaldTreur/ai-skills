# Discipline Map

Use this map to review external sources against the real project-development routine.

## Current Runtime Owners

- Project kickoff: `project-kickoff`
- Project lifecycle monitoring and backlog management: `project-manager`
- Active implementation: `implement-issue`
- Documentation and handoff: `documentation-handoff`
- Debugging: `debugging`
- Code review: `code-review`
- Skill review and promotion: `skill-review`
- Agent orchestration and delegation: `agent-delegation`
- GitHub label automation: `gh-pipeline`
- Browser QA: `browser-qa`
- Test planning: `test-planning`
- Test orchestration: `testing-orchestrator`
- Unit and integration tests: `unit-vitest`
- Playwright E2E tests: `e2e-playwright`
- Test/CI enforcement policy: `test-ci-policy`
- Frontend design: `frontend-design`
- Web architecture and implementation conventions: `developing-web-projects`
- UI prompt building: `ui-design-prompt`
- Web Component generation: `generating-web-components`

## Folded Or Deferred Disciplines

- Research and discovery: folded into `project-kickoff` as grounding before
  shaping. Use `deep-research`, `last30days`, `x_search`, Brave/web search,
  repo discovery, and memory/session lookup only when they can change kickoff,
  backlog, scope, setup, or next-work decisions.
- Product thinking and non-visual design: owned by `project-kickoff`.
- Architecture: owned by the relevant domain skill when one exists, otherwise by
  `project-kickoff`, `project-manager`, `implement-issue`, and `code-review`
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
- Skill review
- Code review
- Implementation lifecycle
- Browser QA
- Project lifecycle monitoring
- Testing and QA
- Project kickoff
- Frontend design
- Agent orchestration and delegation
- GitHub issue automation
- Documentation and handoff
- Final taxonomy cleanup

## Rejected Or Superseded Runtime Owners

- Standalone `research-discovery`: rejected for now. The repeated value is early
  project grounding, so the behavior belongs in `project-kickoff`.
- `enforcing-test-coverage-vitest-playwright`: superseded by
  `test-ci-policy`, `test-planning`, `testing-orchestrator`, `unit-vitest`,
  `e2e-playwright`, and `browser-qa`.
- Broad external-source runtime imports: rejected. External sources stay in
  methodology/provenance artifacts; runtime skills keep local operational
  language.
