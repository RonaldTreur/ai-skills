# Impeccable Detector Notes

Command and report shapes for the detector rules in `visual-pass.md`.

## Command

Preferred shape:

```bash
npm run <repo-impeccable-script> -- <target> --json
```

or the repo's documented equivalent.

Ad-hoc fallback, only after explicit user approval for external package
execution or a repo-level allowlist:

```bash
npx impeccable detect <target> --json
```

If neither a pinned command nor approval exists, mark detector coverage as
skipped. Do not install or execute remote npm packages silently during QA.

Use a narrow target:

- the changed HTML/source file
- the changed route's source folder
- a small fixture/demo page
- a preview URL only when URL scanning is supported and safe

Do not run broad repository scans by default. Do not block QA when the command
cannot install or run.

## Useful Report Shape

```markdown
Detector: `npx impeccable detect <target> --json`
Result: <clean | findings | skipped>
High-signal findings:
- <finding id/name>: <file or URL> -> <why it matters or why false positive>
```
