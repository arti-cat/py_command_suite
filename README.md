# Python Command Suite for Claude Code

**Context Engineering for Python Development with R&D Framework Implementation**

A comprehensive suite implementing advanced context engineering principles from the IDD transcript, featuring modern Python tooling with UV package manager integration, specialized agent delegation, and session continuity.

## 🎯 Overview

The Python Command Suite provides a context-engineered development workflow following the **R&D Framework** (Reduce & Delegate) for optimal Claude Code performance. It maintains minimal context windows while enabling powerful multi-agent delegation and session continuity for complex Python development tasks.

### Key Features

- **🧠 R&D Context Engineering**: 90%+ free context startup, intelligent delegation, session replay
- **🚀 UV-Native Workflow**: Modern package management with `uv venv`, `uv sync`, `uvx` tooling
- **🤖 Multi-Agent Delegation**: Specialized subagents and background primary agents
- **📦 Session Continuity**: Context bundles enable task resumption across sessions
- **⚡ Quality Automation**: Integrated ruff, mypy, pytest with automatic hooks
- **🔧 Framework Intelligence**: Django, FastAPI, Flask detection and optimization

## 🚀 Quick Start

```bash
# 1. Prime your Python project context (≤800 tokens)
/prime base

# 2. Set up UV development environment  
/uv-setup

# 3. Quality assurance pipeline
/lint && /types && /test

# 4. For complex tasks - delegate to background agent
/background "Generate comprehensive API documentation with examples"
```

## 📋 Context Engineering Commands

### 🧠 Context Priming System

