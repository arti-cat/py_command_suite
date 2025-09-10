---
name: project-init
description: Universal Python project scaffolding via project-scaffolder agent
orchestrates: project-scaffolder
output-style: project-status
---

# Universal Python Project Initialization

I'll create a universal Python project structure using our specialized project-scaffolder agent.

## Agent Delegation

I'll delegate project scaffolding to our `project-scaffolder` agent with comprehensive setup requirements:

### Context Provided to Agent
- **Project Name**: Target project identifier
- **Framework Detection**: Any existing framework patterns to preserve
- **UV Integration**: Complete UV-native package management setup
- **Quality Standards**: Modern Python tooling and best practices
- **Universal Compatibility**: Structure that works with any Python framework

### Project Scaffolding Scope
- **Modern Python Structure**: src/ layout with proper package organization
- **UV Package Management**: pyproject.toml, virtual environment, lock files
- **Quality Tooling**: ruff, mypy, pytest configuration with fixed pre-commit hooks
- **Security Baseline**: detect-secrets integration and .secrets.baseline
- **CI/CD Foundation**: GitHub Actions workflow with multi-Python testing
- **Documentation**: Comprehensive README and development setup guides

## Expected Output

Results will be formatted using our `project-status` output style for:
- Project initialization summary
- Environment setup verification
- Quality tool configuration status
- Framework compatibility assessment
- Development readiness confirmation

## Agent Brief

**Project-Scaffolder Agent Assignment:**
- **Tools**: Write, Bash (for project structure creation and setup)
- **Focus**: Universal Python project scaffolding with modern best practices
- **Context**: Target project requirements and compatibility needs
- **Deliverables**: Complete project setup ready for immediate development
- **Integration**: Setup report saved to `agents/reports/project-init-{{timestamp}}.md`

The project-scaffolder agent will create a production-ready Python project structure that immediately benefits from the entire Python Command Suite ecosystem while maintaining compatibility with any Python framework or application type.