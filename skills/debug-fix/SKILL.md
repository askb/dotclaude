<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Debug & Fix

Systematic bug triage: reproduce, trace, fix, test, commit.

## When to Use

Run this skill when investigating and fixing a bug or failure.

## Steps

1. **Reproduce** — Confirm the issue exists
   - Run the failing test/command
   - Capture error output and stack trace
   - Note environment details

2. **Trace** — Find the root cause
   - Read error messages carefully
   - Check recent changes: `git log --oneline -10`
   - Search for related code: grep for error strings
   - Check logs, CI output, resource state

3. **Fix** — Apply the minimal correct fix
   - Make the smallest change that fixes the issue
   - Don't fix unrelated problems in the same commit
   - Add comments if the fix isn't obvious

4. **Test** — Verify the fix works
   - Run the previously failing test/command
   - Run related tests to check for regressions
   - Run `pre-commit run --all-files`

5. **Commit** — Record the fix
   - `git commit -s -m "fix: <description of what was fixed>"`
   - Reference issue/bug numbers if applicable
