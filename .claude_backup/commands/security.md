---
name: security
description: Comprehensive security analysis with SAST, dependency scanning, and compliance alignment
---

# Security Analysis Command

Enterprise-grade security analysis suite for Python projects implementing comprehensive SAST, dependency vulnerability scanning, and security compliance validation.

## Multi-Layer Security Analysis

I'll perform comprehensive security analysis using industry-standard tools:

### 1. Static Application Security Testing (SAST)
```bash
# Install security analysis tools via UV
uv add --group dev bandit semgrep safety detect-secrets

# Bandit - Python-specific security linting
uvx bandit -r . -f json -o agents/reports/bandit-results.json
uvx bandit -r . --severity-level medium --confidence-level medium

# Semgrep - Multi-language SAST with OWASP rules
uvx semgrep --config=auto --json --output=agents/reports/semgrep-results.json .
```

### 2. Dependency Vulnerability Scanning
```bash
# Safety - Known vulnerability database scanning
uvx safety check --json --output agents/reports/safety-results.json

# UV vulnerability audit (built-in)
uv pip check --verbose

# Advanced dependency analysis
uvx pip-audit --format=json --output=agents/reports/pip-audit-results.json
```

### 3. Secrets Detection Integration
```bash
# detect-secrets baseline and scanning
if [ ! -f .secrets.baseline ]; then
    uvx detect-secrets scan --baseline .secrets.baseline
fi
uvx detect-secrets scan --baseline .secrets.baseline --force-use-all-plugins
```

### 4. Code Quality Security Patterns
**High-Priority Security Checks:**
- SQL injection vulnerabilities (ORM usage patterns)
- Command injection risks (subprocess, os.system usage)
- Path traversal vulnerabilities (file operations)
- Insecure deserialization (pickle, eval usage)
- Cryptographic implementation issues
- Authentication and authorization flaws

**Framework-Specific Analysis:**
- **Django**: CSRF protection, SQL injection, XSS prevention
- **FastAPI**: Input validation, dependency injection security
- **Flask**: Session management, template injection prevention

## Security Report Generation

I'll create a comprehensive security assessment:

```markdown
# Security Analysis Report - {{timestamp}}

## Executive Summary
- **Overall Security Score**: {{score}}/100
- **Critical Vulnerabilities**: {{critical_count}}
- **High-Risk Issues**: {{high_count}}  
- **Medium-Risk Issues**: {{medium_count}}
- **Compliance Status**: {{compliance_status}}

## SAST Analysis Results

### Critical Vulnerabilities (CVSS 9.0-10.0)
{{critical_vulnerabilities}}

### High-Risk Security Issues (CVSS 7.0-8.9)
{{high_risk_issues}}

### Medium-Risk Issues (CVSS 4.0-6.9)
{{medium_risk_issues}}

## Dependency Vulnerability Assessment

### Known CVE Vulnerabilities
{{cve_vulnerabilities}}

### Outdated Dependencies
{{outdated_dependencies}}

### License Compliance Issues
{{license_issues}}

## Secrets and Credential Exposure

### Detected Secrets
{{secrets_findings}}

### Environment Security
{{environment_security}}

## Security Best Practices Compliance

### OWASP Top 10 Alignment
- [ ] A01: Broken Access Control
- [ ] A02: Cryptographic Failures  
- [ ] A03: Injection Vulnerabilities
- [ ] A04: Insecure Design
- [ ] A05: Security Misconfiguration
- [ ] A06: Vulnerable Components
- [ ] A07: Authentication Failures
- [ ] A08: Software Integrity Failures
- [ ] A09: Logging/Monitoring Failures
- [ ] A10: Server-Side Request Forgery

### CIS Controls Implementation
{{cis_controls_status}}

## Remediation Roadmap

### Immediate Actions (0-7 days)
{{immediate_actions}}

### Short-term Improvements (1-4 weeks)  
{{short_term_actions}}

### Long-term Security Enhancements (1-3 months)
{{long_term_actions}}

## Security Tool Integration Recommendations

### CI/CD Pipeline Integration
{{cicd_recommendations}}

### IDE Security Plugin Configuration
{{ide_plugin_config}}
```

