---
description: Format Python code with Ruff formatter
allowed-tools: Bash
argument-hint: "[path]"
---
Format Python code using Ruff's fast formatter:

`uvx ruff format ${ARGUMENTS:-.}`

This applies consistent code formatting to:
- Indentation and spacing
- Line length (following project settings)
- Import organization
- String quote normalization

If no path is specified, formats the entire project. Use specific paths to format particular files or directories.