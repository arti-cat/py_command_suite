---
name: bash
signature:
  command: string
  description: string (optional)
returns:
  ok: boolean
  stdout: string
  stderr: string
  exit_code: number
limits:
  timeout_seconds: 120
  max_output_bytes: 500000
safety:
  executes_commands: true
  sandbox: true
  allowed_commands: ["ls", "find", "grep", "wc", "head", "tail", "cat", "tree", "git", "npm", "python", "uv"]
  denied_commands: ["curl", "wget", "rm", "sudo", "chmod", "chown", "dd", "mkfs"]
---

# Bash Command

Executes shell commands with strict safety controls and output limits.

## Purpose

Provides controlled command execution capabilities with:
- Whitelist-based command filtering
- Resource limits and timeouts  
- Output capture and size limits
- Integration with development workflows

## Usage

```
bash(command="ls -la", description="List files with details")
bash(command="python -m pytest tests/", description="Run test suite")
bash(command="git status", description="Check repository status")
```

## Parameters

**command** (required): Shell command to execute
- Must start with an allowed command from the whitelist
- Arguments are validated for safety
- Complex commands may be rejected or modified

**description** (optional): Human-readable description of the command
- Used for logging and audit trails
- Helps with session continuity and debugging
- Displayed in hook processing and error messages

## Return Values

**ok**: Whether the command executed successfully (exit code 0)
**stdout**: Standard output from the command
**stderr**: Standard error output from the command  
**exit_code**: Numeric exit code from the command

## Safety Controls

**Command Whitelist:**
- Only pre-approved commands can be executed
- Command validation happens before execution
- Arguments checked for dangerous patterns
- Aliases and shell functions are blocked

**Resource Limits:**
- 2-minute maximum execution timeout
- 500KB maximum output size (stdout + stderr combined)
- Automatic termination if limits exceeded
- Resource usage tracking and reporting

**Dangerous Command Blocking:**
```bash
# ALLOWED
bash(command="git status")
bash(command="python test.py")
bash(command="npm run build")

# BLOCKED
bash(command="curl http://malicious.site")
bash(command="rm -rf /")
bash(command="sudo apt install")
```

## Command Categories

**File Operations (Safe):**
- `ls`, `find`, `tree` - Directory listing and traversal
- `head`, `tail`, `cat` - File content viewing
- `wc`, `grep` - Text processing and analysis
- Size and depth limits applied automatically

**Development Tools:**
- `git` - Version control operations (read-only commands preferred)
- `python`, `uv` - Python execution and package management
- `npm`, `yarn` - Node.js package management and scripts
- `cargo`, `go` - Other language toolchain commands

**Testing and Quality:**
```bash
bash(command="python -m pytest tests/ --tb=short")
bash(command="npm run test:ci")  
bash(command="uv run ruff check src/")
bash(command="git diff --name-only")
```

## Command Transformations

Some commands are automatically transformed for safety:

**Testing Commands:**
```bash
"npm test" → "npm run test:ci --reporter=json"
"python -m pytest" → "python -m pytest --tb=short --maxfail=5"
```

**Output Control:**
```bash
"find /" → "find . -maxdepth 3"  # Limit search scope
"cat large.log" → "head -1000 large.log"  # Limit output
```

## Error Handling

**Command Not Allowed:**
```json
{
  "ok": false,
  "error": "Command 'curl' is not in the allowed list",
  "allowed_commands": ["ls", "find", "grep", "git", "python", "..."],
  "suggestion": "Use http command for web requests"
}
```

**Timeout Exceeded:**
```json
{
  "ok": false,
  "error": "Command timed out after 120 seconds",
  "stdout": "Partial output before timeout...",
  "suggestion": "Break command into smaller operations"
}
```

**Output Size Exceeded:**
```json
{
  "ok": false,
  "error": "Output exceeded 500KB limit",
  "stdout_truncated": true,
  "suggestion": "Use output filtering or pagination"
}
```

## Development Workflows

**Testing Integration:**
```bash
# Run tests with proper reporting
bash(command="python -m pytest tests/ --json-report --json-report-file=.claude/reports/test_results.json")

# Check code quality
bash(command="uv run ruff check src/")
bash(command="uv run mypy src/")
```

**Git Operations:**
```bash
# Safe git commands (read-only)
bash(command="git status")
bash(command="git diff --cached")  
bash(command="git log --oneline -10")

# Blocked git commands (require explicit permission)
# bash(command="git commit -m 'message'")  # BLOCKED
# bash(command="git push origin main")     # BLOCKED
```

**Build and Package Management:**
```bash
# Python with UV
bash(command="uv sync")
bash(command="uv run python script.py")
bash(command="uv add requests")

# Node.js
bash(command="npm install")
bash(command="npm run build")
bash(command="npm run lint")
```

## Integration

**With Hook System:**
- PreToolUse hooks validate and transform commands
- PostToolUse hooks log execution and capture outputs
- Error hooks implement retry logic for failed commands

**With Session Tracking:**
- All command executions logged with timestamps
- Output artifacts cataloged for session continuity  
- Command history available for debugging

**With Resource Management:**
- Execution time counted against task budgets
- Output size tracked for context management
- Parallel execution limits enforced

## Best Practices

**Command Design:**
- Use descriptive command descriptions
- Prefer specific over general commands
- Include output filtering when possible
- Test commands in development environment first

**Output Management:**
- Redirect large outputs to files instead of returning directly
- Use JSON output formats when available for structured data
- Filter output to relevant information only

**Error Resilience:**
- Handle expected failures gracefully
- Provide alternative approaches for blocked commands
- Use command chaining carefully (prefer single commands)

## Implementation Notes

This command wraps system shell execution with:
- Comprehensive command validation and filtering
- Resource limit enforcement and monitoring
- Output capture and size management
- Integration with R&D framework safety policies
- Enhanced error reporting and suggestion system