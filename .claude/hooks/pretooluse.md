---
name: pretooluse
on: PreToolUse
description: Enforces safety rules and patches commands before execution
---

# Pre-Tool Use Hook

This hook executes before every tool use to enforce security, safety, and R&D discipline.

## Safety Rules Enforced

### 1. Command Blocking
Deny dangerous commands that violate security or R&D principles:

**Network Commands:**
- `bash` when first arg in `{curl, wget, nc, telnet}`
- `http` requests to non-documentation domains
- Any command that could exfiltrate data

**File System Commands:**
- `bash(rm:*)` - Prevent accidental deletions
- `bash(chmod:*)` - Prevent permission changes  
- `bash(sudo:*)` - Prevent privilege escalation
- `write` outside of `$WRITE_ROOT`

**Version Control:**
- `git(push:*)` - Prevent accidental pushes
- `git(reset:--hard:*)` - Prevent destructive resets
- `git(commit:*)` - Require explicit commit approval

### 2. Command Patching
Transform commands to be safer and more appropriate:

**Development Commands:**
```
bash(["npm", "test"]) → bash(["npm", "run", "test:ci"])
bash(["python", "-m", "pytest"]) → bash(["python", "-m", "pytest", "--tb=short"])
```

**File Operations:**
```
write("/some/path/file.txt") → write(".claude/artifacts/file.txt") 
read("../../secrets/key.txt") → DENIED
```

**Timeout Extensions:**
- Add longer timeouts for test commands
- Set appropriate limits for build operations
- Cap execution time for safety

### 3. Path Validation and Rebasing
Ensure all file operations stay within safe boundaries:

**Write Path Rebasing:**
- If path not under `$WRITE_ROOT`, rebase into `.claude/artifacts/`
- Preserve relative directory structure when rebasing
- Log all path transformations for transparency

**Read Path Validation:**
- Allow reading project files and documentation
- Block access to system files, secrets, credentials
- Validate paths against permission patterns

## Hook Implementation

```bash
#!/usr/bin/env bash
# Pre-tool use enforcement script

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')
TOOL_INPUT=$(echo "$INPUT" | jq -r '.tool_input')

case "$TOOL_NAME" in
    "Bash")
        COMMAND=$(echo "$TOOL_INPUT" | jq -r '.command')
        FIRST_ARG=$(echo "$COMMAND" | cut -d' ' -f1)
        
        # Block dangerous network commands
        case "$FIRST_ARG" in
            "curl"|"wget"|"nc"|"telnet")
                echo "DENIED: Network command '$FIRST_ARG' not allowed"
                exit 2
                ;;
            "rm"|"rmdir")
                echo "DENIED: Destructive command '$FIRST_ARG' not allowed"
                exit 2
                ;;
            "npm")
                # Patch npm test to use CI mode
                if echo "$COMMAND" | grep -q "npm test"; then
                    PATCHED_COMMAND=$(echo "$COMMAND" | sed 's/npm test/npm run test:ci/')
                    echo "PATCHED: '$COMMAND' → '$PATCHED_COMMAND'"
                    # Update the tool input with patched command
                fi
                ;;
        esac
        ;;
        
    "Write")
        FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.file_path')
        
        # Check if path is under write root
        if [[ ! "$FILE_PATH" =~ ^"$WRITE_ROOT" ]]; then
            # Rebase path into write root
            BASENAME=$(basename "$FILE_PATH")
            REBASED_PATH="$WRITE_ROOT/artifacts/$BASENAME"
            echo "REBASED: '$FILE_PATH' → '$REBASED_PATH'"
            
            # Update tool input with rebased path
            UPDATED_INPUT=$(echo "$TOOL_INPUT" | jq --arg new_path "$REBASED_PATH" '.file_path = $new_path')
            echo "$INPUT" | jq --argjson updated_input "$UPDATED_INPUT" '.tool_input = $updated_input'
        fi
        ;;
        
    "Git")
        COMMAND=$(echo "$TOOL_INPUT" | jq -r '.command // empty')
        
        # Block dangerous git operations
        case "$COMMAND" in
            "push"*)
                echo "DENIED: Git push not allowed without explicit permission"
                exit 2
                ;;
            "reset --hard"*)
                echo "DENIED: Destructive git reset not allowed"
                exit 2
                ;;
            "commit"*)
                echo "DENIED: Git commit requires explicit approval"
                exit 2
                ;;
        esac
        ;;
        
    "Http")
        URL=$(echo "$TOOL_INPUT" | jq -r '.url')
        
        # Only allow documentation domains
        if ! echo "$URL" | grep -E "(docs\.|api\.|github\.com|stackoverflow\.com)"; then
            echo "DENIED: HTTP requests only allowed to documentation sites"
            exit 2
        fi
        ;;
esac

# If we get here, allow the tool use
exit 0
```

## Configuration Integration

The hook uses these configuration sources:

**Permissions** (`.claude/policies/permissions.json`):
- `allow` patterns for approved operations
- `deny` patterns for blocked operations  
- `write_root` for file operation boundaries
- `context_limits` for resource constraints

**Safety Rules**:
- No operations outside write root
- No network commands except documentation
- No destructive file or git operations
- All outputs must be traceable and reversible

## Command Transformations

### Development Workflow Patches
```bash
# Testing
"npm test" → "npm run test:ci --reporter=json"
"python -m pytest" → "python -m pytest --tb=short --maxfail=5"
"cargo test" → "cargo test --quiet"

# Building  
"npm run build" → "npm run build --production"
"python setup.py install" → "pip install -e ."

# Formatting
"black ." → "black --check --diff ."
"prettier --write" → "prettier --check"
```

### File Operation Patches
```bash
# Write operations
write("/project/src/file.py") → write(".claude/artifacts/file.py")
write("../other-project/file") → write(".claude/artifacts/file")

# Read operations - add size limits
read("large-file.txt") → read("large-file.txt", limit=2000)
```

## Error Handling

**Denial Actions:**
- Exit code 2: Block the operation entirely
- Exit code 1: Allow with warnings
- Exit code 0: Allow normally

**Patch Actions:**
- Modify tool input JSON and continue
- Log all transformations for transparency
- Preserve user intent while ensuring safety

**Fallback Behavior:**
- If hook fails, default to blocking unsafe operations
- Log hook failures for debugging
- Provide clear error messages to agents

## Audit Trail

All hook actions are logged to `.claude/sessions/` for:
- Security audit and compliance
- Debugging blocked operations
- Understanding agent behavior patterns
- Optimizing hook rules over time

## Integration Notes

This hook works with:
- **Permission policies**: Enforces rules from permissions.json
- **Agent limits**: Respects resource constraints from limits.json  
- **Context management**: Supports the R&D framework's focus discipline
- **Session tracking**: Contributes to audit trails and session continuity