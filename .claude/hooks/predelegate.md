---
name: predelegate  
on: PreDelegate
description: Enriches delegation with context packs and enforces I/O contracts
---

# Pre-Delegate Hook

This hook executes before any task delegation to ensure agents receive properly structured context and clear contracts.

## Actions Performed

### 1. Context Pack Creation
If the task lacks `doc_snippets`:
- Fetch version-pinned documentation from local cache or MCP server
- Create focused context pack under `.claude/context-bundles/`
- Include only essential information within token limits
- Add citations and version information

### 2. I/O Contract Enforcement
Ensure every delegated task has a clear I/O contract:
- **plan** tasks → `json.plan` output required
- **coding** tasks → `json.patch` output required  
- **review** tasks → `json.review` output required
- **research** tasks → `json.report` output required
- Add schema references and validation requirements

### 3. Write Root Configuration
Set appropriate write permissions:
- **Default**: `WRITE_ROOT=.claude/` (embedded mode)
- **Project mode**: Allow writing to specific project paths
- Validate all file operations stay within write root
- Rebase any external paths into the write root

### 4. Agent Context Preparation
Prepare context for the target agent:
- Load agent-specific context lens
- Include relevant policy files
- Add tool constraints and permissions
- Set resource limits and timeouts

## Context Pack Structure

When creating context packs, this hook generates:

```json
{
  "objective": "Clear task description",
  "inputs": {
    "files": ["relevant/files.py"],
    "data": {"key": "value"}
  },
  "constraints": {
    "write_root": ".claude/",
    "max_tokens": 6000,
    "time_limit_minutes": 10
  },
  "doc_snippets": [
    {
      "source": "https://docs.example.com/api/v2.1#auth",
      "version": "v2.1.0",
      "content": "OAuth2 authentication flow...",
      "relevance_score": 0.9
    }
  ],
  "io_contract": {
    "format": "json.patch",
    "required_fields": ["manifest", "diff"],
    "schema_path": ".claude/output-styles/json.patch.schema.json"
  },
  "success_checks": [
    "All modified files are under write_root",
    "Output conforms to json.patch schema", 
    "Implementation includes tests",
    "Citations are provided for external references"
  ]
}
```

## Hook Implementation

```bash
#!/usr/bin/env bash
# Pre-delegate hook script

INPUT=$(cat)
TASK_ID=$(echo "$INPUT" | jq -r '.task_id')
AGENT=$(echo "$INPUT" | jq -r '.agent')
TASK_TYPE=$(echo "$INPUT" | jq -r '.task_type')

# Set write root
export WRITE_ROOT=".claude/"
echo "WRITE_ROOT set to: $WRITE_ROOT"

# Create context pack if missing
if ! echo "$INPUT" | jq -e '.context_pack' >/dev/null; then
    CONTEXT_PACK_PATH=".claude/context-bundles/${TASK_ID}_context.json"
    echo "Creating context pack: $CONTEXT_PACK_PATH"
    
    # Generate context pack based on task type and requirements
    # This would call an MCP server or local documentation service
fi

# Add I/O contract based on task type
case "$TASK_TYPE" in
    "plan"|"delegate") 
        IO_CONTRACT="json.plan"
        ;;
    "coding"|"implement"|"refactor")
        IO_CONTRACT="json.patch" 
        ;;
    "review"|"audit")
        IO_CONTRACT="json.review"
        ;;
    "research"|"document")
        IO_CONTRACT="json.report"
        ;;
    *)
        IO_CONTRACT="json.report"  # Default fallback
        ;;
esac

echo "I/O contract set to: $IO_CONTRACT"

# Validate agent capabilities
ROUTING=$(cat .claude/policies/routing.json)
VALID_AGENT=$(echo "$ROUTING" | jq -r ".task_routes[\"$TASK_TYPE\"]")

if [ "$AGENT" != "$VALID_AGENT" ]; then
    echo "Warning: $AGENT may not be optimal for $TASK_TYPE (recommended: $VALID_AGENT)"
fi
```

## Documentation Sources

The hook can fetch documentation from:
- **Local cache**: `.claude/background/` directory
- **MCP servers**: Version-pinned API docs and references
- **Project files**: README, API documentation, inline comments
- **External APIs**: Official documentation endpoints

## Version Pinning Strategy

All documentation snippets include:
- **API versions**: Specific version numbers (v1.2.3, v2.1.0)
- **Library versions**: Exact semver versions
- **Git commits**: Commit hashes for source code references  
- **Timestamps**: When the information was last verified
- **Deprecation status**: Whether the information is current

## Error Handling

If context pack creation fails:
1. **Missing docs**: Create minimal context with task description only
2. **Network issues**: Use cached/fallback documentation
3. **Invalid formats**: Generate basic template context
4. **Size limits**: Truncate and prioritize most relevant snippets
5. **Permission errors**: Adjust write root or request broader permissions

## Integration Points

This hook integrates with:
- **MCP servers**: For live documentation fetching
- **Agent routing**: Uses routing.json for agent capabilities
- **Permission system**: Enforces write root restrictions
- **Resource limits**: Respects token and time budgets from limits.json