---
name: generate-git-commit-message
description: Compose Git commit messages following the Conventional Commits specification.
compatibility: Designed for Claude Code. Requires git.
metadata:
  author: Leyton Addison-Roach
  version: "0.1.0"
allowed-tools: Bash(git diff *) Bash(printf *)
disable-model-invocation: true
effort: medium
---

# Generate Git Commit Messages

## Rules

- Types in the commit title (e.g. `feat`) MUST be lowercase.

## Instructions

1. **Check for staged files:**
    - Run `git diff --cached --quiet`
    - Then run `printf 'exit: %s\n' "$?"`

    Exit code `1` means staged changes exist. Exit code `0` means no staged changes. If staged changes exist, all subsequent diff commands must use `--cached`.

2. **Read the applicable diff:**
    - If staged changes exist, run `git --no-pager diff --cached --histogram --unified=5`
    - Otherwise, run `git --no-pager diff --histogram --unified=5`

3. **Handle no changes** — If the applicable diff is empty, check the other state before concluding:
    - If no staged changes were found and the unstaged diff is empty, inform the user there is nothing to commit.
    - If staged changes exist but the cached diff is empty, report that staged changes could not be read.

4. **Assess whether to split** — If the diff contains unrelated changes, recommend separate commits with a message for each.

5. **Compose the message** — Determine type, infer scope if helpful, write the subject line and add a body if needed.

6. **Present the message** for review.

## Additional resources

- For usage examples, see [examples.md](examples.md).
- For commit types, see [commit-types.md](assets/commit-types.md).
- For information on the Conventional Commits specification, see [conventional-commits-spec.md](references/conventional-commits-spec.md).
