#!/bin/bash
# Post-tool hook: run ruff formatter on .py files.

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_response.filePath // .tool_input.file_path')

if [[ "$file_path" == *.py ]]; then
    uv run ruff format -- "$file_path"
fi
