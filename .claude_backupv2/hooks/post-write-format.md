---
name: post-write-format
description: Auto-format Python files after Write tool using ruff
event: PostToolUse
matcher: Write
---

# Post-Write Formatting Hook

Automatically format Python files after Write tool execution using ruff formatter.

## Purpose

This hook ensures consistent code formatting across the project by automatically running `ruff format` on Python files immediately after they are written or modified by Claude Code.

## Trigger Conditions

- **Event**: PostToolUse
- **Tool**: Write
- **File Types**: .py, .pyi files

## Command Execution

```bash
# Check if the written file is a Python file
if [[ "$file_path" =~ \.pyi?$ ]]; then
    echo "Auto-formatting Python file: $file_path"
    uvx ruff format "$file_path"
    echo "✅ Formatted: $file_path"
fi
```

## Configuration

This hook will be automatically triggered when:
- Any .py or .pyi file is written
- The Write tool completes successfully
- The project has ruff configured (via pyproject.toml or ruff.toml)

## Benefits

- **Consistent Style**: Ensures all Python code follows project formatting standards
- **Zero Friction**: Developers don't need to remember to format files
- **Quality Automation**: Part of the deterministic quality pipeline
- **UV Integration**: Uses `uvx ruff` for fast, isolated formatting