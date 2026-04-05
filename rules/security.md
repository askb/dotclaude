<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
---
paths:

- "scripts/**"
- "**/*.sh"

---

# Security Standards

## Secret Management

- **Never** log secrets or credentials
- Use `::add-mask::$SECRET` in GitHub Actions
- Secret naming: `<SERVICE>_<PURPOSE>_B64` for base64-encoded values
- Auto-detect base64 encoding:

  ```bash
  if echo "$PASSWORD" | base64 -d &>/dev/null; then
      PASSWORD=$(echo "$PASSWORD" | base64 -d)
  fi
  ```

## Credentials

- OAuth ephemeral keys preferred over static credentials
- Set `ephemeral: false` for keys surviving disconnects
- Minimal permissions (principle of least privilege)
- Set job timeouts to prevent runaway processes

## File Protection

- Never edit: `.env`, `*.pem`, `*.key`, lock files
- Never commit: credentials, tokens, private keys
- Detect and block: AWS keys (AKIA...), GitHub tokens (ghp_/gho_)

## Resource Cleanup

```bash
function cleanup() {
    openstack server delete "$SERVER_ID" || true
}
trap cleanup EXIT
```

Always clean up on failure — use `if: always()` in workflows.
