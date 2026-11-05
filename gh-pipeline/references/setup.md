# Enabling a repository

Read this before enabling the label pipeline on a repository.

1. Confirm the repo has [[project-manager]]-level readiness: integration branch, runnable checks, issue conventions, and enough test and QA setup for feature work.
2. Ask before creating the pipeline labels in bulk.
3. Decide whether the orchestrator may mutate issues automatically or runs in dry-run, report-only mode.
4. Decide the lock timeout, the maximum number of concurrent issues, and the notification channel.
5. Record the repo allow-list and settings in the project handoff or the approved config location.
