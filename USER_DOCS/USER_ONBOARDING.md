# Python Command Suite (PCS) - User Onboarding

Welcome to **Python Command Suite** - your specialized Claude Code configuration for Python development excellence.

## What is PCS?

PCS transforms Claude Code into a Python-focused development environment by providing:
- **Specialized Python agents** for different development tasks
- **UV-first workflows** for modern Python package management
- **Integrated tooling** (pytest, ruff, mypy, etc.)
- **R&D Framework enforcement** for context discipline and efficiency

## Quick Start Tutorial

### Prerequisites
- Claude Code installed and running
- Python 3.8+ on your system
- Git repository (recommended)

### Installation

1. **Clone PCS to your Python project:**
```bash
# From your Python project root
git clone https://github.com/your-repo/py_command_suite .claude-config
cd .claude-config
```

2. **Verify PCS commands are available:**
```bash
# In Claude Code
/help
# Should show PCS commands: /uv-setup, /test, /lint, /format, etc.
```

### Your First PCS Session

Let's walk through a complete development session using PCS.

#### Scenario: Adding a new feature to a Python project

**Step 1: Project Setup**
```bash
# Initialize Python environment
/uv-setup
```
This command:
- Creates `uv.lock` if needed
- Installs dependencies
- Sets up development environment
- Configures testing framework

**Step 2: Development Planning**
```
Tell Claude: "I need to add user authentication with JWT tokens to my FastAPI project"
```

PCS will:
- Launch the **orchestrator agent** to break down the task
- Create a structured todo list
- Delegate research to the **researcher agent**
- Plan implementation phases

**Step 3: Research Phase**
The researcher agent will:
- Analyze your existing FastAPI structure
- Research JWT implementation patterns
- Check for existing auth-related code
- Document security requirements

**Step 4: Implementation Phase**
The coder agent will:
- Create auth models and schemas
- Implement JWT token handling
- Add authentication middleware
- Write comprehensive tests

**Step 5: Quality Assurance**
```bash
# Run complete quality check
/lint && /format && /test
```

**Step 6: Code Review**
The reviewer agent automatically:
- Reviews security implications
- Checks performance considerations
- Validates test coverage
- Suggests improvements

## Workflow Examples

### Example 1: Bug Investigation and Fix

**User:** "There's a memory leak in the data processing module"

**PCS Response:**
1. **Orchestrator** creates investigation plan
2. **Researcher** analyzes code patterns and memory usage
3. **Coder** implements fixes with proper resource cleanup
4. **Reviewer** validates fix and suggests optimizations
5. **Background testing** ensures no regressions

**Commands Used:**
```bash
/test --verbose  # Detailed test output
/lint --strict   # Enhanced linting
```

### Example 2: New Feature Development

**User:** "Add caching layer with Redis integration"

**PCS Workflow:**
1. **Research existing caching patterns** in codebase
2. **Plan Redis integration architecture**
3. **Implement cache decorators and utilities**
4. **Add comprehensive testing** including cache invalidation
5. **Performance benchmarking** and optimization
6. **Documentation and examples**

### Example 3: Refactoring Legacy Code

**User:** "Modernize the old sync database layer to async"

**PCS Approach:**
1. **Analyze current implementation** patterns
2. **Plan gradual migration strategy**
3. **Create async database utilities**
4. **Migrate endpoints incrementally**
5. **Maintain backward compatibility** during transition
6. **Performance validation** throughout process

## Common Pitfalls and Solutions

### Pitfall 1: Overwhelming Context
**Problem:** Feeding too much code context at once, causing agent confusion.

**Solution:** Use PCS's context discipline features:
```python
# Instead of: "Here's my entire 5000-line module, fix it"
# Do this: "Focus on the UserService class in services/user.py line 150-200"
```

**PCS Feature:** Automatic context windowing and focused file reading.

### Pitfall 2: Skipping Test Setup
**Problem:** Implementing features without proper test infrastructure.

