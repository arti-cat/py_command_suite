# Python Command Suite for Claude Code

A comprehensive collection of Python development commands for Claude Code, featuring modern tooling integration with UV package manager, Context7 documentation intelligence, and framework-aware development workflows.

## 🎯 Overview

The Python Command Suite provides a complete development workflow for Python projects, from environment setup through testing and deployment. Built specifically for Claude Code, it addresses the critical agent context gap by providing rich context bundles for sub-agent interactions while leveraging modern Python tooling.

### Key Features

- **🚀 UV Package Manager Excellence**: Fast, modern dependency management with intelligent resolution
- **🧠 Context7 Intelligence**: Real-time documentation research and best practices integration  
- **🔧 Framework Awareness**: Deep support for Django, FastAPI, Flask, and Data Science workflows
- **🤖 Agent Context Bundling**: Solves the "agents have ZERO project context" problem with rich context sharing
- **⚡ Modern Python Standards**: Python 3.11+ features, async patterns, comprehensive type checking
- **🔄 Complete Workflow**: Environment → Dependencies → Quality → Testing integration

## 🚀 Quick Start

```bash
# 1. Analyze and prime your Python project
/project-prime

# 2. Set up development environment with UV
/py:setup-environment my-project --framework fastapi

# 3. Add dependencies with intelligent research
/py:add-dependency fastapi uvicorn pydantic

# 4. Complete quality workflow
/py:format-code
/py:type-check  
/py:run-tests --coverage
```

## 📋 Commands Overview

### 🛠️ Command Management System

