---
name: posttooluse
on: PostToolUse
description: Processes tool outputs and maintains session continuity
---

# Post-Tool Use Hook

This hook executes after every tool use to process outputs, maintain audit trails, and support session continuity.

## Actions Performed

### 1. Output Processing
Process and enrich tool outputs:
- **File operations**: Track created/modified files for session manifest
- **Code changes**: Generate diff summaries and impact analysis  
- **Research outputs**: Extract and catalog reusable snippets
- **Error handling**: Capture and categorize failures for retry logic

### 2. Session Continuity
Maintain context bundles and session state:
- **Append to context bundle**: Add successful operations to current session bundle
- **Update session manifest**: Track progress, artifacts, and resource usage
- **Create checkpoints**: Save state for resumable sessions
- **Log metrics**: Token usage, execution time, success/failure rates

### 3. Artifact Management
Organize and catalog outputs:
- **Move artifacts**: Relocate temporary files to appropriate directories
- **Generate metadata**: Create artifact manifests with provenance
- **Update indexes**: Maintain searchable catalogs of session outputs
- **Clean up**: Remove temporary files and expired cache entries

### 4. Quality Validation
Validate outputs against contracts and standards:
- **Schema validation**: Ensure JSON outputs conform to contracts
- **Format checking**: Validate code formatting and style
- **Completeness**: Check that required fields are present
- **Size limits**: Verify outputs don't exceed resource limits

## Session Bundle Updates

After each successful tool use, append to the active context bundle:

```json
{
  "session_id": "20241010_143022_abc123",
  "timestamp": "2024-10-10T14:30:22Z",
  "tool_use": {
    "tool_name": "Write",
    "input_summary": "Created new authentication module",
    "output_summary": "Successfully wrote auth.py with 150 lines",
    "files_affected": [".claude/artifacts/auth.py"],
    "success": true,
    "duration_ms": 1234,
    "tokens_consumed": 450
  },
  "context_impact": {
    "context_added": 450,
    "context_removed": 0,
    "net_change": 450,
    "remaining_budget": 5550
  }
}
```

## Hook Implementation

