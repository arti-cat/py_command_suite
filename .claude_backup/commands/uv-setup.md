---
description: Create/refresh Python environment with UV - idempotent and deterministic
allowed-tools: Bash, Read, Write
---

# UV Environment Setup

Create or refresh Python development environment using UV package manager with deterministic dependency resolution.

## Task

I'll set up a complete Python development environment using UV, ensuring reproducible builds and proper virtual environment isolation.

## Process

I'll follow these idempotent steps:

### 1. Verify UV Installation
```bash
# Check UV availability
uv --version
```

### 2. Virtual Environment Setup
```bash
# Create virtual environment (idempotent)
uv venv .venv

# Verify virtual environment exists  
ls -la .venv/
```

### 3. Dependency Management
```bash
# Generate/update lock file for reproducible installs
uv lock

# Sync dependencies from lock file
uv sync

# Verify installation
uv pip list
```

### 4. Environment Validation
```bash
# Test Python access through UV
uv run python --version

# Verify key development tools are available
uv run python -c "import sys; print(f'Python: {sys.version}')"
```

### 5. Environment Report
Write comprehensive environment status to `agents/reports/uv-setup-${DATE_HOUR}.md`

## UV Commands Used

### Core Environment Commands
- **`uv venv .venv`**: Create virtual environment (idempotent)
- **`uv lock`**: Generate deterministic dependency lock file  
- **`uv sync`**: Install dependencies from lock file
- **`uv pip list`**: Show installed packages

### Development Integration
- **`uv run <command>`**: Execute commands in virtual environment
- **`uv add <package>`**: Add new dependency and update lock
- **`uv remove <package>`**: Remove dependency and update lock

## Environment Report Format

```markdown
# UV Environment Report - {{timestamp}}

## Environment Status
- **UV Version**: {{uv_version}}
- **Python Version**: {{python_version}}  
- **Virtual Env**: {{venv_status}}
- **Lock File**: {{lock_status}}

## Dependencies
{{dependency_summary}}

## Setup Actions Taken
{{actions_performed}}

## Verification
- [{{check_status}}] Python accessible via `uv run`
- [{{check_status}}] Dependencies synchronized  
- [{{check_status}}] Lock file current

## Next Steps
{{recommended_actions}}
```

## Error Handling

### UV Not Installed
```bash
# Installation guidance
echo "UV not found. Install with:"
echo "curl -LsSf https://astral.sh/uv/install.sh | sh"
```

### Environment Issues
- **Permission Problems**: Check directory write permissions
- **Python Version**: Ensure compatible Python version available
- **Dependency Conflicts**: Review pyproject.toml for version constraints

### Recovery Actions
```bash
# Clean slate environment recreation
rm -rf .venv uv.lock
uv venv .venv
uv sync
```

## Project Structure Integration

### Expected Files
- **`pyproject.toml`**: Project metadata and dependencies
- **`.venv/`**: Virtual environment (created)
- **`uv.lock`**: Dependency lock file (created/updated)

### Created Artifacts
- **`agents/reports/uv-setup-*.md`**: Environment setup report
- **`.venv/`**: Project virtual environment
- **`uv.lock`**: Locked dependency versions

## Best Practices

### Reproducible Environments  
- Always use `uv lock` before `uv sync`
- Commit `uv.lock` to version control
- Use `uv sync --locked` in CI/CD for exact reproduction

### Development Workflow
- Use `uv run` for all Python commands
- Use `uv add` instead of `pip install`
- Regular `uv sync` after pulling changes

### Performance Optimization
- UV provides faster dependency resolution than pip
- Parallel downloads and caching improve install speed
- Virtual environment isolation prevents conflicts

## Integration with Other Commands

### Quality Assurance Pipeline
```bash
/uv-setup  # Environment setup
/test      # Run tests with uv run pytest
/lint      # Code quality with uvx ruff  
/types     # Type checking with uvx mypy
```

### Development Commands
```bash
# After environment setup
uv run python -m src.main      # Run application
uv add requests                 # Add new dependency  
uv remove deprecated-lib        # Remove dependency
uv sync                         # Resync after changes
```

## Platform Compatibility

### Linux/macOS
```bash
source .venv/bin/activate  # Manual activation if needed
```

### Windows
```bash  
.venv\Scripts\activate     # Manual activation if needed
```

### Universal (Recommended)
```bash
uv run <command>           # No manual activation needed
```

I'll ensure the environment is properly configured for Python development with all dependencies resolved and validated.