<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Claude Code Rules

Rules are markdown files with YAML frontmatter that provide context-specific
instructions to Claude Code.

## Path Scoping

Rules use `paths:` frontmatter to load only when working on matching files:

```yaml
---
paths:
  - "**/*.sh"
  - "scripts/**"
---
```

This rule only loads when Claude is editing or viewing `.sh` files or files
under `scripts/`.

## Always-On Rules

Rules with `alwaysApply: true` load on every turn regardless of file context:

```yaml
---
alwaysApply: true
---
```

Use sparingly — each always-on rule consumes tokens every turn.

## Best Practices

- Keep rules concise (30-50 lines)
- Use path scoping to minimize token usage
- Only use `alwaysApply` for critical principles
- One concern per rule file
- Use frontmatter globs (`**/*.py`) not directory names
