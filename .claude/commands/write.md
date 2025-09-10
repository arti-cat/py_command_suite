---
name: write
signature:
  path: string
  content: string
returns:
  ok: boolean
  path: string
  bytes_written: number
limits:
  max_bytes: 1000000
  timeout_seconds: 30
safety:
  writes_files: true
  sandbox: true
  write_root_required: true
  backup_on_overwrite: true
---

# Write Command

Writes files under the configured write_root with safety guarantees.

## Purpose

Provides controlled file writing capabilities with:
- Write root enforcement and path validation
- Automatic backups for overwrite protection
- Content size limits and validation
- Safe file operations with rollback capability

## Usage

```
write(path="artifacts/new_module.py", content="def hello():\n    return 'world'")
write(path="reports/analysis.json", content='{"status": "complete"}')
```

## Parameters

**path** (required): Target file path for writing
- Automatically prefixed with write_root if not already under it
- Path is validated and sanitized for security
- Directories are created automatically as needed

**content** (required): Content to write to the file
- String content that will be written exactly as provided
- Supports any text content including code, JSON, markdown
- Size limited to prevent resource exhaustion

## Return Values

**ok**: Whether the write operation succeeded
**path**: The actual path where file was written (may be rebased)
**bytes_written**: Number of bytes written to disk

## Safety Measures

**Write Root Enforcement:**
- All writes must be under the configured write_root
- Paths outside write_root are automatically rebased
- No writes allowed to system or parent directories
- Clear error messages when write_root violations occur

**Backup Protection:**
- Existing files are backed up before overwriting
- Backups stored with timestamp suffix (.bak.YYYYMMDD_HHMMSS)
- Backup cleanup after successful operations
- Rollback capability if write operations fail

**Content Validation:**
- Maximum file size limits (1MB default)
- Content encoding validation and normalization
- Prevention of binary content in text files
- Malicious content pattern detection

## Path Rebasing

If a path is outside the write_root, it gets rebased:

```
write_root = ".claude/"

Input:  "/project/src/module.py"  
Output: ".claude/artifacts/module.py"

Input:  "../other-project/file.py"
Output: ".claude/artifacts/file.py"  

Input:  ".claude/plans/task.json"
Output: ".claude/plans/task.json" (no change)
```

## Error Handling

**Write Root Violation:**
```json
{
  "ok": false,
  "error": "Path outside write root",
  "attempted_path": "/etc/passwd",
  "write_root": ".claude/",
  "suggestion": "Files can only be written under .claude/"
}
```

**File Size Exceeded:**
```json
{
  "ok": false,
  "error": "Content size exceeds limit (1.2MB > 1MB)",
  "suggestion": "Break large files into smaller modules"
}
```

**Permission Error:**
```json
{
  "ok": false,
  "error": "Permission denied writing to .claude/artifacts/file.py",
  "suggestion": "Check directory permissions and write_root configuration"
}
```

## Directory Creation

The command automatically creates parent directories:

```
write(path="deep/nested/structure/file.py", content="...")
```

Creates:
- `.claude/artifacts/deep/` (if write_root rebasing occurred)
- `.claude/artifacts/deep/nested/`
- `.claude/artifacts/deep/nested/structure/`
- `.claude/artifacts/deep/nested/structure/file.py`

## Backup Strategy

**Backup Creation:**
- Original file → `file.py.bak.20241010_143022`
- Preserves permissions and timestamps
- Automatic cleanup of old backups (>7 days)

**Rollback Process:**
1. If write fails, restore from backup
2. If backup restoration fails, preserve backup with error suffix
3. Log all backup and rollback operations
4. Notify user of recovery actions taken

## Integration

**With Git Operations:**
- Writes tracked by git status monitoring
- Automatic staging suggestions for new files  
- Integration with commit workflows

**With Session Management:**
- All writes logged to session artifacts list
- File provenance tracking (what created each file)
- Support for session replay and resume

**With Hook System:**
- PreToolUse hooks validate paths and content
- PostToolUse hooks update catalogs and manifests
- Error hooks handle failed writes and rollbacks

## Best Practices

**File Organization:**
```
.claude/
├── artifacts/     # Generated code and outputs
├── plans/         # Planning documents  
├── reports/       # Analysis and reviews
├── context-bundles/  # Context packs
└── sessions/      # Session state
```

**Content Guidelines:**
- Keep individual files under 100KB when possible
- Use appropriate file extensions for content type
- Include proper headers/metadata in generated files
- Structure content for human readability

**Safety Practices:**
- Always validate content before writing
- Use meaningful file names with timestamps
- Test write operations in development first
- Monitor disk space usage

## Implementation Notes

This command wraps Claude Code's native Write tool with:
- Mandatory write_root enforcement
- Automatic path rebasing and validation
- Backup creation and rollback capability
- Integration with R&D framework policies
- Enhanced error handling and user feedback