**Solution:** Always start with `/uv-setup` and verify test framework:
```bash
/uv-setup
/test --dry-run  # Verify test discovery works
```

### Pitfall 3: Mixed Tool Versions
**Problem:** Using pip alongside UV, creating dependency conflicts.

**Solution:** PCS enforces UV-first approach:
- All dependencies through `pyproject.toml`
- UV lock file management
- Consistent environment across team

### Pitfall 4: Inadequate Code Review
**Problem:** Rushing to implementation without proper review.

**Solution:** Use PCS's automated review process:
```python
# PCS reviewer agent automatically checks:
# - Security implications
# - Performance considerations  
# - Code style consistency
# - Test coverage gaps
```

### Pitfall 5: Context Switching Overhead
**Problem:** Losing track of multi-step development tasks.

**Solution:** PCS maintains session continuity:
- Persistent todo tracking
- Agent specialization reduces context switching
- Background task delegation for long operations

### Pitfall 6: Configuration Drift
**Problem:** Team members using different development configurations.

**Solution:** PCS provides consistent, reproducible configs:
- Shared `.claude-config/` directory
- Version-controlled agent definitions
- Standardized command workflows

## Advanced Workflows

### Multi-Agent Development Session
```bash
# Launch parallel development streams
Tell Claude: "Run tests in background while I implement the feature"

# PCS will:
# 1. Launch background-runner agent for continuous testing
# 2. Keep coder agent focused on implementation  
# 3. Use reviewer agent for real-time code feedback
# 4. Coordinate between agents automatically
```

### Research-Heavy Tasks
```bash
# For complex technical decisions
Tell Claude: "Research the best approach for implementing distributed caching"

# PCS researcher agent will:
# - Analyze multiple technical approaches
# - Compare performance implications
# - Check compatibility with existing stack
# - Provide structured recommendation with examples
```

### Large Codebase Navigation
```bash
# For understanding complex systems
Tell Claude: "Help me understand the authentication flow in this Django project"

# PCS will:
# - Use doc-scraper agent to map auth-related files
# - Create visual flow documentation
# - Identify security patterns and potential issues
# - Generate navigation guides for the codebase
```

## Best Practices

### 1. Start with Structure
```bash
# Always begin sessions with clear structure
/uv-setup  # Environment consistency
Tell Claude your goal clearly and completely
```

### 2. Use Agent Specialization
```python
# Leverage specialized agents for better results
"Use the researcher agent to analyze this API integration"
"Have the reviewer focus on security implications"  
"Let the coder implement while tests run in background"
```

### 3. Maintain Context Discipline
```python
# Be specific about scope and focus
# Good: "Fix the validation logic in models/user.py lines 45-67"
# Bad: "Fix my user model" (too vague, requires full context scan)
```

### 4. Verify Continuously
```bash
# Use PCS's integrated quality gates
/lint    # After each significant change
/test    # Before moving to next feature
/format  # Before committing code
```

### 5. Document Decisions
```python
# PCS automatically maintains context through:
# - Structured todo tracking
# - Agent decision logs  
# - Implementation rationale capture
```

## Troubleshooting

### Command Not Found
```bash
# Verify PCS installation
ls .claude-config/
# Should show PCS configuration files

# Reload Claude Code configuration
# Restart Claude Code session
```

### Tests Not Running
```bash
# Check UV environment
/uv-setup --verbose
# Verify test discovery
/test --collect-only
```

### Agent Not Responding
```bash
# Check agent configuration
# Verify .claude-config/agents/ directory
# Restart session if needed
```

## Getting Help

- **Built-in Help:** `/help` for available commands
- **Context Help:** Ask Claude about specific PCS features
- **Debug Mode:** Add `--verbose` to commands for detailed output
- **Community:** Check PCS documentation and examples

## Next Steps

1. **Complete your first development session** using the walkthrough above
2. **Explore specialized agents** for different types of tasks
3. **Customize PCS configuration** for your team's specific needs
4. **Share feedback** to help improve PCS for the Python community

Welcome to more efficient, focused Python development with PCS!