<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
---
paths:

- "**/*.md"
- "docs/**"

---

# Documentation Standards

## README Structure

1. Project name and brief description
2. Features list
3. Usage with basic and advanced examples
4. Inputs/Outputs tables
5. Troubleshooting section
6. License (SPDX identifier)

## Progress Document Naming

Always prefix with repository name:

- `<repo-name>-PLAN.md` — Architecture and phases
- `<repo-name>-IMPLEMENTATION.md` — Detailed changes
- `<repo-name>-STATUS.md` — Current state and blockers
- `<repo-name>-FINAL_STATUS.md` — Completion summary

All docs go in `~/git/docs-mvp/`, completed in `~/git/docs-mvp/completed/`.

## Commit Messages

```text
<type>: <subject>

<body>

Signed-off-by: Anil Belur <askb23@gmail.com>
```

## Changelog

- Keep CHANGELOG.md updated for releases
- Follow Keep a Changelog format
- Group by: Added, Changed, Deprecated, Removed, Fixed, Security
