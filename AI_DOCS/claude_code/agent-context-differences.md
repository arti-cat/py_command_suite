# Claude Code: Main Agent vs Subagent Context Differences

## Overview

Based on Claude Code documentation and project requirements, there are critical differences in how main agents and subagents receive and process context information. Understanding these differences is essential for effective delegation and task management.

## Key Distinction: User Prompts vs System Prompts

### Main Agent Context Model
- **Input Method**: User prompts and conversation history
- **Context Sources**: 
  - CLAUDE.md file content (project-wide instructions)
  - Memory files and project documentation
  - Conversation history and previous interactions
  - Direct access to project files and structure
- **Prompt Type**: User prompts that build conversational context
- **Context Retention**: Maintains full conversation history and project awareness

### Subagent Context Model
- **Input Method**: System prompts and delegated instructions
- **Context Sources**:
  - System prompt defined in agent configuration (YAML frontmatter)
  - Delegated context from main agent
  - Limited access to project files (tool-dependent)
- **Prompt Type**: System prompts that define role and behavior
- **Context Retention**: **ZERO project context unless explicitly provided by main agent**

## The Critical Gap

As noted in the project CLAUDE.md:

> "Agents differ in a key way as they are interacted with by the main claude agent, meaning agents have ZERO project context unless the main agent has a way to prime it."

This creates a fundamental challenge:
- **Main Agent**: Rich project understanding through CLAUDE.md and memory files
- **Subagent**: Isolated system prompt with no inherent project awareness
- **Result**: Context loss during delegation

## Context Transfer Mechanisms

### 1. System Prompt Configuration
**Location**: `.claude/agents/agent-name.md`

```markdown
---
name: python-pro
description: Expert Python developer for clean, performant code
tools: Read, Write, Edit, MultiEdit, Grep, Glob, Bash
model: sonnet
---

# Python Pro

**Role**: Senior-level Python expert...
[System prompt content defines behavior but lacks project context]
```

### 2. Delegation Context Passing
**Main Agent Responsibility**: Include relevant project context when delegating

**Poor Delegation Example**:
```
> Use the python-pro subagent to optimize this code
```

**Effective Delegation Example**:
```
> Use the python-pro subagent to optimize this FastAPI code. 
> Context: This is a Python 3.11 project using UV package manager, 
> pytest for testing, and following PEP 8 standards. The code is 
> part of a user authentication module that processes JWT tokens.
```

### 3. Priming Commands Solution
**Purpose**: Bridge the context gap by providing project-specific information to both main agent and subagents

**Implementation**: Commands like `/project_prime` that:
- Analyze project structure and configuration
- Extract key project information (frameworks, versions, patterns)
- Provide context that can be passed to subagents during delegation

## Practical Implications

### For Command Design
1. **Main Agent Commands**: Can assume project context availability
2. **Subagent Instructions**: Must include context or request it explicitly
3. **Delegation Commands**: Should include project-specific context transfer

### For Agent Configuration
1. **System Prompts**: Focus on role definition, not project specifics
2. **Tool Access**: Configure based on agent's intended responsibilities
3. **Context Requirements**: Document what context each agent needs

### For Project Priming
1. **CLAUDE.md**: Provides context to main agent only
2. **Priming Commands**: Bridge context to subagents through delegation
3. **Context Caching**: Store frequently needed project info for delegation

## Best Practices

### 1. Context-Aware Delegation
Always include relevant project context when delegating to subagents:

```markdown
# Good Delegation Pattern
Use the [agent-name] subagent with this context:
- Project: [project-type] using [framework] [version]
- Package Manager: [uv/pip/poetry]
- Testing: [pytest/unittest] setup
- Standards: [PEP 8/specific style guide]
- Task-specific context: [relevant details]
```

### 2. Priming Command Usage
Use project priming commands to establish shared context:

1. Run `/project_prime` at session start
2. Include key findings in subagent delegations
3. Reference established project patterns

### 3. Subagent Design Principles
When creating subagents:

1. **Focus on Role**: System prompt defines expertise and behavior
2. **Assume No Context**: Don't assume project-specific knowledge
3. **Tool Configuration**: Provide tools needed for context discovery
4. **Documentation**: Clearly state what context the agent needs

## Context Transfer Examples

### Effective Context Transfer
```markdown
> Use the python-pro subagent to refactor this authentication module.
> 
> Project Context:
> - Python 3.11 FastAPI application
> - UV package manager for dependencies  
> - JWT-based authentication using python-jose
> - SQLAlchemy ORM with async sessions
> - pytest with >90% coverage requirement
> - Code follows PEP 8 with black formatting
> - Type hints required (mypy strict mode)
```

### Ineffective Context Transfer
```markdown
> Use the python-pro subagent to refactor this code.
[No project context provided - subagent lacks critical information]
```

## Implementation Strategy

### Phase 1: Context Documentation
- Document project-specific patterns and requirements
- Create standardized context templates for common delegations
- Establish context requirements for each subagent

### Phase 2: Priming Commands
- Implement `/project_prime` for comprehensive project analysis
- Create context extraction and formatting utilities
- Develop delegation templates with context inclusion

### Phase 3: Enhanced Delegation
- Modify delegation patterns to include context transfer
- Create context-aware subagent invocation helpers
- Implement context validation for critical delegations

## Conclusion

The fundamental difference between main agent and subagent context models requires deliberate context transfer mechanisms. The main agent's rich project awareness through CLAUDE.md and memory files contrasts sharply with subagents' system prompt-only context. Effective delegation requires explicit context transfer, making priming commands and context-aware delegation patterns essential for successful multi-agent workflows.

Success depends on:
1. **Recognition**: Understanding that subagents have zero inherent project context
2. **Preparation**: Using priming commands to establish shared context
3. **Delegation**: Including relevant project context in subagent instructions
4. **Design**: Creating context-aware commands and delegation patterns