---
name: license-check
description: License compatibility analysis and compliance validation for Python dependencies
---

# License Compatibility Analysis

Comprehensive license analysis for Python projects ensuring legal compliance and identifying potential license conflicts.

## Core License Analysis

I'll perform multi-layered license compliance checking using:

### 1. pip-licenses Integration
```bash
# Install pip-licenses via UV
uv add --group dev pip-licenses

# Generate comprehensive license report
uvx pip-licenses --format=json --output-file=licenses-report.json
uvx pip-licenses --format=csv --output-file=licenses-summary.csv
uvx pip-licenses --format=html --output-file=licenses-report.html
```

### 2. license-expression Analysis
```bash
# Install license analysis tools
uv add --group dev license-expression licensecheck

# Validate license expressions and compatibility
uvx licensecheck --format json --output licenses-detailed.json
```

### 3. Custom License Scanning
```bash
# Scan source code for embedded licenses
find . -name "LICENSE*" -o -name "COPYING*" -o -name "COPYRIGHT*"
find . -name "*.py" -exec grep -l "license\|copyright\|GPL\|MIT\|BSD" {} \;
```

## License Risk Assessment

### Risk Categories

**🔴 High Risk - Copyleft Licenses**
- **GPL v2/v3**: Requires source code disclosure for derivatives
- **AGPL v3**: Network copyleft, affects SaaS applications
- **LGPL**: Limited copyleft, linking restrictions

**🟡 Medium Risk - Permissive with Conditions**
- **Apache 2.0**: Patent grant, notice requirements
- **MPL 2.0**: File-level copyleft, disclosure requirements
- **EPL**: Eclipse Public License restrictions

**🟢 Low Risk - Permissive Licenses**
- **MIT**: Minimal restrictions, attribution required
- **BSD 2/3-Clause**: Permissive with attribution
- **ISC**: Simplified permissive license

**⚫ Unknown Risk - Proprietary/Custom**
- **Proprietary**: Commercial licenses requiring review
- **Custom**: Non-standard licenses requiring legal analysis
- **Dual Licensed**: Multiple license options available

## Compliance Validation

### License Compatibility Matrix
I'll analyze package combinations for conflicts:

```python
# Example compatibility analysis
INCOMPATIBLE_COMBINATIONS = {
    "GPL-2.0": ["Proprietary", "Commercial"],
    "AGPL-3.0": ["Proprietary", "Commercial", "MIT"],
    "GPL-3.0": ["GPL-2.0", "Proprietary"]
}
```

### Project License Policy Enforcement
```bash
# Check against project license policy
uvx pip-licenses --allow-only="MIT;BSD;Apache;ISC"
uvx pip-licenses --fail-on="GPL;AGPL;LGPL"
```

## Report Generation

I'll create comprehensive license compliance reports:

```markdown
# License Compliance Report - {{timestamp}}

## Executive Summary
- **Total Dependencies**: {{total_packages}}
- **License Types Found**: {{license_types_count}}
- **High Risk Licenses**: {{high_risk_count}}
- **License Conflicts**: {{conflict_count}}
- **Compliance Status**: {{overall_status}}

## License Distribution
{{license_distribution_chart}}

## High Risk Packages (Immediate Review Required)
{{high_risk_packages}}

## License Conflicts
{{license_conflicts}}

## Compliance Recommendations
{{compliance_recommendations}}

## Legal Review Required
{{legal_review_packages}}
```

## Enterprise License Management

### License Policy Configuration
```json
{
  "allowed_licenses": [
    "MIT", "BSD-2-Clause", "BSD-3-Clause", 
    "Apache-2.0", "ISC", "Python-2.0"
  ],
  "restricted_licenses": [
    "GPL-2.0", "GPL-3.0", "AGPL-3.0", "LGPL-2.1", "LGPL-3.0"
  ],
  "requires_review": [
    "MPL-2.0", "EPL-2.0", "CDDL-1.0"
  ],
  "project_license": "MIT"
}
```

### SPDX Compliance
```bash
# Generate SPDX-compliant license information
uvx pip-licenses --format=json | jq '.[] | {name, version, license}'

# SPDX license identifier validation
uvx license-expression --validate "MIT AND Apache-2.0"
```

## CI/CD Integration

### Pre-commit License Validation
```yaml
repos:
  - repo: local
    hooks:
      - id: license-check
        name: License compliance check
        entry: uvx pip-licenses --fail-on "GPL;AGPL;LGPL"
        language: system
        files: requirements.*\.txt$|pyproject\.toml$
```

### Automated License Monitoring
```bash
# CI pipeline license validation
uvx pip-licenses --format=json --output-file=licenses-ci.json
uvx pip-licenses --summary --fail-on="GPL;AGPL"

# Generate license report for legal review
uvx pip-licenses --format=html --output-file=licenses-review.html
```

## UV Package Management

All license tools managed via UV:
```bash
# Development dependencies for license analysis
uv add --group dev pip-licenses license-expression licensecheck

# Optional compliance tools
uv add --group compliance spdx-tools fossa-cli
```

## Legal Compliance Workflows

### 1. New Dependency Review
```bash
# Before adding new dependencies
uvx pip-licenses --packages new-package --format=json

# License compatibility check
uvx license-expression --validate "$(pip show package | grep License)"
```

### 2. Quarterly License Audits
```bash
# Comprehensive quarterly review
uvx pip-licenses --format=html --output-file=quarterly-license-audit.html
uvx pip-licenses --summary --order=license
```

### 3. Legal Exception Management
```json
{
  "license_exceptions": {
    "package-name": {
      "license": "GPL-2.0", 
      "justification": "Used only in development/testing",
      "approved_by": "Legal Team",
      "review_date": "2024-12-31"
    }
  }
}
```

## Open Source License Best Practices

### License File Management
- Maintain accurate LICENSE file in repository root
- Include copyright notices for all dependencies
- Document license decisions and exceptions
- Regular license audit and review processes

### Attribution Requirements
```bash
# Generate attribution file for distribution
uvx pip-licenses --format=plain-vertical --with-authors > ATTRIBUTION.txt

# Include in build artifacts
uvx pip-licenses --format=html > licenses.html
```

## Industry Standards Compliance

### Legal Framework Alignment
- **OSS Compliance**: Open Source License compliance
- **Corporate Policy**: Internal license approval processes  
- **Export Control**: ECCN and export regulation compliance
- **Supply Chain**: Software composition analysis requirements

### Audit Trail Maintenance
- License decision documentation
- Exception approval processes
- Regular compliance reviews
- Legal team collaboration workflows

## Output Artifacts

- **Report**: `agents/reports/license-check-{{timestamp}}.md`
- **JSON Data**: `licenses-report.json`, `licenses-detailed.json`
- **HTML Report**: `licenses-report.html` (stakeholder review)
- **CSV Summary**: `licenses-summary.csv` (spreadsheet analysis)
- **SPDX SBOM**: Standards-compliant software bill of materials
- **Attribution File**: `ATTRIBUTION.txt` for distribution

This command provides enterprise-grade license compliance management suitable for any Python project requiring legal review, open source compliance, or commercial distribution.