# Adaptation Log

This log records how external agent-methodology sources influence this repository.

Use one entry for each material adoption, adaptation, inspiration, rejection, deferral, or supersession.

## Entry Template

```yaml
id:
date:
discipline:
status:
source:
source_url:
source_ref:
source_path:
license:
local_target:
influence_type:
summary:
local_adaptation:
rationale:
credit_note:
reviewer:
next_review:
```

## Entries

```yaml
id: 2026-05-24-testing-qa-auth-readiness
date: 2026-05-24
discipline: testing-and-qa
status: adopted
source: local project lifecycle and browser QA decisions
source_url: local Discord discussion
source_ref: 2026-05-24 #claw-enhance conversation
source_path: n/a
license: repository-local decision
local_target: test-planning/SKILL.md; testing-orchestrator/SKILL.md; test-planning/PROVENANCE.md; testing-orchestrator/PROVENANCE.md; methodology/disciplines/testing-and-qa.md
influence_type: structural
summary: Testing strategy must plan browser-QA scope, safe auth, seed data, fixtures, CI, and blocked coverage before feature issues depend on them.
local_adaptation: Added auth/test-data/browser-QA/CI sections to TEST_PLAN expectations and added readiness checks to the testing orchestrator workflow.
rationale: Full QA and durable tests are not possible if protected flows, fixtures, or preview commands are discovered as blockers only after implementation.
credit_note: Local testing policy decision from the user and prior PR #7/#8 outcomes.
reviewer: Merlin
next_review: When e2e-playwright and unit-vitest receive their own focused pass
```

```yaml
id: 2026-05-24-testing-qa-flexible-e2e-roles
date: 2026-05-24
discipline: testing-and-qa
status: adapted
source: Matt Pocock Skills
source_url: https://github.com/mattpocock/skills
source_ref: b8be62ffacb0118fa3eaa29a0923c87c8c11985c
source_path: skills/engineering/tdd/SKILL.md
license: MIT
local_target: testing-orchestrator/SKILL.md; testing-orchestrator/PROVENANCE.md
influence_type: behavioral
summary: Testing should move in vertical behavior slices rather than mandatory horizontal phases.
local_adaptation: Kept the Playwright planner/generator/healer roles for durable scenario generation, but stopped requiring the full sequence for tiny issue-local changes where one focused failing test is enough.
rationale: A rigid full E2E role pipeline can add ceremony and delay feedback; vertical slices preserve discipline while keeping the loop tight.
credit_note: Adapted from Matt Pocock's TDD guidance.
reviewer: Merlin
next_review: After several issue implementations exercise the lighter path
```

```yaml
id: 2026-05-24-project-manager-testable-readiness
date: 2026-05-24
discipline: project-lifecycle-monitoring
status: adopted
source: local project lifecycle discussion
source_url: local Discord discussion
source_ref: 2026-05-24 #claw-enhance conversation
source_path: n/a
license: repository-local decision
local_target: project-manager/SKILL.md; project-manager/PROVENANCE.md; methodology/disciplines/project-lifecycle-monitoring.md
influence_type: structural
summary: Project management should prevent QA and auth blockers by ensuring project setup is testable before feature issues depend on it.
local_adaptation: Added a project-readiness gate for commands, CI, seed data, safe auth paths, browser-QA access, and durable handoff state; issue decomposition now includes browser-QA scope and test-data prerequisites.
rationale: Browser QA and implementation can only stay reliable when project setup creates a safe verification path up front.
credit_note: Local lifecycle policy decision from the user.
reviewer: Merlin
next_review: When test-planning and testing-orchestrator receive their deeper pass
```

```yaml
id: 2026-05-24-browser-qa-controlled-profile
date: 2026-05-24
discipline: browser-qa
status: adopted
source: local user QA workflow decision
source_url: local Discord discussion
source_ref: 2026-05-24 #claw-enhance conversation
source_path: n/a
license: repository-local decision
local_target: browser-qa/SKILL.md; browser-qa/PROVENANCE.md
influence_type: behavioral
summary: Browser QA should default to the active agent's own controlled browser profile unless instructed otherwise.
local_adaptation: Added setup guidance to use the agent-controlled profile by default and avoid personal or project-specific profiles unless explicitly requested.
rationale: Automated browser QA needs a profile the agent can control reliably; switching to other profiles can break flows through missing extensions, permissions, or private state.
credit_note: Local QA policy decision from the user.
reviewer: Merlin
next_review: When browser tooling adds first-class multi-profile support
```

