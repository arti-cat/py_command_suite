---
description: Strict type checking with MyPy for enhanced code reliability
allowed-tools: Bash
---

# Python Type Checking

Enforce strict type safety using MyPy to catch type-related bugs and improve code reliability.

## Task

I'll run comprehensive static type analysis using MyPy with strict settings to ensure type safety across the Python codebase.

## Process

I'll execute type checking with progressively strict validation:

### 1. Strict Type Checking
```bash
# Run MyPy with strict settings on source and tests
uvx mypy --strict src tests
```

### 2. Incremental Analysis (if needed)
```bash
# Check specific modules for focused feedback
uvx mypy --strict src/module_name.py
```

### 3. Error Analysis and Reporting
Analyze type errors and suggest fixes for common issues.

## MyPy Command Options

### Core Settings
- **`--strict`**: Enable all strict mode flags
- **`--show-error-codes`**: Display error codes for filtering
- **`--pretty`**: Enhanced error formatting

### Incremental Processing
- **`--incremental`**: Use cache for faster subsequent runs
- **`--cache-dir .mypy_cache`**: Specify cache directory

### Output Control
- **`--no-error-summary`**: Suppress error count summary
- **`--show-column-numbers`**: Show precise error locations

## Strict Mode Components

### Type Annotations Required
```python
# MyPy requires explicit annotations in strict mode
def process_data(data: str) -> dict[str, Any]:
    return {"result": data.upper()}
```

### No Implicit Optional
```python
# Before (fails strict mode)
def get_user(id: int) -> User:
    return None  # Error: incompatible return type

# After (strict mode compatible)  
def get_user(id: int) -> User | None:
    return None
```

### No Untyped Calls
```python
# All function calls must be typed
from typing import Any

def untyped_function() -> Any: ...  # Must annotate return
```

## Configuration Integration

### pyproject.toml Configuration
```toml
[tool.mypy]
python_version = "3.11"
strict = true
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

# Per-module configuration
[[tool.mypy.overrides]]
module = "tests.*"
ignore_errors = true

[[tool.mypy.overrides]]
module = "third_party.*"
ignore_missing_imports = true
```

## Common Type Issues and Fixes

### Missing Return Type Annotations
```python
# Before (MyPy error)
def calculate(x, y):
    return x + y

# After (type-safe)
def calculate(x: float, y: float) -> float:
    return x + y
```

### Untyped Function Arguments
```python
# Before (MyPy error)  
def process_items(items):
    return [item.upper() for item in items]

# After (type-safe)
def process_items(items: list[str]) -> list[str]:
    return [item.upper() for item in items]
```

### Optional Type Handling
```python
# Before (MyPy error)
def get_name(user: User) -> str:
    return user.name.upper()  # user.name might be None

# After (type-safe)
def get_name(user: User) -> str:
    if user.name is None:
        return ""
    return user.name.upper()
```

### Generic Type Usage
```python
# Before (imprecise typing)
def get_items() -> list:
    return []

# After (precise typing)
def get_items() -> list[dict[str, Any]]:
    return []
```

## Framework-Specific Considerations

### Django Integration
```bash
# Install Django type stubs
uv add django-stubs

# Configure for Django
uvx mypy --django-settings-module=settings src
```

### FastAPI Integration
```python
# Use proper FastAPI typing
from fastapi import FastAPI
from pydantic import BaseModel

class UserModel(BaseModel):
    name: str
    age: int

app = FastAPI()

@app.post("/users/")
async def create_user(user: UserModel) -> dict[str, str]:
    return {"status": "created", "name": user.name}
```

### Async Code Typing
```python
# Proper async type annotations
from typing import Awaitable
import asyncio

async def fetch_data(url: str) -> dict[str, Any]:
    # Async operation
    return {"data": "result"}

async def process_urls(urls: list[str]) -> list[dict[str, Any]]:
    tasks: list[Awaitable[dict[str, Any]]] = [
        fetch_data(url) for url in urls
    ]
    return await asyncio.gather(*tasks)
```

## Error Categories and Solutions

### Import Resolution Issues
```bash
# Install type stubs for third-party packages
uv add types-requests types-redis types-pillow

# Or ignore missing imports
uvx mypy --ignore-missing-imports src
```

### Gradual Typing Adoption
```python
# Use Any for gradual adoption
from typing import Any

def legacy_function(data: Any) -> Any:
    # Gradually add more specific types
    return data
```

### Type: ignore Usage
```python
# Selective type checking bypass (use sparingly)
result = complex_legacy_function()  # type: ignore[no-untyped-call]
```

## Integration with Development Workflow

### Quality Assurance Pipeline
```bash
/types    # Type safety validation
/lint     # Code style and quality  
/test     # Runtime behavior validation
```

### IDE Integration
MyPy integrates with:
- VS Code (Python extension)
- PyCharm (built-in support)
- Vim/Neovim (via LSP)

## Performance Optimization

### Incremental Checking
```bash
# First run (full analysis)
uvx mypy --strict src tests

# Subsequent runs (incremental)
uvx mypy --strict src tests  # Uses cache automatically
```

### Selective Checking
```bash
# Check only modified files
uvx mypy --strict src/modified_module.py

# Check specific directories
uvx mypy --strict src/core/
```

## CI/CD Integration

### GitHub Actions Example
```bash
# Check types without installing project
uvx mypy --install-types --non-interactive --strict src tests
```

### Pre-commit Integration
```yaml
# .pre-commit-config.yaml
repos:
- repo: https://github.com/pre-commit/mirrors-mypy
  rev: v1.5.1
  hooks:
  - id: mypy
    args: [--strict]
```

## Advanced Features

### Stub File Generation
```bash
# Generate stub files for untyped libraries
uvx stubgen -p untyped_package -o stubs/
```

### Type Coverage Analysis
```bash
# Check type coverage percentage  
uvx mypy --strict --html-report coverage-report src
```

### Plugin System
```toml
[tool.mypy]
plugins = [
    "pydantic.mypy",
    "sqlalchemy.ext.mypy.plugin"
]
```

## Error Resolution Strategy

### Prioritize Errors
1. **Import errors**: Fix missing stubs and imports
2. **Function signatures**: Add missing annotations
3. **Return types**: Specify function return types
4. **Variable assignments**: Add type hints where needed

### Incremental Adoption
- Start with new code (strict mode)
- Gradually annotate existing code  
- Use `# type: ignore` temporarily for complex cases
- Focus on public interfaces first

## Best Practices

### Type Annotation Strategy
- Annotate public interfaces completely
- Use precise types over `Any` when possible
- Leverage Union types for multiple possibilities
- Document complex type relationships

### Maintenance
- Keep type stubs updated
- Review type errors regularly
- Use mypy reports to track coverage
- Integrate with code review process

I'll ensure your Python code maintains strict type safety standards for improved reliability and maintainability.