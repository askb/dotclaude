#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
##############################################################################
# Session Start Hook — injects dynamic git context at session start
# Runs at the beginning of every Claude Code session.
# Must always exit 0 (never block session start).
##############################################################################

set -euo pipefail

# Session start hooks should never fail
trap 'exit 0' ERR

echo "## Session Context"
echo ""

# Git repository info
if git rev-parse --is-inside-work-tree &>/dev/null; then
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo "unknown")
    echo "- **Branch**: \`${branch}\`"

    last_commit=$(git --no-pager log -1 --oneline 2>/dev/null || echo "no commits")
    echo "- **Last commit**: ${last_commit}"

    stash_count=$(git stash list 2>/dev/null | wc -l)
    if [[ "${stash_count}" -gt 0 ]]; then
        echo "- **Stashes**: ${stash_count}"
    fi

    # Check for dirty working tree
    if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
        dirty_files=$(git status --porcelain 2>/dev/null | wc -l)
        echo "- ⚠️ **Dirty working tree**: ${dirty_files} modified file(s)"
    fi

    # Active PR (if gh CLI available)
    if command -v gh &>/dev/null; then
        pr_info=$(gh pr view --json number,title,state 2>/dev/null | \
            jq -r '"PR #\(.number): \(.title) [\(.state)]"' 2>/dev/null || true)
        if [[ -n "${pr_info}" ]]; then
            echo "- **Active PR**: ${pr_info}"
        fi
    fi

    # Remote info
    remote_url=$(git remote get-url origin 2>/dev/null || echo "no remote")
    echo "- **Remote**: ${remote_url}"
else
    echo "- Not a git repository"
fi

echo ""

exit 0