```yaml
id: 2026-05-23-browser-qa-implementation-testability
date: 2026-05-23
discipline: browser-qa
status: adopted
source: Local ai-skills implementation lifecycle review
source_url: local repository
source_ref: PR #7 review on 2026-05-23
source_path: implement-issue/SKILL.md; browser-qa/SKILL.md
license: repository-local guidance
local_target: implement-issue/SKILL.md; implement-issue/PROVENANCE.md; browser-qa/SKILL.md
influence_type: structural
summary: Implementation must make user-visible web features browser-QA-able, including protected authenticated flows.
local_adaptation: Added QA access to implementation intake, vertical slices, verification gates, merge criteria, and stop conditions. Missing safe auth setup for changed protected flows is now an implementation blocker before merge.
rationale: The user clarified that QA blockers should be prevented while building testable features, not merely discovered after the fact by browser QA.
credit_note: Internal workflow refinement from the user's review of the browser QA adaptation.
reviewer: Merlin
next_review: When project-manager or project-kickoff defines standard project setup requirements
```

```yaml
id: 2026-05-23-browser-qa-auth-blockers
date: 2026-05-23
discipline: browser-qa
status: adapted
source: GStack
source_url: https://github.com/garrytan/gstack
source_ref: 61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c
source_path: qa/SKILL.md
license: MIT
local_target: browser-qa/SKILL.md
influence_type: behavioral
summary: Browser QA for protected areas requires an explicit auth path; CAPTCHA, login, and missing test data can block meaningful coverage.
local_adaptation: Added an authenticated-QA hierarchy: documented non-production test accounts or seeded users first, approved secret stores only, ignored local storage state when supported, production-disabled dev auth paths only when documented, and explicit QA infrastructure blockers when no safe auth path exists.
rationale: The user identified auth as a practical blocker for full QA; making it a browser-qa rule prevents silent partial coverage and points project setup toward reusable test accounts or fixtures.
credit_note: Adapted from GStack's browser QA authentication/blocker handling and localized to local safety rules.
reviewer: Merlin
next_review: When project setup skills define standard seeded users or preview auth conventions
```

```yaml
id: 2026-05-23-browser-qa-gstack-browser-first
date: 2026-05-23
discipline: browser-qa
status: adapted
source: GStack
source_url: https://github.com/garrytan/gstack
source_ref: 61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c
source_path: qa/SKILL.md
license: MIT
local_target: browser-qa/SKILL.md
influence_type: behavioral
summary: Browser QA should actually exercise the app in a browser, scale by mode, check console/responsive/user flows, and report defects with evidence.
local_adaptation: Created a focused browser-qa skill with quick, focused, post-merge, and full modes; defect evidence and P0-P3 priority; and explicit output shape.
rationale: The user identified scattered browser/post-merge QA references in implement-issue; a dedicated skill provides clearer ownership without bloating the implementation workflow.
credit_note: Adapted from GStack's browser-first QA workflow, with GStack runtime machinery removed.
reviewer: Merlin
next_review: After the skill has been used on several web PRs
```

```yaml
id: 2026-05-23-browser-qa-gstack-heavy-runtime
date: 2026-05-23
discipline: browser-qa
status: rejected
source: GStack
source_url: https://github.com/garrytan/gstack
source_ref: 61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c
source_path: qa/SKILL.md
license: MIT
local_target: browser-qa/SKILL.md
influence_type: negative-example
summary: GStack combines QA, auto-fixing, per-fix commits, health scoring, telemetry, setup checks, persistent reports, and test-framework bootstrap in one large workflow.
local_adaptation: Rejected those mechanics for default ai-skills behavior; kept only lightweight browser verification, triage, and reporting.
rationale: The user's workflow needs a smart browser QA specialist, not another broad lifecycle owner or runtime-specific system.
credit_note: Reviewed GStack QA and intentionally did not adopt its heavier runtime and report machinery.
reviewer: Merlin
next_review: Revisit only if the user wants formal QA reports or health scoring as a productized workflow
```

