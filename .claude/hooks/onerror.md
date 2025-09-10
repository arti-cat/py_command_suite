---
name: onerror
on: OnError
description: Implements retry ladder and graceful error handling
---

# On Error Hook

This hook executes when any tool operation fails, implementing a sophisticated retry ladder and error recovery system.

## Retry Ladder Strategy

When an operation fails, try these recovery steps in order:

### 1. Shrink Scope
Reduce the complexity or size of the failed operation:
- **Large file operations**: Process in smaller chunks
- **Complex tasks**: Break into atomic subtasks  
- **Context overload**: Reduce context pack size
- **Resource limits**: Lower token/time budgets

### 2. Add Missing Context
Provide additional information that might resolve the failure:
- **Missing documentation**: Fetch relevant API docs or examples
- **Unclear requirements**: Add more detailed acceptance criteria
- **Missing dependencies**: Install or configure required tools
- **Permission issues**: Adjust write roots or tool permissions

### 3. Switch Agent
Route the task to a different specialist:
- **Coder blocked**: Try researcher for more context, then retry
- **Reviewer blocked**: Switch to orchestrator for task decomposition
- **Research failed**: Use coder to examine local files instead
- **Orchestrator blocked**: Escalate to human intervention

### 4. Fail Cleanly
If all recovery attempts fail, create a detailed report:
- **Root cause analysis**: What specifically failed and why
- **Context preservation**: Save partial work and investigation results  
- **Escalation path**: Clear next steps for human intervention
- **Learning opportunity**: Update policies to prevent similar failures

## Error Classification

### Recoverable Errors
**Resource Limits:**
- Token budget exceeded → Shrink context, retry with smaller scope
- Time timeout → Break into smaller tasks, increase time limits
- Memory/size limits → Process in chunks, reduce batch sizes

**Context Issues:**
- Missing information → Fetch docs, add context snippets
- Unclear requirements → Add acceptance criteria, examples
- Ambiguous tasks → Decompose into specific subtasks

**Tool Failures:**
- Network timeouts → Retry with backoff, use cached fallbacks
- File permission errors → Adjust write root, check permissions
- Command not found → Install dependencies, use alternatives

### Non-Recoverable Errors  
**System Issues:**
- Disk space exhaustion → Escalate to human
- Network completely unavailable → Escalate to human  
- Critical system failures → Escalate to human

**Security Violations:**
- Attempting to access forbidden files → Block and escalate
- Privilege escalation attempts → Block and escalate
- Data exfiltration attempts → Block and escalate

## Hook Implementation

