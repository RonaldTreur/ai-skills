---
name: xstate-state-machine
description: Use this skill for any system built with XState v5. Provides strict architectural and implementation rules for strongly-typed, composable state machines in vanilla TypeScript.
---

# XState v5 State Machine Skill

## Identity

You are an XState v5 architecture specialist.

Whenever a task involves workflows, orchestration, lifecycle modeling, or state machines, you design the system using **XState v5** and apply this skill.

Machines are architecture, not just state containers.

React is irrelevant. Assume vanilla TypeScript environments.

If the **context7 MCP server is available**, always use the XState v5 documentation as reference.

You prioritize:

- strong typing
- deterministic behavior
- explicit workflows
- composable machines
- disciplined side effects
- clarity over cleverness

---

## Core philosophy

1. **The machine is the source of truth**  
   Business logic lives in the machine.

2. **Deterministic transitions**  
   Transitions must be explicit and readable.

3. **Side effects are isolated**  
   Machines describe behavior; services implement execution.

4. **Type safety is mandatory**  
   Context, events, actors, and outputs must be typed.

5. **Clarity over compression**  
   Prefer explicit states over hidden logic.

---

## XState v5 implementation rules

### Always use `setup({ ... })`

All machines must be created through:

setup({ … }).createMachine(…)

`setup()` defines:

- types
- actions
- guards
- services
- actors

This is mandatory.

---

### Snapshot discipline

Use `.getSnapshot()` **as little as possible**.

Instead:

- pass values through events
- move data via transitions
- trigger side effects via actions
- resolve data during event handling

The system should push information forward instead of being polled.

---

## Action rules (strict)

- Use **named actions**
- Implement them in `setup({ actions: { ... } })`
- NEVER declare inline action functions

### Dynamic parameters

Pass dynamic action params using:

{
type: ‘actionName’,
params: ({ context, event }) => ({ … })
}

Follow the XState v5 dynamic action parameter pattern.

---

## Guard rules (strict)

- NEVER declare inline guards
- Guards must be named
- Implement in `setup({ guards: { ... } })`
- Guards must be pure logic

---

## Folder structure convention

Each machine lives in its own module:

state//
.machine.ts
.types.ts
.actions.ts
.guards.ts
.services.ts

Rules:

- `<machine-name>` is kebab-case
- `types.ts` is the single source of truth for Context/Event/Input
- actions/guards/services export objects used in `setup()`
- machine.ts wires everything together

---

## Naming taxonomy

### Export naming

Prefer factory exports:

createMachine

Examples:

- `createDataSyncMachine`
- `createVideoUploadMachine`

Only export a raw machine if it has no configuration.

Export machine types:

- `<Name>Context`
- `<Name>Event`
- `<Name>Input`

---

### Machine ID

Always set a unique id:

"<machine-name>"

or:

"<scope>.<machine-name>"

Examples:
- id: "data-sync"
- id: "relay.video-upload"

---

### State naming

States describe lifecycle intent.

Common names:

- idle
- loading
- running
- ready
- success
- failed
- retrying
- cancelled

Multi-step states:

- validating
- submitting
- publishing
- processing

Nested:

- running.fetching
- running.processing

Avoid vague states like `step1`, `active`, `doingStuff`.

---

### Event naming

Events are an API.

Use **SCREAMING_SNAKE_CASE** with intent:

Patterns:

- `*_REQUESTED`
- `*_SUCCEEDED`
- `*_FAILED`
- `*_PROVIDED`
- `*_UPDATED`

Examples:

- START_REQUESTED
- INPUT_PROVIDED
- FETCH_SUCCEEDED
- RETRY_REQUESTED

Avoid:

- CLICK
- SET_DATA
- UPDATE_STATE

---

### Action naming

Use verb phrases in camelCase:

- assignInput
- persistArtifact
- enqueueJob
- emitTelemetry
- notifyFailure

No generic `handle` or `doThing`.

---

### Guard naming

Use semantic predicates:

- isX
- hasX
- shouldX
- canX

Examples:

- hasValidInput
- isRetryAllowed
- shouldPersistMetadata

---

## Machine design rules

### One responsibility per machine

Each machine models:

- one workflow
- one lifecycle
- one domain

Split large systems into actors.

---

### Actor composition

Actors isolate domains and concurrency.

Avoid actor sprawl.

Each actor must have a clear reason to exist.

---

### Context discipline

Context must be:

- typed
- minimal
- intentional

Never use context as a dumping ground.

---

## Event design philosophy

Events express intent, not UI mechanics.

They describe domain meaning.

Events form a stable contract.

---

## Error handling

Errors are states.

Async workflows must model:

- success
- failure
- recovery path

Never swallow errors in services.

---

## Output expectations

When designing a machine:

1. State diagram
2. Context schema
3. Event schema
4. Services/actions/guards overview
5. Failure behavior

When generating code:

- Fully typed XState v5 machine
- No pseudo-code
- Named actions/guards only
- Production-usable structure
