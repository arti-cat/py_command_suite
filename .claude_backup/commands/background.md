---
description: Launch background primary agent for long tasks with progress reporting
argument-hint: "purpose sentence"
allowed-tools: Bash, Write
---

# Background Primary Agent Delegation

Launch independent Claude Code instance for heavy tasks, freeing up main context window while maintaining progress visibility.

## Purpose

Enable primary multi-agent delegation by spawning background Claude Code instances that work independently and report progress, implementing the highest level of the R&D framework's delegation strategy.

## Task

I'll launch a background primary agent for: {{purpose}}

This delegates the entire task off the main context window while providing progress monitoring.

## Process

### 1. Create Background Task Environment
```bash
# Generate unique task identifier
TASK_ID=$(date +%Y%m%d_%H%M%S)_$(uuidgen | cut -c1-8)

# Create task directory structure
mkdir -p "agents/background/${TASK_ID}"
```

### 2. Initialize Progress Reporting
I'll create the progress report file:
```markdown
# Background Task: {{purpose}}

**Task ID**: {{task_id}}
**Started**: {{timestamp}}  
**Status**: INITIALIZING

## Objective
{{detailed_purpose_description}}

## Progress Log
{{timestamp}} - Task initiated
{{timestamp}} - Background agent starting
```

### 3. Launch Background Claude Code Instance
```bash
# Launch background Claude Code with focused prompt
claude --background --report-file "agents/background/${TASK_ID}/report.md" << 'EOF'
{{purpose}}

Context: You are a background primary agent working independently. 

Your task: {{purpose}}

Rules:
1. Work autonomously - don't wait for user input
2. Update report file regularly with progress
3. Use R&D principles: Reduce context, Delegate to subagents when needed
4. Write final results to files, not just chat
5. Complete the task or reach clear completion/blocking point

When complete, update report status to COMPLETED or BLOCKED with summary.
EOF
```

### 4. Monitor and Report
I'll provide immediate feedback:
```markdown
## Background Task Launched ✓

**Task ID**: {{task_id}}
**Purpose**: {{purpose}}
**Report File**: `agents/background/{{task_id}}/report.md`
**Context Bundle**: `agents/context-bundles/session-{{date_hour}}-background-{{task_id}}.md`

## Monitoring
```bash
# Monitor progress
tail -f agents/background/{{task_id}}/report.md

# Load results when complete
/loadbundle agents/context-bundles/session-{{date_hour}}-background-{{task_id}}.md
```

## Background Task Categories

### Heavy Analysis Tasks
```bash
/background "Analyze entire codebase for security vulnerabilities and performance bottlenecks"

# Background agent will:
# - Scan all source files systematically
# - Run security analysis tools
# - Generate comprehensive report
# - Not consume main context window
```

### Complex Implementation Projects
```bash
/background "Implement complete REST API with authentication, validation, and comprehensive test suite"

# Background agent will:
# - Plan implementation strategy
# - Create all necessary files
# - Implement comprehensive testing
# - Report progress continuously
```

### Documentation Generation
```bash
/background "Generate complete API documentation and usage examples from codebase"

# Background agent will:
# - Analyze public interfaces
# - Generate documentation files
# - Create usage examples
# - Format for publication
```

### Long-Running Quality Assurance
```bash
/background "Run comprehensive quality analysis: tests, coverage, types, security, and performance"

# Background agent will:
# - Execute full test suite
# - Generate coverage reports
# - Run type checking
# - Perform security audit
# - Create quality dashboard
```

## Progress Report Structure

### Report File Format
```markdown
# Background Task: {{task_title}}

**Task ID**: {{unique_identifier}}
**Started**: {{start_timestamp}}
**Status**: {{current_status}}
**Progress**: {{completion_percentage}}%

## Objective
{{detailed_task_description}}