| Command | Purpose | Context Impact |
|---------|---------|----------------|
| [`/prime`](#prime) | Python project context setup | ≤800 tokens total |
| [`/prime-bug`](#prime-bug) | Bug hunting focused context | ≤500 tokens total |

### 🔧 Development Workflow

| Command | Purpose | UV Integration |
|---------|---------|----------------|
| [`/uv-setup`](#uv-setup) | Idempotent environment setup | `uv venv`, `uv sync`, `uv lock` |
| [`/test`](#test) | Fast, deterministic testing | `uv run pytest` with coverage |
| [`/lint`](#lint) | Code quality with ruff | `uvx ruff check --fix` |
| [`/types`](#types) | Strict type checking | `uvx mypy --strict` |

### 🤖 Agent Delegation System

| Command/Agent | Purpose | Delegation Strategy |
|---------------|---------|-------------------|
| [`planner`](#planner-agent) | Task planning with subagent briefs | Creates focused delegation plans |
| [`implementer`](#implementer-agent) | Small code changes with testing | ≤200 lines per file |
| [`/loadbundle`](#loadbundle) | Session context replay | Deduplicated operation history |
| [`/background`](#background) | Primary multi-agent delegation | Independent Claude Code instances |

### 🛡️ Context Engineering Enforcement

| System | Purpose | R&D Implementation |
|--------|---------|-------------------|
| **Guardrails** | Block wasteful operations | No default MCP, UV-only Python ops |
| **Context Bundles** | Session tracking & replay | Automatic Read/Write/Bash logging |
| **Minimal Memory** | Essential context only | 350 tokens vs 20K+ bloat |

## 📖 Detailed Command Documentation

### Context Priming Commands

#### `/prime [area]`
**Context-prime agent for Python project work with minimal token usage**

```bash
# General Python development context
/prime base        

# Feature development focus
/prime feature     

# Bug hunting context
/prime bug

# Documentation focus  
/prime docs
```

**Features:**
- **Token Efficient**: ≤800 tokens total context addition
- **Framework Detection**: Automatic Django, FastAPI, Flask identification
- **Risk Assessment**: I/O operations, secrets, large files analysis
- **Delegation Suggestions**: Recommends specialized agents for heavy work

---

#### `/prime-bug`
**Focused bug hunting context with minimal reads**

```bash
# Target bug investigation context
/prime-bug
```

**Features:**
- **Ultra Focused**: ≤500 tokens context addition
- **Failure Analysis**: Error traces, failing tests, target modules only
- **Hypothesis Generation**: Root cause theories and fix strategies
- **Minimal Reproduction**: Single-file test creation

### Development Workflow Commands

#### `/uv-setup`
**Idempotent Python environment setup with UV package manager**

```bash
# Complete environment setup
/uv-setup
```

**Features:**
- **UV-Native**: `uv venv`, `uv lock`, `uv sync` workflow
- **Idempotent Operations**: Safe to run multiple times
- **Environment Validation**: Python version and dependency verification
- **Comprehensive Reporting**: Setup status written to `agents/reports/`

---

#### `/test`
**Fast, deterministic testing with coverage analysis**

```bash
# Run optimized test suite
/test
```

**Features:**
- **Fast Feedback**: `--maxfail=1` stops on first failure
- **Deterministic**: `--random-order-seed=0` for reproducible results  
- **Coverage Integration**: Built-in coverage reporting
- **Failure Analysis**: Detailed failure reports in `agents/reports/`

---

#### `/lint`
**Code quality enforcement with Ruff integration**

```bash
# Comprehensive linting and formatting
/lint
```

**Features:**
- **Modern Tooling**: Ruff for 10x faster linting than traditional tools
- **Auto-fix**: `uvx ruff check --fix` applies safe corrections
- **Formatting**: `uvx ruff format` for consistent code style
- **Configuration**: Integration with `pyproject.toml` settings

---

#### `/types`
**Strict type checking with MyPy**

```bash
# Comprehensive type analysis
/types
```

**Features:**
- **Strict Mode**: `uvx mypy --strict` for maximum type safety
- **Framework Support**: Django-stubs, async patterns, modern typing
- **Incremental**: Caching for faster subsequent runs
- **Error Analysis**: Detailed type error reporting and suggestions

### Agent Delegation System

#### `/loadbundle <path>`
**Load prior context bundle to replay session state**

```bash
# Resume previous development session
/loadbundle agents/context-bundles/session-2024-09-09-14-abc123.md
```

**Features:**
- **Session Continuity**: Resume complex tasks across context limits
- **Operation Deduplication**: Smart filtering of redundant operations
- **Context Reconstruction**: ≤1000 tokens for previous session state
- **Continuation Planning**: Generates ≤10 step plan for next actions

---

#### `/background <purpose>`
**Launch independent Claude Code instance for heavy tasks**

```bash
# Delegate complex analysis to background agent
/background "Generate comprehensive API documentation with examples"
```

**Features:**
- **Context Isolation**: Heavy work doesn't affect main context window
- **Progress Reporting**: Real-time updates to `agents/background/<id>/report.md`
- **Independent Processing**: Can spawn its own subagents
- **Parallel Execution**: Multiple background tasks simultaneously

### Specialized Agents

#### `planner` Agent
**Task planning with subagent delegation briefs**

```bash
# Create focused implementation plan
planner
```

**Features:**
- **Minimal Plans**: ≤500 token focused plans with clear steps
- **Subagent Briefs**: Creates delegation instructions for heavy work
- **Risk Assessment**: Identifies high/medium/low risk areas
- **Rollback Strategies**: Plans for safe implementation reversal

---

#### `implementer` Agent  
**Code implementation with comprehensive testing**

```bash
# Execute code changes with testing
implementer
```

**Features:**
- **Small Changes**: ≤200 lines per file modification
- **Type Safety**: Complete type annotations for all new code
- **Testing Integration**: Tests accompany all new functionality
- **Quality Standards**: Follows Python best practices and patterns

## 🔄 Development Workflows

### Context-Engineered Development Setup
```bash
# 1. Prime project context (≤800 tokens)
/prime base

# 2. Environment setup
/uv-setup

# 3. Quality pipeline
/lint && /types && /test
```

### Feature Development Workflow
```bash
# 1. Feature-focused context
/prime feature

# 2. Planning with delegation
planner

# 3. Implementation  
implementer

# 4. Quality validation
/lint && /types && /test
```

### Complex Task Delegation
```bash
# 1. Delegate heavy analysis to background
/background "Analyze codebase for performance bottlenecks and create optimization report"

# 2. Monitor progress (optional)
tail -f agents/background/*/report.md

# 3. Load results when complete
/loadbundle agents/context-bundles/session-*-background-*.md
```

### Session Continuity Workflow
```bash
# 1. Work on complex task until context limit
/prime feature
planner
# ... complex work continues until context fills

# 2. Context bundle automatically created
# agents/context-bundles/session-2024-09-09-14-abc123.md

# 3. New session - resume work
/loadbundle agents/context-bundles/session-2024-09-09-14-abc123.md
# Continue where left off
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
# 1. Prime your Python project context
/prime base

# 2. Set up development environment
/uv-setup

# 3. Run quality pipeline to validate setup
/lint && /types && /test
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
/prime base && /uv-setup

# Quality pipeline
/lint && /types && /test

# Feature development  
/prime feature && planner && implementer

# Complex task delegation
/background "task description" && /loadbundle path/to/results
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
# Verify Claude Code installation
claude --version

# Check .claude directory structure
ls -la .claude/commands/ .claude/agents/
```

#### Virtual Environment Issues
```bash
# Reset environment
rm -rf .venv uv.lock
/uv-setup

# Manual UV environment setup
uv venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
```

## 🚀 Advanced Features

### R&D Context Engineering
The Python Command Suite implements advanced context engineering following the R&D (Reduce & Delegate) framework:

**Reduce Context Pollution:**
- Minimal memory files (350 tokens vs 20K+ potential bloat)
- Focused context priming instead of large static files
- Guardrails prevent wasteful operations

**Delegate Heavy Work:**
- Specialized subagents for focused tasks
- Background primary agents for complex analysis
- Session continuity via context bundles

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
New commands should be created by directly editing files in `.claude/commands/` following the established patterns and markdown format used by existing commands.

### Best Practices
- Follow UV-first approach for all dependency management
- Integrate Context7 research for library recommendations
- Support framework-specific patterns (Django, FastAPI, Flask)
- Include comprehensive testing and type checking
- Maintain backward compatibility

## 📄 License

MIT License - see LICENSE file for details.

---

**The Python Command Suite implements advanced context engineering for Python development in Claude Code. Start with `/prime base` to establish focused project context and experience the benefits of the R&D framework for scalable, efficient AI-assisted development.**