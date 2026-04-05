<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Global Claude Code Instructions — Anil Belur

## Identity

- **Name**: Anil Belur (askb / <askb23@gmail.com>)
- **Role**: Infrastructure Engineer — Linux Foundation / OpenDaylight
- **Stack**: GitHub Actions, Packer, OpenStack, Ansible, JJB, Tailscale

## Working Style

- **Concise & direct** — actionable responses, minimal fluff
- **MVP approach** — minimum viable first, iterate after
- **Iterative development** — break large tasks into phases
- Progress docs go in `~/git/docs-mvp/` using naming: `<repo-name>-PLAN.md`,
  `<repo-name>-STATUS.md`, `<repo-name>-IMPLEMENTATION.md`,
  `<repo-name>-FINAL_STATUS.md`
- Completed work summaries: `~/git/docs-mvp/completed/`

## TODO Tracking

- **Master TODO**: `~/git/docs-mvp/TODO-MASTER-TRACKER.md`
- **Work log**: `~/git/docs-mvp/completed/WORK-LOG.md`
- Review at every session start; update immediately when tasks complete
- Priority: 🔴 P0 (now) · 🟡 P1 (soon) · 🟢 P2 (backlog)

## Commit Format

```text
<type>: <subject>

<body>

Signed-off-by: Anil Belur <askb23@gmail.com>
```

Types: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `ci`

## Gerrit-First Development (ODL repos)

- Submit via `git review` — NOT `git push`
- GitHub is read-only mirror — no pull requests
- All commits require `Signed-off-by` (DCO): `git commit -s`
- Group related changes with topic: `git review -t <topic>`

## NON-NEGOTIABLE Rules

1. **Pin Actions to SHA** — never use floating tags

   ```yaml
   # ✅ Good
   - uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683  # v4.2.2
   # ❌ Bad
   - uses: actions/checkout@v4
   ```

2. **Never `--no-verify`** — always run pre-commit hooks
3. **SPDX headers** on every file:
   - ODL repos: `EPL-1.0`
   - LF infra repos: `Apache-2.0`
4. **`set -euo pipefail`** in every bash script
5. **Type hints** on all Python functions
6. **Never log secrets** — use `::add-mask::` in Actions

## Code Quality Tools

- **pre-commit**: Required on all repos (`pre-commit run --all-files`)
- **shellcheck**: Bash linting (zero warnings)
- **actionlint**: GitHub Actions validation
- **yamllint**: YAML linting
- **prettier**: YAML/JSON/Markdown formatting
- **black/isort/flake8**: Python formatting and linting
- **markdownlint**: Markdown style

## Security

- Never log secrets or credentials
- Base64 auto-detect for secrets with special characters
- Use `::add-mask::$SECRET` in GitHub Actions
- OAuth ephemeral keys preferred for OpenStack
- Minimal permissions (least privilege)
- Always cleanup resources on failure (`trap cleanup EXIT`)

## Error Handling

### Bash

```bash
set -euo pipefail
IFS=$'\n\t'
trap cleanup EXIT
```

### Python

```python
from typing import Optional
def func(param: str, opt: Optional[int] = None) -> bool:
    """Google-style docstring."""
```

## Key Repositories

| Repo | Purpose |
|------|---------|
| `releng-builder` | JJB configs, Packer templates |
| `global-jjb` | Shared Jenkins job templates |
| `lfreleng-actions` | Reusable GitHub Actions (40+) |
| `packer-build-action` | OpenStack image builds |
| `tailscale-openstack-bastion-action` | Bastion proxy |
| `lftools` | CLI tools for LF infra |

## OpenStack & Bastion Pattern

```text
GitHub Runner (tag:ci) → Tailscale VPN → Bastion (tag:bastion) → Target VM
```

- Dual config: `clouds.yaml` + `cloud-env.json`
- Timeout-based resource cleanup
- Tag and name all resources with run ID

## GitHub Actions Patterns

- Inputs: `kebab-case`; Outputs: `snake_case`; Env: `SCREAMING_SNAKE_CASE`
- Composite actions preferred
- Always add `workflow_dispatch` for debugging
- Generate `$GITHUB_STEP_SUMMARY` for visibility

## JJB Key Points

- Config per project: `jjb/<project>/<project>.yaml`
- Never delete jobs — use `disable-job: true`
- Validate: `jenkins-jobs test -r jjb/ -o output/ <job-name>`

## ODL Gerrit CI Pipeline

1. **prepare** — Clear votes, allow replication
2. **build/verify** — Maven, tox, pre-commit
3. **vote** — Report back (`if: always()`)

## Quick Commands

```bash
# Pre-commit
pre-commit run --all-files

# JJB validation
jenkins-jobs test -r jjb/ -o jjb-output/ <job-name>

# Packer
packer validate template.pkr.hcl

# Gerrit
git review -t <topic>
```
