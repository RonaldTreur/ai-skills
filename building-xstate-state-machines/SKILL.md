---
name: building-xstate-state-machines
description: Use this skill for any system built with XState v5. Provides strict architectural and implementation rules for strongly-typed, composable state machines in vanilla TypeScript.
---

# XState v5 State Machine Skill

Use this skill when a task involves XState v5 machines, workflows, orchestration, lifecycle modeling, or actor composition.

Machines are architecture, not just state containers. React is irrelevant; assume vanilla TypeScript environments.

If the context7 MCP server is available, use the XState v5 documentation as reference.

Prioritize strong typing, deterministic behavior, explicit workflows, composable machines, disciplined side effects, and clarity over cleverness.

## Core Philosophy

- **The machine is the source of truth**: business logic lives in the machine.
- **Deterministic transitions**: transitions are explicit and readable.
- **Side effects are isolated**: machines describe behavior; services execute.
- **Type safety is mandatory**: context, events, actors, and outputs are typed.
- **Clarity over compression**: prefer explicit states over hidden logic.

## XState v5 Rules

- Create machines through `setup({ ... }).createMachine(...)`.
- Define types, actions, guards, services, and actors in `setup()`.
- Use `.getSnapshot()` as little as possible. Push information forward through events, transitions, actions, and event handling instead of polling.
- Use named actions and guards only; never declare inline action or guard functions.
- Use dynamic action params as `params: ({ context, event }) => ({ ... })`.
- Guards must be named and pure.

## Module Structure

Each machine lives in its own module under `src/state/`:

```text
src/state/<machine-name>/
  <machine-name>.machine.ts
  <machine-name>.types.ts
  <machine-name>.actions.ts
  <machine-name>.guards.ts
  <machine-name>.services.ts
```

Rules:

- `<machine-name>` is kebab-case.
- `<machine-name>.types.ts` is the single source of truth for `Context`, `Event`, and `Input`.
- actions, guards, and services export objects used in `setup()`.
- `<machine-name>.machine.ts` wires everything together.

## Naming Taxonomy

- Prefer factory exports such as `createDataSyncMachine` or `createVideoUploadMachine`; export a raw machine only when it has no configuration.
- Export machine types as `<Name>Context`, `<Name>Event`, and `<Name>Input`.
- Always set a unique id: `"<machine-name>"` or `"<scope>.<machine-name>"`, such as `data-sync` or `relay.video-upload`.
- State names describe lifecycle intent. Use names like `idle`, `loading`, `running`, `ready`, `success`, `failed`, `retrying`, `cancelled`, `validating`, `submitting`, `publishing`, `processing`, or nested names such as `running.fetching`. Avoid vague states like `step1`, `active`, or `doingStuff`.
- Events are an API. Use `SCREAMING_SNAKE_CASE` with domain intent, especially `*_REQUESTED`, `*_SUCCEEDED`, `*_FAILED`, `*_PROVIDED`, and `*_UPDATED`. Examples: `START_REQUESTED`, `INPUT_PROVIDED`, `FETCH_SUCCEEDED`, `RETRY_REQUESTED`. Avoid UI or mutation names such as `CLICK`, `SET_DATA`, and `UPDATE_STATE`.
- Use camelCase verb phrases for actions: `assignInput`, `persistArtifact`, `enqueueJob`, `emitTelemetry`, `notifyFailure`. Avoid generic names like `handle` or `doThing`.
- Use semantic predicate names for guards: `isX`, `hasX`, `shouldX`, `canX`, such as `hasValidInput`, `isRetryAllowed`, or `shouldPersistMetadata`.

## Machine Design Rules

- Each machine models one workflow, lifecycle, or domain.
- Split large systems into actors only when the actor has a clear reason to exist. Avoid actor sprawl.
- Keep context typed, minimal, and intentional. Never use context as a dumping ground.
- Events express domain intent, not UI mechanics. Treat events as a stable API.

## Error Handling

Errors are states. Async workflows must model success, failure, and recovery paths. Never swallow errors in services.

## Output Expectations

When designing a machine:

1. State diagram
2. Context schema
3. Event schema
4. Services/actions/guards overview
5. Failure behavior

When generating code:

- fully typed XState v5 machine
- no pseudo-code
- named actions and guards only
- production-usable structure
