# Writing levers

Read this when writing or rewriting a document an agent consumes: a skill, the repo's agent instructions, a reference reached by a pointer. The packaging differs; the writing does not. The aim is a predictable process on every run, not an identical output.

## Pointers

A context pointer is a line held in context that names material outside it and encodes when to reach for it. A skill description is one; a line in the agent instructions naming a doc is the same object. The pointer's wording, not its target, decides whether the agent gets there. A must-have target behind a weak pointer is a variance bug: sharpen the wording first, and inline the material only if sharpening fails. Front-load the leading word, give one trigger per distinct branch, and cut identity the body already carries.

## Hierarchy

A document mixes steps (what the agent does, in order) and reference (rules and facts consulted on demand). Rank each piece by how immediately the agent needs it: in-file step, then in-file reference, then disclosed reference behind a pointer. Push too little down and the top bloats; push too much and you hide material the agent needs. Branching is the cleanest test: inline what every branch needs, disclose what only some branches reach. Inside a file, keep a concept's definition, rules and caveats under one heading so reading one part brings its neighbours. The document should read like documentation written for the agent.

## Exhaustiveness

Give the agent a checkable bar for being done: "every step done" for a sequence, "every rule applied" for flat reference. Without one, attention thins across a long document and later items become a coin flip.

## Splitting

A split spends one of the two loads, so cut only when it earns it. Split by sequence when later steps tempt the agent to rush the one in front of it; keeping them out of view drives more legwork now. Split by invocation when a distinct trigger word in your prompts should fire a piece on its own, or another skill must reach it. When user-invoked skills multiply past what you remember, a router skill names them and when to use each; it can hint, never fire them.

## Leading words

A leading word is a concept already in the model's pretraining that it thinks with while running the document: tight, red, seam, tracer bullet. Repeated as a token, never as a sentence, it anchors a region of behaviour in the fewest tokens. Hunt for triads spelled out at three sites and pointers spending a sentence on one idea; each collapses into a word. A word too weak to beat the default is a no-op, and the fix is a stronger word, not a different technique. Negation drags the forbidden behaviour into context and makes it more available, so state the target behaviour instead; pair any unavoidable prohibition with its positive form.

## Pruning

- One source of truth per meaning; duplication costs tokens, maintenance, and inflates a meaning's rank.
- Check each line for relevance: never bearing on the task, or stale. Without this the default fate is sediment, stale layers that settle because adding feels safe and removing feels risky.
- Apply review checks 3 (no-ops) and 4 (cache) from `SKILL.md` sentence by sentence.
