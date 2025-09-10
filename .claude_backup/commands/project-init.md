---
name: project-init
description: Universal Python project scaffolding with UV-native setup and modern tooling
---

# Project Init Command

Universal Python project scaffolding that creates production-ready project structure with UV package manager integration, modern tooling, and quality gates.

## Universal Project Scaffolding

I'll create a complete Python project structure that works for ANY framework - Django, FastAPI, Flask, Streamlit, data science, or CLI tools:

### 1. Project Structure Creation
```bash
# Get project name from user or use current directory
PROJECT_NAME=${1:-$(basename "$PWD")}
PROJECT_DIR=${2:-"$PROJECT_NAME"}

# Create universal project structure
mkdir -p "$PROJECT_DIR"/{src/$PROJECT_NAME,tests,docs,.github/workflows}

# Navigate to project directory
cd "$PROJECT_DIR"

echo "Creating universal Python project: $PROJECT_NAME"
```

### 2. Core Project Files Setup
```bash
# Create pyproject.toml with UV-native configuration
cat > pyproject.toml << 'EOF'
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "PROJECT_NAME_PLACEHOLDER"
version = "0.1.0"
description = "A modern Python project"
readme = "README.md"
requires-python = ">=3.11"
dependencies = []

[project.optional-dependencies]
dev = [
    "pytest>=7.0.0",
    "pytest-cov>=4.0.0",
    "ruff>=0.1.0",
    "mypy>=1.0.0",
    "pre-commit>=3.0.0",
]

[tool.hatch.build.targets.wheel]
packages = ["src/PROJECT_NAME_PLACEHOLDER"]

[tool.ruff]
line-length = 88
target-version = "py311"
src = ["src", "tests"]

[tool.ruff.lint]
select = ["E", "F", "I", "N", "UP", "RUF"]
ignore = []

[tool.mypy]
python_version = "3.11"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
strict = true

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py", "*_test.py"]
addopts = "--cov=src --cov-report=term-missing"

[tool.coverage.run]
source = ["src"]
omit = ["tests/*"]

[dependency-groups]
dev = [
    "detect-secrets>=1.5.0",
]
EOF

# Replace placeholder with actual project name
sed -i "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" pyproject.toml
```

### 3. Source Code Structure
```bash
# Create main module with proper structure
cat > "src/$PROJECT_NAME/__init__.py" << 'EOF'
"""PROJECT_NAME_PLACEHOLDER - A modern Python project."""

__version__ = "0.1.0"
__author__ = "Your Name"
__email__ = "your.email@example.com"

from .main import main

__all__ = ["main"]
EOF

# Create main module with CLI entry point
cat > "src/$PROJECT_NAME/main.py" << 'EOF'
"""Main module for PROJECT_NAME_PLACEHOLDER."""

import logging
import sys
from typing import Any, Optional

logger = logging.getLogger(__name__)


class ProjectNameApp:
    """Main application class for PROJECT_NAME_PLACEHOLDER."""
    
    def __init__(self, debug: bool = False) -> None:
        """Initialize the application.
        
        Args:
            debug: Enable debug logging
        """
        self.debug = debug
        self._setup_logging()
    
    def _setup_logging(self) -> None:
        """Set up application logging."""
        level = logging.DEBUG if self.debug else logging.INFO
        logging.basicConfig(
            level=level,
            format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
        )
    
    def run(self, args: Optional[list[str]] = None) -> int:
        """Run the main application logic.
        
        Args:
            args: Command line arguments
            
        Returns:
            Exit code (0 for success, non-zero for error)
        """
        try:
            logger.info("Starting PROJECT_NAME_PLACEHOLDER")
            
            # Add your main application logic here
            self._process_data()
            
            logger.info("PROJECT_NAME_PLACEHOLDER completed successfully")
            return 0
            
        except Exception as e:
            logger.error(f"Application error: {e}")
            if self.debug:
                logger.exception("Full traceback:")
            return 1
    
    def _process_data(self) -> dict[str, Any]:
        """Process application data.
        
        Returns:
            Processed data dictionary
        """
        # Placeholder for main business logic
        return {"status": "success", "message": "Hello from PROJECT_NAME_PLACEHOLDER!"}


def main() -> int:
    """Main entry point for the application."""
    import argparse
    
    parser = argparse.ArgumentParser(description="PROJECT_NAME_PLACEHOLDER application")
    parser.add_argument(
        "--debug", 
        action="store_true", 
        help="Enable debug logging"
    )
    parser.add_argument(
        "--version", 
        action="version", 
        version="PROJECT_NAME_PLACEHOLDER 0.1.0"
    )
    
    args = parser.parse_args()
    
    app = ProjectNameApp(debug=args.debug)
    return app.run()


if __name__ == "__main__":
    sys.exit(main())
EOF

# Replace placeholders in source files
sed -i "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" "src/$PROJECT_NAME/__init__.py"
sed -i "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" "src/$PROJECT_NAME/main.py"
```

