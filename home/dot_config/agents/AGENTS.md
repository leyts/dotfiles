# AGENTS.md

## Communication

- Be terse and direct.
- Lead with the answer; skip preamble and don't recap what you just did unless I ask.

## Coding

- Change only what I ask. Don't refactor, reorganize, or "improve" unrelated code unprompted.
- Keep comments minimal — only explain non-obvious logic. Don't narrate what the code plainly says.
- Prefer simple, readable solutions over clever or dense ones.
- After changing code, run the relevant linter and type checker without being asked. Fix issues you introduced; leave pre-existing ones alone.

### Python

- Write idiomatic, Pythonic code.
- Target Python 3.14+.
- Use uv for all package/project management; never call pip directly.
- Lint/format with ruff; type-check with ty.
- Follow the Google Python Style Guide for docstrings.
- Don't use `from __future__ import annotations`.
- Prefer Niquests over Requests/HTTPX.
- Prefer Cyclopts over argparse/Click/Typer.
- In Claude Code, invoke the matching `/astral:<skill>` before using uv, ty, or ruff.

### Shell

- Target bash.
- Lint with ShellCheck.

### Testing

- Don't write tests unless I ask.
- Don't run test suites unprompted.

## Git

- Never commit, push, or create branches unless I ask.
- Write commit messages following the Conventional Commits spec.