## Enterprise Security Integration

### Development Security Workflow
```bash
# Pre-commit security hooks
cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets
        args: ['--baseline', '.secrets.baseline']
  
  - repo: https://github.com/PyCQA/bandit
    rev: '1.7.5'
    hooks:
      - id: bandit
        args: ['-iii', '-ll']
        
  - repo: https://github.com/returntocorp/semgrep
    rev: 'v1.45.0'
    hooks:
      - id: semgrep
        args: ['--config=auto']
EOF
```

### Security Monitoring Setup
```bash
# GitHub Security Advisory integration
uv add --group dev pip-audit github3.py

# Automated security reporting
uvx pip-audit --format=cyclonedx-json --output=sbom.json
```

## UV-Native Security Toolchain

All security tools integrated via UV package management:
```bash
# Core security analysis tools
uv add --group dev bandit semgrep safety detect-secrets pip-audit

# Extended security toolkit  
uv add --group security checkov cyclonedx-bom vulndb

# Framework-specific security tools
uv add --group dev django-security flask-security fastapi-security
```

## Compliance Framework Alignment

### SOC 2 Type II Compliance
- **Security**: Continuous security monitoring implementation
- **Availability**: Dependency vulnerability management
- **Confidentiality**: Secrets management and data protection
- **Processing Integrity**: Secure coding practices validation
- **Privacy**: Data handling security assessment

### GDPR/Privacy Compliance
- Personal data handling security review
- Data encryption implementation validation  
- Access control and audit logging assessment
- Data breach prevention measures evaluation

### Industry Standards
- **NIST Cybersecurity Framework**: Risk assessment and management
- **ISO 27001**: Information security management alignment
- **PCI DSS**: Payment data security (if applicable)

## Advanced Security Features

### Container Security Scanning
```bash
# Docker security analysis (if Dockerfile present)
uvx dive --source=docker-archive analyze <image>
uvx hadolint Dockerfile
```

### Infrastructure as Code Security
```bash
# Terraform/CloudFormation security scanning
uvx checkov --framework terraform --output json
uvx cfn-lint **/*.yaml
```

### API Security Assessment
- OpenAPI security schema validation
- Authentication mechanism analysis
- Rate limiting and DOS protection review
- Input validation and sanitization assessment

## False Positive Management

### Baseline Configuration
- Maintain `.security-baseline.json` for accepted risks
- Document security exceptions with business justification
- Regular security baseline reviews with security team
- Automated baseline updates with approval workflow

### Risk Acceptance Workflow
1. **Vulnerability Assessment**: Technical impact and exploitability analysis
2. **Business Risk Evaluation**: Business context and acceptance criteria
3. **Compensating Controls**: Alternative security measures implementation
4. **Documentation**: Formal risk acceptance documentation
5. **Review Schedule**: Regular re-assessment of accepted risks

## Emergency Security Response

### Active Threat Detection
If critical vulnerabilities are identified:
1. **Immediate**: Deploy hotfix patches for critical CVEs
2. **Short-term**: Implement compensating security controls
3. **Medium-term**: Comprehensive security architecture review
4. **Long-term**: Security process and training improvements

### Incident Response Integration
- Automated security alert generation for critical findings
- Integration with SIEM/SOC monitoring systems  
- Escalation procedures for high-risk vulnerabilities
- Post-incident security improvement recommendations

## Output Artifacts

- **Comprehensive Report**: `agents/reports/security-scan-{{timestamp}}.md`
- **SARIF Results**: `agents/reports/security-results.sarif` (tool-agnostic format)
- **SBOM**: `agents/reports/software-bill-of-materials.json`
- **Compliance Matrix**: `agents/reports/compliance-assessment.json`
- **Action Plan**: `agents/reports/security-remediation-plan.md`
- **Executive Summary**: `agents/reports/security-executive-summary.pdf`

This command provides enterprise-grade security analysis suitable for organizations requiring comprehensive security posture assessment, regulatory compliance, and continuous security monitoring integration.