## Progress Log
{{timestamp}} - {{progress_update_1}}
{{timestamp}} - {{progress_update_2}}
{{timestamp}} - {{progress_update_3}}

## Current Phase
{{current_work_description}}

## Artifacts Created
- {{file_1}}: {{purpose}}
- {{file_2}}: {{purpose}}
- {{file_3}}: {{purpose}}

## Next Steps
{{planned_next_actions}}

## Blockers/Issues
{{any_obstacles_encountered}}

## Final Results
{{completion_summary_when_done}}
```

### Status Types
- **INITIALIZING**: Setting up task environment
- **PLANNING**: Creating implementation strategy  
- **WORKING**: Actively implementing/analyzing
- **TESTING**: Validating results
- **COMPLETING**: Finalizing outputs
- **COMPLETED**: Task successfully finished
- **BLOCKED**: Cannot proceed, needs intervention

## Context Engineering Benefits

### Main Context Window Freedom
- **Zero Context Consumption**: Background task doesn't affect main agent
- **Parallel Processing**: Multiple tasks can run simultaneously
- **Clean Separation**: Each task has isolated context and state

### Delegation Efficiency
- **Full Task Autonomy**: Background agent handles entire workflow
- **Comprehensive Reporting**: Progress visible without context pollution
- **Result Integration**: Easy to load results via context bundles

## Task Management

### Multiple Background Tasks
```bash
# Launch multiple independent tasks
/background "Generate comprehensive test suite for authentication module"
/background "Analyze performance bottlenecks in data processing pipeline" 
/background "Create deployment automation scripts and documentation"

# Each runs independently with separate reporting
```

### Task Monitoring
```bash
# List active background tasks
ls -la agents/background/

# Monitor specific task
tail -f agents/background/20240909_143022_a7b8c9d2/report.md

# Check all task statuses
grep "Status:" agents/background/*/report.md
```

### Task Integration
```bash
# Load completed task results
/loadbundle agents/context-bundles/session-09-background-20240909_143022.md

# Continue where background task left off
# Main agent now has context of background work without the processing overhead
```

## Advanced Delegation Patterns

### Hierarchical Delegation
```bash
# Background agent can spawn its own subagents
/background "Create comprehensive Python package with CLI, API, tests, and documentation"

# Background agent will:
# - Use planner agent for strategy
# - Use implementer agent for code
# - Use doc-scraper for external research  
# - Coordinate all work independently
```

### Pipeline Processing
```bash
# Chain background tasks
/background "Phase 1: Analyze requirements and create implementation plan"
# Wait for completion, then:
/loadbundle agents/context-bundles/session-09-background-phase1.md
/background "Phase 2: Implement core functionality based on Phase 1 plan"
```

## Error Handling

### Background Agent Failures
- **Timeout Handling**: Background agents have time limits
- **Error Recovery**: Failures are logged in report files
- **Partial Results**: Intermediate work is preserved even on failure

### Resource Management
- **Context Limits**: Background agents can hit their own context limits
- **File System**: All work is persisted to files for recovery
- **Process Isolation**: Failed background tasks don't affect main agent

## Best Practices

### When to Use Background Agents
- **Heavy Analysis**: Large codebase analysis, comprehensive audits
- **Complex Implementation**: Multi-file features requiring planning
- **Long-Running Tasks**: Tasks taking >5 minutes of concentrated work
- **Independent Work**: Tasks with minimal back-and-forth requirements

### Task Scoping
- **Clear Objectives**: Provide specific, measurable goals
- **Autonomous Work**: Background agents can't ask for clarification
- **Result Focus**: Emphasize final outputs and deliverables
- **Context Boundaries**: Define scope to prevent unbounded exploration

### Integration Strategy
- **Progress Monitoring**: Check reports regularly during development
- **Result Loading**: Use loadbundle to integrate completed work
- **Iterative Refinement**: Use background agents for major phases

I'll launch the background primary agent and provide you with monitoring information for this delegated task.