---
name: security
description: Comprehensive security analysis via security-auditor agent
orchestrates: security-auditor
output-style: security-report
---

# Comprehensive Security Analysis

I'll orchestrate a complete security analysis of your Python project using our specialized security-auditor agent.

## Agent Delegation

I'll delegate comprehensive security scanning to our `security-auditor` agent with full project context:

### Context Provided to Agent
- **Project Structure**: Framework detection and file organization
- **Dependencies**: Complete pyproject.toml and lock file analysis  
- **Security Baseline**: Existing .secrets.baseline and previous scan results
- **Compliance Requirements**: OWASP, CIS, SOC 2, GDPR alignment needs

### Security Analysis Scope
- **Secrets Detection**: detect-secrets baseline and scanning
- **Static Analysis**: bandit and semgrep SAST analysis
- **Dependency Vulnerabilities**: safety and pip-audit scanning
- **License Compliance**: License compatibility and legal analysis
- **Security Best Practices**: Code patterns and configuration review

## Expected Output

Results will be formatted using our `security-report` output style for:
- Executive summary with security status
- Detailed findings by category
- Prioritized remediation plan
- Compliance assessment
- Implementation recommendations

## Agent Brief

**Security-Auditor Agent Assignment:**
- **Tools**: Read, Write, Bash (for security tool execution)
- **Focus**: Comprehensive security analysis with enterprise-grade reporting
- **Context**: Complete project understanding with dependency analysis
- **Deliverables**: Professional security assessment with actionable recommendations
- **Integration**: Results saved to `agents/reports/security-scan-{{timestamp}}.md`

The security-auditor agent will provide thorough analysis while I maintain clean context for continued development work.