```bash
#!/usr/bin/env bash
# Post-tool use processing script

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')
TOOL_INPUT=$(echo "$INPUT" | jq -r '.tool_input')
TOOL_OUTPUT=$(echo "$INPUT" | jq -r '.tool_output')
SUCCESS=$(echo "$INPUT" | jq -r '.success')

SESSION_ID=$(cat .claude/sessions/current_session_id 2>/dev/null || echo "unknown")
BUNDLE_PATH=".claude/context-bundles/${SESSION_ID}.json"

# Process based on tool type
case "$TOOL_NAME" in
    "Write")
        FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.file_path')
        
        if [ "$SUCCESS" = "true" ]; then
            echo "File written: $FILE_PATH"
            
            # Add to session manifest
            echo "$FILE_PATH" >> ".claude/sessions/${SESSION_ID}_artifacts.txt"
            
            # Update context bundle
            jq --arg file "$FILE_PATH" --arg timestamp "$(date -Iseconds)" \
               '.artifacts += [$file] | .last_updated = $timestamp' \
               "$BUNDLE_PATH" > "${BUNDLE_PATH}.tmp" && \
               mv "${BUNDLE_PATH}.tmp" "$BUNDLE_PATH"
        fi
        ;;
        
    "Read")
        FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.file_path')
        
        if [ "$SUCCESS" = "true" ]; then
            # Track files read for context management
            echo "File read: $FILE_PATH"
            
            # Add to context bundle operations log
            jq --arg file "$FILE_PATH" --arg timestamp "$(date -Iseconds)" \
               '.operations += [{"type": "read", "file": $file, "timestamp": $timestamp}]' \
               "$BUNDLE_PATH" > "${BUNDLE_PATH}.tmp" && \
               mv "${BUNDLE_PATH}.tmp" "$BUNDLE_PATH"
        fi
        ;;
        
    "Bash")
        COMMAND=$(echo "$TOOL_INPUT" | jq -r '.command')
        
        if [ "$SUCCESS" = "true" ]; then
            # Log successful command execution
            echo "Command executed: $COMMAND"
            
            # Special handling for test commands
            if echo "$COMMAND" | grep -E "(test|pytest|npm.*test)"; then
                # Extract test results if available
                TEST_RESULTS=$(echo "$TOOL_OUTPUT" | grep -E "(passed|failed|errors)")
                if [ -n "$TEST_RESULTS" ]; then
                    echo "Test results: $TEST_RESULTS"
                    echo "$TEST_RESULTS" >> ".claude/sessions/${SESSION_ID}_test_results.txt"
                fi
            fi
        fi
        ;;
        
    "Git")
        # Track git operations for version control awareness
        if [ "$SUCCESS" = "true" ]; then
            GIT_COMMAND=$(echo "$TOOL_INPUT" | jq -r '.command // "status"')
            echo "Git operation: $GIT_COMMAND"
            
            # Update repository state tracking
            if [ "$GIT_COMMAND" = "status" ]; then
                # Cache git status for other agents
                echo "$TOOL_OUTPUT" > ".claude/sessions/${SESSION_ID}_git_status.txt"
            fi
        fi
        ;;
esac

# Update session metrics
DURATION=$(echo "$INPUT" | jq -r '.duration_ms // 0')
TOKENS=$(echo "$INPUT" | jq -r '.tokens_consumed // 0')

# Update session totals
if [ -f ".claude/sessions/${SESSION_ID}_metrics.json" ]; then
    jq --argjson duration "$DURATION" --argjson tokens "$TOKENS" \
       '.total_duration_ms += $duration | .total_tokens += $tokens | .tool_uses += 1' \
       ".claude/sessions/${SESSION_ID}_metrics.json" > \
       ".claude/sessions/${SESSION_ID}_metrics.json.tmp" && \
       mv ".claude/sessions/${SESSION_ID}_metrics.json.tmp" \
          ".claude/sessions/${SESSION_ID}_metrics.json"
else
    # Create initial metrics file
    jq -n --argjson duration "$DURATION" --argjson tokens "$TOKENS" \
       '{total_duration_ms: $duration, total_tokens: $tokens, tool_uses: 1, session_id: "'$SESSION_ID'"}' > \
       ".claude/sessions/${SESSION_ID}_metrics.json"
fi

# Clean up old artifacts if needed
find .claude/sessions -name "*.tmp" -mtime +1 -delete 2>/dev/null || true
find .claude/context-bundles -name "*.json" -mtime +7 -delete 2>/dev/null || true
```

## Artifact Organization

**Immediate Processing:**
- Code files → `.claude/artifacts/` with timestamp
- Documentation → `.claude/background/` for reuse
- Test outputs → `.claude/sessions/{session_id}_test_results.txt`
- Error logs → `.claude/sessions/{session_id}_errors.json`

**Batch Processing:**
- Daily artifact cleanup and archiving
- Context bundle optimization and compression
- Session analysis and metric aggregation
- Knowledge base updates with successful patterns

## Quality Validation

**JSON Schema Validation:**
```bash
# Validate agent outputs against contracts
validate_json_output() {
    local output_file="$1"
    local schema_file="$2"
    
    if command -v jsonschema >/dev/null; then
        jsonschema -i "$output_file" "$schema_file"
    else
        # Fallback to basic JSON validation
        jq empty "$output_file"
    fi
}
```

**Code Quality Checks:**
- Run formatters on generated code
- Check for basic syntax errors
- Validate imports and dependencies
- Ensure test files are properly structured

## Error Recovery

**Failed Tool Operations:**
- Log detailed error information
- Preserve partial outputs for analysis
- Update retry counters and backoff timers
- Trigger appropriate error handling workflows

**Resource Limit Violations:**
- Cap output sizes and truncate if needed
- Archive oversized artifacts for later review
- Update resource usage tracking
- Trigger resource optimization recommendations

## Integration Points

This hook integrates with:
- **Session management**: Updates active session state
- **Context bundles**: Maintains operation history
- **Artifact catalogs**: Organizes and indexes outputs
- **Resource tracking**: Monitors usage against limits
- **Quality gates**: Validates outputs against standards