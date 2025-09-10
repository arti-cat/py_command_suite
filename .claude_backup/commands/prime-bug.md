---
description: Minimal priming for bug hunting and error investigation
allowed-tools: Read, Grep
---

# Bug Investigation Context Primer

Prime the agent for focused bug hunting with minimal context reads (≤500 tokens total).

## Purpose

Establish targeted debugging context without bloating the main context window. Focus on failure reproduction and root cause isolation.

## Focused Read Strategy

I'll read only failure-critical files:

### 1. Error Evidence (≤200 tokens)
- **Failing Tests**: Read specific test files that are failing
- **Error Traces**: Last stacktrace or pytest output 
- **Logs**: Recent error logs (last 20 lines max)

### 2. Target Investigation (≤200 tokens)  
- **Failed Module**: The specific module/function where error occurs
- **Related Code**: Only the failing function and its immediate dependencies
- **Test Setup**: Fixtures or setup code related to failing tests

### 3. Environment Context (≤100 tokens)
- **Dependencies**: Check pyproject.toml for version constraints
- **Python Version**: Confirm compatibility issues
- **Recent Changes**: Git diff of recent commits (if provided)

## Analysis Output

I'll emit a focused debugging plan:

### Failure Hypothesis (≤150 tokens)
```markdown
## Bug Analysis

**Error Type**: {{error_type}}
**Root Cause Theory**: {{hypothesis}}
**Affected Components**: {{components}}

**Evidence**:
- {{evidence_point_1}}
- {{evidence_point_2}}
- {{evidence_point_3}}
```

### Reproduction Plan (≤150 tokens)
```markdown
## Minimal Reproduction

**Single File Test**:
```python
# {{reproduction_test_name}}.py
{{minimal_test_code}}
```

**Expected**: {{expected_behavior}}
**Actual**: {{actual_error}}
```

### Fix Strategy (≤100 tokens)
```markdown
## Patch Plan

**Target**: {{target_file}}:{{line_range}}
**Change Type**: {{change_type}}
**Risk Level**: {{risk_assessment}}

**Validation**:
1. {{test_step_1}}
2. {{test_step_2}}
3. {{regression_check}}
```

## Bug Categories

### Import/Dependency Issues
- Missing imports, circular imports
- Version conflicts, missing packages
- Path resolution problems

### Logic Errors  
- Conditional logic bugs
- Loop termination issues
- State management problems

### Type/Data Issues
- Type mismatches, None handling
- Data structure assumptions
- Serialization/deserialization errors

### Integration Failures
- Database connection issues
- API call failures  
- File system operations

### Test-Specific Issues
- Fixture setup problems
- Mock configuration errors
- Test data inconsistencies

## Investigation Process

1. **Read Evidence**: Gather minimal failure information
2. **Isolate Scope**: Identify smallest reproducible case  
3. **Form Hypothesis**: Propose root cause theory
4. **Plan Fix**: Design minimal, targeted solution
5. **Suggest Validation**: Outline testing approach

## Delegation Strategy

For complex investigations, suggest:
- **fixer agent**: For implementing the minimal patch
- **background-runner**: For extensive test suite analysis
- **planner**: For multi-component architectural fixes

## Best Practices

### Context Conservation
- Read only failing components, not entire codebase
- Focus on error messages and stack traces
- Avoid reading passing tests (unless directly related)

### Python-Specific
- Check for common Python gotchas (mutable defaults, import issues)
- Consider async/await context if relevant
- Verify Python version compatibility

### Fix Strategy
- Prefer smallest possible change
- Maintain backward compatibility
- Add regression test alongside fix

I'll keep the total context addition under 500 tokens and delegate complex analysis to specialized agents.