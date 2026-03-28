# Cloudflare-Specific Review Checks

Use this checklist when the codebase uses Cloudflare Workers, D1, KV, Durable Objects, R2, Queues, or Pages.

## Workers
- Verify CPU/memory limits are respected for request paths.
- Ensure heavy/background work uses `ctx.waitUntil()` where appropriate.
- Flag Node.js built-in imports unless compatibility is intentional and configured.
- Check for predictable error handling and response shaping.

## D1
- Require parameterized SQL queries (never string concatenation).
- Check query batching opportunities for multi-step writes.
- Validate row limits/pagination for read endpoints.
- Ensure database errors are handled and surfaced safely.

## KV
- Account for eventual consistency (no strict read-after-write assumptions).
- Check key naming conventions and namespace hygiene.
- Validate metadata usage and size safety.

## Durable Objects
- Check state/transaction patterns for consistency.
- Verify alarm usage and retry/idempotency behavior.
- Review WebSocket handling and cleanup.
- Ensure hibernation-compatible state behavior where required.

## R2
- Use multipart upload for large files.
- Ensure correct `Content-Type` and metadata behavior.
- Validate presigned URL expiry and access scope.

## Pages / General Platform
- Check bundle size and dependency footprint.
- Verify `wrangler.toml` correctness (bindings, environments, vars).
- Ensure environment-specific secrets/config are not hardcoded.

## Architecture alignment
- Favor simple Cloudflare primitives over over-engineering.
- Keep hot paths cheap; move expensive work to async pipelines.
- Prefer explicit boundaries between edge handlers, domain logic, and data adapters.
