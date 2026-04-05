<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
---
paths:

- "**/*.sh"
- "scripts/**"

---

# Bash Scripting Standards

## Required Header

```bash
#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>

set -euo pipefail
IFS=$'\n\t'
```

## Conventions

- Functions: `lowercase_with_underscores`
- Variables: `SCREAMING_SNAKE_CASE` for constants, `lower_snake` for locals
- Always quote variables: `"${var}"` not `$var`
- Use `[[ ]]` not `[ ]` for conditionals

## Error Handling

- `set -euo pipefail` — mandatory, no exceptions
- `trap cleanup EXIT` for resource cleanup
- Validate all inputs at script start
- Log errors to stderr: `echo "ERROR: msg" >&2`

## Shellcheck

- Must pass with zero warnings
- Use `# shellcheck disable=SC####` only with justification comment
- Pass `-x` flag for sourced files, `-S warning` minimum severity

## Patterns

```bash
function cleanup() {
    # Resource cleanup
}
trap cleanup EXIT

function main() {
    # Validate inputs
    # Main logic
}
main "$@"
```
