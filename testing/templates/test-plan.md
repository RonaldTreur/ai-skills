# TEST_PLAN.md

## Context
- Feature / change:
- Source of truth (`BRIEF.md`, issue, PR):
- Reviewer:
- Date:

## Test Strategy Summary
- Outside-in sequence:
- Risk areas:
- Coverage target (default 100% unit thresholds):

## E2E Tests (`tests/e2e/`)

### User Flows
- [ ] Flow 1:
- [ ] Flow 2:

### Happy Paths
- [ ] HP-1:
- [ ] HP-2:

### Edge Cases
- [ ] EC-1:
- [ ] EC-2:

### Error States
- [ ] ER-1:
- [ ] ER-2:

## Integration/API Tests
- [ ] Worker/API boundary:
- [ ] Persistence, queue, auth callback or external-service seam:

## Unit Tests

### Module: `src/...`
- Function: `name()`
  - [ ] behavior 1
  - [ ] behavior 2
- Function: `name()`
  - [ ] behavior 1

### Module: `src/...`
- Function: `name()`
  - [ ] behavior 1

## Browser QA
- Smoke / focused / post-merge flows for [[browser-qa]]:
- Responsive and console-error checks:

## Auth and Test Data
- Safe non-production auth path for protected flows:
- Seed users, fixtures, storage state, reset steps:
- Forbidden production credentials or actions:

## CI and Commands
- install / build / typecheck / lint / unit / E2E / preview / coverage:
- Artifacts kept on failing E2E runs:

## Coverage Gaps
- Existing tests found:
- Missing high-value coverage:
- Legacy risk areas:

## Not Testing (with rationale)
- Item:
  - Reason:
  - Mitigation (if any):

## Execution Links
- E2E implementation: [[e2e-playwright]]
- Unit implementation: [[unit-vitest]]

## Progress Tracking
- [ ] Plan approved
- [ ] E2E tests added
- [ ] Unit tests added
- [ ] Coverage validated

### Coverage Snapshot
- Lines:
- Statements:
- Functions:
- Branches:

## Post-implementation Notes
- Deviations from plan:
- Follow-up work:
