---
description: Load prior context bundle to replay key session state
argument-hint: "path/to/bundle.md"
allowed-tools: Read
---

# Context Bundle Loader

Load and replay prior agent session context without bloating the current context window.

## Purpose

Restore agent understanding from previous sessions by efficiently replaying key operations and decisions, enabling complex task continuation across context window boundaries.

## Task

I'll load the context bundle from {{path}} and create a focused replay of the previous agent's state.

## Process

### 1. Bundle Analysis (≤300 tokens)
I'll read and analyze the context bundle:
- **Session Overview**: Original objectives and scope
- **Key Operations**: Critical read/write/bash operations performed
- **Artifacts Created**: Files written and their purposes
- **Decision Points**: Important choices and reasoning

### 2. Operation Deduplication
I'll consolidate redundant operations:
- **Unique Reads**: Remove duplicate file reads, keep final state
- **Write Sequence**: Track file creation and modification order
- **Command Patterns**: Identify repeated operations and their outcomes

### 3. State Reconstruction Summary (≤400 tokens)

**Context Summary Format:**
```markdown
# Session Replay: {{bundle_id}}

## Original Objective
{{primary_task_description}}

## Key Accomplishments
- {{major_outcome_1}}
- {{major_outcome_2}}  
- {{major_outcome_3}}

## Current State
**Files Modified**: {{file_list}}
**Configuration Changes**: {{config_changes}}
**Environment Setup**: {{env_state}}

## Knowledge Gained
{{important_insights_or_patterns_discovered}}

## Remaining Tasks
{{unfinished_work_or_next_steps}}
```

### 4. Generate Replay Plan (≤200 tokens)

**Replay Plan (≤10 steps):**
```markdown
## Continuation Plan

1. **{{step_1}}** - {{action_description}}
2. **{{step_2}}** - {{action_description}}
3. **{{step_3}}** - {{action_description}}
4. **{{step_4}}** - {{action_description}}
5. **{{step_5}}** - {{action_description}}
6. **{{step_6}}** - {{action_description}}
7. **{{step_7}}** - {{action_description}}
8. **{{step_8}}** - {{action_description}}
9. **{{step_9}}** - {{action_description}}
10. **{{step_10}}** - {{action_description}}
```

## Bundle Analysis Strategy

### Context Bundle Structure
Context bundles typically contain:
```markdown
## Session: timestamp
**Prompt:** Original user request

### Operations:
- READ file_path
- WRITE file_path  
- BASH command
- TASK description (agent_type)
```

### Critical Information Extraction
- **Primary Intent**: What was the agent trying to accomplish?
- **Progress Made**: Which objectives were completed?
- **Knowledge Acquired**: What did the agent learn about the codebase?
- **Blockers Encountered**: What challenges or limitations were found?

### Operation Prioritization
1. **High Priority**: Operations that changed system state
2. **Medium Priority**: Operations that provided critical insights
3. **Low Priority**: Exploratory operations with no lasting impact

## Deduplication Rules

### File Operations
- **Multiple Reads**: Keep only the last read of each file
- **Read-Write Cycles**: Track the progression of file modifications
- **Temporary Files**: Exclude operations on temporary or cache files

### Command Operations
- **Repeated Commands**: Summarize patterns rather than listing duplicates
- **Failed Commands**: Note failures but focus on successful operations
- **Environment Setup**: Consolidate setup operations into current state

### Agent Interactions
- **Subagent Calls**: Summarize subagent outcomes rather than full interaction
- **Task Delegation**: Focus on results achieved rather than process details

## Replay Scenarios

### Complex Feature Implementation
```markdown
# Feature Development Replay

## Original Objective
Implement user authentication system with JWT tokens

## Key Accomplishments  
- Created User model with password hashing
- Implemented JWT token generation and validation
- Added login/logout endpoints with proper error handling
- Created comprehensive test suite with 95% coverage

## Current State
**Files Modified**: 
- src/models/user.py (created)
- src/auth/jwt_handler.py (created)  
- src/api/auth_routes.py (created)
- tests/test_auth.py (created)

## Continuation Plan
1. **Add password reset functionality** - Email integration
2. **Implement role-based permissions** - Admin/user roles
3. **Add rate limiting** - Prevent brute force attacks
```

### Bug Investigation Replay
```markdown
# Bug Investigation Replay

## Original Objective
Fix memory leak in data processing pipeline

## Key Accomplishments
- Identified memory leak in file processing loop
- Found issue with unclosed file handles in error cases
- Implemented proper context manager usage
- Added memory monitoring to test suite

## Current State
**Files Modified**:
- src/processing/pipeline.py (fixed)
- tests/test_pipeline.py (enhanced)

## Continuation Plan
1. **Deploy fix to staging** - Validate memory usage
2. **Monitor production metrics** - Confirm leak resolution
3. **Add memory profiling** - Prevent future regressions
```

## Context Efficiency

### Token Conservation
- **Summarize, Don't Replay**: Focus on outcomes, not detailed steps
- **Deduplicate Aggressively**: Remove redundant information
- **Prioritize Context**: Include only decision-relevant information

### Knowledge Transfer
- **Pattern Recognition**: Identify useful patterns discovered
- **Constraint Awareness**: Note discovered limitations or requirements  
- **Decision Rationale**: Preserve reasoning behind key choices

## Integration with Current Session

### Contextual Awareness
After loading a bundle, I'll have understanding of:
- **Project Structure**: Layout and organization patterns
- **Code Conventions**: Style and architectural patterns used
- **Test Strategies**: Testing approaches and coverage expectations
- **Deployment Patterns**: How the project handles releases

### Continuation Strategy
- **Build on Previous Work**: Extend rather than recreate
- **Maintain Consistency**: Follow established patterns and decisions
- **Respect Constraints**: Honor previously discovered limitations

## Usage Examples

### Load Recent Development Session
```bash
/loadbundle agents/context-bundles/session-2024-01-15-14-session-abc123.md
```

### Continue Feature Implementation
```bash
# After loading bundle showing partial authentication implementation
# Agent now understands current auth system state and can continue
```

### Resume Bug Investigation  
```bash
# After loading bundle from debugging session
# Agent has context of investigation progress and next steps
```

I'll efficiently replay the previous agent's context, providing focused understanding for seamless task continuation.