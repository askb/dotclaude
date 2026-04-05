<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->

# /explain — Code Explanation

Provide clear, layered explanations of code, architecture, or system behavior.

## Trigger

`/explain <file, function, or concept>`

## Workflow

### 1. One-Liner

Start with a single sentence summary of what it does.

### 2. Mental Model

Explain the key abstraction or pattern in 2-3 sentences. What problem does
this solve? What would break without it?

### 3. Walkthrough

Step through the logic:

- Entry point and control flow
- Key data transformations
- Side effects (I/O, state changes, API calls)
- Error handling paths

### 4. Connections

- What calls this? What does it call?
- Related files or modules
- Configuration that affects behavior

### 5. Why It Matters

- Why was this approach chosen?
- Known trade-offs or tech debt
- Gotchas for someone modifying this code

## Rules

- Use ASCII diagrams for data flow when helpful
- Reference actual line numbers and file paths
- Don't explain obvious things (variable declarations, imports)
- Focus on the "why" more than the "what"
- Flag any code smells or risks discovered during explanation
