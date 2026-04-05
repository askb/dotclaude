<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Project Instructions — GitHub Action

## Overview

This is a GitHub Actions composite action repository.

## Key Rules

- License: `Apache-2.0` (SPDX headers on all files)
- Pin ALL external actions to SHA with version comment
- Inputs: `kebab-case`, Outputs: `snake_case`
- Every `run:` step needs `shell: bash`
- Support `workflow_dispatch` for testing

## Testing

```bash
# Validate workflows
actionlint .github/workflows/*.yaml

# Run pre-commit
pre-commit run --all-files

# Test locally with act (if configured)
act -j test-job
```

## Structure

- `action.yaml` — Action definition
- `.github/workflows/test-*.yaml` — Test workflows
- `scripts/` — Helper scripts
