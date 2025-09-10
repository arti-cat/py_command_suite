# Python Command Suite - Context Engineering Essentials

## R&D Framework (Always Apply)
- **Reduce**: Read only necessary files; summarize aggressively; keep context lean
- **Delegate**: Push heavy work to subagents or background primary agents

## Core Principles
- UV package manager for all Python operations (`uv add`, `uv run`, `uv sync`)
- Context priming via `/prime` commands instead of large memory files
- Subagents for web scraping, documentation, and heavy analysis
- Background primary agents for long-running tasks
- Write artifacts to files, not chat - keep replies concise

## Project Structure
- `.claude/agents/` - Specialized subagents for delegation
- `.claude/commands/` - Context priming and development commands  
- `.claude/hooks/` - Automation and guardrails
- `agents/context-bundles/` - Session replay data
- `agents/background/` - Background task reports

## Quality Gates
- All Python files: `uvx ruff format` + syntax validation on write
- Focus reads on: `src/`, `tests/`, `pyproject.toml`, `README.md`
- Delegate context-heavy work: documentation scraping, large file analysis

**A focused agent is a performant agent.**