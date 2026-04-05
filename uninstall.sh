#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
##############################################################################
# Uninstall dotclaude — remove installed Claude Code configuration
##############################################################################

set -euo pipefail
IFS=$'\n\t'

CLAUDE_DIR="${HOME}/.claude"

function remove_file() {
    local target="$1"
    if [[ -e "${target}" || -L "${target}" ]]; then
        rm -f "${target}"
        echo "  REMOVED: ${target}"
    else
        echo "  SKIP: ${target} (not found)"
    fi
}

function main() {
    echo "Uninstalling dotclaude..."
    echo ""

    # Remove core files
    echo "Core files:"
    remove_file "${HOME}/CLAUDE.md"
    remove_file "${CLAUDE_DIR}/settings.json"

    # Remove hooks
    echo ""
    echo "Hooks:"
    for hook in session-start.sh protect-files.sh scan-secrets.sh \
                block-dangerous-commands.sh format-on-save.sh; do
        remove_file "${CLAUDE_DIR}/hooks/${hook}"
    done

    # Remove agents
    echo ""
    echo "Agents:"
    for agent in bash-scripts.md code-quality.md github-actions.md \
                 home-assistant.md openstack-infra.md repo-management.md \
                 security-reviewer.md jjb-specialist.md; do
        remove_file "${CLAUDE_DIR}/agents/${agent}"
    done

    # Clean up empty directories
    echo ""
    echo "Cleanup:"
    for dir in "${CLAUDE_DIR}/hooks" "${CLAUDE_DIR}/agents"; do
        if [[ -d "${dir}" ]] && [[ -z "$(ls -A "${dir}" 2>/dev/null)" ]]; then
            rmdir "${dir}"
            echo "  REMOVED empty dir: ${dir}"
        fi
    done

    echo ""
    echo "✅ Uninstall complete!"
    echo ""
    echo "Note: ~/CLAUDE.local.md and ~/.claude/settings.local.json were NOT removed."
    echo "Delete them manually if no longer needed."
}

main "$@"
