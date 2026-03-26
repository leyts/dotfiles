---
name: generate-git-commit-message
description: >
  Compose Git commit messages following the Conventional Commits specification. Use this skill whenever the user asks to write, draft, or compose a commit message, when they ask you to commit staged changes, or when they want help describing their code changes for version control.
  Trigger on phrases like "commit message", "write a commit", "commit this", "conventional commit", or any request involving summarising code changes into a commit.
allowed-tools: Bash(git diff *), Bash(printf *)
---

# Conventional Commit Messages

## Format

```text
<type>[(scope)][!]: <description>

[body]
```

## Subject line rules

- Imperative, present tense: *change* not *changed* nor *changes*
- 50 characters max (type, scope, colon, space, and description all count)
- Lowercase, no trailing full stop
- Prefer short verbs: add, drop, fix, hide, move, rename, swap, use
- Wrap code identifiers, flags, and commands in backticks (e.g. ``feat: add `__str__` method to `NotebookCell` class``)

## Commit types

Use the type that reflects the *primary intent*. A refactor that also fixes a bug is `fix`; a feature that includes tests is `feat`.

| Type | Purpose |
| --- | --- |
| `build` | Build system/dependencies |
| `chore` | Maintenance/misc |
| `ci` | CI/config changes |
| `docs` | Documentation only |
| `feat` | New feature |
| `fix` | Bug fix |
| `perf` | Performance improvement |
| `refactor` | Code refactor (no feature/fix) |
| `revert` | Revert commit |
| `style` | Formatting/style (no logic) |
| `test` | Add/update tests |

## Scope

Optional. Infer from the module, domain, or layer being changed. Aim for what helps a reader scanning `git log --oneline` — `refactor(validation)` is useful; `refactor(src/utils/helpers)` is noise. Omit if the change is broad.

## Breaking changes

Append `!` after the type or scope: `feat(api)!: require API key`.

Do **NOT** use `BREAKING CHANGE:` footers.

## Body

Include only when the subject line doesn't convey *why*. Separate with a blank line, wrap at 72 characters. Explain motivation — don't restate the diff.

## Workflow

1. **Check for staged files** — Run `git diff --cached --quiet; printf 'exit: %s\n' "$?"`. Non-zero exit means staged changes exist — all subsequent diffs must use `--cached`.
2. **Read the diff** — `git --no-pager diff --histogram --unified=5` (add `--cached` if staged).
3. **Assess whether to split** — If the diff contains unrelated changes, recommend separate commits with a message for each.
4. **Compose the message** — Determine type, infer scope if helpful, write the subject line, add a body if needed.
5. **No changes?** — If both staged and unstaged diffs are empty, inform the user there is nothing to commit.
6. **Present the message** for review.

## Examples

```text
fix(parser): handle empty input gracefully
```

```text
feat(auth): add OAuth2 login flow

GitHub and Google providers are supported. The refresh
token is stored in an encrypted cookie rather than the
database to keep sensitive data out of storage at rest.
```

```text
feat(api)!: require API key for all endpoints
```

Possible split:

> The staged changes contain two unrelated modifications:
>
> 1. A bug fix in the date parser
> 2. A new CLI flag for verbose output
>
> Commit 1: `fix(parser): correct off-by-one in date range`  
> Commit 2: ``feat(cli): add `--verbose` flag for detailed output``

## Fixed-format scenarios

Some commits must always follow a specific template:

**Version bump:**

```text
chore: bump version to <version>
```

**Revert:** Use the `revert` type with a descriptive subject. Reference the reverted commit SHAs in a `Refs:` footer.

```text
revert: <description of what is being undone>

Refs: <sha>[, <sha>...]
```