### 4. Test Suite Setup
```bash
# Create test structure with comprehensive examples
cat > "tests/__init__.py" << 'EOF'
"""Test suite for PROJECT_NAME_PLACEHOLDER."""
EOF

cat > "tests/conftest.py" << 'EOF'
"""Shared test configuration and fixtures."""

import pytest
from unittest.mock import Mock

from src.PROJECT_NAME_PLACEHOLDER.main import ProjectNameApp


@pytest.fixture
def app():
    """Create a test application instance."""
    return ProjectNameApp(debug=True)


@pytest.fixture
def mock_logger():
    """Create a mock logger for testing."""
    return Mock()


@pytest.fixture
def sample_data():
    """Provide sample data for testing."""
    return {
        "test_key": "test_value",
        "items": [1, 2, 3],
        "nested": {"inner": "data"}
    }
EOF

cat > "tests/test_main.py" << 'EOF'
"""Tests for the main module."""

import pytest
from unittest.mock import patch, Mock

from src.PROJECT_NAME_PLACEHOLDER.main import ProjectNameApp, main


class TestProjectNameApp:
    """Test cases for ProjectNameApp class."""
    
    def test_app_initialization(self, app):
        """Test application initializes correctly."""
        assert app is not None
        assert app.debug is True
    
    def test_app_initialization_no_debug(self):
        """Test application initializes without debug."""
        app = ProjectNameApp(debug=False)
        assert app.debug is False
    
    def test_run_success(self, app):
        """Test successful application run."""
        result = app.run()
        assert result == 0
    
    def test_process_data_returns_dict(self, app):
        """Test _process_data returns expected structure."""
        result = app._process_data()
        assert isinstance(result, dict)
        assert "status" in result
        assert "message" in result
        assert result["status"] == "success"
    
    @patch('src.PROJECT_NAME_PLACEHOLDER.main.logger')
    def test_run_logs_start_and_end(self, mock_logger, app):
        """Test that run method logs appropriately."""
        app.run()
        
        # Check that info was called for start and end
        assert mock_logger.info.call_count >= 2
        start_call = mock_logger.info.call_args_list[0][0][0]
        assert "Starting" in start_call
    
    @patch('src.PROJECT_NAME_PLACEHOLDER.main.ProjectNameApp._process_data')
    def test_run_handles_exceptions(self, mock_process, app):
        """Test error handling in run method."""
        mock_process.side_effect = Exception("Test error")
        
        result = app.run()
        assert result == 1


class TestMainFunction:
    """Test cases for main function."""
    
    @patch('sys.argv', ['prog', '--debug'])
    @patch('src.PROJECT_NAME_PLACEHOLDER.main.ProjectNameApp')
    def test_main_with_debug_flag(self, mock_app_class):
        """Test main function with debug flag."""
        mock_app = Mock()
        mock_app.run.return_value = 0
        mock_app_class.return_value = mock_app
        
        result = main()
        
        mock_app_class.assert_called_once_with(debug=True)
        mock_app.run.assert_called_once()
        assert result == 0
    
    @patch('sys.argv', ['prog'])
    @patch('src.PROJECT_NAME_PLACEHOLDER.main.ProjectNameApp')
    def test_main_without_debug_flag(self, mock_app_class):
        """Test main function without debug flag."""
        mock_app = Mock()
        mock_app.run.return_value = 0
        mock_app_class.return_value = mock_app
        
        result = main()
        
        mock_app_class.assert_called_once_with(debug=False)
        mock_app.run.assert_called_once()
        assert result == 0
EOF

# Replace placeholders in test files
sed -i "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" "tests/__init__.py"
sed -i "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" "tests/conftest.py"
sed -i "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" "tests/test_main.py"
```

