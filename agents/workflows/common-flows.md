# R&D Framework - Common Development Workflows

## New Feature Development Flow
**Goal**: Implement new functionality following R&D Framework principles

1. **Prime & Plan**: `/prime-rd` → Use `orchestrator` agent for planning
2. **Setup Environment**: `/uv-setup` to ensure clean, deterministic dependencies
3. **Implement**: Use `coder` agent for focused implementation with TDD
4. **Quality Gates**: `/lint` → `/format` → `/types` → `/test`
5. **Security Check**: `/sec-audit` for dependency and code security
6. **Review**: Use `reviewer` agent for final quality assessment
7. **Package**: `/package` to build distributable artifacts

**Context Management**: Keep main agent focused on orchestration, delegate heavy work to specialized agents.

---

## Bug Fix Workflow  
**Goal**: Fix issues with minimal scope and regression prevention

1. **Prime for Bug Work**: `/prime-rd` for framework awareness
2. **Isolate Issue**: Use `coder` agent to reproduce and isolate the bug
3. **Minimal Fix**: Apply smallest safe change following single-responsibility principle
4. **Add Regression Test**: Ensure bug doesn't return
5. **Fast Validation**: `/test` with focused test pattern
6. **Quality Check**: `/lint` and `/format` for consistency

**R&D Principle**: Reduce scope to the specific issue, delegate analysis to focused agents.

---

## Documentation Sync Process
**Goal**: Update documentation without polluting main context

1. **Plan Documentation Needs**: Use `orchestrator` agent to identify doc gaps
2. **Delegate Web Scraping**: Use `doc-scraper` agent for external documentation
3. **Context Bundle Loading**: `/loadbundle` if continuing previous documentation work
4. **Focused Updates**: Update docs based on summarized information
5. **Quality Review**: Use `reviewer` agent for documentation quality

**Context Discipline**: Keep documentation gathering separate from main workflow context.

---

## Long-Running Task Delegation
**Goal**: Execute complex tasks without blocking main agent

1. **Background Delegation**: `/background "Generate comprehensive project analysis and refactoring plan"`
2. **Monitor Progress**: Check `agents/background/*/report.md` files periodically  
3. **Context Continuity**: Use `/loadbundle` to resume from background work
4. **Integration**: Use `orchestrator` agent to integrate background results

**Agentic Pattern**: True out-of-loop execution with independent background agents.

---

## Development Environment Refresh
**Goal**: Clean, deterministic environment setup

1. **Environment Setup**: `/uv-setup` for fresh virtual environment
2. **Dependency Audit**: `/sec-audit` to check for vulnerable dependencies
3. **Code Quality Baseline**: `/lint` → `/format` → `/types` → `/test`
4. **Package Health**: `/package` to ensure buildable artifacts

**Determinism Focus**: UV ensures reproducible environments across team members.

---

## Context Window Recovery
**Goal**: Continue work after context window explosion

1. **Context Bundle Analysis**: `/loadbundle path/to/recent/bundle.md`
2. **Re-prime Framework**: `/prime-rd` for fresh R&D context
3. **Resume Strategy**: Focus on continuation plan from bundle summary
4. **Targeted Delegation**: Use appropriate specialist agents based on work type

**Session Continuity**: Context bundles provide 60-70% recovery of previous agent state.

---

## First-Time User Onboarding
**Goal**: Get new users productive with R&D Framework

1. **Welcome & Setup**: `/onboard` for step-by-step guidance
2. **Framework Priming**: `/prime-rd` to understand core principles  
3. **Environment Validation**: `/uv-setup` and check for 90%+ free context
4. **Test Delegation**: Try simple task with each specialist agent
5. **Build First Workflow**: Combine commands for complete development cycle

**Learning Path**: Progress from simple slash commands to complex multi-agent workflows.

---

## Success Metrics for All Workflows

### Good R&D Framework Usage
- ✅ 90%+ context window free on startup
- ✅ Context packs under 6000 tokens each  
- ✅ Clear agent specialization and routing
- ✅ Successful task completion in single attempts
- ✅ Effective use of background delegation for heavy tasks

### Poor Context Engineering Signs
- ❌ Agents struggling with oversized context
- ❌ Multiple retry attempts due to confusion  
- ❌ Wasted tokens on irrelevant information
- ❌ Agents taking on multiple unfocused responsibilities
- ❌ Ignoring context budget and token consumption

Remember: **"A focused agent is a performant agent"** - The goal is one-shot, out-of-loop agent execution with focused, specialized agents.