```yaml
id: 2026-05-23-browser-qa-implement-issue-specialist
date: 2026-05-23
discipline: browser-qa
status: adopted
source: Local ai-skills implementation lifecycle review
source_url: local repository
source_ref: PR #6 merged 2026-05-23
source_path: implement-issue/SKILL.md
license: repository-local guidance
local_target: implement-issue/SKILL.md; implement-issue/PROVENANCE.md
influence_type: structural
summary: The implementation workflow should call a browser QA specialist instead of defining vague browser/post-merge QA inline.
local_adaptation: Updated implement-issue to reference [[browser-qa]] for user-visible browser checks, repeated UI/routing verification, and post-merge QA.
rationale: This preserves implement-issue as one-issue execution while giving QA a clear owner and reducing inline workflow bloat.
credit_note: Internal refinement prompted by the user's review of PR #6.
reviewer: Merlin
next_review: When project-manager and testing-orchestrator are revisited
```

```yaml
id: 2026-05-23-implementation-superpowers-delegation
date: 2026-05-23
discipline: implementation-lifecycle
status: adapted
source: SuperPowers
source_url: https://github.com/obra/superpowers
source_ref: f2cbfbefebbfef77321e4c9abc9e949826bea9d7
source_path: skills/subagent-driven-development/SKILL.md; skills/subagent-driven-development/implementer-prompt.md
license: MIT
local_target: implement-issue/SKILL.md
influence_type: behavioral
summary: Delegated implementation should include explicit context, clear write scope, escalation statuses, and review before completion.
local_adaptation: Added Vectrix-first delegation guidance and DONE/DONE_WITH_CONCERNS/NEEDS_CONTEXT/BLOCKED status handling to the implement-issue skill.
rationale: The user's workflow uses multiple agents, but fresh agents need bounded context and explicit escalation rather than inherited assumptions.
credit_note: Adapted from SuperPowers subagent-driven development.
reviewer: Merlin
next_review: When OpenClaw delegation semantics or Vectrix ownership changes
```

```yaml
id: 2026-05-23-implementation-matt-vertical-tdd
date: 2026-05-23
discipline: implementation-lifecycle
status: adopted
source: Matt Pocock Skills
source_url: https://github.com/mattpocock/skills
source_ref: b8be62ffacb0118fa3eaa29a0923c87c8c11985c
source_path: skills/engineering/tdd/SKILL.md
license: MIT
local_target: implement-issue/SKILL.md; testing-orchestrator/SKILL.md
influence_type: behavioral
summary: TDD should proceed in vertical behavior slices through public interfaces, not horizontal all-tests-then-all-code batches.
local_adaptation: Added vertical behavior-first slices to the issue implementation workflow and outside-in testing workflow.
rationale: The approach preserves outside-in discipline while keeping each implementation slice small and learnable.
credit_note: Inspired by Matt Pocock's TDD skill, adapted for ai-skills.
reviewer: Merlin
next_review: After several implement-issue PRs exercise this workflow
```

```yaml
id: 2026-05-23-implementation-compound-guardrails
date: 2026-05-23
discipline: implementation-lifecycle
status: adapted
source: Compound Engineering
source_url: https://github.com/everyinc/compound-engineering-plugin
source_ref: 5297a9440fa009822ceef8052b9e644e782281e1
source_path: docs/skills/ce-plan.md
license: MIT
local_target: project-manager/SKILL.md; implement-issue/SKILL.md
influence_type: structural
summary: Plans should capture guardrails, decisions, scope, risks, units, and tests without pre-writing stale implementation choreography.
local_adaptation: Project management issues now describe behavior, dependencies, tests, and affected areas while leaving code-level decisions to the active implementation workflow.
rationale: This keeps plans useful for fresh agents without making them brittle when the codebase shifts.
credit_note: Adapted from Compound Engineering planning guidance.
reviewer: Merlin
next_review: When planning artifacts are evaluated against real project builds
```

```yaml
id: 2026-05-23-implementation-gstack-plan-review
date: 2026-05-23
discipline: implementation-lifecycle
status: adapted
source: GStack
source_url: https://github.com/garrytan/gstack
source_ref: 61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c
source_path: autoplan/SKILL.md; plan-ceo-review; plan-design-review; plan-devex-review; plan-eng-review; plan-tune
license: MIT
local_target: project-manager/SKILL.md; methodology/disciplines/implementation-lifecycle.md
influence_type: review-policy
summary: Planning review should surface unresolved decisions, close calls, and cross-functional risk before implementation proceeds.
local_adaptation: Adopted the decision/risk focus into project-manager readiness and discipline review, while rejecting GStack runtime scaffolding.
rationale: The useful part is the planning judgment, not the source's session/runtime machinery.
credit_note: Adapted from GStack plan review patterns.
reviewer: Merlin
next_review: If a dedicated project lifecycle monitoring skill is created
```

