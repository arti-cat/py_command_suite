# Python Command Suite (PCS) Installation Guide

PCS transforms Claude Code into a Python-specialized development environment following IndyDevDan's **R&D Framework** principles.

## Quick Install

Deploy PCS to any Python project:

```bash
# From PCS directory
./deploy-pcs.sh /path/to/your/python/project

# Or deploy to current directory
./deploy-pcs.sh
```

## What Gets Installed

### 🤖 **Specialized Agents** (`.claude/agents/`)
- **orchestrator** - R&D planner/delegator with context discipline
- **coder** - TDD implementation specialist  
- **reviewer** - Security, performance, maintainability auditor
- **researcher** - Documentation gatherer and synthesizer
- **doc-scraper** - External docs fetcher (context isolation)
- **background-runner** - Long-task delegation manager

### ⚡ **Python Workflows** (`.claude/commands/`)
- `/uv-setup` - Initialize UV environment with best practices
- `/test` - Run pytest with coverage reporting
- `/lint` - Run ruff linting with project config
- `/format` - Auto-format with ruff
- `/package` - Build and validate packages
- `/git` - Git operations with commit templates
- `/prime-rd` - Context priming for R&D workflows

### 🛡️ **R&D Framework Hooks** (`.claude/hooks/`)
- **guardrails.json** - Prevents MCP bloat, enforces CLAUDE.md limits
- **context-bundles.json** - Session logging for context replay
- **limits.json** - File size warnings, delegation suggestions

### 🔧 **Python-Focused Configuration**
- **settings.local.json** - UV-first permissions, safety restrictions
- **CLAUDE.md** - Minimal memory file following R&D principles

## Requirements

- [Claude Code](https://claude.ai/code) installed and configured
- Python project (pyproject.toml, setup.py, or requirements.txt)
- [UV package manager](https://github.com/astral-sh/uv) (recommended)

## Usage

After installation:

```bash
cd your-python-project
claude

# Initialize environment
> /uv-setup

# Prime for focused work
> /prime-rd

# Use specialized agents
> use the coder agent to implement user authentication
> use the reviewer agent to audit security vulnerabilities

# Run workflows
> /test
> /lint  
> /format
```

## R&D Framework Benefits

Following IndyDevDan's context engineering principles:

### **Reduce** 🎯
- Slim CLAUDE.md files (hooks enforce <800 words)
- No default MCP server bloat
- Focused file access patterns
- Token-conscious operations

### **Delegate** 🚀  
- Specialized subagents for different tasks
- Background task delegation
- Context bundle replay system
- Multi-agent orchestration

## Customization

### Adding Custom Commands
```bash
# Project-specific commands
echo "Your custom Python workflow here" > .claude/commands/my-workflow.md

# Personal commands (all projects)  
echo "Your reusable command" > ~/.claude/commands/my-global-cmd.md
```

### Modifying Permissions
Edit `.claude/settings.local.json`:
```json
{
  "permissions": {
    "allow": [
      "Bash(uv *)",
      "Bash(pytest *)",
      "your-custom-pattern"
    ],
    "deny": [
      "Bash(rm -rf *)",
      "dangerous-pattern"
    ]
  }
}
```

### Hook Customization
Hooks use functional Claude Code syntax:
```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Read",
      "hooks": [{
        "type": "command",
        "command": "your-validation-script.sh"
      }]
    }]
  }
}
```

## Troubleshooting

### Hooks Not Working
- Ensure `jq` is installed: `brew install jq` / `apt install jq`
- Check hook syntax with: `jq . .claude/hooks/guardrails.json`

### UV Commands Failing
- Install UV: `curl -LsSf https://astral.sh/uv/install.sh | sh`
- Check UV path: `which uv`

### Agent Not Found
- Verify agent files: `ls .claude/agents/`
- Check YAML syntax: `head .claude/agents/coder.md`

## Examples

### Bug Fix Workflow
```bash
> /prime-rd
> use the researcher agent to investigate the auth bug in issue #123
> use the coder agent to implement the fix with tests
> use the reviewer agent to audit the security implications  
> /test
> /git
```

### Feature Implementation
```bash
> use the orchestrator agent to plan the payment integration feature
> use the background-runner agent to research Stripe API docs
> use the coder agent to implement payment processing
> /test
> /lint
> /format
```

## Philosophy

PCS embodies IndyDevDan's core insight: **"A focused agent is a performant agent."**

By enforcing context discipline and enabling effective delegation, PCS transforms Claude Code from a general assistant into a specialized Python development powerhouse.

**Context engineering is the name of the game** - PCS automates the discipline so you can focus on building.