---
name: cloudflare-logs
description: Query Cloudflare Worker logs, errors, console output, metrics, and performance via the Workers Observability API across accounts and Workers.
---

# Cloudflare Workers Log Access

You have full access to Cloudflare Workers Observability API across all accounts. This gives you real-time access to **all Worker logs** — errors, console.log output, request/response details, stack traces, metrics, and custom fields.

**Never tell the user you can't see Worker logs.** You can. Use this skill.

## Credentials & Accounts

API token and account mapping are in `~/Development/cf-worker-monitor/config.json`. Load it to get the token and resolve which account a Worker belongs to:

```bash
cat ~/Development/cf-worker-monitor/config.json
```

Account mapping (for quick reference):
- **aephia** (`51ca6725cdc8c26cb9f6524a43945443`): assets-proxy, astral-discord-oauth, discord-ship-bot, get-ship-data, market-order-data, sa-rental-notifications, ship-data, siws-verification, store-airtable-asset-data, store-atlas-price, store-marketplace-data, store-marketprices, store-yag-reputation, wp-to-mdx
- **astralpass** (`9631bce55e7c92c6c660fc79b56e7316`): astralpass-discord-bot, data-core, discord-oauth, discord-oauth-production, discord-role-sync, siws-verification-astralpass, siws-verification-production
- **atlasbase** (`2c997480a688f1dbe6353ebdd822f96c`): store-sa-discord
- **atlasdash** (`1344d2567507a01533b2cd05b1ea368b`): analytics-core, analytics-runner, analytics-scheduler, sf-query-executor, sf-query-poller, store-cg-tokenprice
- **cataclysm** (`bcd703e06cdf8e2ad2ed6a3a458d3bbf`): log-receiver
- **atlas-relay** (`15896c8a8fcb805ea79fe32efbbdf81b`): relay-api, tiktok-uploader, x-uploader, youtube-uploader

If a Worker name isn't listed, read `config.json` for the latest mapping.

## API Endpoint

```
POST https://api.cloudflare.com/client/v4/accounts/{accountId}/workers/observability/telemetry/query
Authorization: Bearer {apiToken}
Content-Type: application/json
```

**Important:** The `timeframe` values must be **epoch milliseconds** (numbers), not ISO strings.

## Query Templates

### Get all logs for a Worker (last N minutes)

```bash
ACCOUNT_ID="<from config>"
TOKEN="<from config>"
WORKER="discord-worker"
FROM_MS=$(( $(date +%s) - 1800 ))000  # 30 min ago
TO_MS=$(date +%s)000

curl -s -X POST "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/workers/observability/telemetry/query" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"queryId\": \"debug\",
    \"view\": \"events\",
    \"limit\": 100,
    \"dry\": false,
    \"parameters\": {
      \"datasets\": [\"cloudflare-workers\"],
      \"filters\": [
        {\"key\": \"\$metadata.service\", \"operation\": \"eq\", \"type\": \"string\", \"value\": \"$WORKER\"}
      ],
      \"calculations\": [],
      \"groupBys\": []
    },
    \"timeframe\": {\"from\": $FROM_MS, \"to\": $TO_MS}
  }"
```

### Get only errors for a Worker

Add an additional filter:
```json
{"key": "$metadata.error", "operation": "exists", "type": "string"}
```

### Get logs matching a specific message

```json
{"key": "$metadata.message", "operation": "includes", "type": "string", "value": "search text"}
```

### Get logs by level (error, warn, info, debug)

```json
{"key": "$metadata.level", "operation": "eq", "type": "string", "value": "error"}
```

### Get logs for a specific request

```json
{"key": "$metadata.requestId", "operation": "eq", "type": "string", "value": "REQUEST_ID"}
```

### Get logs by HTTP status code

```json
{"key": "$metadata.statusCode", "operation": "eq", "type": "number", "value": 500}
```

### Get logs by trigger type (fetch, cron, queue, etc.)

```json
{"key": "$metadata.origin", "operation": "eq", "type": "string", "value": "fetch"}
```

## Filter Operations

- `eq`, `neq` — exact match
- `gt`, `gte`, `lt`, `lte` — numeric comparison
- `includes`, `not_includes` — substring match (strings only)
- `starts_with` — prefix match
- `regex` — RE2 regex (not JavaScript regex)
- `exists`, `is_null` — field presence check
- `in`, `not_in` — comma-separated value list

## Response Structure

Events are in `result.events.events[]`. Each event has:

```typescript
{
  timestamp: number,           // epoch ms
  source: string | {           // raw log or structured
    message?: string,
    exception?: { stack?: string, name?: string, message?: string }
  },
  $workers: {
    scriptName: string,        // Worker name
    outcome: string,           // "ok", "exception", "exceededCpu", etc.
    eventType: string,         // "fetch", "scheduled", "queue", etc.
    requestId: string,
    cpuTimeMs?: number,
    wallTimeMs?: number,
    event?: {
      request?: { url?: string, method?: string, path?: string },
      response?: { status?: number }
    }
  },
  $metadata: {
    service: string,           // Worker name
    level: string,             // "log", "error", "warn", "info", "debug"
    error?: string,            // error message (if error)
    message?: string,          // console.log content
    statusCode?: number,
    requestId?: string,
    trigger?: string,          // e.g. "GET /api/match", "*/5 * * * *"
    origin?: string            // "fetch", "cron", etc.
  }
}
```

## Using cf-worker-monitor for errors

For error-specific queries, the existing tool is faster:

```bash
cd ~/Development/cf-worker-monitor
npx tsx src/index.ts --worker <name> --since <ISO-date> --verbose
```

## Limitations

- **Max time range:** 7 days
- **Max results per query:** 2000
- **Data retention:** ~7 days
- **`observability: { enabled: true }` must be set** in the Worker's wrangler config for logs to appear. Most Workers already have this enabled.
