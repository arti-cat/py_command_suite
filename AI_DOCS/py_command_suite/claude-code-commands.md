# Claude Code Commands: Best Practices and Creation Guide

## Overview

Claude Code Commands are pre-built slash commands that extend Claude Code's functionality with project-specific actions. They automate common tasks, provide quick access to operations, enhance productivity by reducing context switching, and standardize workflows across team members.

## Command Structure

Commands are defined in Markdown files located in the `.claude/commands/` directory. Each command follows a standardized format:

```markdown
# Command Name

Brief description of what the command does and its primary use case.

## Task

I'll [action description] for $ARGUMENTS following [relevant standards/practices].

## Process

I'll follow these steps:

1. [Step 1 description]
2. [Step 2 description]
3. [Step 3 description]
4. [Final step description]

## [Specific sections based on command type]

### [Category 1]
- [Feature 1 description]
- [Feature 2 description]
- [Feature 3 description]

### [Category 2]
- [Implementation detail 1]
- [Implementation detail 2]
- [Implementation detail 3]

## Best Practices

### [Practice Category]
- [Best practice 1]
- [Best practice 2]
- [Best practice 3]

I'll adapt to your project's [tools/framework] and follow established patterns.
```

## Command Types

### 1. Code Generation Commands
- Component generators (React, Vue, Angular)
- API endpoint generators
- Test file generators
- Configuration file generators

### 2. Code Analysis Commands
- Code quality analyzers
- Security audit commands
- Performance profilers
- Dependency analyzers

### 3. Build and Deploy Commands
- Build optimization commands
- Deployment automation
- Environment setup commands
- CI/CD pipeline generators

### 4. Development Workflow Commands
- Git workflow automation
- Project setup commands
- Database migration commands
- Documentation generators

## Naming Conventions

### File Naming
- Use lowercase with hyphens: `generate-component.md`
- Be descriptive and action-oriented: `optimize-bundle.md`
- Include target type: `analyze-security.md`

### Command Names
- Use clear, imperative verbs: "Generate Component"
- Include target and action: "Optimize Bundle Size"
- Keep names concise but descriptive: "Security Analyzer"

## Implementation Guidelines

When creating custom commands, follow these principles:

- **Single Responsibility**: Each command should focus on one specific task
- **Parameterization**: Make commands flexible with appropriate options
- **Documentation**: Include comprehensive usage examples
- **Performance**: Optimize for common use cases
- **Clear Naming**: Use descriptive, action-oriented command names
- **Consistent Syntax**: Follow established parameter patterns
- **Helpful Output**: Provide actionable feedback and suggestions
- **Error Handling**: Include clear error messages and recovery suggestions

## Installation Methods

### 1. CLI Parameter Installation (Recommended)
```bash
npx claude-code-templates@latest --command=check-file --yes
npx claude-code-templates@latest --command=generate-tests --yes
```

### 2. Direct Download
```bash
# Create commands directory if it doesn't exist
mkdir -p .claude/commands

# Install specific commands via direct download
curl -o .claude/commands/check-file.md \
  https://raw.githubusercontent.com/davila7/claude-code-templates/main/components/commands/check-file.md
```

### 3. Batch Installation
```bash
commands=("check-file" "generate-tests" "run-tests" "create-component")
for cmd in "${commands[@]}"; do
  curl -o .claude/commands/${cmd}.md \
    https://raw.githubusercontent.com/davila7/claude-code-templates/main/components/commands/${cmd}.md
done
```

## Command Examples

### Code Analysis Commands
```bash
/check-file src/components/UserProfile.tsx
/analyze-dependencies
/analyze-dependencies --outdated
```

### Testing Commands
```bash
/generate-tests src/utils/dateHelper.js
/generate-tests src/components/Button.tsx --framework=jest
/run-tests
/run-tests --changed
/run-tests --pattern=Button
```

### Code Generation Commands
```bash
/create-component UserCard --type=functional
/create-component Modal --with-styles --with-tests
/generate-api-client swagger.json
```

### Optimization Commands
```bash
/optimize-imports src/
/optimize-imports --remove-unused --sort-alphabetically
```

## Testing and Quality Assurance

### Command Testing Checklist
1. **Functionality Testing**
   - Test with various argument combinations
   - Verify output format and content
   - Test error conditions and edge cases
   - Validate performance with large inputs

2. **Integration Testing**
   - Test with Claude Code CLI system
   - Verify component installation process
   - Test cross-platform compatibility
   - Validate with different project structures

3. **Documentation Testing**
   - Verify all examples work as documented
   - Test argument descriptions and options
   - Validate process steps and outcomes
   - Check for clarity and completeness

## Command Development Workflow

1. **Identify Need**: Find repetitive tasks that could be automated
2. **Design Interface**: Plan command syntax and parameters
3. **Write Documentation**: Create clear usage instructions
4. **Test Thoroughly**: Validate command works in various scenarios
5. **Share with Team**: Add to project's command collection

## Maintenance

### Regular Updates
- Check for Updates
- Review Changelog
- Test Updates

### Custom Command Maintenance
- Version Control
- Documentation
- Team Sync

## Python-Specific Considerations

For Python development, commands should integrate with:
- **UV Package Manager**: Use `uv add` for package installation and `uv run` for execution
- **Python Testing Frameworks**: pytest, unittest
- **Code Quality Tools**: black, isort, flake8, pylint, mypy
- **Virtual Environments**: Support for venv and conda
- **Django/FastAPI**: Framework-specific commands
- **Database Tools**: Alembic for migrations

### Example Python Commands
```bash
# Python environment
/setup-python-env --python=3.11 --with-uv
/activate-venv

# Code quality
/format-python --tool=black
/lint-python --strict
/type-check --mypy

# Testing
/test-python --coverage --parallel
/generate-pytest-tests src/

# Package management
/add-dependency --dev pytest
/update-dependencies --check-security
```

## Troubleshooting

### Command Not Found
1. Check Installation
2. Verify Naming
3. Restart Claude Code

### Command Not Working as Expected
1. Check Syntax
2. Verify Context
3. Update Commands

### Performance Issues
1. Limit Scope
2. Optimize Frequency
3. Clean Up