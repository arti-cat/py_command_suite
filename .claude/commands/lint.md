---
description: Run Ruff linting with automatic safe fixes
allowed-tools: Bash
argument-hint: "[path]"
---
Run Ruff linter with automatic fixing of safe issues:

`uvx ruff check --fix ${ARGUMENTS:-.}`

This will:
- Check all Python files for style and code quality issues
- Automatically fix safe issues (imports, formatting, etc.)
- Report remaining issues that require manual attention

If no path is specified, lints the entire project. Use specific paths to focus on particular files or directories.