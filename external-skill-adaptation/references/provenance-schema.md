# Provenance Schema

Use this schema for each material external influence.

## Entry Fields

- `id`: stable slug, such as `2026-05-22-debugging-matt-diagnose-feedback-loop`
- `date`: review or adoption date
- `discipline`: normalized discipline name
- `status`: `adopted`, `adapted`, `inspired`, `rejected`, `deferred`, or `superseded`
- `source`: source project or author
- `source_url`: repository, document, or file URL
- `source_ref`: commit SHA, tag, release, or retrieval date
- `source_path`: file path or section title
- `license`: source license when known
- `local_target`: local file or skill affected
- `influence_type`: `copied`, `paraphrased`, `structural`, `behavioral`, `negative-example`, or `comparison-only`
- `summary`: concise description of the idea
- `local_adaptation`: how the idea changed before landing
- `rationale`: why this was adopted, rejected, or deferred
- `credit_note`: how to credit the influence publicly
- `reviewer`: person or agent who performed the review
- `next_review`: optional date or condition for revisiting

## Policy

Use `copied` only when text is intentionally copied and license-compatible. Most entries should be `paraphrased`, `structural`, or `behavioral`.

Do not hide weak influence. If an external source materially shaped the local design, record it even if no text was copied.

Do not over-credit generic industry practice. Credit a source when it changed a decision, wording, structure, or priority.
