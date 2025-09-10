---
description: Create/refresh Python environment with UV; lock and sync deterministically
allowed-tools: Bash, Read, Write
argument-hint: ""
---
Initialize or refresh the UV Python environment with deterministic dependency resolution.

Run the following UV commands idempotently:
- `uv venv` (create virtual environment if needed)
- `uv lock` (generate lockfile with pinned versions)  
- `uv sync` (install dependencies from lockfile)

After completion, write a brief environment report to `agents/reports/uv-setup-${DATE_HOUR}.md` including:
- Python version
- UV version
- Number of dependencies installed
- Any warnings or issues encountered

Keep output concise and focused on actionable information.