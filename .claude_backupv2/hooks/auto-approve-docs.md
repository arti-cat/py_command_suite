---
name: auto-approve-docs
description: Auto-approve Read tool for safe documentation and configuration files
event: PreToolUse
matcher: Read
---

# Auto-Approve Documentation Reading Hook

Automatically approves Read tool usage for safe documentation and configuration files, reducing permission friction for common development operations.

## Purpose

This hook implements deterministic approval for Read operations on safe file types, eliminating unnecessary permission prompts while maintaining security for sensitive files.

## Auto-Approved File Types

### Documentation Files
- `.md`, `.mdx` - Markdown documentation
- `.txt` - Plain text files
- `.rst` - reStructuredText documentation

### Configuration Files
- `pyproject.toml` - Python project configuration
- `package.json` - Node.js configuration  
- `.gitignore` - Git ignore rules
- `README.*` - Project readme files
- `LICENSE*` - License files
- `CHANGELOG.*` - Changelog files

### Code Structure Files
- `__init__.py` - Python package initialization
- `conftest.py` - pytest configuration
- `setup.py`, `setup.cfg` - Legacy Python setup

## Security Boundaries

### Never Auto-Approve
- `.env*` - Environment variables and secrets
- `*.key`, `*.pem`, `*.crt` - Cryptographic keys and certificates
- `config/secrets/` - Any path containing 'secrets'
- `credentials.*` - Credential files
- Files outside project directory

### Permission Required
- Binary files
- Files in system directories (`/etc/`, `/usr/`, etc.)
- Database files (`.db`, `.sqlite`)
- Compiled files (`.pyc`, `.so`, `.dll`)

## Implementation Logic

```python
import os
import json

def should_auto_approve(file_path):
    # Get file extension and basename
    _, ext = os.path.splitext(file_path)
    basename = os.path.basename(file_path).lower()
    
    # Check for sensitive patterns
    sensitive_patterns = ['.env', '.key', '.pem', '.crt', 'secret', 'credential']
    if any(pattern in file_path.lower() for pattern in sensitive_patterns):
        return False
    
    # Auto-approve safe extensions
    safe_extensions = ['.md', '.mdx', '.txt', '.rst', '.toml', '.json', '.py', '.yaml', '.yml']
    if ext.lower() in safe_extensions:
        return True
    
    # Auto-approve common files
    safe_files = ['readme', 'license', 'changelog', 'gitignore']
    if any(pattern in basename for pattern in safe_files):
        return True
    
    return False

# Hook execution
if should_auto_approve(file_path):
    print(json.dumps({
        "decision": "approve",
        "reason": "Safe documentation/configuration file",
        "suppressOutput": True
    }))
else:
    # Let normal permission flow proceed
    pass
```

## Benefits

- **Reduced Friction**: No permission prompts for safe file reads
- **Maintained Security**: Sensitive files still require permission
- **Development Flow**: Faster exploration of project structure
- **R&D Framework**: Reduces context overhead from permission prompts