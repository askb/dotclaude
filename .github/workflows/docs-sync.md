---
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
name: Docs Sync
description: Weekly verification that README directory tree matches actual repository structure
on:
  schedule: weekly on monday
  workflow_dispatch:
permissions:
  contents: read
  issues: read
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
  bash:
    - "find *"
    - "diff *"
    - "tree *"
safe-outputs:
  create-issue:
    max: 1
    title-prefix: "[Docs Sync] "
    labels: [documentation, automated]
    close-older-issues: true
    expires: 7d
timeout-minutes: 10
---

# Documentation Sync Agent

You verify that the README.md directory tree accurately reflects the actual repository structure.

## Task

1. Read the current README.md and extract the directory tree section
2. Generate the actual directory tree from the repository
3. Compare the two and identify discrepancies:
   - Files/directories in README but not in repo (removed but docs not updated)
   - Files/directories in repo but not in README (added but docs not updated)
   - Incorrect descriptions or outdated counts

## Output

If discrepancies are found, create an issue listing:

- What's out of sync
- Suggested corrections (show the corrected tree)

If everything is in sync, do nothing (no issue created).