### 5. Quality and Security Configuration
```bash
# Create comprehensive .gitignore
cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Virtual environments
.env
.venv/
env/
venv/
ENV/
env.bak/
venv.bak/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# Testing
.coverage
.pytest_cache/
.tox/
htmlcov/
.coverage.*
coverage.xml
*.cover
.hypothesis/

# Security
.secrets.baseline
*.pem
*.key
.env.local
.env.production

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Project specific
logs/
data/
temp/
tmp/
*.log
EOF

# Create secrets baseline for security
cat > .secrets.baseline << 'EOF'
{
  "version": "1.5.0",
  "plugins_used": [
    {
      "name": "ArtifactoryDetector"
    },
    {
      "name": "AWSKeyDetector"
    },
    {
      "name": "Base64HighEntropyString",
      "limit": 4.5
    },
    {
      "name": "BasicAuthDetector"
    },
    {
      "name": "CloudantDetector"
    },
    {
      "name": "HexHighEntropyString",
      "limit": 3.0
    },
    {
      "name": "JwtTokenDetector"
    },
    {
      "name": "KeywordDetector",
      "keyword_exclude": ""
    },
    {
      "name": "MailchimpDetector"
    },
    {
      "name": "PrivateKeyDetector"
    },
    {
      "name": "SlackDetector"
    },
    {
      "name": "SoftlayerDetector"
    },
    {
      "name": "SquareOAuthDetector"
    },
    {
      "name": "StripeDetector"
    },
    {
      "name": "TwilioKeyDetector"
    }
  ],
  "filters_used": [
    {
      "path": "detect_secrets.filters.allowlist.is_line_allowlisted"
    },
    {
      "path": "detect_secrets.filters.common.is_baseline_file"
    },
    {
      "path": "detect_secrets.filters.common.is_ignored_due_to_verification_policies",
      "min_level": 2
    },
    {
      "path": "detect_secrets.filters.heuristic.is_indirect_reference"
    },
    {
      "path": "detect_secrets.filters.heuristic.is_likely_id_string"
    },
    {
      "path": "detect_secrets.filters.heuristic.is_templated_secret"
    }
  ],
  "results": {},
  "generated_at": "$(date -Iseconds)"
}
EOF

# Create pre-commit configuration
cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-merge-conflict

  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.6
    hooks:
      - id: ruff
        args: [--fix, --exit-non-zero-on-fix]
      - id: ruff-format

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.7.1
    hooks:
      - id: mypy
        additional_dependencies: [types-all, types-requests]
        args: ["--ignore-missing-imports", "src/"]

  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets
        args: ['--baseline', '.secrets.baseline']
EOF
```

### 6. Documentation and CI/CD Setup
```bash
# Create comprehensive README
cat > README.md << 'EOF'
# PROJECT_NAME_PLACEHOLDER

A modern Python project with universal structure and best practices.

## Features

- **Modern Python**: Built for Python 3.11+ with full type annotations
- **UV Package Manager**: Fast, reliable dependency management
- **Quality Tools**: Pre-configured ruff, mypy, pytest, and pre-commit
- **Security**: Baseline secret detection and security best practices
- **CI/CD Ready**: GitHub Actions workflow included
- **Universal Structure**: Compatible with any Python framework

## Quick Start

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd PROJECT_NAME_PLACEHOLDER

# Set up environment with UV
uv venv .venv
uv sync

# Install pre-commit hooks
uv run pre-commit install
```

### Usage

```bash
# Run the application
uv run python -m src.PROJECT_NAME_PLACEHOLDER

# With debug logging
uv run python -m src.PROJECT_NAME_PLACEHOLDER --debug

# Run tests
uv run pytest

# Code quality checks
uv run ruff check
uv run ruff format
uv run mypy src
```

## Development

### Project Structure

```
PROJECT_NAME_PLACEHOLDER/
├── src/PROJECT_NAME_PLACEHOLDER/    # Main package
│   ├── __init__.py
│   └── main.py
├── tests/                           # Test suite
│   ├── __init__.py
│   ├── conftest.py
│   └── test_main.py
├── docs/                            # Documentation
├── .github/workflows/               # CI/CD workflows
├── pyproject.toml                   # Project configuration
├── README.md                        # Project documentation
├── .gitignore                       # Git ignore rules
├── .secrets.baseline                # Security baseline
└── .pre-commit-config.yaml          # Pre-commit hooks
```

