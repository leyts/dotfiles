# claude

## General

- Use British English (en-GB).
- Always ask clarifying questions when there are multiple valid approaches to a task.
- Always use Context7 MCP when I need library/API documentation, code generation, setup or configuration steps without me having to explicitly ask.

## Git

- Generate Git commit messages following the Conventional Commits specification.

## Python

### Coding Conventions

- Use uv to manage packages.
- Invoke the relevant `/astral:<skill>` for `uv`, `ty`, and `ruff` to ensure best practices are followed.
- Functions must have descriptive names and include type hints.
- Prefer `pathlib` over `os`, `os.path` and other low-level file APIs.
