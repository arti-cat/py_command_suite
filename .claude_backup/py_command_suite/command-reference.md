# Python Command Suite - Command Reference

## Available Commands and Agents

Based on actual implementation in `.claude/` directory.

## Context Priming Commands

### `/prime [area]`
**Location**: `.claude/commands/prime.md`  
**Purpose**: Context-prime agent for Python project work (base|bug|feature|docs)  
**Context Impact**: ≤800 tokens total  
**Tools**: Read, Grep, Write

```bash
/prime base        # General Python development context
/prime feature     # Feature development focus
/prime bug         # Bug hunting focus  
/prime docs        # Documentation focus
```

**Output**: Repo fact sheet, risk map, suggested subagents

### `/prime-bug`
**Location**: `.claude/commands/prime-bug.md`  
**Purpose**: Minimal priming for bug hunting and error investigation  
**Context Impact**: ≤500 tokens total  
**Tools**: Read, Grep

```bash
/prime-bug         # Focus on failure context and minimal reproduction
```

**Output**: Failure hypothesis, reproduction plan, fix strategy

## Development Workflow Commands

### `/uv-setup`
**Location**: `.claude/commands/uv-setup.md`  
**Purpose**: Create/refresh Python environment with UV - idempotent and deterministic  
**Tools**: Bash, Read, Write

```bash
/uv-setup          # Complete UV environment setup
```

**Operations**:
- `uv venv .venv` (create virtual environment)
- `uv lock` (generate dependency lock)
- `uv sync` (install dependencies)
- Environment validation and reporting

### `/test`
**Location**: `.claude/commands/test.md`  
**Purpose**: Run fast, deterministic tests with coverage reporting  
**Tools**: Bash, Write, Read

```bash
/test              # Fast test execution with coverage
```

**Features**:
- `uv run pytest -q --maxfail=1 -k "not slow" --random-order --random-order-seed=0 --cov`
- Failure analysis and reporting
- Coverage analysis and HTML reports

### `/lint`
**Location**: `.claude/commands/lint.md`  
**Purpose**: Code quality enforcement with Ruff linting and formatting  
**Tools**: Bash

```bash
/lint              # Comprehensive linting and formatting
```

**Operations**:
- `uvx ruff check --fix .` (linting with auto-fix)
- `uvx ruff format .` (code formatting)
- Configuration integration via `pyproject.toml`

### `/types`
**Location**: `.claude/commands/types.md`  
**Purpose**: Strict type checking with MyPy for enhanced code reliability  
**Tools**: Bash

```bash
/types             # Comprehensive static type analysis
```

**Features**:
- `uvx mypy --strict src tests`
- Incremental analysis and caching
- Framework-specific integration (Django, FastAPI)

## Context Management Commands

### `/loadbundle <path>`
**Location**: `.claude/commands/loadbundle.md`  
**Purpose**: Load prior context bundle to replay key session state  
**Tools**: Read

```bash
/loadbundle agents/context-bundles/session-2024-09-09-14-abc123.md
```

**Features**:
- Operation deduplication and analysis
- State reconstruction summary  
- Continuation plan generation (≤10 steps)

### `/background <purpose>`
**Location**: `.claude/commands/background.md`  
**Purpose**: Launch background primary agent for long tasks with progress reporting  
**Tools**: Bash, Write

```bash
/background "Generate comprehensive API documentation with examples"
```

**Features**:
- Independent Claude Code instance spawning
- Progress reporting to `agents/background/<id>/report.md`
- Task isolation and parallel processing

## Specialized Agents

### `planner`
**Location**: `.claude/agents/planner.md`  
**Purpose**: Minimal, testable planning with subagent delegation briefs and rollback strategies  
**Tools**: Read, Grep, Write

**Capabilities**:
- Creates focused plans (≤500 tokens)
- Generates subagent briefs for delegation
- Risk assessment and rollback planning
- Outputs plans to `agents/plans/<timestamp>.md`