```yaml
id: 2026-05-23-implementation-project-manager-boundary
date: 2026-05-23
discipline: implementation-lifecycle
status: adopted
source: local user workflow decision
source_url: local Discord discussion
source_ref: 2026-05-23 #claw-enhance conversation
source_path: n/a
license: repository-local decision
local_target: project-manager/SKILL.md
influence_type: ownership-boundary
summary: Project management should own lifecycle, backlog, dependencies, status, and issue selection, not per-issue code execution.
local_adaptation: Reworked project-manager into the lifecycle owner and made it hand selected issues to implement-issue with compact context.
rationale: The old broad project-manager skill was unused because it overlapped too much with implementation and testing skills.
credit_note: Local policy decision from the user.
reviewer: Merlin
next_review: When project-manager is first used on a real project end to end
```

```yaml
id: 2026-05-23-implementation-remove-codex-alias
date: 2026-05-23
discipline: implementation-lifecycle
status: superseded
source: Local ai-skills implementation workflow
source_url: local repository policy
source_ref: feat/implementation-lifecycle-methodology on 2026-05-23
source_path: codex-implementation-cycle/SKILL.md; implement-issue/SKILL.md
license: repository-local process
local_target: codex-implementation-cycle/SKILL.md; implement-issue/SKILL.md
influence_type: deletion
summary: The old Codex-specific implementation-cycle skill duplicated the newer implement-issue skill.
local_adaptation: Removed codex-implementation-cycle and made implement-issue the canonical active-issue implementation workflow.
rationale: Keeping both would preserve duplicate ownership and stale Codex-specific framing.
credit_note: Local repository cleanup decision from the user and implementing agent.
reviewer: Merlin
next_review: If external tooling still references the old skill name
```

```yaml
id: 2026-05-23-implementation-web-boundary
date: 2026-05-23
discipline: implementation-lifecycle
status: adopted
source: Local skill ownership review
source_url: local repository policy
source_ref: feat/implementation-lifecycle-methodology on 2026-05-23
source_path: developing-web-projects/SKILL.md
license: repository-local process
local_target: developing-web-projects/SKILL.md
influence_type: ownership-boundary
summary: Web project guidance should own architecture and implementation defaults, not issue sequencing or implementation state.
local_adaptation: Added a scope boundary and adjusted the approval checkpoint for approved implement-issue runs.
rationale: Web defaults should constrain implementation, while the implementation workflow should own branch, issue, PR, and QA flow.
credit_note: Local repository ownership clarification.
reviewer: Merlin
next_review: When the web project skill is next exercised inside implement-issue
```

```yaml
id: 2026-05-23-implementation-test-planning-boundary
date: 2026-05-23
discipline: implementation-lifecycle
status: adopted
source: Local skill ownership review and Matt Pocock behavior-first testing
source_url: local repository policy; https://github.com/mattpocock/skills
source_ref: feat/implementation-lifecycle-methodology on 2026-05-23; b8be62ffacb0118fa3eaa29a0923c87c8c11985c
source_path: test-planning/SKILL.md; testing-orchestrator/SKILL.md; skills/engineering/tdd/SKILL.md
license: repository-local process; MIT
local_target: test-planning/SKILL.md; testing-orchestrator/SKILL.md
influence_type: ownership-boundary
summary: Test planning owns strategy and approval gates; active implementation adds issue-local tests in vertical behavior slices.
local_adaptation: Clarified approval boundaries in test-planning and changed testing-orchestrator's outside-in loop to one behavior at a time.
rationale: This keeps high-level test strategy deliberate while allowing approved implementation issues to move without unnecessary pauses.
credit_note: Local ownership clarification with behavior-slice influence from Matt Pocock's TDD skill.
reviewer: Merlin
next_review: During the dedicated test-planning/testing-orchestrator discipline pass
```

