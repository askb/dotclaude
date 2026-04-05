<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->

# /tdd — Test-Driven Development

Strict Red-Green-Refactor loop for implementing features with full test coverage.

## Trigger

`/tdd <feature description>`

## Workflow

### 1. Red — Write Failing Test

- Understand the feature requirement
- Write the **minimum** test that describes expected behavior
- Run tests — confirm the new test **fails**
- Commit: `test: add failing test for <feature>`

### 2. Green — Make It Pass

- Write the **minimum** code to make the test pass
- No extra logic, no premature optimization
- Run tests — confirm **all** tests pass
- Commit: `feat: implement <feature>`

### 3. Refactor — Clean Up

- Improve code structure without changing behavior
- Remove duplication, improve naming
- Run tests — confirm all still pass
- Commit: `refactor: clean up <feature>`

### 4. Repeat

- If the feature needs more behavior, go back to step 1
- Each cycle should be small (5-15 minutes)

## Rules

- Never write production code without a failing test first
- Never refactor while tests are red
- Keep cycles small — one behavior per cycle
- Run the full test suite after each step
- Use the project's existing test framework and patterns
