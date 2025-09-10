---
description: Run dependency and code security scanning
allowed-tools: Bash, Read, Write
argument-hint: ""
---
Run comprehensive security audit using multiple tools:

**Dependency Security Scan:**
`uvx pip-audit -r pyproject.toml || true`

**Code Security Scan:**  
`uvx bandit -q -r src || true`

Both commands use `|| true` to continue execution even if issues are found, allowing full audit completion.

After scanning, write findings summary to `agents/reports/sec-${DATE_HOUR}.md` including:
- High/medium/low severity issue counts
- Critical vulnerabilities requiring immediate attention
- Recommended remediation actions
- False positive notes (if applicable)

Focus on actionable security insights and prioritized remediation steps.