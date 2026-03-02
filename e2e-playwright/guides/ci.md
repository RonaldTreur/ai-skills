# Playwright in CI

## When to use
- Running reliable browser tests in GitHub Actions
- Preserving artifacts for failed runs
- Scaling with sharding/parallel jobs

## Avoid when
- CI command differs from local command set
- Browser dependencies are installed ad-hoc per test file

## GitHub Actions baseline

```yaml
- name: Install dependencies
  run: npm ci

- name: Install browsers
  run: npx playwright install --with-deps

- name: Build app
  run: npm run build

- name: Run E2E
  run: npm run test:e2e
```

## CI guidance
- Keep local and CI scripts identical
- Upload trace/screenshot/video artifacts on failure
- Use sharding for large suites

## Anti-patterns
- Running E2E against random preview URLs without setup control
- Skipping artifacts, making failures opaque
- Different retry settings between team members and CI without documentation
