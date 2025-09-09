---
description: Context-prime agent for Python project work (base|bug|feature|docs)
argument-hint: "[area] (optional: base|bug|feature|docs)"
allowed-tools: Read, Grep, Write
---

# Python Project Context Primer

Prime the agent minimally for {{area | default:"base"}} Python development work using R&D principles.

## Purpose

Establish focused project context (≤800 tokens total) for Python development without bloating the main context window. Delegate heavy analysis to specialized subagents.

## Read Phase (≤400 tokens summary)

I'll read only essential project files:

1. **Project Metadata** (≤150 tokens)
   - `pyproject.toml` - dependencies, scripts, package config
   - `README.md` - project purpose and setup instructions
   
2. **Code Structure** (≤150 tokens) 
   - `src/**/__init__.py` - module structure and docstrings only
   - Main package entry points and public interfaces
   
3. **Testing Setup** (≤100 tokens)
   - `tests/` - list test files, detect framework (pytest/unittest)
   - Test configuration and patterns

## Run Phase - Generate Context

I'll emit these focused summaries:

### Repo Fact Sheet (≤200 tokens)
- **Package**: Name, version, description
- **Dependencies**: Core deps (not dev/test deps)
- **Entry Points**: CLI commands, main modules
- **Test Framework**: pytest/unittest, coverage config
- **UV Integration**: Virtual env status, lock file present

### Risk Map (≤150 tokens)
- **I/O Operations**: File handling, network calls, external APIs
- **Secret Management**: Environment variables, config files
- **Large Files**: Any files >256KB that need careful handling
- **External Dependencies**: Services, databases, APIs

### Delegation Suggestions (≤150 tokens)
Based on {{area}}, suggest specialized agents for:
- **doc-scraper**: External library documentation
- **planner**: Complex implementation roadmaps  
- **background-runner**: Heavy analysis or long-running tasks

## Area-Specific Context

### Base (Default)
General Python development - code quality, dependencies, testing

### Bug  
Focus on test failures, error traces, debugging context

### Feature
Architecture analysis, integration points, implementation strategy

### Docs
Documentation structure, API surfaces, example code

## Output Format

```markdown
# {{PROJECT_NAME}} Context ({{area}})

## Repo Fact Sheet
- Package: {{name}} v{{version}}
- Framework: {{framework | default:"None detected"}}
- Test Framework: {{test_framework}}
- UV Status: {{uv_status}}

## Dependencies (Core)
{{core_deps}}

## Risk Map  
- I/O: {{io_risks}}
- Secrets: {{secret_risks}}
- Large Files: {{large_files}}

## Suggested Subagents
{{subagent_suggestions}}

## Ready for: {{area}} development
```

## Best Practices

### Context Management
- Keep all summaries concise - prefer bullets over paragraphs
- Never inline full file contents - summarize only
- Focus on actionable information for the specified area
- Suggest delegation for context-heavy operations

### Python-Specific
- Prioritize UV package manager usage (`uv add`, `uv run`)
- Identify framework patterns (Django, FastAPI, Flask)
- Note async/sync patterns and type hint usage
- Check for common Python project files (setup.py, requirements.txt)

### Subagent Integration
- Suggest `doc-scraper` for external API/library research
- Suggest `planner` for complex architectural decisions
- Suggest `background-runner` for lengthy analysis tasks

I'll adapt the priming based on your project's structure and the specified area focus, keeping the total context addition ≤800 tokens to maintain agent performance.