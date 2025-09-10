---
name: project-status
description: Standardized project initialization and health report format
---

# Project Status Output Style

Standardized format for project initialization, health assessment, and development readiness reports.

## Report Structure

### Project Overview
- **Project Name**: {{project_name}}
- **Status**: 🟢 READY | 🟡 NEEDS SETUP | 🔴 ISSUES FOUND
- **Report Date**: {{timestamp}}
- **Python Version**: {{python_version}}
- **Package Manager**: {{package_manager}} {{version}}

### 📋 **Initialization Summary**

#### ✅ **Completed Setup**
{{#each completed_tasks}}
- ✅ **{{task_name}}**: {{description}}
  {{#if details}}
  - {{details}}
  {{/if}}
{{/each}}

#### ⚠️ **Issues Found**
{{#each issues}}
- ⚠️ **{{issue_type}}**: {{description}}
  - **Impact**: {{impact_level}}
  - **Resolution**: {{resolution_steps}}
{{/each}}

#### ⏳ **Pending Tasks**
{{#each pending_tasks}}
- ⏳ **{{task_name}}**: {{description}}
  - **Next Action**: {{next_action}}
{{/each}}

### 🏗️ **Project Structure**

#### Directory Structure
```
{{project_name}}/
{{#each directory_structure}}
├── {{path}}{{#if description}} # {{description}}{{/if}}
{{/each}}
```

#### Key Files Status
| File | Status | Description |
|------|--------|-------------|
{{#each key_files}}
| {{filename}} | {{status_emoji}} {{status}} | {{description}} |
{{/each}}

### 🔧 **Development Environment**

#### Python Environment
- **Virtual Environment**: {{venv_status}} ({{venv_path}})
- **Python Path**: {{python_path}}
- **Package Manager**: {{package_manager}} {{pm_version}}
- **Dependencies**: {{total_dependencies}} packages ({{locked_dependencies}} locked)

#### Quality Tools Configuration
| Tool | Status | Configuration |
|------|--------|---------------|
| **Ruff** | {{ruff_status}} | {{ruff_config}} |
| **MyPy** | {{mypy_status}} | {{mypy_config}} |
| **Pytest** | {{pytest_status}} | {{pytest_config}} |
| **Pre-commit** | {{precommit_status}} | {{precommit_config}} |

#### Security Baseline
- **Secrets Detection**: {{secrets_baseline_status}}
- **Baseline File**: {{secrets_baseline_path}}
- **Security Scan**: {{security_scan_status}}

### 📦 **Dependencies Analysis**

#### Runtime Dependencies
{{#each runtime_dependencies}}
- **{{name}}** {{version}} {{#if description}}({{description}}){{/if}}
{{/each}}

#### Development Dependencies
{{#each dev_dependencies}}
- **{{name}}** {{version}} {{#if description}}({{description}}){{/if}}
{{/each}}

#### Dependency Health
- **Outdated Packages**: {{outdated_count}}
- **Security Vulnerabilities**: {{vulnerability_count}}
- **License Issues**: {{license_issues_count}}

### 🧪 **Testing Setup**

#### Test Coverage
- **Test Files**: {{test_file_count}}
- **Test Cases**: {{test_case_count}}
- **Coverage**: {{coverage_percentage}}%
- **Coverage Target**: {{coverage_target}}%

#### Test Status
{{#each test_results}}
- **{{test_suite}}**: {{passed}}/{{total}} tests passing
  {{#if failures}}
  - **Failures**: {{failure_count}} ({{failure_details}})
  {{/if}}
{{/each}}

### 🚀 **CI/CD Integration**

#### GitHub Actions
- **Workflow Files**: {{workflow_count}} configured
- **Status**: {{cicd_status}}
- **Last Run**: {{last_ci_run}}

#### Deployment Readiness
| Component | Status | Notes |
|-----------|--------|-------|
| **Docker** | {{docker_status}} | {{docker_notes}} |
| **Environment Config** | {{env_status}} | {{env_notes}} |
| **Health Checks** | {{health_status}} | {{health_notes}} |

### 🔍 **Framework Detection**

#### Detected Frameworks
{{#each detected_frameworks}}
- **{{framework_name}}** {{version}} (Confidence: {{confidence}}%)
  - **Features Used**: {{features}}
  - **Best Practices**: {{best_practices_status}}
  - **Optimizations Available**: {{optimizations}}
{{/each}}

#### Framework-Specific Status
{{#if django_status}}
**Django Project:**
- **Settings**: {{django_settings_status}}
- **Database**: {{django_db_status}}
- **Apps**: {{django_apps_count}} configured
{{/if}}

{{#if fastapi_status}}
**FastAPI Project:**
- **Routers**: {{fastapi_router_count}}
- **Async Patterns**: {{fastapi_async_status}}
- **OpenAPI**: {{openapi_status}}
{{/if}}

### 📊 **Project Health Score**

#### Overall Health: {{overall_health_score}}/100

| Category | Score | Status |
|----------|-------|--------|
| **Setup Completeness** | {{setup_score}}/25 | {{setup_status}} |
| **Quality Tools** | {{quality_score}}/25 | {{quality_status}} |
| **Security** | {{security_score}}/25 | {{security_status}} |
| **Testing** | {{testing_score}}/25 | {{testing_status}} |

### 🎯 **Recommendations**

#### High Priority Actions
{{#each high_priority_actions}}
1. **{{action}}**
   - **Reason**: {{reason}}
   - **Impact**: {{impact}}
   - **Effort**: {{effort}}
{{/each}}

#### Quick Wins
{{#each quick_wins}}
- **{{action}}**: {{description}} ({{time_estimate}})
{{/each}}

#### Long-term Improvements
{{#each long_term_improvements}}
- **{{improvement}}**: {{description}}
{{/each}}

### 🚀 **Getting Started**

#### Next Steps for Development
```bash
# 1. Activate environment
{{activation_command}}

# 2. Install dependencies  
{{install_command}}

# 3. Run tests
{{test_command}}

# 4. Start development
{{dev_command}}
```

#### Available Commands
{{#each available_commands}}
- **{{command}}**: {{description}}
{{/each}}

#### Framework-Specific Quickstart
{{#if framework_quickstart}}
{{framework_quickstart}}
{{/if}}

### 📚 **Documentation Links**

#### Project Documentation
{{#each documentation_links}}
- **{{title}}**: {{link}}
{{/each}}

#### Framework Resources
{{#each framework_resources}}
- **{{framework}}**: {{resource_links}}
{{/each}}

### Report Metadata

- **Generated by**: Python Command Suite Project Analysis
- **Analysis Tools**: {{analysis_tools}}
- **Report Duration**: {{analysis_duration}}
- **Configuration Hash**: {{config_hash}}

---

**Project Status**: {{final_status_message}}

**Ready for Development**: {{development_readiness}} | **Next Review**: {{next_review_date}}