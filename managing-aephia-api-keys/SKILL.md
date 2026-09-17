---
name: managing-aephia-api-keys
description: Create, store, list, rename, rotate, or revoke named internal Aephia API keys for projects consuming api.aephia.com.
---

# Aephia API keys

Manage credentials for the existing Aephia gateway, including from other project directories. This is not a workflow for building another key service or changing Discord member tokens.

## Check out and prepare the operator

Canonical source: **https://github.com/Aephia/api-gateway** (private). GitHub access and Cloudflare access are separate prerequisites. Do not substitute another similarly named repository.

1. Look for an existing checkout in the host's normal project directory; `/Users/ronaldtreur/Development/Aephia/api-gateway` is only a hint for Ronald's Mac, not a required path. Verify its Git origin is `Aephia/api-gateway` (SSH and HTTPS forms are equivalent). Do not reset or overwrite a dirty checkout.
2. If absent, choose a writable checkout directory outside the consuming project's repository. Verify access with `gh repo view Aephia/api-gateway`, then clone with `gh repo clone Aephia/api-gateway <checkout-directory>` or authenticated `git clone https://github.com/Aephia/api-gateway.git <checkout-directory>`. If the private repository cannot be accessed, resolve GitHub authentication/access; do not create a substitute repository or rebuild the operator.
3. Use the repository's current default branch for a fresh checkout. For an existing clean checkout, fetch and fast-forward that branch when possible. Preserve local changes/divergent branches and resolve them explicitly; never force a reset to run a key command.
4. Read the checkout's `AGENTS.md`, `README.md`, and `scripts/keys.ts`. They are authoritative for commands and behavior. Use `.nvmrc` when present and verify `package.json`'s Node requirement (currently Node 22.14+, Node 24 recommended).
5. Run `npm ci` in the operator checkout on a fresh clone, when dependencies are absent, or after its lockfile changes. Use the pinned local Wrangler; no global installation or copying the operator into the consuming project is needed.
6. Check `npx wrangler whoami` and the checkout's configured account. Production uses **Aephia and FC**, account `51ca6725cdc8c26cb9f6524a43945443`. If authentication is missing, use the user's normal Wrangler login or scoped Cloudflare API-token setup; do not copy credentials from another machine, print them, or change the configured account to bypass an access failure.

Run key commands in the operator checkout, not the consuming project's directory. Production D1 is already provisioned: ordinary key management needs no migrations or gateway deployment. `--remote` means the real Aephia gateway; `--local` means the operator checkout's local development database. A consuming app running locally may still need a remote key if it calls `https://api.aephia.com`.

## Identify the request

- Determine the consuming project, environment and custom key name. Prefer an evident name such as `Slingshot production`; ask only when the project or environment is unclear.
- Identify the intended secret destination from the task and consumer's configuration. Follow its existing variable name, or use `AEPHIA_API_KEY` when adding a new one. Ask if the destination is ambiguous.
- Treat an explicit create/rename/rotate/revoke request as authorization for that operation. Do not repeat confirmation. A request to list or explain keys does not authorize issuance, revocation, deployment, or changes to consumer secrets.
- Names are editable labels, not unique project IDs or permission scopes. Multiple keys may share a name. Use the returned UUID for rename/revoke; resolve ambiguous existing keys before mutation.

## Commands

These production examples run from the gateway checkout:

```sh
npm run keys -- list --remote --name "Slingshot production"
npm run keys -- create --remote --name "Slingshot production"
npm run keys -- rename --remote --id <key-id> --name "Slingshot staging"
npm run keys -- revoke --remote --id <key-id>
```

Creation optionally accepts `--expires` with a future UTC ISO timestamp. Do not add an expiry unless requested or required by the project. For local gateway tests, substitute `--local`; initialize that local database only if needed with `npm run db:migrate:local`.

The CLI requires Cloudflare authentication. A permission failure is not a reason to bypass it with raw D1 writes or to change account configuration.

## Secret delivery and verification

Creation returns JSON containing key metadata and a one-time `token`. To automate delivery, invoke `node --experimental-strip-types scripts/keys.ts ...` using an argument-array subprocess, capture stdout in memory and parse its JSON. Direct invocation avoids npm's stdout banners. Never emit the captured stdout into tool output or interpolate the token into a shell command.

Store the token in the selected consumer's secret manager or gitignored local secret file. For Cloudflare Workers, feed it through stdin to `wrangler secret put` in the consuming checkout and intended environment, when authorized by the task. Honor that project's deployment conventions. Never put it in Wrangler `vars`, committed source, browser bundles, URLs, or logs. If the requested consumer would expose a shared internal key client-side, resolve server-side use before issuing it.

Verify a read using `Authorization: Bearer <token>` without logging the header. `GET https://api.aephia.com/v1/sage/ship-configurations/1` is a small existing read; confirm the current README if the API changes. Report the key UUID, name, expiry and destination, not the secret. If the user explicitly requests manual secret delivery, use their chosen private destination; do not invent a public share link.

Only the hash is stored: an existing secret cannot be retrieved. Listing shows metadata, not secrets or hashes. If creation or delivery fails, inspect records before retrying. Revoke only a newly issued key that is conclusively associated with this failed attempt; never revoke another key merely because its name matches. Leave ambiguous cases for reconciliation rather than issuing repeatedly.

For rotation, create the replacement, update the authorized consumer destination and verify the consumer works before revoking the exact old UUID. If activation or deployment is outside the authorized scope, leave the old key active and report what remains. Revocation is permanent; subsequent requests should return 401, though in-flight reads may finish.

## Boundaries

Internal keys start with `aep_internal_` and are checked only against the gateway's D1 records; invalid internal keys never fall back to security-bot. Other tokens use the existing Discord validation service. Both categories currently have the same read access. Manage internal keys through the operator CLI; do not read security-bot's token store, recreate the database, run remote migrations, or redeploy the gateway as part of ordinary key management.
