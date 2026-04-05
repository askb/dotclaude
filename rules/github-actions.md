<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
---
paths:

- ".github/workflows/**"
- "action.yaml"
- "action.yml"

---

# GitHub Actions Standards

## Action Pinning (NON-NEGOTIABLE)

```yaml
# ✅ Always pin to SHA with version comment
- uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683  # v4.2.2

# ❌ Never use floating tags
- uses: actions/checkout@v4
```

## Naming Conventions

- Inputs: `kebab-case` (e.g., `packer-template`)
- Outputs: `snake_case` (e.g., `image_id`)
- Environment variables: `SCREAMING_SNAKE_CASE`
- Secrets: `SCREAMING_SNAKE_CASE_B64` for base64-encoded

## Composite Actions

- Preferred over JavaScript/Docker actions
- Clear input/output contracts
- Every step needs `shell: bash`
- Use `$GITHUB_OUTPUT` for outputs, `$GITHUB_STEP_SUMMARY` for visibility

## Testing

- Add `workflow_dispatch` trigger for manual debugging
- Test categories: success, error, edge cases
- Set `timeout-minutes` on all jobs
- Use `ubuntu-24.04` (latest LTS)

## Patterns

- Generate `$GITHUB_STEP_SUMMARY` for user-facing output
- Use `if: always()` for cleanup steps
- Separate concerns into small composable actions
