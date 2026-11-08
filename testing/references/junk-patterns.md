# Junk test patterns

The authoring gate in `SKILL.md` rejects a new test that matches one of these; the typed `test-audit` skill hunts for existing ones. Judge a test by its assertions, not its name.

Vacuous or circular:

- assertion-free probes that only execute code for coverage;
- self-comparisons, identity copies, or expected values computed by the helper or renderer under test;
- mocks that implement the behavior being asserted, or one identical mock standing in for different APIs;
- fixtures that hand the owner the receipts, acknowledgements or callback order it is supposed to produce, or persistence asserted against a store the path never writes.

Duplicated or misplaced:

- copies of fixtures, inventories, manifests or export lists;
- private predicate or call-shape tests that duplicate a real boundary;
- repeated invocations of one contract, or provider-local replays of a shared helper;
- the same scenario replayed at several layers.

Coupled to implementation:

- exact source, import or string greps that survive no refactor;
- tests whose only purpose is keeping a test-only export, global or wrapper alive;
- dead production code whose only callers are tests;
- capability or flag tests that restate a declaration instead of exercising what the flag promises.

Misleading:

- negative controls that pass for an unrelated reason, such as a different guard's denial or a rejection the production path never reaches;
- names or fixtures that promise more than the input exercises.

Several of these are greppable (assertion-free tests, test-only exports, source greps) and belong in lint once a project has hit them twice.
