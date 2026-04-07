<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->

# Contributing to dotclaude

Thank you for your interest in contributing to **dotclaude** — a Claude Code
configuration dotfiles repository.

## Getting Started

### Fork and Clone

```bash
# Fork via GitHub UI, then:
git clone https://github.com/<your-username>/dotclaude.git
cd dotclaude
```

### Development Setup

```bash
# Install pre-commit hooks
pip install pre-commit
pre-commit install
pre-commit install --hook-type commit-msg
```

This installs hooks for:

- **gitlint** — commit message format
- **trailing-whitespace** / **end-of-file-fixer** — basic hygiene
- **check-yaml** / **check-json** — syntax validation
- **shellcheck** — bash script linting
- **prettier** — YAML/JSON formatting
- **markdownlint** — markdown style
- **reuse** — SPDX license compliance

## Making Changes

### Branch Naming

Use descriptive branch names:

```bash
git checkout -b feat/add-terraform-agent
git checkout -b fix/hook-exit-code
git checkout -b docs/update-readme-tree
```

### SPDX Headers (Required)

Every new file **must** include SPDX license headers:

**Shell scripts / YAML:**

```bash
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
```

**Markdown:**

```markdown
<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
```

Files that cannot contain comments (JSON, etc.) are covered by `.reuse/dep5`.

### Running Pre-commit Hooks

```bash
# Run all hooks on all files
pre-commit run --all-files

# Run a specific hook
pre-commit run shellcheck --all-files
pre-commit run reuse --all-files
```

**Never** use `--no-verify` to bypass hooks.

### Commit Message Format

Use [Conventional Commits](https://www.conventionalcommits.org/) with DCO
sign-off:

```
<type>: <subject>

<optional body>

Signed-off-by: Your Name <your-email@example.com>
```

**Types:** `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `ci`

**Examples:**

```bash
git commit -s -m "feat: add terraform agent definition"
git commit -s -m "fix: correct shellcheck flags in scan-secrets hook"
git commit -s -m "docs: update directory tree in README"
```

The `-s` flag adds the `Signed-off-by` trailer (DCO requirement).

## Pull Request Process

1. Ensure all pre-commit hooks pass: `pre-commit run --all-files`
2. Ensure shellcheck passes on any shell scripts
3. Update `README.md` if you changed the directory structure
4. Push your branch and open a pull request
5. Fill out the PR template checklist
6. Wait for CI checks and review

### PR Checklist

- [ ] SPDX headers on all new files
- [ ] Pre-commit hooks pass (`pre-commit run --all-files`)
- [ ] shellcheck passes on any shell scripts
- [ ] README updated if structure changed
- [ ] Commit signed off (DCO)

## What to Contribute

### Good First Contributions

- Add a new agent definition in `agents/`
- Add a new rule in `rules/`
- Add a new skill in `skills/`
- Improve documentation or fix typos
- Add a new project template in `templates/`

### Guidelines for New Files

- **Rules** (`rules/*.md`): Must have YAML frontmatter with `paths:` patterns
- **Agents** (`agents/*.md`): Must have clear role description and instructions
- **Hooks** (`hooks/*.sh`): Must use `set -euo pipefail`, pass shellcheck,
  and follow the JSON protocol (stdin/stdout, exit 0=allow, exit 2=block)
- **Skills** (`skills/*/SKILL.md`): Must define step-by-step procedures

## Code of Conduct

This project follows the
[Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/).
Please be respectful and constructive in all interactions.

## Questions?

Open an issue with the `question` label if you need help or clarification.

## License

By contributing, you agree that your contributions will be licensed under the
Apache-2.0 license.
