---
name: read
signature:
  path: string
  offset: number (optional)
  limit: number (optional)
returns:
  ok: boolean
  content: string
  lines_read: number
  total_lines: number
limits:
  max_bytes: 1000000
  max_lines: 2000
  timeout_seconds: 30
safety:
  reads_files: true
  sandbox: true
  allowed_paths: ["**/*.py", "**/*.md", "**/*.json", "**/*.toml", "**/*.yaml"]
  denied_paths: [".env", ".env.*", "secrets/**", "**/*secret*", "**/*password*"]
---

# Read Command

Reads file contents with safety limits and path restrictions.

## Purpose

Provides controlled file reading capabilities with:
- Automatic size and line limits
- Path validation and sandboxing
- Support for partial file reading (offset/limit)
- Content type detection and validation

## Usage

```
read(path="/path/to/file.py")
read(path="/path/to/large/file.py", offset=100, limit=500)
```

## Parameters

**path** (required): File path to read
- Must be relative to project root or absolute within allowed areas
- Automatically validated against allow/deny patterns
- Supports glob patterns in path validation

**offset** (optional): Line number to start reading from
- Useful for large files to avoid context bloat
- 1-based indexing (first line is 1)
- Defaults to 1 (start of file)

**limit** (optional): Maximum number of lines to read
- Caps the amount of content loaded into context
- Defaults to 2000 lines maximum
- Combined with offset for paginated reading

## Return Values

**ok**: Whether the read operation succeeded
**content**: The file content (potentially truncated)
**lines_read**: Number of lines actually returned
**total_lines**: Total lines in the file (for pagination)

## Safety Measures

**Path Restrictions:**
- Only reads from approved file types (code, docs, configs)
- Blocks access to secrets, credentials, environment files
- Validates paths against permission patterns
- Prevents directory traversal attacks

**Resource Limits:**
- Maximum 1MB file size
- Maximum 2000 lines per read
- 30-second timeout for large files
- Automatic truncation with warnings

**Content Validation:**
- Detects binary files and refuses to read
- Handles encoding issues gracefully
- Provides helpful error messages for invalid files

## Error Handling

**File Not Found:**
```json
{
  "ok": false,
  "error": "File not found: /path/to/missing.py",
  "suggestions": ["Check file path", "Verify file exists"]
}
```

**Permission Denied:**
```json
{
  "ok": false, 
  "error": "Access denied: .env files are restricted",
  "reason": "security_policy"
}
```

**File Too Large:**
```json
{
  "ok": false,
  "error": "File exceeds size limit (1.2MB > 1MB)",
  "suggestions": ["Use offset/limit for partial reading", "Process in chunks"]
}
```

## Integration

**With Context Management:**
- Tracks bytes consumed toward context budget
- Provides warnings when approaching limits
- Supports context-aware partial reading

**With Session Tracking:**
- Logs all file reads for audit trail
- Tracks frequently accessed files
- Supports resume-friendly partial reads

**With Permission System:**
- Enforces allow/deny patterns from policies
- Respects write_root boundaries for reading
- Integrates with hook validation

## Best Practices

**For Large Files:**
- Use offset/limit to read specific sections
- Read table of contents or headers first
- Process iteratively rather than loading all content

**For Context Efficiency:**
- Read only the files needed for current task
- Use grep to find specific content before reading
- Combine with write operations for efficient editing

**For Security:**
- Never read credential or secret files
- Validate all paths before operations
- Log access for security audit

## Implementation Notes

This command is implemented as a thin wrapper around Claude Code's native Read tool with additional:
- Path validation and sanitization
- Resource limit enforcement  
- Content type detection
- Error handling and user feedback
- Integration with R&D framework policies