---
description: Run fast, deterministic tests with coverage reporting
allowed-tools: Bash, Write, Read
---

# Python Test Runner

Execute Python tests using UV with fast, deterministic, and comprehensive coverage reporting.

## Task

I'll run the test suite with optimal settings for development workflow - fast feedback, deterministic results, and coverage analysis.

## Process

I'll execute tests with these optimized settings:

### 1. Fast Test Execution
```bash
# Run tests excluding slow integration tests
uv run pytest -q --maxfail=1 -k "not slow" --random-order --random-order-seed=0 --cov
```

### 2. Coverage Analysis
```bash  
# Generate coverage report (if coverage succeeds)
uv run pytest --cov --cov-report=term-missing --cov-report=html
```

### 3. Result Processing
- **On Success**: Brief summary of results
- **On Failure**: Capture minimal failure logs to `agents/reports/test-fail-${SESSION_ID}.md`

## Test Command Breakdown

### Core Options
- **`-q`**: Quiet output, reduce noise
- **`--maxfail=1`**: Stop after first failure for fast feedback
- **`-k "not slow"`**: Exclude long-running integration tests
- **`--random-order`**: Detect order-dependent test issues
- **`--random-order-seed=0`**: Deterministic randomization

### Coverage Options
- **`--cov`**: Enable coverage tracking
- **`--cov-report=term`**: Terminal coverage summary
- **`--cov-report=html`**: HTML coverage report (optional)

## Test Categories

### Fast Tests (Default)
- Unit tests
- Pure function tests  
- Mock-based tests
- Local file operations

### Slow Tests (Excluded by default)
```python
@pytest.mark.slow
def test_api_integration():
    # Long-running test
    pass
```

### Coverage Targets
- Aim for >80% coverage on new code
- Focus on critical business logic
- Exclude test files and generated code

## Failure Analysis

### On Test Failure
I'll create a focused failure report:

```markdown
# Test Failure Report - {{session_id}}

## Failed Test Summary
**Command**: {{test_command}}
**Exit Code**: {{exit_code}}
**Duration**: {{test_duration}}

## Failure Details
{{failure_output}}

## Affected Files
{{changed_files}}

## Suggested Actions
1. {{action_1}}
2. {{action_2}}
3. {{action_3}}

## Debug Commands
```bash
# Re-run specific failing test
uv run pytest {{failing_test}} -v

# Debug with pdb
uv run pytest {{failing_test}} --pdb

# Check test in isolation  
uv run pytest {{failing_test}} --no-cov
```
```

## Test Framework Detection

### Pytest (Preferred)
```bash
uv run pytest [options]
```

### Unittest (Fallback)  
```bash
uv run python -m unittest discover
```

### Framework-Specific Options

#### Django
```bash
uv run python manage.py test --settings=settings.test
```

#### FastAPI
```bash
uv run pytest -k "not integration" --asyncio-mode=auto
```

## Coverage Configuration

### pyproject.toml Integration
```toml
[tool.coverage.run]
source = ["src"]
omit = ["tests/*", "*/migrations/*"]

[tool.coverage.report]  
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "raise AssertionError",
    "if __name__ == .__main__.:"
]
```

## Performance Optimization

### Fast Feedback Loop
1. **Parallel Execution**: Use `-n auto` with pytest-xdist
2. **Selective Testing**: Use `-k` patterns for focused runs
3. **Fail Fast**: `--maxfail=1` for immediate feedback

### Test Selection Strategies
```bash
# Modified files only (requires pytest-testmon)
uv run pytest --testmon

# By test marker
uv run pytest -m "not integration"

# By directory
uv run pytest tests/unit/
```

## Integration with Development Workflow

### Pre-commit Testing
```bash
/test           # Quick validation
/lint           # Code quality check  
/types          # Type validation
```

### CI/CD Integration  
```bash
# Full test suite (including slow tests)
uv run pytest --cov --cov-report=xml

# Generate coverage reports for CI
uv run coverage xml
```

## Error Recovery

### Common Issues

#### Missing Dependencies
```bash
# Ensure test environment is set up
/uv-setup
uv sync
```

#### Import Errors
```bash
# Check Python path
uv run python -c "import sys; print(sys.path)"

# Verify package installation
uv run pip list
```

#### Database/Resource Issues
```bash
# Reset test database (Django)
uv run python manage.py migrate --run-syncdb --settings=settings.test

# Clear test cache
rm -rf .pytest_cache __pycache__
```

## Reporting

### Success Output
```markdown
## Test Results ✓
- **Tests**: {{test_count}} passed
- **Coverage**: {{coverage_percent}}%  
- **Duration**: {{duration}}s
```

### Failure Output
Detailed failure report saved to `agents/reports/test-fail-${SESSION_ID}.md`

## Best Practices

### Test Organization
- Keep tests fast and focused
- Use fixtures for common setup
- Mock external dependencies
- Separate unit and integration tests

### Coverage Strategy
- Focus on new/changed code
- Don't chase 100% coverage blindly  
- Exclude trivial code (getters, repr)
- Test critical business logic thoroughly

### Debugging Approach
- Run failing tests in isolation first
- Use `--pdb` for interactive debugging
- Check test order dependency issues
- Verify test data and fixtures

I'll run the optimized test suite and provide clear feedback on results and any issues discovered.