```yaml
id: 2026-05-23-implementation-template-adopted-changes
date: 2026-05-23
discipline: external-skill-adaptation
status: adopted
source: local user workflow decision
source_url: local Discord discussion
source_ref: 2026-05-23 #claw-enhance conversation
source_path: external-skill-adaptation/templates/discipline-review.md
license: repository-local decision
local_target: external-skill-adaptation/templates/discipline-review.md; external-skill-adaptation/PROVENANCE.md
influence_type: documentation
summary: The discipline review template should distinguish implemented changes from future recommendations.
local_adaptation: Renamed `Recommended Adaptations` to `Adopted Changes` and directed deferred ideas to rejections/deferrals.
rationale: The old heading was ambiguous once recommendations had already been implemented.
credit_note: Local policy decision from the user.
reviewer: Merlin
next_review: When the next discipline review template change lands
```

```yaml
id: 2026-05-23-code-review-matt-two-axis
date: 2026-05-23
discipline: code-review
status: adopted
source: Matt Pocock Skills
source_url: https://github.com/mattpocock/skills
source_ref: b8be62ffacb0118fa3eaa29a0923c87c8c11985c
source_path: skills/in-progress/review/SKILL.md
license: MIT
local_target: code-review/SKILL.md
influence_type: structural
summary: Split review into spec compliance and standards compliance, with an explicit fixed point and source discovery.
local_adaptation: Adopted as separate review axes for spec compliance, repo standards, and risk/quality inside one local workflow.
rationale: This prevents clean code from passing review when it misses the request, and prevents correct behavior from hiding local-standard violations.
credit_note: Inspired by Matt Pocock's review skill, adapted for ai-skills.
reviewer: Merlin
next_review: When the repo adds automated review harnesses or branch-wide review orchestration
```

```yaml
id: 2026-05-23-code-review-gstack-critical-first
date: 2026-05-23
discipline: code-review
status: adapted
source: GStack
source_url: https://github.com/garrytan/gstack
source_ref: 61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c
source_path: review/checklist.md; review/specialists/
license: MIT
local_target: code-review/SKILL.md
influence_type: behavioral
summary: Review critical risks before informational findings and suppress speculative review noise.
local_adaptation: Added a compact critical-first scan and evidence/suppression rules to the local code-review workflow.
rationale: The review skill should bias toward merge-blocking risk and avoid noisy checklist comments.
credit_note: Adapted from GStack's review checklist and specialist review categories.
reviewer: Merlin
next_review: When local code-review output quality is evaluated against real PRs
```

```yaml
id: 2026-05-23-code-review-compound-evidence-gate
date: 2026-05-23
discipline: code-review
status: adapted
source: Compound Engineering
source_url: https://github.com/everyinc/compound-engineering-plugin
source_ref: 5297a9440fa009822ceef8052b9e644e782281e1
source_path: docs/skills/ce-code-review.md; plugins/compound-engineering/skills/ce-code-review/SKILL.md
license: MIT
local_target: code-review/SKILL.md
influence_type: behavioral
summary: Scale review depth with diff risk and drop findings that are not anchored to the actual code.
local_adaptation: Added risk-scaled depth guidance and concrete finding evidence requirements.
rationale: This keeps small reviews lightweight while forcing deeper scrutiny on auth, data, public APIs, migrations, shell execution, and LLM trust boundaries.
credit_note: Inspired by Compound Engineering's confidence-gated review synthesis.
reviewer: Merlin
next_review: When the user decides whether code reviews should use specialist subagents by default
```

```yaml
id: 2026-05-23-code-review-superpowers-independent-review
date: 2026-05-23
discipline: code-review
status: adapted
source: SuperPowers
source_url: https://github.com/obra/superpowers
source_ref: f2cbfbefebbfef77321e4c9abc9e949826bea9d7
source_path: skills/requesting-code-review/SKILL.md; skills/requesting-code-review/code-reviewer.md; skills/subagent-driven-development/spec-reviewer-prompt.md
license: MIT
local_target: code-review/SKILL.md
influence_type: behavioral
summary: Treat review as an independent gate based on the actual diff, not the implementer's report.
local_adaptation: Strengthened preflight source discovery and kept spec compliance as a first-class review step.
rationale: A review that trusts summaries can miss both omitted requirements and unintended behavior.
credit_note: Adapted from SuperPowers code-review and spec-review prompts.
reviewer: Merlin
next_review: When local review workflows decide how often to require subagent review
```

