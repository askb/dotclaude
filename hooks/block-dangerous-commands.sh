#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
##############################################################################
# Block Dangerous Commands Hook — prevents destructive shell operations
# Claude Code PreToolUse hook for Bash operations.
# Reads JSON from stdin, checks command against blocked patterns.
# Exit 0 = allow, Exit 2 = block
##############################################################################

set -euo pipefail

# Read JSON input from stdin
input=$(cat)

# Extract command from tool input
command_str=$(echo "${input}" | jq -r '.tool_input.command // ""' 2>/dev/null || echo "")

if [[ -z "${command_str}" ]]; then
    exit 0
fi

# Dangerous command patterns and their descriptions
declare -A blocked_commands
blocked_commands=(
    ["git push origin main"]="Direct push to main branch"
    ["git push origin master"]="Direct push to master branch"
    ["git push --force "]="Force push (use --force-with-lease instead)"
    ["git push -f "]="Force push (use --force-with-lease instead)"
    ["rm -rf /"]="Recursive delete of root filesystem"
    ["rm -rf ~"]="Recursive delete of home directory"
    ["rm -rf ~/"]="Recursive delete of home directory"
    ["DROP TABLE"]="SQL table deletion"
    ["TRUNCATE TABLE"]="SQL table truncation"
    ["drop table"]="SQL table deletion"
    ["truncate table"]="SQL table truncation"
    ["> /dev/sda"]="Writing to raw block device"
    ["mkfs."]="Formatting filesystem"
    ["dd if="]="Raw disk operation"
    [":(){"]="Fork bomb"
)

for pattern in "${!blocked_commands[@]}"; do
    reason="${blocked_commands[${pattern}]}"
    if [[ "${command_str}" == *"${pattern}"* ]]; then
        # Special case: allow --force-with-lease
        if [[ "${pattern}" == "git push --force " || "${pattern}" == "git push -f " ]]; then
            if [[ "${command_str}" == *"--force-with-lease"* ]]; then
                continue
            fi
        fi
        cat <<EOF
{
  "hookSpecificOutput": {
    "permissionDecision": "deny",
    "permissionDecisionReason": "Blocked dangerous command: ${reason}"
  }
}
EOF
        exit 2
    fi
done

exit 0
