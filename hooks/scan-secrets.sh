#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
##############################################################################
# Scan Secrets Hook — scans content for hardcoded credentials
# Claude Code PreToolUse hook for Edit|Write operations.
# Reads JSON from stdin, scans content for secret patterns.
# Exit 0 = allow, Exit 2 = block
##############################################################################

set -euo pipefail

# Read JSON input from stdin
input=$(cat)

# Extract content from tool input (handles different field names)
content=$(echo "${input}" | jq -r '
    .tool_input.content //
    .tool_input.new_string //
    .tool_input.insert //
    ""' 2>/dev/null || echo "")

if [[ -z "${content}" ]]; then
    exit 0
fi

# Secret patterns (regex)
declare -A secret_patterns
secret_patterns=(
    ["AWS Access Key"]='AKIA[0-9A-Z]{16}'
    ["AWS Secret Key"]='[0-9a-zA-Z/+]{40}'
    ["GitHub Token"]='gh[ps]_[A-Za-z0-9_]{36,}'
    ["GitHub OAuth"]='gho_[A-Za-z0-9_]{36,}'
    ["GitHub PAT"]='github_pat_[A-Za-z0-9_]{22,}'
    ["OpenAI Key"]='sk-[a-zA-Z0-9]{20,}'
    ["Bearer Token"]='[Bb]earer\s+[A-Za-z0-9\-._~+/]{20,}'
    ["Private Key"]='-----BEGIN[[:space:]]+(RSA|DSA|EC|OPENSSH|PGP)[[:space:]]+PRIVATE[[:space:]]+KEY-----'
    ["Generic Secret"]='(?i)(password|secret|api_key|apikey|token)\s*[:=]\s*["\x27][^\s"'\'']{8,}'
)

for name in "${!secret_patterns[@]}"; do
    pattern="${secret_patterns[${name}]}"
    if echo "${content}" | grep -qP "${pattern}" 2>/dev/null; then
        cat <<EOF
{
  "hookSpecificOutput": {
    "permissionDecision": "deny",
    "permissionDecisionReason": "Potential secret detected: ${name}"
  }
}
EOF
        exit 2
    fi
done

exit 0
