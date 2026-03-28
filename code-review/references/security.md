# Security & Reliability Checklist

Use this checklist for TypeScript/web projects, including Cloudflare-based systems.

## XSS
- Search for `innerHTML`, `outerHTML`, `insertAdjacentHTML`, unsafe template interpolation.
- Verify user-controlled input is sanitized/escaped before DOM insertion.
- Check URL/query params rendered into templates without validation.
- Confirm CSP strategy exists for high-risk surfaces.

## Injection
- Flag SQL built via string concatenation (especially D1 queries).
- Require parameterized queries and validated inputs.
- Flag command construction passed to shell/exec APIs with user input.
- Validate allowlists for command options and file paths.

## AuthN / AuthZ
- Ensure all protected routes/actions enforce authentication.
- Ensure authorization checks are resource-scoped (ownership/role/tenant).
- Check for token leakage in client bundles, logs, or query strings.
- Validate JWT/session verification logic and expiry handling.

## Secrets Handling
- Flag hardcoded API keys/tokens/secrets.
- Flag committed `.env` files containing real credentials.
- Check config layering to keep secrets server-side only.

## CSRF
- For state-changing requests, verify CSRF mitigation:
  - CSRF token validation, or
  - SameSite cookie strategy + explicit origin checks.
- Flag unsafe GET endpoints that mutate state.

## Security Headers
- Check presence/adequacy of:
  - `Content-Security-Policy`
  - `X-Frame-Options` (or CSP frame-ancestors)
  - `Strict-Transport-Security`
  - `X-Content-Type-Options`
  - `Referrer-Policy`

## Dependency Risk
- Flag known vulnerable dependencies.
- Flag unnecessary dependencies increasing attack surface.
- Prefer standard platform APIs where feasible.

## Race Conditions / Reliability
- Look for concurrent writes without coordination.
- Identify TOCTOU bugs around reads/checks then writes.
- Validate idempotency and retry safety in async workflows.

## Reporting format for each security finding
- **Severity (P0/P1/P2/P3)**
- **Exploitability**: realistic attack preconditions
- **Impact**: data exposure, integrity, availability, privilege escalation
- **Suggested fix**: minimal safe mitigation path
