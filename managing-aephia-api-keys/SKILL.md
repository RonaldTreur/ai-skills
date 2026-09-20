---
name: managing-aephia-api-keys
description: Create, store, list, rename, rotate, or revoke named internal Aephia API keys for projects consuming api.aephia.com.
---

# Aephia API keys

Use the protected management API at **https://keys.aephia.com** for named project keys. Colleagues sign in with email one-time codes and manage only keys they created. Ordinary management needs no Cloudflare account membership, Wrangler login, migrations, or deployment. Existing operator-created keys remain operator-only.

## Prepare on any machine

Canonical private source: **https://github.com/Aephia/api-gateway**. GitHub repository access and management email login are separate prerequisites.

1. Find an existing checkout in the host's project directory and verify its Git origin is `Aephia/api-gateway`. Ronald's `/Users/ronaldtreur/Development/Aephia/api-gateway` is a hint, not a required path. Preserve dirty or divergent work.
2. If absent, verify `gh repo view Aephia/api-gateway`, then `gh repo clone Aephia/api-gateway <writable-directory>` outside the consuming repository. Use the current default branch. Fetch and fast-forward an existing clean default-branch checkout when possible; never reset it. If access fails, resolve GitHub access rather than rebuilding the client or using a similarly named repo.
3. Read `AGENTS.md`, `README.md`, `scripts/manage-keys.ts` and `scripts/management-client.ts`. Verify the management client exists; an old ship-only checkout needs updating. Use `.nvmrc` (Node 24 recommended; minimum 22.14) and run `npm ci` for a fresh clone, missing dependencies or changed lockfile.
4. Check `cloudflared --version`. Install the official Cloudflare client using the host's package manager when needed (`brew install cloudflared` on macOS; use Cloudflare's installation instructions for other systems). Do not install or configure a Tunnel.
5. Run `node --experimental-strip-types scripts/manage-keys.ts me` from the gateway checkout. If no cached Access session exists, start `cloudflared access login --quiet https://keys.aephia.com`; keep output private if using a client version without `--quiet`, since normal login output contains a session token. Let the user complete browser email-code sign-in, then retry `me`. Do not ask for the Cloudflare setup/admin token, copy sessions across machines, or print JWTs. Login expiry requires signing in again. Check the returned email matches the intended acting user.

The client obtains the cached Access token and sends it only in the `cf-access-token` header; it refuses redirects. Never put credentials in URLs or use `cloudflared access curl` wrappers that may do so. Default production origin is keys.aephia.com; only override `AEPHIA_KEY_MANAGEMENT_URL` for an explicitly intended environment.

## Identify and perform the request

Determine the project/environment, custom key name, and secret destination. Use an evident name such as `Slingshot production`; follow the consuming project's variable name or default to `AEPHIA_API_KEY`. Ask only for missing information. Explicit create/rename/rotate/revoke requests authorize those operations; listing or explanation does not authorize mutation.

Run in the gateway checkout:

```sh
node --experimental-strip-types scripts/manage-keys.ts list
node --experimental-strip-types scripts/manage-keys.ts get --id <key-uuid>
node --experimental-strip-types scripts/manage-keys.ts create --name "Slingshot production" --request-id <fresh-request-uuid>
node --experimental-strip-types scripts/manage-keys.ts rename --id <key-uuid> --name "Slingshot staging"
node --experimental-strip-types scripts/manage-keys.ts revoke --id <key-uuid>
```

**Capture creation stdout in memory, never tool output.** Use an argument-array subprocess, not interpolated shell text. Creation returns `{status:201,result:{key,token}}`. Other successful operations return `{status:200,result:...}`. List pagination returns `result.next`; pass it with `--after` until null. Filter names locally. Names are editable, nonunique labels, not permission scopes; use UUIDs for mutation.

Generate one request UUID before creation and retain it for reconciliation. Creation optionally accepts `--expires` with a future UTC ISO timestamp; do not add expiry unless requested or required by the project. A repeated same-owner request UUID returns `{status:409,result:{error,key}}`, with metadata but **no token**. This is not successful secret delivery. After an ambiguous network result, repeat the same request UUID before issuing anything new. If its secret was lost, revoke only that conclusively identified orphan, then create a replacement with a new request UUID. Never revoke by matching name alone or repeatedly issue on errors.

## Deliver and verify

Store the one-time `result.token` in the user's chosen secret manager or gitignored local secret file with owner-only permissions. Never echo captured JSON, put tokens in shell arguments, committed files, browser code, URLs or logs. Only the hash is stored: an existing secret cannot be retrieved.

For a consumer Worker, feed the token through stdin to that project's `wrangler secret put` only when authorized. This consumer deployment step can need Cloudflare authentication even though issuing the key does not. Follow the consumer's deployment conventions.

Verify a small data read using `Authorization: Bearer <token>` without logging the header, for example `GET https://api.aephia.com/v1/sage/ship-configurations/1` (check current README). Report UUID, custom name, expiry and destination, never the secret. For rotation, activate and verify the replacement before revoking the exact old UUID. If deployment is outside scope, leave the old key active and report what remains. Revocation is permanent; subsequent validations reject it, while in-flight reads may finish.

## Operator-only and local development

Use `scripts/keys.ts` with `--remote` only for explicitly authorized account-wide administration or legacy operator-created keys. That path needs Wrangler authentication for **Aephia and FC**, account `51ca6725cdc8c26cb9f6524a43945443`; it must not be an automatic fallback for denied colleague access. Consult the repository README. Local gateway tests use its `--local` database, not the live management service. A locally running consumer still needs a production key when calling api.aephia.com.

Internal `aep_internal_` keys validate only against gateway D1. Invalid internal keys never fall back to security-bot; other tokens retain Discord validation. Both categories grant the same data read access. Do not access security-bot token storage or reconfigure Access as part of ordinary key management.
