## Removal Candidates

### Safe to Delete Now
| Item | Location | Reason | Verified By |
|------|----------|--------|-------------|
| [description] | [file:line] | [unused/redundant/replaced] | [grep/test/coverage] |

### Defer with Plan
| Item | Location | Reason | Blocked By | Target Date |
|------|----------|--------|------------|-------------|
| [description] | [file:line] | [feature flag/migration needed] | [dependency] | [date] |

### Verification Steps
- [ ] Run full test suite after each removal
- [ ] Check for dynamic imports/requires that grep might miss
- [ ] Verify no external consumers (if library/API)
