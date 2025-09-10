# Getting Started with Python Command Suite Context Engineering

## Quick Overview

The Python Command Suite implements advanced context engineering following the **R&D Framework** (Reduce & Delegate) to maximize Claude Code performance while maintaining powerful development capabilities.

## Core Principle: R&D Framework

- **Reduce**: Keep context windows minimal and focused
- **Delegate**: Push heavy work to specialized agents

## Step 1: Understanding Your New Context-Engineered Environment

### What Changed
✅ **Minimal Memory**: `.claude/claude.md` is now 350 tokens (vs potential 20K+ bloat)  
✅ **Smart Guardrails**: Blocks wasteful operations automatically  
✅ **Session Tracking**: Context bundles enable task resumption  
✅ **Agent Delegation**: Heavy work runs in specialized subagents  

### Context Window Health Check
```bash
# Check your context efficiency (should show 90%+ free)
/context
```

## Step 2: Basic Workflow - Context Priming

### Replace Large Memory Files with Targeted Priming
**OLD APPROACH** (Context Bloat):
- Large `CLAUDE.md` files with everything
- Manual context management
- Context window pollution

**NEW APPROACH** (Context Engineering):
```bash
# Prime context for your specific task (≤800 tokens total)
/prime base        # General Python development
/prime feature     # Feature development focus  
/prime bug         # Bug hunting focus
/prime docs        # Documentation focus
```

### What Priming Does
- Reads only essential project files
- Creates focused summaries (≤800 tokens)
- Suggests specialized agents for heavy work
- Maintains clean context boundaries

## Step 3: Development Workflow with UV Integration

### Environment Setup
```bash
# One-command environment setup with UV
/uv-setup

# This creates:
# - .venv/ virtual environment
# - uv.lock dependency lock file  
# - Development environment report
```

### Quality Assurance Pipeline
```bash
# Run the integrated quality pipeline
/lint              # Ruff formatting and linting
/types             # MyPy strict type checking
/test              # Pytest with coverage

# Or run all together
/lint && /types && /test
```

## Step 4: Agent Delegation for Heavy Tasks

### When to Use Subagents
- **Planning**: Complex implementation strategy
- **Implementation**: Code changes with testing
- **Documentation**: External library research
- **Analysis**: Large codebase investigation

### Subagent Workflow Example
```bash
# 1. Use planner for complex tasks
# The planner creates subagent briefs automatically
planner

# 2. Delegate implementation to implementer
implementer

# 3. For very heavy tasks, use background delegation
/background "Generate comprehensive test suite with 95% coverage"
```

## Step 5: Session Continuity with Context Bundles

### Understanding Context Bundles
Context bundles automatically track your session:
```markdown
## Session: 2024-09-09_14:30
**Prompt:** Implement user authentication system

### Operations:
- READ src/models/user.py
- WRITE src/auth/jwt_handler.py  
- BASH uv add pyjwt
- TASK Create test suite (implementer)
```

### Resume Previous Work
```bash
# List available context bundles
ls agents/context-bundles/

# Load previous session context
/loadbundle agents/context-bundles/session-2024-09-09-14-abc123.md
```

## Step 6: Advanced Delegation Patterns

### Background Primary Agent Delegation
For tasks that would consume significant context:
```bash
# Launch independent Claude Code instance
/background "Analyze entire codebase for security vulnerabilities and create comprehensive report"

# Monitor progress
tail -f agents/background/20240909_143022_a7b8c9d2/report.md

# Load results when complete
/loadbundle agents/context-bundles/session-09-background-20240909_143022.md
```

### Hierarchical Delegation
Background agents can spawn their own subagents:
```bash
/background "Create complete FastAPI application with authentication, database, tests, and documentation"

# Background agent coordinates:
# - planner for strategy
# - implementer for code  
# - doc-scraper for research
# - All independently managed
```

## Example: Complete Feature Development

### Scenario: Add User Authentication to FastAPI App

#### Traditional Approach (Context Bloat)
- Read entire codebase into context
- Manual research on authentication patterns
- Implement in single large session
- Risk context window overflow

#### Context Engineering Approach
```bash
# 1. Prime for feature work (≤800 tokens)
/prime feature

# 2. Plan with delegation (creates subagent briefs)
planner

# 3. Set up environment
/uv-setup

# 4. Heavy research delegated to background
/background "Research FastAPI authentication patterns and JWT implementation best practices"

# 5. Load research results  
/loadbundle agents/context-bundles/session-09-background-research.md

# 6. Implementation by specialized agent
implementer

# 7. Quality pipeline
/lint && /types && /test

# 8. Session automatically tracked for future continuation
```

## Common Patterns and Workflows

### New Project Setup
```bash
/prime base              # Understand project structure
/uv-setup               # Environment setup  
/lint && /types && /test # Quality baseline
```

### Bug Investigation
```bash
/prime-bug              # Focus on failure context
# Investigation and fix by fixer agent
/test                   # Validate fix
```

### Complex Feature Development
```bash
/prime feature          # Feature development context
planner                 # Create implementation plan
/background "Phase 1"   # Heavy analysis/research
/loadbundle <results>   # Load research results
implementer             # Core implementation
/lint && /types && /test # Quality gates
```

### Code Refactoring
```bash
/prime base             # Current code understanding
planner                 # Refactoring strategy
implementer             # Execute refactoring
/test                   # Ensure functionality preserved
```

## Troubleshooting

### Context Window Issues
```bash
# Check context usage
/context

# If context is bloated, restart and use priming
/prime base  # Instead of reading everything manually
```

### UV Environment Issues
```bash
# Reset environment
rm -rf .venv uv.lock
/uv-setup
```

### Session Continuity Issues
```bash
# List available bundles
ls agents/context-bundles/

# Load specific session
/loadbundle agents/context-bundles/session-[timestamp].md
```

## Benefits You'll Experience

### Context Efficiency
- **90%+ free context** on startup
- **Focused context** for each task type
- **No context bloat** from unused information

### Development Speed
- **Fast environment setup** with UV
- **Automated quality gates** via hooks
- **Parallel processing** with agent delegation

### Task Scalability  
- **Complex tasks** handled via background delegation
- **Session continuity** enables multi-day development
- **Specialized expertise** from focused agents

### Quality Assurance
- **Automatic formatting** on file writes
- **Integrated testing** with coverage reporting
- **Type safety** with strict MyPy checking

## Next Steps

1. **Start with priming**: Use `/prime base` for your current project
2. **Try the quality pipeline**: Run `/lint && /types && /test`  
3. **Experiment with delegation**: Use `planner` for a complex task
4. **Test session continuity**: Create a context bundle and reload it

The context engineering approach will feel different initially but provides significantly better performance and scalability for complex Python development tasks.