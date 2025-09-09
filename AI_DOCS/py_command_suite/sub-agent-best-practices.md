# Sub-Agent Best Practices - Intermediate Context Engineering (I2)

*Extracted from IDD Context Engineering transcript - Proper sub-agent usage for context delegation*

## 🎯 **The Intermediate Challenge: Use Sub-Agents PROPERLY**

> **"Now it's not just about using sub-agents. This is about using sub-agents properly."**

Sub-agents represent the **D** (Delegate) principle in the R&D framework - delegating specialized work to isolated context windows while keeping your primary agent focused.

## 🔧 **Core Sub-Agent Architecture**

### **Partially Forked Context Windows**
When you use Claude Code sub-agents, you're creating a **partially forked context window**:

```
Primary Agent Context:
├── Main conversation history
├── Project context and memory
└── Sub-Agent Spawning → Isolated Context
                        ├── Specialized system prompt  
                        ├── Minimal tool access
                        └── Task-specific focus
```

### **Critical Difference: System vs User Prompts**

| **Primary Agent** | **Sub-Agent** |
|------------------|---------------|
| User prompts | System prompts |
| 900 tokens for complex instructions | 122 tokens for same functionality |
| Full conversation context | Isolated task context |
| All tools available | Minimal necessary tools |

> **"There's a massive difference between the system prompt and a user prompt... This is a system prompt, which is nice because it means that it's not directly added to our primary agent's context window."**

## 📊 **Token Economics: The Sub-Agent Advantage**

### **Context Window Savings**
```
Primary Agent Instruction:
- User Prompt: 900 tokens
- Context Pollution: Added to main conversation
- Tool Access: Everything available
- Focus: Diluted across many concerns

Sub-Agent Delegation:
- System Prompt: 122 tokens  
- Context Isolation: Separate window
- Tool Access: Specialized minimal set
- Focus: Single-purpose expertise
```

**Savings**: 778 tokens per delegation + context isolation benefits

### **Delegation Multiplier Effect**
```
Single Complex Task Breakdown:
- Primary handles: 1 main instruction (900 tokens)
- Sub-agent 1: Environment setup (122 tokens)
- Sub-agent 2: Dependency management (122 tokens)  
- Sub-agent 3: Code formatting (122 tokens)
- Sub-agent 4: Testing setup (122 tokens)

Total: 900 + 488 = 1,388 tokens
vs. Single Agent: 3,600+ tokens for equivalent work
```

## 🎯 **Sub-Agent Design Principles**

### **1. Focused Agent = Performant Agent**
> **"A focused agent is a performant agent. Sub-agents are also a little trickier... because you have to isolate the work that your sub-agents are doing into one concise prompt to one focused effort."**

**Good Sub-Agent Purpose**:
- ✅ Set up Python development environment with UV
- ✅ Format Python code with ruff and black  
- ✅ Generate comprehensive pytest test suite
- ✅ Research library documentation with Context7

**Bad Sub-Agent Purpose**:
- ❌ Handle all Python development tasks
- ❌ Manage project and also format code and also test
- ❌ Generic programming assistant
- ❌ Multi-purpose development helper

### **2. Minimal Tool Access**
Sub-agents should have **only** the tools necessary for their specific task:

```markdown
# python-environment-specialist.md
tools: Read, Write, Edit, Bash, mcp__context7__resolve-library-id

# python-code-formatter.md  
tools: Read, Write, Edit, Bash

# python-testing-expert.md
tools: Read, Write, Edit, Bash, Grep, Glob

# python-research-specialist.md
tools: Read, mcp__context7__resolve-library-id, mcp__context7__get-library-docs
```

### **3. Clear Information Flow**
> **"The flow of information in these multi-agent systems is critical. Your primary agent is prompting your sub-agents and your sub-agents are responding not to you but back to your primary agent."**

```
Information Flow Pattern:
User Request → Primary Agent → Sub-Agent → Primary Agent → User Response

Example:
"Set up FastAPI project" → Primary Agent Analysis → 
python-environment-specialist → Environment Report →
Primary Agent → "Environment ready, next steps..."
```

## 🚀 **Python Sub-Agent Implementation**

### **Sub-Agent Specialization Matrix**

| Sub-Agent | System Prompt Focus | Tools | Input | Output |
|-----------|-------------------|-------|--------|--------|
| `python-environment-specialist` | UV environment setup | Read, Write, Edit, Bash, Context7 | Project requirements | Environment ready |
| `python-dependency-manager` | Package management | Read, Edit, Bash, Context7 | Library needs | Dependencies installed |
| `python-code-formatter` | Code formatting | Read, Write, Edit, Bash | Code files | Formatted code |
| `python-type-checker` | Type analysis | Read, Edit, Bash | Python files | Type issues fixed |
| `python-testing-expert` | Test generation | Read, Write, Edit, Bash, Grep | Code to test | Test suite |
| `python-research-specialist` | Documentation research | Read, Context7 | Library queries | Research reports |

### **Example Sub-Agent Implementation**
```markdown
---
name: python-environment-specialist
description: Expert Python environment setup specialist focused solely on UV-based environment creation and configuration. Use when environment setup is needed.
tools: Read, Write, Edit, Bash, mcp__context7__resolve-library-id, mcp__context7__get-library-docs
model: sonnet
---

# Python Environment Specialist

You are a specialized agent focused exclusively on Python development environment setup using UV package manager.

## Single Responsibility
Create and configure Python development environments with:
- UV virtual environment creation
- Python version management  
- Basic dependency structure
- Framework-specific setup (Django/FastAPI/Flask)

## Process
1. Analyze project requirements from context
2. Research optimal environment configuration with Context7
3. Create UV-based virtual environment
4. Configure basic project structure
5. Report environment status to primary agent

## Constraints
- ONLY handle environment setup
- Do NOT manage dependencies (delegate to python-dependency-manager)
- Do NOT format code (delegate to python-code-formatter)  
- ONLY report success/issues back to primary agent
```

