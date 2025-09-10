---
name: git
signature:
  command: string
  description: string (optional)
returns:
  ok: boolean
  output: string
  branch: string (optional)
  status: string (optional)
limits:
  timeout_seconds: 60
  max_output_lines: 1000
safety:
  executes_commands: true
  sandbox: true
  allowed_operations: ["status", "diff", "log", "show", "branch", "remote"]
  denied_operations: ["push", "commit", "reset", "rebase", "merge", "pull"]
---

# Git Command

Provides safe, read-only Git operations with comprehensive repository state tracking.

## Purpose

Enables controlled Git operations that support development workflows while preventing destructive actions:
- Repository status and change tracking
- Diff analysis and code review support  
- Branch and commit history inspection
- Integration with session continuity

## Usage

```
git(command="status", description="Check working tree status")
git(command="diff --cached", description="Show staged changes")
git(command="log --oneline -10", description="Recent commit history")
```

## Parameters

**command** (required): Git operation to perform
- Must be from the allowed operations list
- Arguments validated for safety and appropriateness
- Output automatically formatted for readability

**description** (optional): Purpose description for logging
- Helps with audit trails and session tracking
- Used in error messages and hook processing
- Supports debugging and workflow understanding

## Return Values

**ok**: Whether the git operation succeeded
**output**: Git command output (formatted and truncated if needed)
**branch**: Current branch name (when applicable)
**status**: Repository status summary (when applicable)

## Allowed Operations

**Repository Status:**
```bash
git(command="status")                    # Working tree status
git(command="status --porcelain")       # Machine-readable status  
git(command="status --short")           # Compact status display
```

**Change Analysis:**
```bash
git(command="diff")                      # Unstaged changes
git(command="diff --cached")            # Staged changes
git(command="diff HEAD~1")              # Changes since last commit
git(command="diff --name-only")         # Changed file names only
```

**History and Branches:**
```bash
git(command="log --oneline -10")        # Recent commits
git(command="log --graph --oneline")    # Visual commit history
git(command="branch -v")                # Local branches with info
git(command="remote -v")                # Remote repository info
```

**Inspection:**
```bash
git(command="show HEAD")                # Last commit details
git(command="show --name-only HEAD")    # Files in last commit
```

## Blocked Operations

For security and workflow safety, these operations require explicit permission:

**State-Changing Operations:**
- `commit` - Must be done through approval workflow
- `push` - Prevents accidental publishes  
- `pull` - Could overwrite local changes
- `merge` - Complex operation requiring careful review
- `rebase` - Rewrites history, needs explicit control
- `reset` - Could lose work, especially --hard variants

**Configuration Changes:**
- `config` - Could alter security or identity settings
- `remote add/remove` - Could redirect pushes to wrong locations

## Enhanced Status Information

The git command provides enriched status information:

```json
{
  "ok": true,
  "output": "On branch main\nYour branch is up to date...",
  "branch": "main", 
  "status": {
    "staged_files": ["src/module.py", "tests/test_module.py"],
    "unstaged_files": ["README.md"],
    "untracked_files": ["temp.log"],
    "commits_ahead": 0,
    "commits_behind": 0
  }
}
```

## Error Handling

**Not a Git Repository:**
```json
{
  "ok": false,
  "error": "Not a git repository",
  "suggestion": "Initialize repository with 'git init' or navigate to repository root"
}
```

**Blocked Operation:**
```json
{
  "ok": false,
  "error": "Operation 'push' is not allowed",
  "reason": "Destructive git operations require explicit approval",
  "alternatives": ["Use commit workflow", "Request manual push permission"]
}
```

**Detached HEAD:**
```json
{
  "ok": true,
  "output": "HEAD detached at abc1234...", 
  "branch": null,
  "warning": "In detached HEAD state - commits may be lost"
}
```

## Workflow Integration

**Change Tracking for Sessions:**
```bash
# Before starting work
git(command="status --porcelain")  # Baseline state

# During development  
git(command="diff --name-only")    # Files being modified
git(command="status --short")      # Quick status check

# Before task completion
git(command="diff --cached")       # Review staged changes
```

**Code Review Support:**
```bash
# Analyze changes for review
git(command="diff --stat")                    # Change summary
git(command="diff --name-only HEAD~3")       # Files changed in last 3 commits
git(command="log --oneline --since='1 day'") # Recent activity
```

**Branch and Remote Awareness:**
```bash
# Understanding repository context
git(command="branch -v")           # Local branches
git(command="remote -v")           # Remote repositories
git(command="log --graph -5")      # Visual history
```

## Session Continuity

**Repository State Caching:**
- Current branch and status cached for other agents
- Change tracking for session artifact correlation
- Commit history context for code understanding

**Change Detection:**
- Monitors files modified during session
- Tracks relationship between tasks and file changes
- Supports rollback and undo operations

## Integration Points

**With File Operations:**
- Coordinates with read/write commands for change tracking
- Provides context for file modification decisions
- Supports conflict detection and resolution

**With Code Review:**
- Feeds diff information to reviewer agents
- Provides change context for quality analysis
- Supports incremental review workflows

**With Session Management:**
- Tracks git state changes across task execution
- Provides repository context for task planning
- Supports session resume with proper git context

## Best Practices

**Status Monitoring:**
- Check status before major operations
- Monitor changes during development tasks
- Verify clean state before task completion

**Change Analysis:**
- Use diff commands to understand change scope
- Review staged changes before any commit operations
- Track file modifications for impact analysis

**Branch Awareness:**
- Always know current branch context
- Understand relationship to main/master branch  
- Monitor for detached HEAD states

**Output Processing:**
- Use --porcelain for machine-readable output
- Filter large outputs with appropriate flags
- Cache status information for repeated access

## Implementation Notes

This command provides a safe wrapper around Git operations with:
- Comprehensive operation filtering and validation
- Enhanced status information extraction
- Integration with R&D framework session tracking
- Support for development workflow patterns
- Repository state caching and change detection