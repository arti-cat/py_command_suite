---
name: pre-tooluse-logger
description: Log tool operations for context bundles and session continuity
event: PreToolUse
matcher: "Read|Write|Bash"
---

# Pre-Tool Use Logger Hook

Logs tool operations to enable context bundles and session continuity, implementing the R&D framework's session replay capabilities.

## Purpose

This hook captures tool usage patterns to create context bundles that enable:
- Session continuity across context limits
- Operation replay for new agent instances
- Development workflow tracking
- Context engineering optimization

## Logged Operations

### Read Operations
- File paths accessed
- Read patterns and frequency
- Project structure exploration

### Write Operations  
- Files created or modified
- Content creation patterns
- Project evolution tracking

### Bash Operations
- Commands executed
- Development workflow patterns
- Tool usage and automation

## Log Format

```json
{
  "timestamp": "2025-09-10T00:00:00Z",
  "session_id": "abc123",
  "tool_name": "Read|Write|Bash",
  "operation": {
    "file_path": "/path/to/file",
    "command": "bash command",
    "description": "operation description"
  },
  "context": "current working context"
}
```

## Output Location

Logs are written to `agents/context-bundles/` for session continuity:
- `session-{date}-{hour}-{id}.md` - Human-readable session log
- `operations-{session}.json` - Machine-readable operation log

## Integration with Context Bundles

This logging enables:
- **Session Replay**: `/loadbundle` command functionality
- **Agent Priming**: Give subagents relevant operation history
- **Pattern Recognition**: Understand development workflow patterns
- **Context Optimization**: Identify frequently accessed files/commands

## R&D Framework Implementation

Supports the Reduce & Delegate framework by:
- **Reducing**: Efficient context reconstruction without full history
- **Delegating**: Proper context transfer to subagents and background agents
- **Optimizing**: Pattern recognition for better delegation decisions