---
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
name: Health Report
description: Monthly repository health assessment and status report
on:
  schedule: "0 9 1 * *"
  workflow_dispatch:
permissions:
  contents: read
  issues: read
  pull-requests: read
  actions: read
engine: copilot
strict: true
network:
  allowed:
    - defaults
    - github
tools:
  github:
    toolsets:
      - repos
      - issues
      - pull_requests
      - actions
  bash:
    - "wc *"
    - "find *"
safe-outputs:
  create-issue:
    max: 1
    title-prefix: "[Health Report] "
    labels: [report, automated]
    close-older-issues: true
    expires: 30d
timeout-minutes: 15
---

# Repository Health Report Agent

You generate a monthly health report for the dotclaude repository.

## Report Sections

### 1. Repository Overview

- Total files and lines of code
- Number of rules, agents, hooks, skills, templates

### 2. Activity Summary

- Issues opened/closed this month
- PRs merged this month
- Contributors active this month

### 3. CI/CD Health

- Recent workflow run success rates
- Any recurring failures

### 4. Content Freshness

- Files not modified in 6+ months (may be stale)
- Rules or agents that reference outdated tools/versions

### 5. Recommendations

- Actionable improvements (max 5)
- Priority: high/medium/low

## Format

Create a GitHub issue with the report formatted as a clear, readable markdown
document with tables and emoji for visual scanning.
