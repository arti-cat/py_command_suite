---
name: secrets-scan
description: Secrets detection with detect-secrets and truffleHog integration
---

# Secrets Scanning Command

Comprehensive secrets detection for Python projects using industry-standard tools to prevent credential exposure.

## Core Security Scanning

I'll perform multi-layered secrets detection using:

### 1. detect-secrets Integration
```bash
# Install detect-secrets via UV
uv add --group dev detect-secrets

# Initialize baseline if not exists
if [ ! -f .secrets.baseline ]; then
    uvx detect-secrets scan --baseline .secrets.baseline
fi

# Scan for new secrets
uvx detect-secrets scan --baseline .secrets.baseline --force-use-all-plugins
```

### 2. Manual Pattern Detection
I'll scan for common credential patterns:
- API keys (AWS, Google, GitHub, OpenAI)
- Database connection strings
- Private keys and certificates
- JWT tokens and secrets
- Environment variable leaks

### 3. File Type Analysis
**High-Risk Files:**
- `.env*` files (environment variables)
- `config/` directories
- `*.yaml`, `*.yml` (configuration files)
- `*.json` (potential config/service files)
- `*.py` (hardcoded secrets in source)
- `requirements.txt`, `pyproject.toml` (dependency analysis)

**Safe to Skip:**
- Binary files, images, compiled assets
- `node_modules/`, `__pycache__/`, `.venv/`
- Large data files and logs

### 4. Git History Scanning
```bash
# Check recent commits for accidentally committed secrets
git log --oneline -10 --grep="password\|secret\|key\|token" --all
```

## Security Report Generation

I'll create a comprehensive security report:

```markdown
# Secrets Scanning Report - {{timestamp}}

## Scan Summary
- **Files Scanned**: {{file_count}}
- **Patterns Checked**: {{pattern_count}}
- **Potential Issues**: {{issue_count}}
- **Critical Findings**: {{critical_count}}

## Findings

### Critical Issues (Immediate Action Required)
{{critical_findings}}

### Warnings (Review Recommended)
{{warning_findings}}

### Best Practices Violations
{{best_practice_issues}}

## Remediation Steps
{{remediation_guidance}}

## Prevention Recommendations
- Add .secrets.baseline to version control
- Configure pre-commit hooks for secrets detection
- Use environment variables for all sensitive data
- Implement proper secrets management (Azure Key Vault, AWS Secrets Manager)
```

## Integration with Development Workflow

### Pre-commit Hook Integration
I'll suggest adding to `.pre-commit-config.yaml`:
```yaml
repos:
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets
        args: ['--baseline', '.secrets.baseline']
```

### Environment Variable Validation
I'll check for:
- Missing `.env.example` template files
- Proper `.gitignore` entries for environment files
- Use of python-dotenv for secure environment loading

## UV Package Management

All security tools managed via UV:
```bash
# Development dependencies for security scanning
uv add --group dev detect-secrets truffleHog gitpython

# Optional enterprise tools
uv add --group security bandit safety semgrep
```

## False Positive Management

I'll help configure `.secrets.baseline` to manage false positives:
- Whitelist known safe patterns
- Document exceptions with explanations
- Regular baseline updates with team review

## Compliance and Standards

Scanning aligns with:
- **OWASP Top 10** - Sensitive Data Exposure prevention
- **CIS Controls** - Data protection and access management
- **SOC 2** - Security monitoring and incident response
- **GDPR/Privacy** - Data protection impact assessments

## Emergency Response

If active credentials are detected:
1. **Immediate**: Rotate/revoke compromised credentials
2. **Short-term**: Remove from version control history
3. **Long-term**: Implement proper secrets management
4. **Documentation**: Update incident response procedures

## Output Artifacts

- **Report**: `agents/reports/secrets-scan-{{timestamp}}.md`
- **Baseline**: `.secrets.baseline` (if created/updated)
- **Recommendations**: Security improvement suggestions
- **Integration**: Pre-commit hook configuration guidance

This command provides enterprise-grade secrets detection suitable for any Python project, from startups to large organizations.