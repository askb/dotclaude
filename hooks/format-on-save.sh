#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
##############################################################################
# Format on Save Hook — auto-formats files after edits
# Claude Code PostToolUse hook for Edit|Write operations.
# Detects file type and runs appropriate formatter if available.
##############################################################################

set -euo pipefail

# Read JSON input from stdin
input=$(cat)

# Extract file path from tool input
file_path=$(echo "${input}" | jq -r '.tool_input.file_path // .tool_input.path // ""' 2>/dev/null || echo "")

if [[ -z "${file_path}" || ! -f "${file_path}" ]]; then
    exit 0
fi

# Get file extension
extension="${file_path##*.}"

case "${extension}" in
    sh|bash)
        # Format with shfmt if available
        if command -v shfmt &>/dev/null; then
            shfmt -w -i 4 -ci "${file_path}" 2>/dev/null || true
        fi
        ;;
    py)
        # Format with black if available and configured
        if command -v black &>/dev/null; then
            black --quiet "${file_path}" 2>/dev/null || true
        fi
        # Sort imports with isort if available
        if command -v isort &>/dev/null; then
            isort --quiet "${file_path}" 2>/dev/null || true
        fi
        ;;
    yaml|yml)
        # Format with prettier if available
        if command -v prettier &>/dev/null; then
            prettier --write "${file_path}" 2>/dev/null || true
        fi
        ;;
    json)
        # Format with prettier if available
        if command -v prettier &>/dev/null; then
            prettier --write "${file_path}" 2>/dev/null || true
        fi
        ;;
    md|markdown)
        # Format with prettier if available
        if command -v prettier &>/dev/null; then
            prettier --write --prose-wrap always "${file_path}" 2>/dev/null || true
        fi
        ;;
esac

exit 0
