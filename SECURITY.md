<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->

# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| main branch | ✅ |

## Reporting a Vulnerability

**Do not open a public issue for security vulnerabilities.**

Instead, please report security issues through
[GitHub Security Advisories](https://github.com/askb/dotclaude/security/advisories/new).

You will receive a response within 48 hours acknowledging the report. A fix
will be developed privately and released as soon as possible.

## What Constitutes a Security Issue

Since this is a configuration dotfiles repository, security issues include:

- **Leaked secrets**: API keys, tokens, passwords, or credentials accidentally
  included in configuration examples or templates
- **Dangerous defaults**: Hook scripts or configurations that could execute
  arbitrary code or compromise a user's system
- **Path traversal**: Install/uninstall scripts that could write outside
  intended directories
- **Privilege escalation**: Scripts that request or require unnecessary
  permissions
- **Insecure hook behavior**: Hooks that fail open when they should fail
  closed (e.g., secret scanning that silently passes on error)

## What Is NOT a Security Issue

- Feature requests or enhancement suggestions
- Bugs that do not have security implications
- Documentation errors
- Formatting or style issues

## Disclosure Policy

- Security issues will be disclosed publicly after a fix is released
- Credit will be given to the reporter (unless they prefer to remain anonymous)
- Critical issues will be patched within 7 days of confirmation

## Contact

For sensitive communications, report via
[GitHub Security Advisories](https://github.com/askb/dotclaude/security/advisories/new).
