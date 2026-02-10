---
name: setting-up-cloudflare-d1-drizzle
description: Implement Cloudflare D1 + Drizzle ORM integration in a Workers project. Use when wiring a D1 binding into Wrangler/Env, defining sqlite-core schema, creating a typed Drizzle D1 database, and structuring a DataStore/repository layer with migrations.
---

# Cloudflare D1 + Drizzle Integration (Workers)

## Objective

Wire Cloudflare D1 into a Worker using Drizzle ORM with a schema-first, typed DataStore layer and SQL migrations.

## Prerequisites / Assumptions

- Cloudflare is already chosen as the platform.
- D1 is the correct storage fit for the data (relational).
- The project uses Workers and Wrangler is already configured.
- A D1 database exists and will be bound in `wrangler.toml`.

## Core Pattern (What This Setup Emphasizes)

- Use the D1 adapter: `drizzle-orm/d1`
- Pass schema to Drizzle for full typing: `drizzle(d1, { schema })`
- Centralize all D1 access in a `DataStore` class
- Keep schema in `sqlite-core` and migrations in a dedicated folder wired to Wrangler
- Store JSON payloads as `text` and encode/decode in the DataStore layer

## Minimal Integration Steps

1) **Wrangler D1 binding**
   - Add `d1_databases` entry with:
     - `binding` (Env name used by Worker, e.g. `DB`)
     - `database_name` / `database_id`
     - `migrations_dir` pointing to the Drizzle output folder

2) **Drizzle config**
   - Use sqlite dialect.
   - Keep `out` in sync with Wrangler’s `migrations_dir`.

3) **Schema**
   - Use `drizzle-orm/sqlite-core` and `sqliteTable`.
   - Prefer `snake_case` DB column names.
   - Use timestamp columns as `integer(..., { mode: 'timestamp_ms' })` with `$defaultFn`.

4) **Typed DB**
   - Define a `Database` type alias:
     - `DrizzleD1Database<typeof schema>`

5) **DataStore wrapper**
   - Accept a `D1Database`.
   - Construct Drizzle: `drizzle(d1, { schema }) as Database`.
   - Expose domain methods (queries, upserts, deletes).
   - Use `onConflictDoUpdate` for idempotent upserts.

6) **Worker wiring**
   - Inject `env.DB` into the DataStore:
     - API middleware: instantiate per request.
     - Worker entrypoint: instantiate once in constructor.

7) **Migrations**
   - Keep SQL migrations in `drizzle/`.
   - Ensure schema changes always have migrations.

## Dependencies (Latest)

Use the latest versions.

- Runtime: `drizzle-orm`
- Dev: `drizzle-kit`

Install (use the project’s package manager):

```
pnpm add drizzle-orm
pnpm add -D drizzle-kit
```

```
npm install drizzle-orm
npm install -D drizzle-kit
```

## Expected file locations

```
wrangler.toml
drizzle.config.json
src/db/schema.ts
src/db/index.ts
drizzle/
```

## Drizzle Config (Include as-is)

```json
{
	"schema": "./src/db/schema.ts",
	"out": "./drizzle",
	"dialect": "sqlite"
}
```

## Notes

- Ensure Wrangler is configured before deploy.
- Set up the D1 database (Cloudflare dashboard or CLI) before running migrations.

## Implementation Reminders

- Always use the D1 adapter import: `import { drizzle } from 'drizzle-orm/d1';`
- Always pass the schema into `drizzle` to preserve typing.
- Keep JSON columns as `text` and parse/serialize inside DataStore methods.
- Keep migrations and schema in lockstep to avoid drift.

## Commands (Confirm Before Running)

Use the project’s existing scripts if present. Otherwise, confirm before running raw commands.

Example (confirm for the project):

```
npx drizzle-kit generate
wrangler d1 migrations apply <database_name>
```

## Minimal Wiring Example (Reference)

```ts
// src/db/index.ts
import { drizzle, DrizzleD1Database } from 'drizzle-orm/d1';
import * as schema from './schema';

export type Database = DrizzleD1Database<typeof schema>;

export class DataStore {
  private db: Database;

  constructor(d1: D1Database) {
    this.db = drizzle(d1, { schema }) as Database;
  }
}
```

```ts
// src/index.ts (Worker entry)
import { DataStore } from './db';

export default {
  fetch(request: Request, env: Env) {
    const store = new DataStore(env.DB);
    // use store...
    return new Response('ok');
  },
};
```
