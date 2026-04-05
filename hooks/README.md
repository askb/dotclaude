<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Claude Code Hooks

Hooks are shell scripts that run at specific points during a Claude Code session.
They provide zero-token-cost automation — the scripts run externally and only
their output is consumed.

## Hook Types

### SessionStart

Runs once when a new Claude Code session begins. Use for:

- Injecting git context (branch, last commit, dirty state)
- Checking environment prerequisites
- Loading dynamic configuration

### PreToolUse

Runs before Claude executes a tool (Edit, Write, Bash, etc.). Use for:

- Blocking edits to protected files
- Scanning content for secrets
- Preventing dangerous commands

### PostToolUse

Runs after Claude executes a tool. Use for:

- Auto-formatting saved files
- Running linters on changed files
- Updating indexes

## JSON Protocol

Hooks receive context as JSON on **stdin** and can output JSON on **stdout**.

### Input (stdin)

```json
{
  "tool_name": "Edit",
  "tool_input": {
    "file_path": "/path/to/file",
    "content": "file content..."
  }
}
```

### Output (stdout) — for PreToolUse

```json
{
  "hookSpecificOutput": {
    "permissionDecision": "allow",
    "permissionDecisionReason": "File is safe to edit"
  }
}
```

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Allow / Success |
| 2 | Block / Deny (PreToolUse only) |
| Other | Error (logged, operation continues) |

## Configuration

Hooks are configured in `settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "command": ".claude/hooks/protect-files.sh",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

## File Permissions

All hook scripts must be executable: `chmod +x hooks/*.sh`
