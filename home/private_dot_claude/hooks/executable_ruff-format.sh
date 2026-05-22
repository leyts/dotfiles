#!/bin/bash
# Post-tool hook: run ruff format on Python (.py) files.

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path')

if [[ "$file_path" != *.py ]]; then
    exit 0
fi

uv run --frozen ruff format --no-cache --quiet -- "$file_path"
