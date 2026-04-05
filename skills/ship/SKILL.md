<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Ship

Ship changes: stage, commit, push, and create PR or Gerrit review.

## When to Use

Run this skill when changes are ready to submit.

## Steps

1. **Stage** — Review and stage changes
   - `git status` — review modified files
   - `git diff` — review unstaged changes
   - `git add <files>` — stage relevant files
   - `git diff --cached` — review staged changes

2. **Pre-commit** — Run quality checks
   - `pre-commit run --all-files`
   - Fix any failures, re-stage, re-run

3. **Commit** — Create a clean commit
   - `git commit -s -m "<type>: <subject>"`
   - Follow commit conventions (feat, fix, docs, etc.)
   - Ensure DCO sign-off

4. **Push** — Submit for review
   - **ODL/Gerrit repos**: `git review -t <topic>`
   - **GitHub repos**: `git push origin <branch>`
   - **New PR**: `gh pr create --title "<type>: <subject>" --body "..."`

5. **Verify** — Confirm submission
   - Check CI status: `gh run list` or Gerrit dashboard
   - Watch for failures: `gh run watch`
