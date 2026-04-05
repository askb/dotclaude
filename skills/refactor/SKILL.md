<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->

# /refactor — Safe Refactoring

Restructure code while preserving behavior, backed by tests at every step.

## Trigger

`/refactor <target file, function, or pattern>`

## Workflow

### 1. Understand

- Read the target code and its tests
- Identify callers and dependents
- Document current behavior (inputs → outputs)

### 2. Ensure Test Coverage

- Check existing tests cover the behavior being refactored
- If coverage gaps exist, write tests **first** (before any changes)
- Run tests — confirm all pass
- Commit: `test: add coverage for <target> before refactor`

### 3. Plan

- Describe the refactoring goal (extract, rename, simplify, split, merge)
- List the steps as small, independent changes
- Each step should leave tests green

### 4. Execute (Small Steps)

For each step:

- Make one structural change
- Run tests — confirm all pass
- Commit: `refactor: <what changed>`

### 5. Verify

- Run full test suite
- Confirm no behavior changes (same inputs → same outputs)
- Review the diff — is the code clearer?

## Rules

- Never change behavior and structure in the same commit
- If tests break, revert the step and try a smaller change
- Prefer extracting functions/methods over rewriting
- Keep each commit independently revertible
- If the refactoring reveals a bug, fix it in a **separate** commit