### Adding Dependencies

```bash
# Add runtime dependency
uv add requests

# Add development dependency
uv add --group dev pytest-mock

# Update dependencies
uv lock
uv sync
```

### Quality Assurance

```bash
# Run all checks
uv run pytest --cov
uv run ruff check --fix
uv run ruff format
uv run mypy src

# Security scan
uv run detect-secrets scan --baseline .secrets.baseline
```

## Framework Integration

This universal structure works with any Python framework:

### Web Frameworks
- **Django**: Add django to dependencies, create apps in src/
- **FastAPI**: Add fastapi/uvicorn, create routers in src/
- **Flask**: Add flask, create blueprints in src/

### Data Science
- **Jupyter**: Add jupyter, create notebooks/ directory
- **Pandas/NumPy**: Add data science dependencies
- **ML Libraries**: Add tensorflow/pytorch as needed

### CLI Tools
- **Click/Typer**: Add CLI framework, extend main.py
- **Rich**: Add for enhanced terminal output

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run quality checks (`uv run pytest && uv run ruff check`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For questions and support, please open an issue on the repository.
EOF

# Replace placeholder in README
sed -i "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" README.md

# Create GitHub Actions CI workflow
cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.11", "3.12"]

    steps:
    - uses: actions/checkout@v4

    - name: Install UV
      uses: astral-sh/setup-uv@v3
      with:
        version: "latest"

    - name: Set up Python ${{ matrix.python-version }}
      run: uv python install ${{ matrix.python-version }}

    - name: Install dependencies
      run: |
        uv sync --all-extras --dev

    - name: Run security scan
      run: |
        uv run detect-secrets scan --baseline .secrets.baseline

    - name: Run ruff linting
      run: |
        uv run ruff check

    - name: Run ruff formatting check
      run: |
        uv run ruff format --check

    - name: Run type checking
      run: |
        uv run mypy src

    - name: Run tests
      run: |
        uv run pytest --cov --cov-report=xml

    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage.xml
        fail_ci_if_error: true
EOF

# Create basic Dockerfile for containerization
cat > Dockerfile << 'EOF'
FROM python:3.11-slim

# Install UV
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Set working directory
WORKDIR /app

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN uv sync --frozen --no-cache

# Copy source code
COPY src/ src/
COPY README.md .

# Create non-root user
RUN useradd --create-home --shell /bin/bash app
USER app

# Set entrypoint
ENTRYPOINT ["uv", "run", "python", "-m", "src.PROJECT_NAME_PLACEHOLDER"]
EOF

sed -i "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" Dockerfile
```

### 7. UV Environment Setup
```bash
echo "Setting up UV environment..."

# Create virtual environment
uv venv .venv

# Generate lock file
uv lock

# Sync dependencies
uv sync

# Install pre-commit hooks
uv run pre-commit install

echo "UV environment setup complete!"
```

### 8. Git Repository Initialization
```bash
# Initialize git repository if not already a repo
if [ ! -d ".git" ]; then
    git init
    echo "Initialized git repository"
fi

# Add all files
git add .

# Create initial commit
git commit -m "Initial project setup with universal Python structure

- UV-native package management with pyproject.toml
- Modern Python 3.11+ with full type annotations
- Comprehensive test suite with pytest
- Quality tools: ruff, mypy, pre-commit
- Security baseline with detect-secrets
- GitHub Actions CI/CD workflow
- Universal structure compatible with any framework
- Docker containerization ready"

echo "Git repository initialized with initial commit"
```

## Framework Detection Integration

I'll check for existing framework patterns and provide recommendations:

```bash
# Check if framework-detect command is available
if [ -f ".claude/commands/framework-detect.md" ]; then
    echo "Running framework detection for optimization recommendations..."
    
    # Run framework detection if available
    FRAMEWORK_DATA=$(cat agents/reports/framework-detect-*.json 2>/dev/null | tail -1)
    
    if [ ! -z "$FRAMEWORK_DATA" ]; then
        PRIMARY_FRAMEWORK=$(echo "$FRAMEWORK_DATA" | grep -o '"primary_framework":"[^"]*"' | cut -d'"' -f4)
        
        if [ ! -z "$PRIMARY_FRAMEWORK" ] && [ "$PRIMARY_FRAMEWORK" != "null" ]; then
            echo "Detected primary framework: $PRIMARY_FRAMEWORK"
            echo "Consider running framework-specific setup commands:"
            echo "  /django-setup (for Django projects)"
            echo "  /fastapi-setup (for FastAPI projects)"
            echo "  /flask-setup (for Flask projects)"
        fi
    fi
fi
```

## Project Validation and Report

Generate comprehensive project setup report:

```bash
# Create timestamp for report
TIMESTAMP=$(date +"%Y%m%d_%H%M")

# Create reports directory
mkdir -p agents/reports

# Generate project setup report
cat > "agents/reports/project-init-$TIMESTAMP.md" << EOF
# Project Init Report - $TIMESTAMP

## Project Summary
- **Project Name**: $PROJECT_NAME
- **Created**: $(date -Iseconds)
- **Python Version**: $(uv run python --version)
- **UV Version**: $(uv --version)

## Project Structure Created
- **Source Package**: src/$PROJECT_NAME/
- **Test Suite**: tests/ with pytest configuration
- **Documentation**: README.md with comprehensive guide
- **CI/CD**: GitHub Actions workflow configured
- **Security**: detect-secrets baseline configured
- **Quality Tools**: ruff, mypy, pre-commit configured

## Dependencies Configured
### Runtime Dependencies
$(grep -A 5 'dependencies = \[' pyproject.toml)

### Development Dependencies
$(grep -A 10 'dev = \[' pyproject.toml)

## Quality Gates Enabled
- [x] Ruff linting and formatting
- [x] MyPy type checking
- [x] Pytest testing with coverage
- [x] Pre-commit hooks
- [x] Secret detection baseline
- [x] GitHub Actions CI/CD

## Environment Status
- [x] Virtual environment created (.venv/)
- [x] Dependencies locked (uv.lock)
- [x] Dependencies synced
- [x] Pre-commit hooks installed
- [x] Git repository initialized

## Framework Compatibility
This universal structure supports:
- **Web Frameworks**: Django, FastAPI, Flask
- **Data Science**: Jupyter, Pandas, NumPy, ML libraries  
- **CLI Tools**: Click, Typer, Rich
- **APIs**: REST, GraphQL, gRPC
- **Any Python Framework**: Extensible structure

## Next Steps
1. **Framework Setup**: Run framework-specific commands if needed
2. **Dependencies**: Add project-specific dependencies with \`uv add\`
3. **Development**: Start coding in src/$PROJECT_NAME/main.py
4. **Testing**: Add tests in tests/ directory
5. **Documentation**: Update README.md with project details

## Quick Commands
\`\`\`bash
# Run application
uv run python -m src.$PROJECT_NAME

# Run tests  
uv run pytest

# Quality checks
uv run ruff check --fix
uv run mypy src

# Add dependencies
uv add requests  # runtime
uv add --group dev pytest-mock  # development
\`\`\`

## Project Ready
✅ Universal Python project structure created
✅ UV package management configured
✅ Modern tooling and quality gates enabled
✅ CI/CD pipeline ready
✅ Security baseline established
✅ Documentation complete

The project is ready for immediate development and framework extension.
EOF

echo "Project initialization complete!"
echo "Report saved to: agents/reports/project-init-$TIMESTAMP.md"
echo ""
echo "Next steps:"
echo "1. cd $PROJECT_DIR"
echo "2. uv run python -m src.$PROJECT_NAME --help"
echo "3. Start coding!"
```

## Command Integration

This universal scaffolding integrates with the Python Command Suite:

### Framework-Specific Extensions
- Use `/framework-detect` to identify existing patterns
- Run framework-specific setup commands after universal init
- Leverage framework optimization commands

### Development Workflow  
- Use `/uv-setup` for environment management
- Use `/test` and `/lint` commands for quality assurance
- Use security commands for vulnerability scanning

### Project Templates
- **Web Apps**: Add web framework dependencies
- **Data Science**: Add jupyter, pandas, ML libraries
- **CLI Tools**: Add click/typer, rich for enhanced UX
- **APIs**: Add framework-specific API dependencies

This universal project structure provides the foundation for ANY Python project while maintaining compatibility with the entire Python Command Suite ecosystem.