```yaml
id: 2026-05-23-code-review-autofix-rejected
date: 2026-05-23
discipline: code-review
status: rejected
source: GStack and Compound Engineering
source_url: https://github.com/garrytan/gstack; https://github.com/everyinc/compound-engineering-plugin
source_ref: 61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c; 5297a9440fa009822ceef8052b9e644e782281e1
source_path: review/SKILL.md; docs/skills/ce-code-review.md
license: MIT
local_target: code-review/SKILL.md
influence_type: policy
summary: Review-mode autofix and mode parsing were reviewed and rejected for the generic local code-review skill.
local_adaptation: Preserved the existing rule: do not auto-fix without approval.
rationale: The user asked for review behavior as a quality gate; automatic edits during review blur the contract and can hide reviewer uncertainty.
credit_note: Reviewed but intentionally not adopted.
reviewer: Merlin
next_review: Revisit only if a separate fix-review or auto-remediation skill is created
```

```yaml
id: 2026-05-23-code-review-provenance
date: 2026-05-23
discipline: code-review
status: adopted
source: Local external-skill-adaptation policy
source_url: local repository policy
source_ref: feat/external-skill-adaptation on 2026-05-23
source_path: external-skill-adaptation/SKILL.md
license: repository-local process
local_target: code-review/PROVENANCE.md
influence_type: structural
summary: Material skill changes require a sibling provenance artifact.
local_adaptation: Added code-review/PROVENANCE.md and kept source attribution out of runtime code-review/SKILL.md.
rationale: Provenance is necessary for adaptation review and public explanation, but it should not consume runtime context during code review.
credit_note: Local repository policy.
reviewer: Merlin
next_review: When repository provenance policy changes
```


```yaml
id: 2026-05-22-debugging-matt-feedback-loop
date: 2026-05-22
discipline: debugging
status: adopted
source: Matt Pocock Skills
source_url: https://github.com/mattpocock/skills
source_ref: b8be62ffacb0118fa3eaa29a0923c87c8c11985c
source_path: skills/engineering/diagnose/SKILL.md
license: MIT
local_target: debugging/SKILL.md
influence_type: structural
summary: Build a fast deterministic feedback loop before hypothesizing or fixing.
local_adaptation: Adopted as the local debugging spine: build a fast deterministic repro loop before fixing, then verify with the original repro and a regression guardrail.
rationale: This is the clearest reusable default for non-trivial debugging and fits the approved policy without importing source-specific workflow baggage.
credit_note: Inspired by Matt Pocock's diagnose loop, adapted for ai-skills.
reviewer: Vectrix
next_review: When the repo decides whether adjacent testing skills should inherit the same completion gates
```

```yaml
id: 2026-05-22-debugging-superpowers-root-cause-gate
date: 2026-05-22
discipline: debugging
status: adapted
source: SuperPowers
source_url: https://github.com/obra/superpowers
source_ref: f2cbfbefebbfef77321e4c9abc9e949826bea9d7
source_path: skills/systematic-debugging/SKILL.md
license: MIT
local_target: debugging/SKILL.md
influence_type: behavioral
summary: No fixes without root-cause investigation first; reject multi-fix thrash and skipped repros.
local_adaptation: Adapted into a root-cause-first rule with a trivial-bug fast path, conditional hypothesis surfacing, and a stop-and-ask default after 3 failed fix attempts.
rationale: The source guardrails are valuable, but they needed lighter activation and clearer exceptions to fit normal ai-skills debugging work.
credit_note: Adapted from SuperPowers systematic-debugging guardrails.
reviewer: Vectrix
next_review: When adjacent test-healing skills are aligned with the same stop conditions
```

```yaml
id: 2026-05-22-debugging-superpowers-defense-in-depth
date: 2026-05-22
discipline: debugging
status: adapted
source: SuperPowers
source_url: https://github.com/obra/superpowers
source_ref: f2cbfbefebbfef77321e4c9abc9e949826bea9d7
source_path: skills/systematic-debugging/defense-in-depth.md
license: MIT
local_target: debugging/SKILL.md
influence_type: structural
summary: After finding a real root-cause pattern, consider entry, business, environment, and debug-layer defenses.
local_adaptation: Adapted into conditional defense-in-depth guidance for recurring or high-impact bug classes, auth/security/data-loss/reliability risks, and likely nearby repeats.
rationale: The prevention pattern is useful, but only when the bug class justifies the extra work.
credit_note: Influenced by SuperPowers defense-in-depth validation guidance.
reviewer: Vectrix
next_review: When the repo adds more explicit guidance on choosing regression seams
```

