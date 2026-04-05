<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Project Instructions — Packer Repository

## Overview

This repository builds VM images using Packer for OpenStack.

## Key Rules

- License: `Apache-2.0` (SPDX headers on all files)
- Validate before build: `packer validate template.pkr.hcl`
- Use bastion pattern for isolated networks
- Tag all resources with run identifiers
- Always clean up on failure

## Build

```bash
# Validate
packer validate -var-file=vars/cloud.pkrvars.hcl template.pkr.hcl

# Build
packer build -var-file=vars/cloud.pkrvars.hcl template.pkr.hcl

# Debug
PACKER_LOG=1 packer build template.pkr.hcl
```

## Structure

- `templates/` or `*.pkr.hcl` — Packer templates
- `vars/` — Variable files per cloud/OS
- `provision/` or `scripts/` — Provisioning scripts
