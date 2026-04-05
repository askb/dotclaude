<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Setup Project

Auto-detect tech stack and generate per-project Claude Code configuration.

## When to Use

Run this skill when starting work on a new repository to create proper
Claude Code configuration files.

## Steps

1. **Detect tech stack** — scan for package.json, pom.xml, setup.py,
   pyproject.toml, go.mod, Makefile, action.yaml, packer templates, JJB files
2. **Identify project type** — ODL project, GitHub Action, Packer repo,
   Python tool, or generic
3. **Generate CLAUDE.md** — project-specific instructions based on detected stack
4. **Generate .claude/settings.local.json** — permissions appropriate for the project
5. **Generate AGENTS.md** — if the project benefits from agent context
6. **Copy relevant templates** — from `~/.claude/templates/<type>/`

## Detection Rules

| Indicator | Project Type |
|-----------|-------------|
| `jjb/` + `INFO.yaml` | ODL project |
| `action.yaml` + `.github/workflows/` | GitHub Action |
| `*.pkr.hcl` + `packer/` | Packer repo |
| `setup.py` or `pyproject.toml` | Python tool |
| `pom.xml` | Java/Maven project |

## Output

- `CLAUDE.md` — project instructions
- `.claude/settings.local.json` — project permissions
- `AGENTS.md` — agent context (if applicable)