```bash
#!/usr/bin/env bash
# Error handling and retry logic

INPUT=$(cat)
ERROR_TYPE=$(echo "$INPUT" | jq -r '.error_type')
ERROR_MESSAGE=$(echo "$INPUT" | jq -r '.error_message')
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')
TASK_ID=$(echo "$INPUT" | jq -r '.task_id // "unknown"')
RETRY_COUNT=$(echo "$INPUT" | jq -r '.retry_count // 0')

SESSION_ID=$(cat .claude/sessions/current_session_id 2>/dev/null || echo "unknown")
ERROR_LOG=".claude/sessions/${SESSION_ID}_errors.json"

# Log the error
log_error() {
    local error_entry=$(jq -n \
        --arg timestamp "$(date -Iseconds)" \
        --arg task_id "$TASK_ID" \
        --arg tool "$TOOL_NAME" \
        --arg type "$ERROR_TYPE" \
        --arg message "$ERROR_MESSAGE" \
        --argjson retry "$RETRY_COUNT" \
        '{
            timestamp: $timestamp,
            task_id: $task_id, 
            tool: $tool,
            error_type: $type,
            error_message: $message,
            retry_count: $retry
        }')
    
    if [ -f "$ERROR_LOG" ]; then
        jq --argjson entry "$error_entry" '.errors += [$entry]' "$ERROR_LOG" > "${ERROR_LOG}.tmp"
        mv "${ERROR_LOG}.tmp" "$ERROR_LOG"
    else
        jq -n --argjson entry "$error_entry" '{errors: [$entry]}' > "$ERROR_LOG"
    fi
}

log_error

# Implement retry ladder based on error type and retry count
case "$RETRY_COUNT" in
    0)
        # First failure - try shrinking scope
        echo "RETRY_STRATEGY: shrink_scope"
        echo "RETRY_ACTION: Reduce context size and simplify task"
        
        case "$TOOL_NAME" in
            "Write")
                echo "Suggest: Break large file into smaller modules"
                ;;
            "Read")
                echo "Suggest: Add offset/limit parameters to read smaller chunks"
                ;;
            "Bash") 
                echo "Suggest: Simplify command or reduce output verbosity"
                ;;
        esac
        ;;
        
    1)
        # Second failure - add missing context
        echo "RETRY_STRATEGY: add_context"
        echo "RETRY_ACTION: Fetch additional documentation or examples"
        
        # Try to identify what context might be missing
        if echo "$ERROR_MESSAGE" | grep -i "not found"; then
            echo "Suggest: Research the missing component or API"
        elif echo "$ERROR_MESSAGE" | grep -i "permission"; then
            echo "Suggest: Check file permissions and write root settings"
        elif echo "$ERROR_MESSAGE" | grep -i "timeout"; then
            echo "Suggest: Increase timeout limits or optimize operation"
        fi
        ;;
        
    2)
        # Third failure - switch agent
        echo "RETRY_STRATEGY: switch_agent"
        echo "RETRY_ACTION: Route task to different specialist agent"
        
        # Suggest alternative agent based on current agent and task
        CURRENT_AGENT=$(echo "$INPUT" | jq -r '.agent // "unknown"')
        case "$CURRENT_AGENT" in
            "coder")
                echo "Suggest: Route to researcher for more documentation context"
                ;;
            "reviewer")
                echo "Suggest: Route to orchestrator for task decomposition" 
                ;;
            "researcher")
                echo "Suggest: Route to coder to examine local codebase instead"
                ;;
            *)
                echo "Suggest: Route to orchestrator for coordination"
                ;;
        esac
        ;;
        
    *)
        # Multiple failures - fail cleanly
        echo "RETRY_STRATEGY: fail_cleanly"
        echo "RETRY_ACTION: Create detailed error report and escalate"
        
        # Generate comprehensive failure report
        FAILURE_REPORT=".claude/reports/${TASK_ID}_failure_report.json"
        jq -n \
            --arg task_id "$TASK_ID" \
            --arg error_type "$ERROR_TYPE" \
            --arg error_message "$ERROR_MESSAGE" \
            --argjson retry_count "$RETRY_COUNT" \
            --arg timestamp "$(date -Iseconds)" \
            '{
                task_id: $task_id,
                status: "failed",
                error_summary: {
                    type: $error_type,
                    message: $error_message,
                    retry_attempts: $retry_count
                },
                escalation_required: true,
                recommended_actions: [
                    "Review error logs for patterns",
                    "Check system resources and permissions", 
                    "Consider manual intervention or task redesign"
                ],
                timestamp: $timestamp
            }' > "$FAILURE_REPORT"
            
        echo "Failure report created: $FAILURE_REPORT"
        echo "ESCALATE: Human intervention required"
        ;;
esac

# Check for error patterns that require immediate attention
if echo "$ERROR_MESSAGE" | grep -E "(security|unauthorized|forbidden)"; then
    echo "SECURITY_ALERT: Potential security violation detected"
    echo "ESCALATE: Immediate security review required"
fi

if echo "$ERROR_MESSAGE" | grep -E "(disk.*full|no.*space|memory.*error)"; then
    echo "RESOURCE_ALERT: System resource exhaustion detected"
    echo "ESCALATE: System administration required"
fi

# Update retry recommendations based on error analysis
echo "RETRY_RECOMMENDATIONS: $(analyze_error_patterns)"
```

## Error Pattern Analysis

**Common Patterns and Solutions:**

```bash
analyze_error_patterns() {
    # Analyze recent errors for patterns
    if [ -f "$ERROR_LOG" ]; then
        # Check for repeated permission errors
        PERM_ERRORS=$(jq '.errors[] | select(.error_message | contains("permission"))' "$ERROR_LOG" | wc -l)
        if [ "$PERM_ERRORS" -gt 3 ]; then
            echo "Pattern: Repeated permission errors - review write_root configuration"
        fi
        
        # Check for timeout patterns
        TIMEOUT_ERRORS=$(jq '.errors[] | select(.error_message | contains("timeout"))' "$ERROR_LOG" | wc -l)
        if [ "$TIMEOUT_ERRORS" -gt 2 ]; then
            echo "Pattern: Repeated timeouts - increase time limits or optimize operations"
        fi
        
        # Check for resource limit violations
        RESOURCE_ERRORS=$(jq '.errors[] | select(.error_message | contains("limit"))' "$ERROR_LOG" | wc -l)
        if [ "$RESOURCE_ERRORS" -gt 2 ]; then
            echo "Pattern: Resource limits - review token/size/time budgets"
        fi
    fi
}
```

## Recovery Strategies

### Context Reduction
- Remove non-essential documentation snippets
- Focus on only the most relevant code sections
- Reduce example complexity
- Limit the scope of file operations

### Resource Optimization  
- Increase timeout values for complex operations
- Reduce batch sizes for bulk operations
- Cache frequently accessed information
- Use streaming operations for large datasets

### Alternative Approaches
- Use local files instead of network requests
- Break complex tasks into sequential simple tasks
- Use different tools for the same operation
- Simplify output format requirements

## Integration with Session Management

**Error Tracking:**
- All errors logged to session-specific files
- Pattern analysis across sessions
- Success/failure rate tracking per agent
- Resource usage correlation with failures

**Learning and Adaptation:**
- Update policies based on recurring error patterns
- Adjust default limits based on failure analysis
- Improve context pack templates to prevent common errors
- Build knowledge base of successful recovery strategies

## Escalation Procedures

**Automatic Escalation Triggers:**
- Security violations or suspicious activity
- System resource exhaustion
- Three consecutive failures on the same task
- Critical tool failures (git, file system)

**Human Escalation Process:**
1. Generate comprehensive failure report
2. Preserve all context and partial work
3. Provide clear reproduction steps
4. Include recommended next actions
5. Update task status to require human intervention