---
name: grep
signature:
  pattern: string
  path: string (optional)
  options: object (optional)
returns:
  ok: boolean
  matches: array
  total_matches: number
  files_searched: number
limits:
  max_matches: 500
  max_files: 100
  timeout_seconds: 30
safety:
  reads_files: true
  sandbox: true
  allowed_paths: ["**/*.py", "**/*.md", "**/*.json", "**/*.toml", "**/*.yaml", "src/**", "tests/**"]
  denied_paths: [".env*", "secrets/**", "**/*secret*", "node_modules/**", ".git/**"]
---

# Grep Command

Searches for patterns in files with safety controls and result limits.

## Purpose

Provides powerful text search capabilities while maintaining R&D framework discipline:
- Pattern matching across project files
- Context-aware search result filtering
- Integration with code analysis workflows
- Support for focused searches that minimize context bloat

## Usage

```
grep(pattern="def authenticate", path="src/")
grep(pattern="TODO|FIXME", options={"case_insensitive": true})
grep(pattern="import requests", path="**/*.py", options={"line_numbers": true})
```

## Parameters

**pattern** (required): Search pattern or regular expression
- Supports regex patterns for complex matching
- Case-sensitive by default (override with options)
- Special characters automatically escaped when needed

**path** (optional): Directory or file to search
- Defaults to current directory if not specified
- Supports glob patterns for flexible targeting
- Restricted to allowed paths for security

**options** (optional): Search configuration object
- `case_insensitive`: Boolean for case-insensitive search
- `line_numbers`: Boolean to include line numbers in results
- `context_lines`: Number of context lines before/after matches
- `max_matches_per_file`: Limit results per file

## Return Values

**ok**: Whether the search completed successfully
**matches**: Array of match objects with file, line, and content information
**total_matches**: Total number of matches found
**files_searched**: Number of files examined

## Match Object Structure

```json
{
  "file": "src/auth/client.py",
  "line_number": 42,
  "line_content": "def authenticate(self, username, password):",
  "context_before": ["    # Validate credentials", "    if not username:"],
  "context_after": ["        return False", "    # Hash password"]
}
```

## Search Options

**Case Sensitivity:**
```python
# Case-sensitive (default)
grep(pattern="Error")  # Matches "Error" but not "error"

# Case-insensitive  
grep(pattern="error", options={"case_insensitive": true})  # Matches both
```

**Context Lines:**
```python
# Show surrounding context
grep(pattern="class.*Auth", options={"context_lines": 3})
```

**Result Limiting:**
```python
# Limit results per file
grep(pattern="import", options={"max_matches_per_file": 5})
```

## Common Search Patterns

**Code Analysis:**
```bash
# Find function definitions
grep(pattern="def\\s+\\w+", path="src/")

# Find imports
grep(pattern="^(import|from)\\s+", path="**/*.py")

# Find TODOs and FIXMEs
grep(pattern="(TODO|FIXME|HACK|XXX)", options={"case_insensitive": true})
```

**Security and Quality:**
```bash  
# Find potential security issues
grep(pattern="(password|secret|key|token)\\s*=", options={"case_insensitive": true})

# Find hardcoded URLs
grep(pattern="https?://[^\\s]+")

# Find deprecated patterns
grep(pattern="@deprecated|DEPRECATED")
```

**Configuration and Dependencies:**
```bash
# Find configuration references
grep(pattern="config\\.", path="**/*.py")

# Find version specifications
grep(pattern="version\\s*[=:]", path="**/*.toml")
```

## Error Handling

**Pattern Syntax Error:**
```json
{
  "ok": false,
  "error": "Invalid regex pattern: Unterminated character class",
  "pattern": "[incomplete",
  "suggestion": "Check regex syntax and escape special characters"
}
```

**No Matches Found:**
```json
{
  "ok": true,
  "matches": [],
  "total_matches": 0,
  "files_searched": 15,
  "message": "No matches found for pattern 'nonexistent'"
}
```

**Path Access Denied:**
```json
{
  "ok": false,
  "error": "Access denied to path: .env",
  "reason": "Path blocked by security policy",
  "allowed_paths": ["src/**", "tests/**", "docs/**"]
}
```

## Performance Optimization

**Large Codebases:**
- Automatic result limiting prevents context bloat
- Path filtering reduces search scope
- Binary file detection and skipping
- Early termination on resource limits

**Search Strategy:**
```python
# Efficient: Search specific areas
grep(pattern="authenticate", path="src/auth/")

# Less efficient: Search everything
grep(pattern="authenticate")  # searches entire project

# Focused: Limit file types
grep(pattern="class", path="**/*.py")
```

## Integration with R&D Framework

**Context Pack Creation:**
- Search results can seed context packs with relevant code sections
- Matches automatically include surrounding context for understanding
- Version information preserved with search results

**Code Understanding:**
- Supports agent code exploration and analysis
- Provides targeted code samples for documentation
- Enables pattern-based code quality analysis

**Session Continuity:**
- Search patterns and results logged for session tracking
- Frequently searched patterns cached for performance
- Search history supports iterative development workflows

## Best Practices

**Pattern Design:**
- Use specific patterns to reduce noise
- Test regex patterns before complex searches
- Consider case sensitivity requirements
- Use word boundaries for exact matches

**Scope Management:**
- Search in specific directories when possible
- Use file type filtering to reduce irrelevant matches
- Limit results to manageable quantities

**Context Optimization:**
- Request only necessary context lines
- Focus on actionable search results
- Combine with read command for detailed file inspection

**Performance Considerations:**
- Avoid overly broad patterns in large codebases
- Use path restrictions to limit search scope
- Monitor search time and result counts

## Implementation Notes

This command wraps ripgrep/grep functionality with:
- Comprehensive path validation and security controls
- Result limiting and formatting for agent consumption
- Integration with R&D framework policies and resource limits
- Enhanced error handling and user feedback
- Support for complex regex patterns with safety guards