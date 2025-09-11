# Python Command Suite - Project Definition & Scope

## What PCS Actually Is

**Python Command Suite (PCS)** is a **Configuration Framework** that transforms Claude Code into a specialized Python development environment following IndyDevDan's R&D Framework principles.

### Core Understanding
- **Claude Code** = The executable engine (agents, tools, commands, hooks infrastructure)
- **PCS** = The Python-specialized configuration layer that makes Claude Code powerful for Python development
- **Our Role** = Configuration architects, not engine builders

## What We Are NOT Building

❌ **Not a standalone executable tool** - Claude Code already provides this  
❌ **Not reimplementing agents/commands/hooks** - Claude Code handles execution  
❌ **Not competing with Claude Code** - We enhance and specialize it  
❌ **Not educational templates** - We're building functional configurations  

## What We ARE Building

✅ **Configuration Framework** that makes Claude Code Python-specialized  
✅ **R&D Framework Implementation** through Claude Code's native patterns  
✅ **Python Development Workflows** via commands, agents, and hooks  
✅ **Context Engineering System** that enforces focused, performant agents  

## Architecture Understanding

### Claude Code Provides (Infrastructure Layer)
- **Agent Execution Engine** - Runs `.claude/agents/*.md` as subagents
- **Command Processor** - Executes `.claude/commands/*.md` as slash commands  
- **Hook System** - Executes `.claude/hooks/*.json` configurations at runtime
- **Tool Integration** - Read, Write, Bash, WebFetch, MCP servers, etc.
- **Permission System** - Enforces `.claude/settings.json` policies
- **Session Management** - Context windows, memory, transcripts

### PCS Provides (Configuration Layer)  
- **Python-Specialized Agents** - orchestrator, coder, reviewer, researcher, etc.
- **UV-First Commands** - `/uv-setup`, `/test`, `/lint`, `/format`, `/types`, etc.
- **R&D Framework Hooks** - guardrails.json, context-bundles.json, limits.json
- **Context Engineering Policies** - permissions.json, routing.json, limits.json
- **Python Workflow Integration** - pytest, ruff, mypy, security scanning
- **Background Delegation Patterns** - Multi-agent orchestration configs

## Project Scope Boundaries

### In Scope - Configuration & Integration
1. **Agent Definitions** - YAML frontmatter system prompts for Python specialists
2. **Command Specifications** - Markdown files with Python workflow instructions
3. **Hook Configurations** - JSON files that execute at Claude Code runtime
4. **Policy Files** - Permission and routing configurations
5. **Integration Scripts** - Helper scripts Claude Code calls (when needed)
6. **Installation Templates** - Easy deployment to any Python project
7. **Documentation** - How to use PCS with Claude Code

### Out of Scope - Engine Implementation  
1. **Agent Execution** - Claude Code handles subagent spawning/communication
2. **Command Processing** - Claude Code parses and executes slash commands
3. **Hook Runtime** - Claude Code executes hook configurations
4. **Tool Implementation** - Claude Code provides Read/Write/Bash/etc.
5. **Permission Enforcement** - Claude Code enforces our policies
6. **Context Management** - Claude Code handles memory and sessions

## Success Criteria

### What Success Looks Like
1. **Install PCS template** → Instant Python-specialized Claude Code environment
2. **Run `/uv-setup`** → Claude Code executes UV environment initialization  
3. **Use `coder` agent** → Claude Code spawns Python-specialized subagent
4. **Context discipline enforced** → Hooks prevent bloat, maintain R&D Framework
5. **Background delegation works** → Multi-agent workflows execute autonomously  
6. **Python ecosystem integration** → Seamless pytest/ruff/mypy/packaging workflows

### What Failure Looks Like
1. **Manual interpretation required** → Configurations don't work with Claude Code
2. **Generic workflows** → No Python specialization added
3. **Context bloat** → R&D Framework principles not enforced
4. **Single-agent limitation** → No multi-agent orchestration capability
5. **Tool conflicts** → Poor integration with Python ecosystem

## Relationship to Source Materials

### IndyDevDan's R&D Framework
- **Reduce** → Implemented via hooks (limits.json, guardrails.json)
- **Delegate** → Implemented via specialized agents and background commands
- **Context Engineering** → Enforced through policies and agent design
- **Multi-Agent Systems** → Configured through routing.json and agent coordination

### Claude Code Documentation  
- **Native Patterns** → We follow exact YAML/JSON/Markdown formats
- **Tool Integration** → We configure, Claude Code executes
- **Permission System** → We define policies, Claude Code enforces
- **Hook System** → We provide JSON, Claude Code runs commands

### chat.md Implementation
- **Workflow Commands** → We provide Python-specialized versions
- **Agent Ecosystem** → We adapt patterns for Python development
- **Hook Integration** → We implement functional versions of their examples

## PCS Maintainer Role

As **PCS Maintainer**, I:

### Primary Responsibilities
1. **Maintain Configuration Quality** - Ensure all configs work perfectly with Claude Code
2. **Python Ecosystem Integration** - Keep PCS current with Python tooling evolution
3. **R&D Framework Compliance** - Enforce context engineering principles  
4. **Template Distribution** - Easy installation and updates across projects
5. **Documentation Accuracy** - Clear guidance for PCS users

### Not My Responsibilities  
1. **Claude Code Feature Development** - That's Anthropic's domain
2. **Python Tool Development** - We integrate existing tools (pytest, ruff, etc.)
3. **Individual Project Features** - PCS users handle their app-specific work
4. **Claude Code Bug Fixes** - Users report to Anthropic, not PCS

## Implementation Strategy

### Phase 1: Core Configuration Framework
- **Functional Hooks** - JSON configurations that actually execute
- **Python Commands** - Working slash commands for Python workflows
- **Agent Integration** - Subagents that work seamlessly with Claude Code
- **Policy Enforcement** - Runtime R&D Framework compliance

### Phase 2: Advanced Orchestration
- **Background Delegation** - Multi-agent coordination patterns  
- **Context Management** - Session continuity and bundle systems
- **Python Ecosystem** - Deep integration with UV, pytest, ruff, mypy
- **Quality Gates** - Automated workflows for Python development

### Phase 3: Community & Ecosystem
- **Template Refinement** - Based on real-world usage feedback
- **Extension Patterns** - How others can build on PCS foundation  
- **Best Practices** - Guidance from successful PCS deployments
- **Compatibility Matrix** - Support across Python/UV/tool versions

## Metrics for Success

### Installation Success
- ✅ `install_claude.sh` creates working PCS environment in <5 minutes
- ✅ All commands immediately available in Claude Code
- ✅ Hooks execute properly on first use
- ✅ Agents spawn correctly when called

### Functional Success  
- ✅ `/uv-setup` successfully initializes Python environment
- ✅ `/test` runs pytest with proper configuration
- ✅ Context discipline maintained (>90% free context on startup)
- ✅ Multi-agent workflows complete without manual intervention

### Integration Success
- ✅ Python ecosystem tools work seamlessly
- ✅ R&D Framework principles enforced automatically
- ✅ No conflicts with existing Claude Code functionality
- ✅ Clear upgrade path for PCS improvements

---

## Summary

**Python Command Suite is a Configuration Framework that makes Claude Code incredibly powerful for Python development by providing specialized agents, commands, hooks, and policies that implement IndyDevDan's R&D Framework principles.**

We configure. Claude Code executes. Python developers benefit from focused, performant, multi-agent development environments.

**A focused agent is a performant agent - and PCS makes Claude Code agents focused on Python excellence.**