---
name: deps-audit
description: Dependency vulnerability scanning with safety and pip-audit integration
---

# Dependency Vulnerability Auditing

Comprehensive dependency vulnerability scanning for Python projects using industry-standard security tools.

## Core Vulnerability Scanning

I'll perform multi-layered dependency analysis using:

### 1. Safety Integration
```bash
# Install safety via UV
uv add --group dev safety

# Scan for known vulnerabilities
uvx safety check --json --output deps-safety-report.json
uvx safety check --short-report
```

### 2. pip-audit Integration  
```bash
# Install pip-audit via UV
uv add --group dev pip-audit

# Comprehensive vulnerability scan
uvx pip-audit --format=json --output=deps-audit-report.json
uvx pip-audit --desc --format=cyclone-dx --output=sbom.json
```

### 3. UV Native Scanning
```bash
# UV built-in dependency analysis
uv tree --show-version-specifiers
uv lock --upgrade-package vulnerable-package
```

## Vulnerability Assessment

### High-Risk Package Analysis
- **Direct Dependencies**: Critical packages with known CVEs
- **Transitive Dependencies**: Hidden vulnerabilities in sub-dependencies  
- **Outdated Packages**: Packages with security updates available
- **License Compatibility**: GPL, AGPL, and commercial license conflicts

### Scanning Coverage
- **CVE Database**: Known Common Vulnerabilities and Exposures
- **Security Advisories**: GitHub, PyPI, and vendor security notifications
- **Malicious Packages**: Typosquatting and supply chain attacks
- **License Violations**: Incompatible license combinations

## Report Generation

I'll create comprehensive vulnerability reports:

```markdown
# Dependency Vulnerability Report - {{timestamp}}

## Executive Summary
- **Total Dependencies**: {{total_count}}
- **Vulnerable Packages**: {{vulnerable_count}}
- **Critical Vulnerabilities**: {{critical_count}}
- **High Priority Fixes**: {{high_priority_count}}

## Critical Vulnerabilities (Immediate Action Required)
{{critical_vulnerabilities}}

## High Priority Issues
{{high_priority_vulnerabilities}}

## Medium/Low Priority Issues  
{{medium_low_vulnerabilities}}

## Remediation Plan
{{remediation_steps}}

## SBOM (Software Bill of Materials)
{{sbom_summary}}
```

## Integration with Development Workflow

### Pre-commit Hook Integration
```yaml
repos:
  - repo: local
    hooks:
      - id: safety-check
        name: Safety vulnerability scan
        entry: uvx safety check
        language: system
        files: requirements.*\.txt$|pyproject\.toml$
      - id: pip-audit
        name: Dependency audit
        entry: uvx pip-audit  
        language: system
        files: requirements.*\.txt$|pyproject\.toml$
```

### CI/CD Integration
```bash
# Security scanning in CI pipeline
uvx safety check --json --output safety-report.json
uvx pip-audit --format=json --output audit-report.json

# Exit on vulnerabilities (configurable severity threshold)
uvx safety check --continue-on-vulnerability-error
```

## UV Package Management

All security tools managed via UV:
```bash
# Development dependencies for vulnerability scanning
uv add --group dev safety pip-audit cyclone-dx

# Optional enhanced scanning tools
uv add --group security bandit semgrep
```

## Vulnerability Response Workflow

### 1. Critical Vulnerability Detection
```bash
# Immediate response for critical CVEs
uvx safety check --severity high --exit-code

# Generate emergency patch assessment
uvx pip-audit --desc --vulnerability-service osv
```

### 2. Remediation Planning
- **Immediate**: Update vulnerable packages to patched versions
- **Short-term**: Pin to safe versions if updates break compatibility  
- **Long-term**: Replace vulnerable dependencies with secure alternatives
- **Documentation**: Track security decisions and exceptions

### 3. Supply Chain Security
```bash
# Verify package integrity
uvx pip-audit --verify-hash

# Check for suspicious packages
uvx safety check --policy-file security-policy.json
```

## Enterprise Compliance

### Security Standards Alignment
- **OWASP Top 10**: A06 - Vulnerable and Outdated Components
- **CIS Controls**: 2.1 - Maintain Inventory of Software
- **SOC 2**: Security monitoring and incident response procedures
- **NIST Cybersecurity Framework**: Identify and protect functions

### Reporting Formats
- **JSON**: Machine-readable for security platforms
- **SARIF**: Integration with GitHub Security tab
- **CycloneDX SBOM**: Software Bill of Materials for compliance
- **Executive Summary**: Business stakeholder reporting

## Configuration Management

### Security Policy Configuration
```json
{
  "ignore_vulnerabilities": [],
  "severity_threshold": "medium",
  "exclude_packages": [],
  "custom_advisories": []
}
```

### Continuous Monitoring
```bash
# Scheduled vulnerability scanning
uvx safety check --policy-file .safety-policy.json
uvx pip-audit --requirement requirements.txt --format cyclone-dx
```

## Output Artifacts

- **Report**: `agents/reports/deps-audit-{{timestamp}}.md`
- **JSON Data**: `deps-audit-report.json`, `safety-report.json`
- **SBOM**: `sbom.json` (CycloneDX format)
- **Remediation Plan**: Prioritized vulnerability fixes
- **CI Integration**: Security pipeline configurations

This command provides enterprise-grade dependency vulnerability management suitable for any Python project, from startups to large organizations requiring SOC 2 compliance.