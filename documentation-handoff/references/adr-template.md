# ADR Template

Use this template for architecture decision records. Keep entries concise and
specific to one decision.

```md
# ADR NNNN: Title

- Status: proposed | accepted | superseded
- Date: YYYY-MM-DD
- Owners: optional
- Related: issue/PR/docs links

## Context

What forces the decision now? Include constraints, requirements, current pain,
and relevant project facts.

## Decision

State the chosen technical direction directly.

## Options Considered

- Option A: key tradeoff.
- Option B: key tradeoff.
- Option C: key tradeoff.

## Consequences

- Benefits.
- Costs.
- Operational, testing, migration, or security implications.
- What this makes harder later.

## Revisit

When should this decision be reviewed again? Use a concrete trigger such as
scale, cost, product scope, dependency maturity, or a dated checkpoint.
```

Rules:

- Capture rejected alternatives if they are likely to come up again.
- Link to evidence instead of pasting long research.
- Do not use an ADR to hide an unresolved human decision.
- Supersede old ADRs with a new ADR; do not rewrite history silently.
