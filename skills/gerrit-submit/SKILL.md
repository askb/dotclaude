<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Gerrit Submit

Submit changes to OpenDaylight Gerrit code review.

## When to Use

Run this skill when ready to submit changes to an ODL repository
that uses Gerrit for code review.

## Steps

1. **Run pre-commit** — `pre-commit run --all-files`
   - If hooks fail, fix issues and re-run
   - Never use `--no-verify`
2. **Check diff** — `git diff --cached` to review staged changes
3. **Commit** — `git commit -s -m "<type>: <subject>"`
   - Ensure `Signed-off-by` line is present (DCO)
   - Follow commit message format
4. **Submit** — `git review` (not `git push`)
   - Optionally add topic: `git review -t <topic>`
5. **Verify** — Check Gerrit for the new patchset

## Pre-flight Checks

- [ ] All pre-commit hooks pass
- [ ] Commit message follows `<type>: <subject>` format
- [ ] `Signed-off-by` line present
- [ ] SPDX headers on all new/modified files
- [ ] No secrets or credentials in diff
