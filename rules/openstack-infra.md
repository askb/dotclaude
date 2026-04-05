<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
---
paths:

- "packer/**"
- "openstack-hot/**"
- "cloud-init/**"

---

# OpenStack Infrastructure

## Bastion Pattern

```
GitHub Runner (tag:ci) → Tailscale VPN → Bastion (tag:bastion) → Target VM
```

## Authentication

- OAuth ephemeral keys preferred over static credentials
- Generate both `clouds.yaml` AND `cloud-env.json`
- Auto-detect base64 vs plain-text passwords
- Set `ephemeral: false` for keys that survive disconnects

## Tailscale Tags

- GitHub Runner: `tag:ci`
- Bastion VM: `tag:bastion`
- ACL: `tag:ci` → `tag:bastion:22`

## Resource Management

- Tag all resources with run ID: `github-runner-${{ github.run_id }}`
- Implement timeout-based cleanup
- Use `if: always()` for cleanup steps
- `trap cleanup EXIT` in scripts

## Packer Builds

- Validate first: `packer validate template.pkr.hcl`
- Use `-var-file` for cloud/OS-specific variables
- Debug: `PACKER_LOG=1 packer build ...`
- SSH via bastion proxy for isolated networks
