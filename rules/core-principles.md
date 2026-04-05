<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
---

alwaysApply: true
---

# Core Principles

## Development Approach

- MVP first — start with simplest working solution, iterate after
- Break large tasks into phases with clear tracking
- Create `<repo-name>-PLAN.md` in `~/git/docs-mvp/` for complex work

## Commit Standards

- Format: `<type>: <subject>` (feat, fix, docs, test, refactor, chore, ci)
- Always sign off: `git commit -s` (DCO compliance)
- ODL repos: submit via `git review`, not `git push`

## Non-Negotiable Rules

1. Pin GitHub Actions to SHA commits with version comment
2. Never use `--no-verify` to bypass pre-commit hooks
3. SPDX license headers on every file (EPL-1.0 for ODL, Apache-2.0 for LF)
4. Run `pre-commit run --all-files` before every commit
5. Never log secrets — use `::add-mask::` in Actions
6. Always clean up resources on failure

## Code Quality

- shellcheck: zero warnings on all bash scripts
- actionlint: validate all GitHub Actions workflows
- yamllint: lint all YAML files
- prettier: format YAML, JSON, Markdown
- black/isort/flake8: Python formatting and linting
