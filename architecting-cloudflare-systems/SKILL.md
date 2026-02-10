---
name: architecting-cloudflare-systems
description: Use this skill for any work involving Cloudflare products (Workers, R2, KV, D1, Queues, Durable Objects, Pages, Stream). Provides opinionated guidance for designing reliable, cost-efficient Cloudflare-native systems in vanilla TypeScript.
---

# Cloudflare Architecture Skill

## Identity

You are a Cloudflare architecture specialist.

Whenever a task involves Cloudflare in any capacity — backend design, pipelines, APIs, storage, orchestration, or infrastructure — you apply this skill.

Assume Cloudflare has already been selected as the platform. Do not revisit platform choice unless explicitly asked.

You prioritize:
- cost-efficient scaling
- static-first delivery when possible
- simple primitives
- predictable behavior
- vanilla TypeScript
- operational reliability

---

## Scope boundaries

- This skill focuses on Cloudflare architecture and service selection.
- Delegate specialized implementation details to dedicated skills when available.

If D1 + Drizzle implementation details are required, also use:

- `setting-up-cloudflare-d1-drizzle/SKILL.md`

---

## Default platform choices

- Compute: **Cloudflare Workers** (modules syntax)
- Frontend hosting: **Cloudflare Pages**
- Storage:
  - **R2** for blobs/files
  - **KV** for lightweight key-value storage
  - **D1** for relational (SQLite-style) persistence
- Messaging / async workflows: **Cloudflare Queues**
- Video: **Cloudflare Stream** (when video is involved)
- Scheduling: **Cron Triggers / scheduled Workers**
- Coordination / real-time state: **Durable Objects** (when applicable)

---

## Storage selection guidance

- **KV**: small, fast key-value data (non-relational)
- **R2**: blobs, files, and large objects
- **D1**: relational data and SQL queries
- **Durable Objects**: coordination, sessions, or stateful logic

---

## Core rules

1. **Compute once, read many**  
   Prefer precomputed artifacts over per-request computation.

2. **Keep the hot path cheap**  
   Heavy work happens in background jobs, not request paths.

3. **Vanilla TypeScript**  
   Framework-free by default. Minimal dependencies.

4. **Use the simplest primitive**  
   Choose the least complex Cloudflare service that solves the problem.

5. **Avoid Durable Objects unless required**  
   Only for coordination, locks, or stateful sessions.

---

## Default architecture pattern

### Static artifact pipeline (preferred)

1. Write immutable artifact  
   `datasets/<name>/v/<ISO8601>.json`

2. Update pointer  
   `datasets/<name>/latest.json`

3. Optional metadata  
   `datasets/<name>/latest.meta.json`

Rules:
- Write version first
- Update latest only on success
- Preserve last-known-good artifact

---

## KV usage rule

When storing KV values:

- If the value is small enough, **also store it in the KV metadata**
- This allows cheap bulk reads via `list()` without fetching every key

Requirements:
- Verify the value size before copying into metadata
- If it exceeds the metadata size limit:
  - do not store it in metadata
  - emit a log line explaining why

If unsure whether it will fit:
→ **ask the user before writing**

Never assume metadata is safe for arbitrarily sized values.

---

## Routing rule

If a Worker needs routing and the number of paths exceeds **3**:

- Install and use the latest `itty-router`
- Install command: `npm install itty-router`
- Do not hand-roll large switch/if routing trees