## ⚡ **Advanced Sub-Agent Patterns**

### **Sequential Delegation Chain**
```
Primary Agent Workflow:
1. "Set up complete FastAPI project"
2. → python-environment-specialist (environment)
3. → python-dependency-manager (packages) 
4. → python-code-formatter (code style)
5. → python-type-checker (type safety)
6. → python-testing-expert (test suite)
7. ← Consolidated report to user
```

### **Parallel Sub-Agent Execution**  
```
Primary Agent Workflow:
1. "Analyze existing Python project"
2. Spawn simultaneously:
   ├── python-code-formatter (style analysis)
   ├── python-type-checker (type analysis)  
   ├── python-testing-expert (test coverage)
   └── python-research-specialist (library updates)
3. Aggregate all reports
4. Present unified analysis to user
```

### **Conditional Sub-Agent Activation**
```markdown
## Primary Agent Logic
IF Django detected:
  → django-specialist sub-agent
IF FastAPI detected:  
  → fastapi-specialist sub-agent
IF Security issues found:
  → python-security-auditor sub-agent
IF Performance issues detected:
  → python-performance-optimizer sub-agent
```

## 🔄 **Context Bundle Integration**

### **Sub-Agent Context Preparation**
Before delegating to sub-agents, primary agent creates context bundles:

```
=== PYTHON PROJECT CONTEXT BUNDLE ===
Framework: FastAPI v0.100.0 | Python: 3.11 | Package Manager: UV
Key Libraries: fastapi, uvicorn, pydantic, sqlalchemy, pytest
Testing: pytest | Quality: ruff, mypy configured
Architecture: async | Structure: src layout
Current Task: Environment setup for new FastAPI project
=== END CONTEXT BUNDLE ===
```

### **Sub-Agent Response Pattern**
```markdown
## Sub-Agent Report Format
### Task Completion Status
✅ Environment created successfully

### Work Performed
- Created UV virtual environment (.venv)
- Installed Python 3.11
- Set up FastAPI project structure
- Configured basic pyproject.toml

### Next Steps Recommendations  
- Ready for python-dependency-manager to install packages
- Suggest python-code-formatter for initial code style setup

### Issues/Blockers
None - environment ready for development
```

## 🚨 **Sub-Agent Readiness Assessment**

### **When You're Ready for Sub-Agents**
> **"If you're losing track of a single agent, right, and you have a bunch of wasted context, you probably aren't yet ready for sub-agents."**

**Prerequisites**:
- ✅ Clean context management with single primary agent
- ✅ Understanding of task breakdown and specialization
- ✅ Ability to track multiple agent states simultaneously
- ✅ Clear mental model of information flow patterns

**Warning Signs You're Not Ready**:
- ❌ Primary agent context is messy and unfocused
- ❌ Difficulty managing single agent workflows  
- ❌ Unclear task boundaries and responsibilities
- ❌ Context window frequently overloaded

### **Progression Path**
1. **Master single agent** context management first
2. **Practice task breakdown** into focused components
3. **Understand delegation patterns** and information flow
4. **Start with simple sub-agents** for isolated tasks
5. **Graduate to complex workflows** with multiple sub-agents

## 🔧 **Implementation Best Practices**

### **Sub-Agent Creation Guidelines**
1. **Single Purpose**: Each sub-agent does ONE thing extremely well
2. **Minimal Tools**: Only tools necessary for the specific task
3. **Clear Boundaries**: Explicit about what sub-agent will/won't do
4. **Context Efficient**: System prompts under 200 tokens when possible
5. **Reporting Standards**: Consistent output format for primary agent

### **Primary Agent Responsibilities**
1. **Task Analysis**: Break complex requests into sub-agent tasks
2. **Context Bundling**: Prepare relevant context for each sub-agent  
3. **Delegation Coordination**: Manage sub-agent execution order
4. **Result Aggregation**: Combine sub-agent outputs into user response
5. **Error Handling**: Manage sub-agent failures and retries

### **Common Sub-Agent Anti-Patterns**
- ❌ **Swiss Army Knife**: Sub-agent that does too many things
- ❌ **Context Bloat**: System prompts that are too long/complex
- ❌ **Tool Overload**: Giving sub-agents more tools than needed
- ❌ **Unclear Purpose**: Vague or multi-purpose sub-agent goals
- ❌ **Poor Isolation**: Sub-agents that interfere with each other

## 📊 **Success Metrics**

### **Sub-Agent Effectiveness**
- **Context Savings**: 70%+ reduction in primary agent context usage
- **Task Focus**: Single-purpose agents complete tasks 90%+ faster
- **Error Rate**: Specialized agents have lower error rates
- **Scalability**: Can handle 5+ parallel sub-agents without confusion

### **Delegation Quality**  
- **Clear Handoffs**: Sub-agents understand task from context bundle
- **Complete Results**: Sub-agents provide actionable outputs
- **No Context Leakage**: Sub-agent work doesn't pollute primary context
- **Proper Reporting**: Primary agent can integrate sub-agent results

---

**Key Takeaway**: Sub-agents are powerful for the **D** (Delegate) aspect of R&D framework, but require proper implementation with focused purposes, minimal tools, and clear information flow. Master single agent context management before progressing to sub-agent delegation.

*This technique enables complex Python development workflows while keeping the primary agent focused and the context window clean through specialized delegation.*