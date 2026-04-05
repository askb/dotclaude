#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
##############################################################################
# warn-large-files.sh — Block writes to build artifacts and binaries
# Claude Code PreToolUse hook (reads JSON from stdin)
##############################################################################

set -euo pipefail

# Patterns for files that should not be edited
BLOCKED_PATTERNS=(
    '\.tar\.gz$'
    '\.tar\.bz2$'
    '\.zip$'
    '\.jar$'
    '\.war$'
    '\.ear$'
    '\.class$'
    '\.pyc$'
    '\.pyo$'
    '\.so$'
    '\.dylib$'
    '\.dll$'
    '\.exe$'
    '\.bin$'
    '\.o$'
    '\.a$'
    '\.whl$'
    '\.iso$'
    '\.img$'
    '\.qcow2$'
    '\.vmdk$'
    'node_modules/'
    '__pycache__/'
    '\.terraform/'
    'dist/'
    'build/output'
)

# Size threshold in bytes (500KB)
SIZE_THRESHOLD=512000

# Read tool input from stdin (Claude Code JSON protocol)
INPUT=$(cat)

# Extract file path from JSON
FILE_PATH=""
if command -v jq &>/dev/null; then
    FILE_PATH=$(echo "$INPUT" | jq -r '.toolInput.file_path // .toolInput.path // empty' 2>/dev/null || true)
fi

if [[ -z "$FILE_PATH" ]]; then
    exit 0
fi

# Check against blocked patterns
for pattern in "${BLOCKED_PATTERNS[@]}"; do
    if [[ "$FILE_PATH" =~ $pattern ]]; then
        if command -v jq &>/dev/null; then
            jq -n --arg reason "File '$FILE_PATH' matches binary/artifact pattern. These files should not be edited directly." \
                '{"hookSpecificOutput": {"permissionDecision": "deny", "permissionDecisionReason": $reason}}'
        else
            echo "BLOCKED: '$FILE_PATH' matches binary/artifact pattern" >&2
        fi
        exit 2
    fi
done

# Check file size if it exists
if [[ -f "$FILE_PATH" ]]; then
    FILE_SIZE=$(stat -c%s "$FILE_PATH" 2>/dev/null || stat -f%z "$FILE_PATH" 2>/dev/null || echo 0)
    if [[ "$FILE_SIZE" -gt "$SIZE_THRESHOLD" ]]; then
        SIZE_KB=$((FILE_SIZE / 1024))
        if command -v jq &>/dev/null; then
            jq -n --arg reason "File '$FILE_PATH' is ${SIZE_KB}KB (limit: $((SIZE_THRESHOLD / 1024))KB). Large files may be build artifacts." \
                '{"hookSpecificOutput": {"permissionDecision": "deny", "permissionDecisionReason": $reason}}'
        else
            echo "WARNING: '$FILE_PATH' is ${SIZE_KB}KB" >&2
        fi
        exit 2
    fi
fi

exit 0
