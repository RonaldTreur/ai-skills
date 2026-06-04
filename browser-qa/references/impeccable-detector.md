# Impeccable Detector Notes

Use this reference only when browser QA or review needs concrete command
examples for optional visual anti-pattern scanning.

## Command

```bash
npx impeccable detect <target> --json
```

Prefer a project-pinned script or dependency when one exists. Use ad-hoc `npx`
only when external package execution is already acceptable for the task; otherwise
mark detector coverage as skipped.

Use a narrow target:

- the changed HTML/source file
- the changed route's source folder
- a small fixture/demo page
- a preview URL only when URL scanning is supported and safe

Do not run broad repository scans by default. Do not block QA when the command
cannot install or run.

## Interpretation

Treat detector output as evidence, not authority.

- Confirm findings against rendered behavior, code, or the approved design
  artifact before reporting them.
- Product UIs may legitimately use familiar fonts, one font family, restrained
  palettes, and standard patterns.
- Brand surfaces have a higher distinctiveness bar and should treat generic
  slop findings more seriously.
- If the detector reports a false positive, say why and move on.

## Useful Report Shape

```markdown
Detector: `npx impeccable detect <target> --json`
Result: <clean | findings | skipped>
High-signal findings:
- <finding id/name>: <file or URL> -> <why it matters or why false positive>
```