### `implementer`
**Location**: `.claude/agents/implementer.md`  
**Purpose**: Small, reviewable code changes with single-responsibility focus and comprehensive testing  
**Tools**: Read, Write, Grep

**Standards**:
- ≤200 lines per file modification
- Complete type annotations
- Comprehensive testing alongside code
- Single-responsibility principle enforcement

## Legacy Commands (Available but Deprecated)

### `/py-update-command`
**Location**: `.claude/commands/py-update-command.md`  
**Purpose**: Update and modify existing Python development commands  
**Status**: Legacy command from pre-R&D implementation
**Note**: Use direct editing of command files instead

## Directory Structure Reference

```
.claude/
├── claude.md                 # Minimal memory file (350 tokens)
├── agents/                   # Specialized agents
│   ├── planner.md           # Task planning and delegation
│   └── implementer.md       # Code implementation with testing
├── commands/                 # Development commands
│   ├── prime.md             # Base context priming
│   ├── prime-bug.md         # Bug hunting context
│   ├── uv-setup.md          # Environment management
│   ├── test.md              # Testing with coverage
│   ├── lint.md              # Code quality with ruff
│   ├── types.md             # Type checking with mypy
│   ├── loadbundle.md        # Context replay
│   ├── background.md        # Multi-agent delegation
│   └── py-update-command.md # Legacy command updater
└── hooks/                   # Context engineering automation
    ├── guardrails.json      # Context engineering enforcement
    └── context-bundles.json # Session tracking

agents/                      # Context management directories
├── background/              # Background task reports
├── context-bundles/         # Session replay data
├── plans/                   # Planning outputs
└── reports/                 # Command execution reports
```

## Command Integration Patterns

### Basic Development Workflow
```bash
/prime base               # Set project context
/uv-setup                # Environment setup
/lint && /types && /test  # Quality pipeline
```

### Feature Development Workflow
```bash
/prime feature            # Feature-focused context
planner                   # Create implementation plan
implementer               # Execute implementation
/lint && /types && /test  # Quality validation
```

### Bug Investigation Workflow
```bash
/prime-bug               # Focus on failure context
# Manual investigation or fixer agent usage
/test                    # Validate fix
```

### Complex Task Delegation
```bash
/background "Complex multi-step task description"
# Monitor: tail -f agents/background/<id>/report.md
/loadbundle agents/context-bundles/session-*-background-*.md
```

### Session Continuation
```bash
# List available context bundles
ls agents/context-bundles/

# Load previous session
/loadbundle agents/context-bundles/session-<timestamp>.md

# Continue work where left off
```

## Hook System Integration

### Automatic Context Bundles
All operations automatically logged to:
`agents/context-bundles/session-${DATE_HOUR}-${SESSION_ID}.md`

Tracked operations:
- READ operations with file paths
- WRITE operations with file paths  
- BASH commands (truncated to 80 chars)
- TASK delegations with agent types

### Quality Automation
All Python files automatically formatted and validated on write:
- `uvx ruff format ${FILE}`
- Python syntax compilation check

### Context Engineering Guardrails
Automatic enforcement of:
- No default MCP server loading
- File size limits for reads
- UV-only Python package operations
- Focused read path restrictions

## Usage Notes

### Context Efficiency
- All commands designed for minimal context consumption
- Priming commands replace large memory files
- Agent delegation isolates heavy work

### UV Integration  
- All Python operations use UV package manager
- Commands assume UV is available and configured
- Fallback patterns included for UV installation issues

### Session Management
- Context bundles enable cross-session continuity
- Background tasks can run independently
- Agent delegation prevents context window overflow

### Quality Assurance
- Integrated quality pipeline with `/lint && /types && /test`
- Automatic formatting and validation via hooks
- Coverage reporting and failure analysis included

This reference covers all implemented commands and agents in the actual `.claude/` directory structure.