```yaml
id: 2026-05-22-debugging-compound-causal-chain
date: 2026-05-22
discipline: debugging
status: adapted
source: Compound Engineering
source_url: https://github.com/everyinc/compound-engineering-plugin
source_ref: 5297a9440fa009822ceef8052b9e644e782281e1
source_path: docs/skills/ce-debug.md
license: MIT
local_target: debugging/SKILL.md
influence_type: structural
summary: Require a causal-chain explanation, predictions for uncertain links, and an assumption audit before a non-trivial fix.
local_adaptation: Adapted into lightweight rules for targeted hypotheses, deliberate probes, correct-seam fixes, and explicit stop-and-ask behavior after repeated failed attempts.
rationale: The causal-chain discipline helps on hard bugs, but the local version keeps it optional for trivial fixes and avoids the source's heavier workflow machinery.
credit_note: Inspired by Compound Engineering's ce-debug investigation model.
reviewer: Vectrix
next_review: When the repo decides whether to require more explicit causal-chain writeups for production incidents
```

```yaml
id: 2026-05-22-debugging-gstack-debug-workflow-overhead
date: 2026-05-22
discipline: debugging
status: rejected
source: GStack
source_url: https://github.com/garrytan/gstack
source_ref: 61c9a20bd2e3a579c3d6184ed2fc95b51a528f7c
source_path: investigate/SKILL.md; qa/SKILL.md
license: MIT
local_target: generic debugging discipline
influence_type: comparison-only
summary: Clean-tree requirements, per-fix commit loops, telemetry/learnings hooks, and browser-QA artifact rules were reviewed for possible generic debugging adoption.
local_adaptation: None; only the investigation-first and evidence habits remain candidates.
rationale: These behaviors are too tied to GStack's own runtime, storage, and QA workflow to make sense as default ai-skills debugging rules.
credit_note: Reviewed GStack for debugging ideas; rejected its heavier workflow overhead for ai-skills.
reviewer: Vectrix
next_review: Revisit only if the user wants a browser-first QA/debugging discipline
```

```yaml
id: 2026-05-23-skill-review-claude-official-guidance
date: 2026-05-23
discipline: skill-review
status: adopted
source: Claude Agent Skills Documentation and Agent Skills Open Standard
source_url: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
source_ref: live documentation retrieved 2026-05-23
source_path: Claude Code skills docs; Claude skill authoring best practices; Claude.ai skills docs; agentskills.io overview/spec/evaluation docs
license: public documentation; guidance only
local_target: skill-review/SKILL.md
influence_type: structural
summary: Review skills according to model-facing activation, concise runtime context, progressive disclosure, focused workflows, and realistic behavior testing.
local_adaptation: Adopted as the top-level review order for activation, context value, progressive disclosure, instruction freedom, safety, and realistic prompt probes.
rationale: Claude and the Agent Skills standard are the highest-trust sources for how skill metadata and runtime bodies are consumed by models.
credit_note: Based on official Claude/Agent Skills authoring and evaluation guidance.
reviewer: Merlin
next_review: When official Claude or Agent Skills guidance changes materially
```

```yaml
id: 2026-05-23-skill-review-codex-skill-creator
date: 2026-05-23
discipline: skill-review
status: adopted
source: Codex system skill-creator
source_url: local Codex system skill
source_ref: local file reviewed 2026-05-23
source_path: /Users/merlin/.openclaw/agents/main/agent/codex-home/skills/.system/skill-creator/SKILL.md
license: local system-provided instructions; guidance only
local_target: skill-review/SKILL.md
influence_type: behavioral
summary: Treat context as scarce, assume Codex is already capable, match instruction specificity to task fragility, and protect validation integrity.
local_adaptation: Adopted as context-value review, instruction-freedom review, validation prompt hygiene, and the rule against expanding skills just to satisfy checklists.
rationale: This is Codex's own guidance for creating skills Codex can discover and use reliably.
credit_note: Adapted from the local Codex system skill-creator guidance.
reviewer: Merlin
next_review: When the Codex system skill-creator changes materially
```