| Command | Purpose | Key Features |
|---------|---------|-------------|
| [`py:create-command`](#py-create-command) | Create new Python commands | Templates, UV integration, Context7 patterns |
| [`py:update-command`](#py-update-command) | Safely modify existing commands | Backup system, version control, rollback |
| [`py:remove-command`](#py-remove-command) | Archive/remove commands | Safe removal, backup, restoration |
| [`py:list-commands`](#py-list-commands) | Browse available commands | Search, filtering, categorization |
| [`py:show-command`](#py-show-command) | Display command details | Usage examples, integration info |

### 🔍 Project Analysis

| Command | Purpose | Key Features |
|---------|---------|-------------|
| [`/project-prime`](#project-prime) | Comprehensive project analysis | Framework detection, agent context bundles, tooling analysis |

### 🐍 Core Python Development

| Command | Purpose | Key Features |
|---------|---------|-------------|
| [`py:setup-environment`](#py-setup-environment) | UV-based environment setup | Virtual environments, framework setup, quality tools |
| [`py:add-dependency`](#py-add-dependency) | Smart dependency management | Context7 research, version optimization, conflict resolution |
| [`py:format-code`](#py-format-code) | Modern code formatting | Ruff/Black integration, import organization, pre-commit |
| [`py:type-check`](#py-type-check) | Comprehensive type checking | Mypy integration, modern typing patterns, IDE support |
| [`py:run-tests`](#py-run-tests) | Advanced testing framework | Pytest, coverage reporting, parallel execution |

## 📖 Detailed Command Documentation

### Command Management System

#### `py:create-command`
**Create new Python development commands using templates and best practices**

```bash
# Create basic development command
/py:create-command setup-ml-environment development

# Create framework-specific command  
/py:create-command django-add-api framework

# Create testing command with coverage
/py:create-command pytest-benchmark testing
```

**Features:**
- Template-based command generation for different categories
- UV package manager integration built-in
- Context7 documentation patterns included
- Framework-specific templates (Django, FastAPI, Flask)
- Automatic kebab-case naming and Claude Code standards compliance

---

#### `py:update-command`
**Safely update existing commands with backup creation and version control**

```bash
# Update command with UV integration
/py:update-command setup-environment "Add UV package manager support"

# Enhance with Context7 integration  
/py:update-command django-migrate "Add Context7 Django documentation integration"

# Add modern Python features
/py:update-command format-code "Add ruff formatter integration"
```

**Features:**
- Automatic backup creation with timestamps
- Safe modification with rollback capabilities
- Python-specific enhancement suggestions (UV, Context7, modern tooling)
- Version control integration and change tracking
- Validation and testing of modifications

---

#### `py:remove-command`
**Archive or remove commands with comprehensive backup and rollback capabilities**

```bash
# Archive command safely (recommended)
/py:remove-command old-deployment-script

# Disable temporarily for testing
/py:remove-command experimental-feature --disable

# Permanent removal with confirmation
/py:remove-command obsolete-command --delete --confirm
```

**Features:**
- Multiple removal modes: archive, disable, delete
- Comprehensive backup system with dependency tracking
- Dependency analysis and impact assessment
- Easy restoration capabilities
- Change logging and modification history

---

#### `py:list-commands`
**Browse, search, and filter available Python development commands**

```bash
# List all commands
/py:list-commands

# Search by functionality
/py:list-commands --search "django"

# Filter by features
/py:list-commands --uv-integrated --context7-enabled

# Different output formats
/py:list-commands --format table
/py:list-commands --format detailed
```

**Features:**
- Comprehensive command discovery with search and filtering
- Category organization (development, testing, framework, deployment)
- Multiple output formats (list, table, detailed, JSON)
- Usage statistics and popularity metrics
- Integration feature highlighting (UV, Context7, framework support)

---

#### `py:show-command`
**Display comprehensive details about specific commands with management integration**

```bash
# Show command overview
/py:show-command setup-environment

# Show with detailed analysis
/py:show-command fastapi-setup --detailed --integrations

# Show with management options
/py:show-command legacy-tool --suggest-updates --related
```

**Features:**
- Comprehensive command information display
- Usage examples and integration details
- Performance metrics and analytics
- Quick access to editing and management functions
- Framework compatibility and dependency information

### Project Analysis

#### `/project-prime`
**Comprehensive Python project analysis and agent context preparation**

```bash
# Complete project analysis
/project-prime

# Framework-specific analysis
/project-prime --focus django --async-patterns

# Sub-agent context preparation
/project-prime --prepare-agent-context python-pro
```

**Features:**
- **Deep Framework Detection**: Django, FastAPI, Flask, Data Science project identification
- **UV Integration Analysis**: Package manager usage and optimization opportunities  
- **Context7 Strategic Research**: Library documentation and best practices fetching
- **Agent Context Bundling**: Rich context preparation for sub-agent interactions
- **Modern Tooling Detection**: Ruff, mypy, pytest, async patterns identification
- **Architecture Analysis**: Code organization, type annotation coverage, testing strategies

### Core Python Development Tools

#### `py:setup-environment`
**Comprehensive Python development environment setup with UV package manager**

```bash
# Basic environment setup
/py:setup-environment my-project

# Framework-specific setup
/py:setup-environment blog-app --framework django --database postgresql
/py:setup-environment api-service --framework fastapi --async
/py:setup-environment analysis --framework datascience --jupyter

# Advanced configuration
/py:setup-environment workspace --monorepo --python 3.11
```

**Features:**
- **UV-First Approach**: Modern, fast package management with dependency resolution
- **Framework Intelligence**: Django, FastAPI, Flask, Data Science optimized setups
- **Virtual Environment Management**: Isolated development environments
- **Quality Tooling Setup**: Black, ruff, mypy, pytest integration
- **Context7 Integration**: Real-time framework documentation and best practices

---

#### `py:add-dependency`
**Smart dependency management with Context7 research and version optimization**

```bash
# Add production dependencies
/py:add-dependency fastapi uvicorn pydantic

# Add development dependencies
/py:add-dependency --dev pytest black ruff mypy

# Framework-specific additions
/py:add-dependency django djangorestframework --framework django
/py:add-dependency pandas numpy matplotlib --framework datascience

# Version-constrained installation
/py:add-dependency "django>=4.2,<5.0" --update-existing
```

**Features:**
- **Context7 Intelligence**: Real-time package research and best practices
- **UV Integration**: Fast dependency resolution with lock file management
- **Security Scanning**: Vulnerability checking and security best practices
- **Framework Awareness**: Django, FastAPI, Flask optimized package suggestions
- **Conflict Resolution**: Smart dependency conflict detection and resolution

---

#### `py:format-code`
**Modern Python code formatting with ruff and black integration**

```bash
# Format current directory
/py:format-code

# Format with import organization
/py:format-code --organize-imports

# Set up formatting for project
/py:format-code --setup --tool ruff --framework django

# Check formatting without changes
/py:format-code --check --diff
```

**Features:**
- **Modern Tooling**: Ruff formatter for speed, Black compatibility mode
- **Import Organization**: Smart import sorting and cleanup
- **Framework Configurations**: Django, FastAPI, Flask specific formatting rules
- **Pre-commit Integration**: Automated formatting in git workflows
- **IDE Integration**: VS Code, PyCharm configuration support

---

#### `py:type-check`
**Comprehensive Python type checking with mypy and modern typing patterns**

```bash
# Basic type checking
/py:type-check

# Strict type checking with coverage
/py:type-check --strict --coverage-report

# Framework-specific setup
/py:type-check --setup --framework fastapi
/py:type-check --setup --framework django

# Performance analysis
/py:type-check --profile --show-stats
```

**Features:**
- **Mypy Integration**: Comprehensive static type analysis
- **Modern Typing**: Python 3.10+ union operators, 3.11+ Self type
- **Framework Support**: Django-stubs, Pydantic integration, async typing
- **Performance Optimization**: Incremental checking, caching, parallel processing
- **IDE Integration**: Real-time type checking feedback

---

#### `py:run-tests`
**Advanced Python testing with pytest, coverage, and framework integration**

```bash
# Run all tests with coverage
/py:run-tests --coverage

# Framework-specific testing
/py:run-tests --framework django --reuse-db
/py:run-tests --framework fastapi --async

# Performance and parallel execution
/py:run-tests --parallel --profile --show-slowest

# Selective test execution
/py:run-tests -k "user and not integration" --fast-only
```

**Features:**
- **Pytest Excellence**: Advanced test discovery, fixtures, parametrization
- **Coverage Analysis**: Comprehensive coverage reporting (HTML, XML, terminal)
- **Framework Testing**: Django TestCase, FastAPI TestClient, async testing
- **Performance Optimization**: Parallel execution, test profiling, selective running
- **Context7 Integration**: Testing pattern research and best practices

## 🔄 Development Workflows

### Complete Development Setup
```bash
# 1. Project analysis and context preparation
/project-prime

# 2. Environment setup with framework detection
/py:setup-environment my-api --framework fastapi

# 3. Add core dependencies with research
/py:add-dependency fastapi uvicorn pydantic sqlalchemy

# 4. Add development tools
/py:add-dependency --dev pytest httpx black ruff mypy

# 5. Complete quality pipeline
/py:format-code --setup
/py:type-check --setup --framework fastapi
/py:run-tests --setup-coverage
```

### Quality Assurance Pipeline
```bash
# Format code
/py:format-code --organize-imports

# Type checking
/py:type-check --strict

# Run tests with coverage
/py:run-tests --coverage --parallel

# Combined quality check
/py:format-code && /py:type-check && /py:run-tests --coverage
```

### Framework-Specific Workflows

#### Django Development
```bash
/project-prime --focus django
/py:setup-environment blog --framework django --database postgresql
/py:add-dependency django djangorestframework django-extensions
/py:add-dependency --dev pytest-django factory-boy django-debug-toolbar
/py:format-code --framework django
/py:type-check --setup --framework django
/py:run-tests --framework django --reuse-db
```

#### FastAPI Development  
```bash
/project-prime --focus fastapi --async-patterns
/py:setup-environment api --framework fastapi --async
/py:add-dependency fastapi uvicorn pydantic sqlalchemy
/py:add-dependency --dev httpx pytest-asyncio
/py:format-code --async-patterns
/py:type-check --setup --framework fastapi
/py:run-tests --framework fastapi --async
```

#### Data Science Workflow
```bash
/project-prime --focus datascience
/py:setup-environment analysis --framework datascience --jupyter
/py:add-dependency pandas numpy matplotlib seaborn jupyter
/py:add-dependency --dev pytest nbconvert
/py:format-code --line-length 100 --ignore-notebooks
/py:type-check --data-science-mode
/py:run-tests --ignore-notebooks --data-validation
```

## 🛠️ Installation and Setup

### Prerequisites
- Python 3.8+ (Python 3.11+ recommended for modern features)
- Claude Code installed and configured
- Git for version control

### Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd py_command_suite
   ```

2. Install UV package manager (if not already installed):
   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

3. Set up commands in Claude Code:
   ```bash
   # Commands are automatically available in Claude Code
   # Verify installation
   /py:list-commands
   ```

### First-Time Setup
```bash
# 1. Analyze your existing project
/project-prime

# 2. Set up your development environment
/py:setup-environment . --detect-framework

# 3. Install quality tools
/py:add-dependency --dev pytest black ruff mypy

# 4. Configure formatting and type checking
/py:format-code --setup
/py:type-check --setup
```

## 🔧 Configuration

### UV Integration
All commands prioritize UV package manager for:
- Faster dependency resolution
- Better dependency conflict handling  
- Modern Python packaging standards
- Virtual environment management

### Context7 Integration
Commands automatically research:
- Library documentation and best practices
- Framework-specific patterns
- Security considerations
- Performance optimization techniques

### Framework Detection
Automatic detection and optimization for:
- **Django**: Model patterns, admin setup, testing with pytest-django
- **FastAPI**: Async patterns, Pydantic integration, OpenAPI documentation
- **Flask**: Application factory, blueprints, testing patterns
- **Data Science**: Jupyter integration, pandas workflows, scientific stack

## 📚 Quick Reference

### Common Command Combinations
```bash
# New project setup
/project-prime && /py:setup-environment

# Add and format
/py:add-dependency requests && /py:format-code

# Quality pipeline
/py:format-code && /py:type-check && /py:run-tests

# Command management
/py:list-commands --search "django" && /py:show-command django-setup
```

### Troubleshooting

#### UV Installation Issues
```bash
# Alternative UV installation
pip install uv
# Or use the installer script
curl -LsSf https://astral.sh/uv/install.sh | sh
```

#### Command Not Found
```bash
# List available commands
/py:list-commands

# Show command details
/py:show-command command-name

# Verify Claude Code installation
claude --version
```

#### Virtual Environment Issues
```bash
# Reset environment
/py:setup-environment . --reset-environment

# Manual UV environment setup
uv venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
```

## 🚀 Advanced Features

### Agent Context Bundling
The Python Command Suite solves the critical "agents have ZERO project context" problem by creating rich context bundles:

```bash
# Prepare context for sub-agent work
/project-prime --prepare-agent-context python-pro

# Context bundle format delivered to sub-agents:
=== PYTHON PROJECT CONTEXT BUNDLE ===
Framework: FastAPI v0.100.0 | Python: 3.11 | Package Manager: UV
Key Libraries: fastapi, uvicorn, pydantic, sqlalchemy, pytest
Testing: pytest | Quality: ruff, mypy configured  
Architecture: async | Structure: src layout
Current Task Context: [specific context for the current task]
=== END CONTEXT BUNDLE ===
```

### Modern Python Integration
- **Python 3.11+ Features**: Union operators (`str | int`), Self type, enhanced error messages
- **Async Excellence**: Native async/await patterns, async testing, performance optimization
- **Type Safety**: Comprehensive type checking, modern typing patterns, IDE integration
- **Quality Standards**: Modern formatting (ruff), comprehensive testing (pytest), security scanning

### Performance Optimization
- **UV Speed**: 10-100x faster than pip for dependency resolution
- **Parallel Operations**: Type checking, testing, and formatting run efficiently
- **Caching**: Intelligent caching for faster subsequent operations
- **Incremental**: Smart incremental operations for large codebases

## 🤝 Contributing

### Adding New Commands
```bash
# Create new command using the command creator
/py:create-command your-command-name category

# Update existing commands
/py:update-command existing-command "Enhancement description"
```

### Best Practices
- Follow UV-first approach for all dependency management
- Integrate Context7 research for library recommendations
- Support framework-specific patterns (Django, FastAPI, Flask)
- Include comprehensive testing and type checking
- Maintain backward compatibility

## 📄 License

MIT License - see LICENSE file for details.

---

**The Python Command Suite transforms Python development in Claude Code with modern tooling, intelligent context sharing, and comprehensive workflow integration. Start with `/project-prime` to analyze your project and unlock the full potential of AI-assisted Python development.**