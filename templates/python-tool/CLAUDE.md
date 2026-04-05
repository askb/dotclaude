<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Project Instructions — Python Tool

## Overview

This is a Python CLI tool or library.

## Key Rules

- License: `Apache-2.0` (SPDX headers on all files)
- Python 3.8+ minimum (prefer 3.11+)
- Type hints on all functions
- Google-style docstrings
- Format: black (line-length 120), isort, flake8

## Development

```bash
# Install in dev mode
pip install -e ".[dev]"

# Run tests
pytest -v

# Format
black .
isort .

# Lint
flake8
mypy .

# Pre-commit
pre-commit run --all-files
```

## Structure

- `src/` or package directory — Source code
- `tests/` — Test suite
- `pyproject.toml` — Project metadata and tool config
