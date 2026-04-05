<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Templates

Pre-built Claude Code configurations for different project types.

## Usage

Copy the appropriate template directory into your project:

```bash
# For an ODL project
cp -r ~/.claude/templates/odl-project/CLAUDE.md ./CLAUDE.md
cp -r ~/.claude/templates/odl-project/AGENTS.md ./AGENTS.md
mkdir -p .claude
cp ~/.claude/templates/odl-project/claude/settings.local.json .claude/settings.local.json

# For a GitHub Action
cp -r ~/.claude/templates/github-action/CLAUDE.md ./CLAUDE.md
mkdir -p .claude
cp ~/.claude/templates/github-action/claude/settings.local.json .claude/settings.local.json
```

Or use the `setup-project` skill to auto-detect and apply templates.

## Available Templates

| Template | For |
|----------|-----|
| `odl-project/` | OpenDaylight repos (JJB, Maven, Gerrit) |
| `github-action/` | GitHub Actions (composite actions, workflows) |
| `packer-repo/` | Packer image build repos |
| `python-tool/` | Python CLI tools and libraries |

## Customization

Templates provide a starting point. After copying, customize:

- `CLAUDE.md` — Add project-specific instructions
- `.claude/settings.local.json` — Add project-specific permissions
- `AGENTS.md` — Add project-specific agent context
