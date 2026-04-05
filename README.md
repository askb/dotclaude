<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->

# dotclaude

Personal [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
configuration for infrastructure engineering across Linux Foundation and
OpenDaylight projects.

## Philosophy

**Token efficiency through layered configuration:**

| Layer | File | Loads When | Token Cost |
|-------|------|-----------|------------|
| Global | `~/CLAUDE.md` | Every session | ~200 lines (fixed) |
| Rules | `rules/*.md` | Path-matched files active | 30-50 lines each |
| Agents | `agents/*.md` | On demand | Zero until invoked |
| Hooks | `hooks/*.sh` | Shell execution | Zero (external scripts) |
| Skills | `skills/*/SKILL.md` | Slash command invoked | Zero until used |
| Per-project | `CLAUDE.md` in project | Project sessions only | Varies |

Global instructions stay lean (~200 lines). Domain-specific knowledge lives in
path-scoped rules that only load when relevant files are active.

## Quick Start

```bash
git clone https://github.com/askb/dotclaude.git ~/git/dotclaude
cd ~/git/dotclaude

# Symlink mode (default) — changes auto-sync
./install.sh

# Or copy mode — independent copies
./install.sh --copy

# With backup of existing files
./install.sh --backup --link
```

## Directory Structure

```
dotclaude/
├── CLAUDE.md                  # Global instructions (~200 lines)
├── CLAUDE.local.md.example    # Machine-specific template (git-ignored)
├── settings.json              # Base permissions and hooks config
├── settings.local.json.example # Personal permissions template
├── rules/                     # Path-scoped context rules
│   ├── core-principles.md     # Always-on core rules
│   ├── bash-standards.md      # *.sh, scripts/**
│   ├── python-standards.md    # *.py
│   ├── github-actions.md      # .github/workflows/**, action.yaml
│   ├── openstack-infra.md     # packer/**, openstack-hot/**
│   ├── jjb-development.md     # jjb/**
│   ├── gerrit-workflow.md     # .github/workflows/**
│   ├── security.md            # scripts/**, *.sh
│   └── documentation.md       # *.md, docs/**
├── agents/                    # Specialist agents (on demand)
│   ├── bash-scripts.md
│   ├── code-quality.md
│   ├── github-actions.md
│   ├── home-assistant.md
│   ├── openstack-infra.md
│   ├── repo-management.md
│   ├── security-reviewer.md
│   └── jjb-specialist.md
├── hooks/                     # Shell scripts (zero token cost)
│   ├── session-start.sh       # Git context injection
│   ├── protect-files.sh       # Block edits to sensitive files
│   ├── scan-secrets.sh        # Detect hardcoded credentials
│   ├── block-dangerous-commands.sh  # Prevent destructive commands
│   └── format-on-save.sh      # Auto-format after edits
├── skills/                    # Slash command workflows
│   ├── setup-project/         # Auto-detect stack, generate config
│   ├── gerrit-submit/         # Pre-commit → commit → git review
│   ├── debug-fix/             # Reproduce → trace → fix → test
│   ├── ship/                  # Stage → commit → push/review
│   └── packer-debug/          # Debug Packer build failures
├── templates/                 # Per-project config templates
│   ├── odl-project/           # OpenDaylight repos
│   ├── github-action/         # GitHub Actions repos
│   ├── packer-repo/           # Packer image repos
│   └── python-tool/           # Python CLI tools
├── install.sh                 # Install/symlink configuration
├── uninstall.sh               # Remove installed files
└── .github/workflows/         # CI/CD
    ├── ci.yaml                # Lint + shellcheck + test
    └── release.yaml           # Tag-based releases
```

## How It Works

### Global vs Per-Project

- **`~/CLAUDE.md`** loads for every Claude Code session in any directory
- **`CLAUDE.md`** in a project root loads only for that project
- Both are active simultaneously — project config supplements global

### Rules with Path Scoping

Rules use YAML frontmatter to control when they load:

```yaml
---
paths:
  - "**/*.sh"
  - "scripts/**"
---
# Bash standards content here...
```

This rule **only loads** when Claude is working on `.sh` files. Rules with
`alwaysApply: true` load every turn (use sparingly).

### Hook System

Hooks are shell scripts triggered at specific points:

| Hook | Trigger | Purpose |
|------|---------|---------|
| `SessionStart` | New session | Inject git context |
| `PreToolUse` | Before Edit/Write/Bash | Guard against mistakes |
| `PostToolUse` | After Edit/Write | Auto-format files |

Hooks use a JSON protocol — they receive context on stdin and return decisions
on stdout. Exit code 0 allows, exit code 2 blocks.

### Skills

Skills are slash-command workflows in `skills/<name>/SKILL.md`. They define
step-by-step procedures for common tasks:

- `/setup-project` — Auto-detect tech stack, generate config
- `/gerrit-submit` — ODL Gerrit submission workflow
- `/debug-fix` — Systematic bug triage
- `/ship` — Stage, commit, push
- `/packer-debug` — Debug Packer build failures

### Templates

Pre-built configurations for different project types:

```bash
# Set up an ODL project
cp templates/odl-project/CLAUDE.md ./CLAUDE.md
mkdir -p .claude
cp templates/odl-project/claude/settings.local.json .claude/settings.local.json
```

Or use the `/setup-project` skill to auto-detect and apply.

## Token Cost Comparison

| Approach | Tokens/Turn |
|----------|------------|
| Monolithic instructions file (500+ lines) | ~2000 |
| **dotclaude** (global + 1-2 active rules) | ~400-600 |
| Per-project only (no global) | ~200-400 |

Path-scoped rules keep per-turn token cost **60-70% lower** than loading
everything every turn.

## Installation Details

### What Gets Installed

| Source | Target | Method |
|--------|--------|--------|
| `CLAUDE.md` | `~/CLAUDE.md` | Link or copy |
| `settings.json` | `~/.claude/settings.json` | Link or copy |
| `hooks/*.sh` | `~/.claude/hooks/` | Link or copy |
| `agents/*.md` | `~/.claude/agents/` | Link or copy |
| `CLAUDE.local.md.example` | `~/CLAUDE.local.md` | Copy (one-time) |
| `settings.local.json.example` | `~/.claude/settings.local.json` | Copy (one-time) |

### Uninstall

```bash
./uninstall.sh
```

Removes installed symlinks/copies. Preserves personal `.local` files.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes with SPDX headers on all files
4. Run `pre-commit run --all-files`
5. Commit with sign-off: `git commit -s`
6. Open a pull request

## License

Apache-2.0 — see [LICENSE](LICENSE) for details.