```yaml
id: 2026-05-23-skill-review-provenance-placement
date: 2026-05-23
discipline: skill-review
status: adapted
source: Codex system skill-creator plus local external-skill-adaptation policy
source_url: local Codex system skill and local repository policy
source_ref: local files reviewed 2026-05-23
source_path: skill-creator/SKILL.md; external-skill-adaptation/SKILL.md
license: mixed local guidance
local_target: skill-review/SKILL.md; skill-review/PROVENANCE.md
influence_type: structural
summary: Avoid extraneous runtime files while preserving required adaptation provenance outside SKILL.md.
local_adaptation: Created skill-level `PROVENANCE.md`, but kept all attribution and rebuild notes out of the runtime skill text.
rationale: Provenance is necessary for this repository's adaptation workflow, but it does not help the model perform skill review during activation.
credit_note: Local adaptation of Codex file-hygiene guidance to ai-skills provenance requirements.
reviewer: Merlin
next_review: When repository provenance policy changes
```

```yaml
id: 2026-05-23-skill-review-community-verdict-shape
date: 2026-05-23
discipline: skill-review
status: adapted
source: Community skill review tools
source_url: https://skillstore.io/skills/softaworks-skill-judge
source_ref: live web pages retrieved 2026-05-23
source_path: skill-judge summaries; review-skill summary; skill-validator repository summary
license: mixed/marketplace sources; comparison only
local_target: skill-review/SKILL.md
influence_type: output-shape
summary: Use severity tiers and a categorical verdict to make skill review findings actionable.
local_adaptation: Adopted Critical/Important/Polish severities and PASS/NEEDS WORK/FAIL verdicts while rejecting default numeric scoring.
rationale: Severity and verdicts help actionability; numeric scoring risks false precision and checklist gaming.
credit_note: Inspired by community skill-review tools, subordinated to official Claude/Codex guidance.
reviewer: Merlin
next_review: If the repo adds an automated skill validator or eval harness
```

```yaml
id: 2026-05-23-skill-review-local-wiki-links
date: 2026-05-23
discipline: skill-review
status: adopted
source: local user integration decision
source_url: local Discord discussion
source_ref: 2026-05-23 #claw-enhance conversation
source_path: n/a
license: repository-local decision
local_target: skill-review/SKILL.md
influence_type: behavioral
summary: Do not flag `[[skill-name]]` references between local skills during skill review.
local_adaptation: Added a review exception for local wiki-style skill references because this repository's skills are designed to work together.
rationale: Treating these links as portability defects creates false positives and pushes the repo toward isolated skills, which is not the intended design.
credit_note: Local policy decision from the user.
reviewer: Merlin
next_review: If the repo changes how skills reference each other
```

```yaml
id: 2026-05-23-external-skill-adaptation-review-gate
date: 2026-05-23
discipline: external-skill-adaptation
status: adopted
source: Skill Review discipline and local user workflow decision
source_url: local repository skill-review workflow
source_ref: feat/external-skill-adaptation as of 2026-05-23
source_path: skill-review/SKILL.md; external-skill-adaptation/SKILL.md
license: repository-local decision
local_target: external-skill-adaptation/SKILL.md
influence_type: workflow
summary: End every created or changed runtime skill with a skill-review pass.
local_adaptation: Added a final `[[skill-review]]` gate to the external skill adaptation workflow and discipline-review template.
rationale: Skill adaptation should not finish before checking trigger accuracy, context cost, progressive disclosure, safety, and behavior.
credit_note: Local policy decision from the user, implemented via the new skill-review discipline.
reviewer: Merlin
next_review: After the next full discipline adaptation pass exercises the new gate
```

```yaml
id: 2026-05-23-debugging-trigger-dedup
date: 2026-05-23
discipline: debugging
status: adapted
source: Skill Review discipline
source_url: local repository skill-review workflow
source_ref: feat/external-skill-adaptation as of 2026-05-23
source_path: skill-review/SKILL.md; debugging/SKILL.md
license: repository-local decision
local_target: debugging/SKILL.md
influence_type: context-hygiene
summary: Remove redundant post-load trigger guidance from the debugging runtime skill.
local_adaptation: Deleted the loaded-body "Use this skill when" section because the frontmatter description already carries trigger guidance.
rationale: Once a skill is loaded, duplicate activation guidance spends context without improving debugging behavior.
credit_note: Follow-up from the first skill-review pass on debugging.
reviewer: Merlin
next_review: When debugging trigger behavior is next revised
```
