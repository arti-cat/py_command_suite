---
description: Code quality enforcement with Ruff linting and formatting
allowed-tools: Bash
---

# Python Code Linting and Formatting

Enforce code quality standards using Ruff - the fast Python linter and formatter.

## Task

I'll run comprehensive code quality checks and apply automatic fixes using Ruff through UV for consistent, high-quality Python code.

## Process

I'll execute linting and formatting in optimal order:

### 1. Linting with Auto-fix
```bash
# Run linter with automatic fixes
uvx ruff check --fix .
```

### 2. Code Formatting  
```bash
# Apply consistent code formatting
uvx ruff format .
```

### 3. Final Validation
```bash
# Verify no remaining issues
uvx ruff check .
```

## Ruff Commands Explained

### Core Linting
- **`uvx ruff check`**: Run all configured linters
- **`uvx ruff check --fix`**: Apply safe automatic fixes
- **`uvx ruff check --diff`**: Preview changes without applying

### Code Formatting
- **`uvx ruff format`**: Format code consistently
- **`uvx ruff format --diff`**: Preview formatting changes
- **`uvx ruff format --check`**: Check if formatting is needed

### Advanced Options
- **`--select E,W,F`**: Select specific rule categories
- **`--ignore E501`**: Ignore specific rules
- **`--target-version py311`**: Target specific Python version

## Rule Categories

### Error Prevention (E)
- Syntax errors
- Indentation issues
- Import problems

### Warning Detection (W)  
- Code style violations
- Potential bugs
- Performance issues

### Flake8 Integration (F)
- Undefined names
- Unused imports
- Dead code detection

### Import Sorting (I)
- Import organization
- Dependency grouping
- Alphabetical ordering

## Configuration Integration

### pyproject.toml Configuration
```toml
[tool.ruff]
target-version = "py311"
line-length = 88
select = [
    "E",   # pycodestyle errors
    "W",   # pycodestyle warnings  
    "F",   # Pyflakes
    "I",   # isort
    "N",   # pep8-naming
    "UP",  # pyupgrade
]
ignore = [
    "E501",  # Line too long (handled by formatter)
    "W503",  # Line break before binary operator
]

[tool.ruff.format]
quote-style = "double"
indent-style = "space"
skip-magic-trailing-comma = false
```

## Framework-Specific Rules

### Django Projects
```bash
uvx ruff check --select DJ .  # Django-specific rules
```

### FastAPI Projects  
```bash
uvx ruff check --select ASYNC .  # Async/await patterns
```

### Data Science
```bash
uvx ruff check --select PD .  # Pandas best practices
```

## Issue Resolution

### Common Linting Issues

#### Import Organization
```python
# Before (flagged by ruff)
import os
import requests
import sys

# After (auto-fixed)
import os
import sys

import requests
```

#### Code Style Fixes
```python
# Before (flagged by ruff)
def bad_function( x,y ):
    return x+y

# After (auto-formatted)  
def bad_function(x, y):
    return x + y
```

#### Unused Variables
```python
# Before (flagged by ruff)
def process_data(data, unused_param):
    return data.strip()

# After (manual fix required)
def process_data(data):
    return data.strip()
```

## Integration with Development Workflow

### Quality Gate Pipeline
```bash
/lint     # Fix style and quality issues
/types    # Validate type annotations
/test     # Ensure functionality works
```

### Pre-commit Integration
Ruff runs automatically on Python file writes via hooks:
```json
{
  "PostWrite": [
    {"matcher": "\\.py$", "hooks": [
      {"type": "bash", "command": "uvx ruff format ${FILE}"}
    ]}
  ]
}
```

## Performance Benefits

### Speed Comparison
- **Ruff**: ~10x faster than flake8 + black + isort
- **Single Tool**: Replaces multiple linting tools
- **Incremental**: Only processes changed files when possible

### Tool Consolidation
Ruff replaces:
- flake8 (linting)
- black (formatting)  
- isort (import sorting)
- pyupgrade (syntax modernization)

## Error Handling

### Ruff Not Available
```bash
# Installation check
uvx ruff --version || echo "Installing ruff..."
```

### Configuration Issues
```bash
# Test configuration
uvx ruff check --show-settings

# Validate config file
uvx ruff check --config pyproject.toml --show-files
```

### Large Codebases
```bash
# Process specific directories
uvx ruff check src/ --fix
uvx ruff format src/

# Skip problematic files
uvx ruff check --exclude="legacy/*" .
```

## Selective Processing

### Target Specific Files
```bash
# Single file
uvx ruff check src/main.py --fix

# Multiple files
uvx ruff check src/*.py --fix

# Directory
uvx ruff check tests/ --fix
```

### Rule Selection
```bash
# Only import issues
uvx ruff check --select I .

# Only safety issues  
uvx ruff check --select E,F .

# Exclude formatting
uvx ruff check --ignore E501,W503 .
```

## CI/CD Integration

### Check Mode (No Changes)
```bash
# Verify code is properly formatted
uvx ruff format --check .

# Verify no linting issues
uvx ruff check .
```

### Generate Reports
```bash
# JSON output for CI tools
uvx ruff check --output-format=json .

# GitHub Actions annotations
uvx ruff check --output-format=github .
```

## Best Practices

### Development Workflow
- Run `/lint` before committing changes
- Use auto-fix for safe corrections
- Review manual fixes for complex issues
- Configure editor integration for real-time feedback

### Configuration Strategy  
- Start with recommended defaults
- Gradually enable stricter rules
- Use project-specific ignores sparingly
- Document reasoning for ignored rules

### Team Adoption
- Establish consistent formatting standards
- Use ruff configuration in version control
- Integrate with pre-commit hooks
- Provide clear documentation for rule exceptions

I'll ensure your code meets high quality standards with consistent formatting and comprehensive linting.