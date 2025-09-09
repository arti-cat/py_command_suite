# Python Command Updater

Update and modify existing Python development commands. Safely edit command files with backup creation, version control integration, and Python-specific enhancements.

## Task

I'll update the existing command specified in $ARGUMENTS with improvements, bug fixes, or Python tooling enhancements while preserving functionality and following Claude Code standards.

## Process

I'll follow these steps:

1. **Locate and Analyze Existing Command**
   - Find the command file in `.claude/commands/`
   - Read and understand current implementation
   - Identify areas for improvement or required changes
   - Check for Python-specific integration opportunities

2. **Create Safety Backup**
   - Create timestamped backup of original command
   - Store in `.claude/backups/commands/` directory
   - Log changes in command modification history
   - Ensure version control safety

3. **Analyze Enhancement Opportunities**
   - **UV Integration**: Add or improve UV package manager usage
   - **Context7 Integration**: Enhance library documentation fetching
   - **Python Best Practices**: Update to latest Python conventions
   - **Framework Support**: Add Django, FastAPI, Flask awareness
   - **Quality Tools**: Integrate black, ruff, mypy, pytest

4. **Apply Updates with Validation**
   - Implement requested changes while preserving core functionality
   - Enhance with Python-specific improvements where applicable
   - Validate markdown syntax and Claude Code conventions
   - Test argument handling and edge cases

5. **Documentation and Verification**
   - Update command documentation and examples
   - Add changelog entry for modifications
   - Verify command works with existing workflows
   - Provide summary of changes made

## Update Categories

### Python Tooling Integration
- **UV Package Manager**: Add `uv add`, `uv remove`, `uv sync` integration
- **Type Checking**: Include mypy type checking capabilities
- **Code Quality**: Integrate black, isort, ruff formatting and linting
- **Testing**: Enhance pytest integration with fixtures and coverage

### Framework Enhancement
- **Django Support**: Add Django-specific patterns and management commands
- **FastAPI Integration**: Include async patterns and OpenAPI documentation
- **Flask Features**: Add blueprint support and application factory patterns
- **Data Science**: Integrate pandas, jupyter, and analysis workflows

### Context7 Library Integration
- **Real-time Documentation**: Add Context7 library research capabilities
- **Best Practices**: Include framework-specific pattern recommendations
- **Dependency Guidance**: Smart dependency selection with documentation

### Modern Python Features
- **Python 3.11+ Features**: Update to use latest language features
- **Async/Await Patterns**: Enhance async programming support
- **Type Hints**: Improve type annotation usage
- **Error Handling**: Implement modern exception handling patterns

## Safety Features

### Backup System
```bash
# Automatic backup creation
.claude/backups/commands/
├── command-name_2024-09-09_14-30-15.md
├── command-name_2024-09-08_10-15-30.md
└── modification-log.json
```

### Change Tracking
- Timestamps for all modifications
- Summary of changes made
- Backup file references
- User identification for team environments

### Rollback Capability
- Easy restoration from backups
- Command comparison tools
- Incremental change tracking
- Version control integration

## Enhancement Examples

### Adding UV Integration to Existing Command
```markdown
# Before Update
"Install dependencies using pip"

# After Update  
"Install dependencies using UV package manager (fallback to pip if unavailable)"

## Process Enhancement
1. Check for UV availability: `uv --version`
2. Use UV for faster dependency resolution: `uv add package-name`
3. Fallback to pip if UV not available: `pip install package-name`
4. Update lock files and virtual environment
```

### Adding Context7 Integration
```markdown
# Enhanced Library Research
1. Use Context7 to research library best practices
2. Fetch current documentation and usage patterns  
3. Include security and performance considerations
4. Provide framework-specific integration examples
```

### Framework Awareness Addition
```markdown
# Framework Detection Enhancement
1. Detect Django: Check for manage.py, settings.py
2. Detect FastAPI: Check for FastAPI imports, main.py patterns
3. Detect Flask: Check for Flask imports, app.py patterns
4. Adapt command behavior based on detected framework
```

## Usage Examples

```bash
# Update command with UV integration
/py:update-command setup-environment "Add UV package manager support"

# Enhance command with Context7 integration  
/py:update-command django-migrate "Add Context7 Django documentation integration"

# Update testing command with pytest enhancements
/py:update-command run-tests "Add coverage reporting and parallel execution"

# Add framework detection to generic command
/py:update-command format-code "Add Django, FastAPI, Flask specific formatting rules"
```

## Modification Types

### Bug Fixes
- Correct command syntax errors
- Fix argument handling issues
- Resolve path and environment problems
- Address edge case failures

### Feature Enhancements
- Add new functionality while preserving existing behavior
- Integrate modern Python tooling (UV, Context7)
- Enhance framework support and detection
- Improve error handling and user feedback

### Maintenance Updates
- Update to latest Python conventions and best practices
- Refresh library recommendations and documentation links
- Improve command performance and reliability
- Update examples and usage documentation

### Python-Specific Improvements
- Integrate UV package manager where beneficial
- Add Context7 library documentation fetching
- Include framework-specific optimizations
- Enhance type checking and quality tool integration

## Validation Checklist

### Functionality Verification
- [ ] Original command functionality preserved
- [ ] New features work as expected
- [ ] Arguments handled correctly
- [ ] Error cases managed appropriately

### Python Integration
- [ ] UV package manager integration where applicable
- [ ] Context7 library research included
- [ ] Framework detection and adaptation
- [ ] Quality tools (black, ruff, mypy) integrated

### Documentation Quality
- [ ] Clear usage examples provided
- [ ] Process steps well-documented
- [ ] Best practices included
- [ ] Change summary provided

### Safety Compliance
- [ ] Backup created successfully
- [ ] Changes logged in modification history
- [ ] Original functionality tested
- [ ] Rollback procedure verified

## Best Practices

### Update Strategy
- Make incremental changes rather than complete rewrites
- Preserve existing functionality while adding enhancements
- Test changes thoroughly before finalizing
- Document all modifications clearly

### Python Integration
- Always consider UV package manager integration opportunities
- Include Context7 library research where beneficial
- Add framework detection for Django, FastAPI, Flask
- Integrate quality tools following Python conventions

### Team Collaboration
- Create clear change documentation
- Use descriptive modification summaries
- Maintain backward compatibility where possible
- Coordinate with existing workflow patterns

I'll safely update your command with Python-specific enhancements while preserving all existing functionality and creating appropriate backups.