#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
##############################################################################
# Protect Files Hook — blocks edits to sensitive/protected files
# Claude Code PreToolUse hook for Edit|Write operations.
# Reads JSON from stdin, checks file_path against blocked patterns.
# Exit 0 = allow, Exit 2 = block
##############################################################################

set -euo pipefail

# Read JSON input from stdin
input=$(cat)

# Extract file path from tool input
file_path=$(echo "${input}" | jq -r '.tool_input.file_path // .tool_input.path // ""' 2>/dev/null || echo "")

if [[ -z "${file_path}" ]]; then
    # No file path found — allow (might be a different tool format)
    exit 0
fi

# Blocked file patterns
blocked_patterns=(
    '\.env$'
    '\.env\.'
    '\.pem$'
    '\.key$'
    '\.p12$'
    '\.pfx$'
    '\.jks$'
    '\.keystore$'
    '\.credentials'
    '\.git/'
    'package-lock\.json$'
    'yarn\.lock$'
    'poetry\.lock$'
    'Pipfile\.lock$'
    'go\.sum$'
    '\.terraform\.lock\.hcl$'
    '__pycache__/'
    'node_modules/'
    '\.pyc$'
)

for pattern in "${blocked_patterns[@]}"; do
    if [[ "${file_path}" =~ ${pattern} ]]; then
        # Output denial reason as JSON
        cat <<EOF
{
  "hookSpecificOutput": {
    "permissionDecision": "deny",
    "permissionDecisionReason": "Protected file pattern: ${pattern} matched ${file_path}"
  }
}
EOF
        exit 2
    fi
done

# File is safe to edit
exit 0
