<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
---
paths:

- ".github/workflows/**"

---

# ODL Gerrit CI Workflow

## Pipeline Pattern (3-4 jobs)

1. **prepare** — Clear previous Gerrit votes, `sleep 10s` for replication
2. **build/verify** — Actual CI (maven-verify, tox-verify, pre-commit)
3. **(optional) publish** — Artifacts to Nexus or container registry
4. **vote** — Report conclusion to Gerrit (`if: always()`)

Uses `lfit/gerrit-review-action` for Gerrit integration.

## Reusable Workflows

| Workflow | Purpose |
|----------|---------|
| `compose-repo-linting.yaml` | Pre-commit linting |
| `compose-maven-verify.yaml` | Maven verify build |
| `gerrit-compose-required-tox-verify.yaml` | Tox verify |
| `gerrit-required-info-yaml-verify.yaml` | INFO.yaml validation |
| `gerrit-compose-required-maven-merge.yaml` | Maven merge + deploy |

## Naming Conventions

- `gerrit-verify.yaml` — Patchset verification
- `gerrit-maven-merge.yaml` — Post-merge CI
- `gerrit-packer-*-*.yaml` — Packer image builds
- `openstack-cron-*.yaml` — Scheduled cleanup
