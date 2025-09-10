---
description: Build Python wheel and source distribution deterministically
allowed-tools: Bash, Read, Write
argument-hint: ""
---
Build Python package using UV's build system:

`uv build`

This creates:
- Wheel distribution (.whl) for fast installation
- Source distribution (.tar.gz) for compatibility

After successful build, write a summary to `agents/reports/artifacts-${DATE_HOUR}.txt` containing:
- Build artifacts created (with file sizes)
- SHA256 checksums for verification
- Package metadata (name, version)
- Any build warnings or issues

Output files are created in `dist/` directory. Keep report concise and focused on verification details.