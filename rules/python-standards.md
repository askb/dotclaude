<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
---
paths:

- "**/*.py"

---

# Python Standards

## Version & Style

- Python 3.8+ minimum (prefer 3.11+)
- Type hints on all function parameters and returns
- Google-style or NumPy-style docstrings
- Line length: 120 (black default override)

## Required Tools

- **black**: Code formatting
- **isort**: Import sorting
- **flake8**: Linting
- **mypy**: Type checking (when configured)

## Template

```python
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com>
"""Module docstring."""

from typing import List, Optional


def function_name(param: str, optional: Optional[int] = None) -> bool:
    """Function description.

    Args:
        param: Parameter description
        optional: Optional parameter

    Returns:
        Description of return value

    Raises:
        ValueError: When validation fails
    """
    return True
```

## Imports

- Standard library → third-party → local (isort handles this)
- Absolute imports preferred over relative
