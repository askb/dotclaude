<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
# Project Instructions — OpenDaylight

## Overview

This is an OpenDaylight project. Code review is via **Gerrit** (not GitHub PRs).

## Key Rules

- License: `EPL-1.0` (SPDX headers on all files)
- Submit via `git review`, never `git push`
- All commits require `Signed-off-by` (DCO)
- JJB config in `jjb/<project>/<project>.yaml`
- Never delete JJB jobs — use `disable-job: true`

## Build

```bash
# Maven build
mvn clean install -Pq

# JJB validation
jenkins-jobs test -r jjb/ -o jjb-output/ <job-name>

# Pre-commit
pre-commit run --all-files
```

## CI Pipeline

1. prepare → 2. verify (maven/tox/pre-commit) → 3. vote (Gerrit)
