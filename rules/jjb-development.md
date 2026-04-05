<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- SPDX-FileCopyrightText: 2025 Anil Belur <askb23@gmail.com> -->
---
paths:

- "jjb/**"

---

# Jenkins Job Builder (JJB) Development

## Structure

- Project config: `jjb/<project>/<project>.yaml`
- Shared templates: `jjb/releng-templates-java.yaml`
- Global defaults: `jjb/defaults.yaml`
- Shared JJB: `global-jjb/` (git submodule)

## Key Rules

- **Never delete jobs** — use `disable-job: true` for deprecation
- Validate changes: `jenkins-jobs test -r jjb/ -o jjb-output/ <job-name>`
- Follow existing patterns in the project's YAML file

## Key Parameters

- `build-node`: Jenkins agent label (e.g., `ubuntu2204-docker-4c-4g`)
- `mvn-settings`: Maven settings credential name
- `build-timeout`: Timeout in minutes
- `java-version`: JDK version (e.g., `openjdk21`)
- `mvn-version`: Maven version (e.g., `mvn39`)
- `disable-job`: Set `true` to disable

## Job Groups

- `{project-name}-github-{stream}`: Standard verify + merge
- Use existing job groups from `releng-templates-java.yaml`
- Override parameters at project level when needed
