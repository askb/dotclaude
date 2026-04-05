#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
##############################################################################
# Install dotclaude — bootstrap Claude Code configuration
# Supports: --link (default), --copy, --backup
##############################################################################

set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
MODE="link"
BACKUP=false

function usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Install Claude Code configuration files.

Options:
  --link      Symlink files (default) — changes sync automatically
  --copy      Copy files — independent copies
  --backup    Backup existing files before overwriting
  -h, --help  Show this help message

Files installed:
  CLAUDE.md           → ~/CLAUDE.md
  settings.json       → ~/.claude/settings.json
  hooks/*.sh          → ~/.claude/hooks/
  agents/*.md         → ~/.claude/agents/ (if supported)
  CLAUDE.local.md.example → ~/CLAUDE.local.md (copy only, if not exists)
  settings.local.json.example → ~/.claude/settings.local.json (copy only, if not exists)
EOF
}

function backup_file() {
    local target="$1"
    if [[ -e "${target}" && "${BACKUP}" == "true" ]]; then
        local backup
        backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
        echo "  Backing up: ${target} → ${backup}"
        cp -a "${target}" "${backup}"
    fi
}

function install_file() {
    local source="$1"
    local target="$2"

    if [[ ! -f "${source}" ]]; then
        echo "  SKIP: ${source} (not found)"
        return
    fi

    backup_file "${target}"

    # Remove existing target (symlink or file)
    if [[ -e "${target}" || -L "${target}" ]]; then
        rm -f "${target}"
    fi

    # Ensure parent directory exists
    mkdir -p "$(dirname "${target}")"

    if [[ "${MODE}" == "link" ]]; then
        ln -sf "${source}" "${target}"
        echo "  LINK: ${target} → ${source}"
    else
        cp -f "${source}" "${target}"
        echo "  COPY: ${source} → ${target}"
    fi
}

function install_example() {
    local source="$1"
    local target="$2"

    if [[ ! -f "${source}" ]]; then
        echo "  SKIP: ${source} (not found)"
        return
    fi

    if [[ -e "${target}" ]]; then
        echo "  SKIP: ${target} (already exists — not overwriting)"
        return
    fi

    mkdir -p "$(dirname "${target}")"
    cp -f "${source}" "${target}"
    echo "  COPY: ${source} → ${target} (example, one-time)"
}

function main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --link)   MODE="link"; shift ;;
            --copy)   MODE="copy"; shift ;;
            --backup) BACKUP=true; shift ;;
            -h|--help) usage; exit 0 ;;
            *) echo "Unknown option: $1"; usage; exit 1 ;;
        esac
    done

    echo "Installing dotclaude (mode: ${MODE})..."
    echo ""

    # Create .claude directory
    mkdir -p "${CLAUDE_DIR}"
    mkdir -p "${CLAUDE_DIR}/hooks"
    mkdir -p "${CLAUDE_DIR}/agents"

    # Install main files
    echo "Core files:"
    install_file "${SCRIPT_DIR}/CLAUDE.md" "${HOME}/CLAUDE.md"
    install_file "${SCRIPT_DIR}/settings.json" "${CLAUDE_DIR}/settings.json"

    # Install hooks
    echo ""
    echo "Hooks:"
    for hook in "${SCRIPT_DIR}"/hooks/*.sh; do
        if [[ -f "${hook}" ]]; then
            hook_name=$(basename "${hook}")
            install_file "${hook}" "${CLAUDE_DIR}/hooks/${hook_name}"
            chmod +x "${CLAUDE_DIR}/hooks/${hook_name}"
        fi
    done

    # Install agents
    echo ""
    echo "Agents:"
    for agent in "${SCRIPT_DIR}"/agents/*.md; do
        if [[ -f "${agent}" ]]; then
            agent_name=$(basename "${agent}")
            install_file "${agent}" "${CLAUDE_DIR}/agents/${agent_name}"
        fi
    done

    # Install example files (one-time copy, never overwrite)
    echo ""
    echo "Examples (one-time, won't overwrite existing):"
    install_example "${SCRIPT_DIR}/CLAUDE.local.md.example" "${HOME}/CLAUDE.local.md"
    install_example "${SCRIPT_DIR}/settings.local.json.example" "${CLAUDE_DIR}/settings.local.json"

    echo ""
    echo "✅ Installation complete!"
    echo ""
    echo "Next steps:"
    echo "  1. Edit ~/CLAUDE.local.md for machine-specific settings"
    echo "  2. Edit ~/.claude/settings.local.json for additional permissions"
    echo "  3. Start Claude Code in any project directory"
}

main "$@"
