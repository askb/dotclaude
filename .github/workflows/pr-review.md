---
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
name: PR Review
description: Reviews pull requests for compliance with repo standards
on:
  pull_request:
    types: [opened, synchronize]
  workflow_dispatch:
permissions:
  contents: read
  pull-requests: read
engine: copilot
strict: true
network:
  allowed:
    - defaults
    - github
tools:
  github:
    toolsets:
      - pull_requests
      - repos
  bash:
    - "shellcheck *"
safe-outputs:
  add-comment:
    max: 1
    hide-older-comments: true
  messages:
    footer: "> 🔍 *Review by [{workflow_name}]({run_url})*"
timeout-minutes: 10
---

# PR Review Agent

You review pull requests to the dotclaude repository for standards compliance.

## Checks

For each changed file, verify:

<!-- REUSE-IgnoreStart -->

1. **SPDX headers**: Every file must have `SPDX-License-Identifier: Apache-2.0` and `SPDX-FileCopyrightText` headers

<!-- REUSE-IgnoreEnd -->
2. **Shell scripts**: Must have `set -euo pipefail`, proper shebang, and pass shellcheck
3. **Markdown rules**: Must have YAML frontmatter with `paths:` pattern (for rules/ files)
4. **Agent files**: Must have clear role description and actionable guidance
5. **Claude hooks**: Must use JSON protocol (read stdin via jq, exit 0=allow, exit 2=block)
6. **No secrets**: No API keys, tokens, or credentials in any file

## Output

Post a single comment with:

- ✅ for passing checks
- ⚠️ for warnings (style, minor issues)
- ❌ for blocking issues (missing SPDX, secrets found)

Be concise — only mention files with issues, not passing ones.
