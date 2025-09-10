---
description: Run strict type checking with MyPy
allowed-tools: Bash
argument-hint: "[path]"
---
Run MyPy type checker in strict mode:

`uvx mypy --strict ${ARGUMENTS:-src tests}`

Strict mode enables:
- No implicit optional types
- No untyped function definitions
- No missing return statements
- No implicit Any types
- All optional type checking features

If no path is specified, checks both `src` and `tests` directories. Use specific paths to type-check particular modules.