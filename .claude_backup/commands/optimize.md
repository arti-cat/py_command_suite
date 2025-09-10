---
name: optimize
description: Performance optimization analysis with static code analysis, complexity assessment, and actionable improvement recommendations
---

# Performance Optimization Command

Enterprise-grade performance optimization suite implementing static code analysis, complexity assessment, memory optimization analysis, and framework-specific optimization recommendations with actionable improvement plans and integration with profiling and benchmarking results.

## Multi-Layer Optimization Analysis

I'll perform comprehensive performance optimization analysis using industry-standard tools:

### 1. Static Code Analysis for Performance
```bash
# Install optimization analysis tools via UV
uv add --group dev vulture bandit radon complexity-validator cyclomatic-complexity
uv add --group dev flake8-performance pyflakes-docstrings pylint-performance
uv add --group dev memray py-spy ast-grep

# Performance anti-pattern detection
uvx vulture --min-confidence 80 src/ > agents/reports/dead-code-analysis.txt
uvx radon cc src/ --json > agents/reports/complexity-analysis.json
uvx radon mi src/ --json > agents/reports/maintainability-index.json

# Performance-specific linting
uvx flake8 --select=PERF src/ > agents/reports/performance-linting.txt
uvx pylint --load-plugins=pylint.extensions.check_elif src/ --disable=all --enable=performance
```

### 2. Code Complexity and Big O Analysis
```bash
# Cyclomatic complexity analysis
python -c "
import ast
import json
from pathlib import Path
from typing import Dict, List, Any

class ComplexityAnalyzer(ast.NodeVisitor):
    def __init__(self):
        self.functions = {}
        self.current_function = None
        
    def visit_FunctionDef(self, node):
        complexity = self.calculate_complexity(node)
        big_o_estimate = self.estimate_big_o(node)
        
        self.functions[node.name] = {
            'complexity': complexity,
            'big_o_estimate': big_o_estimate,
            'line_count': node.end_lineno - node.lineno if hasattr(node, 'end_lineno') else 0,
            'nested_loops': self.count_nested_loops(node),
            'optimization_opportunities': self.identify_optimizations(node)
        }
        self.generic_visit(node)
    
    def calculate_complexity(self, node):
        complexity = 1  # Base complexity
        for child in ast.walk(node):
            if isinstance(child, (ast.If, ast.For, ast.While, ast.With, ast.Try)):
                complexity += 1
            elif isinstance(child, ast.BoolOp):
                complexity += len(child.values) - 1
        return complexity
    
    def estimate_big_o(self, node):
        nested_loops = self.count_nested_loops(node)
        if nested_loops >= 3:
            return 'O(n³) or worse'
        elif nested_loops == 2:
            return 'O(n²)'
        elif nested_loops == 1:
            return 'O(n)'
        else:
            return 'O(1) or O(log n)'
    
    def count_nested_loops(self, node):
        max_depth = 0
        current_depth = 0
        
        for child in ast.walk(node):
            if isinstance(child, (ast.For, ast.While)):
                current_depth += 1
                max_depth = max(max_depth, current_depth)
            elif isinstance(child, ast.FunctionDef) and child != node:
                current_depth = 0
        
        return max_depth
    
    def identify_optimizations(self, node):
        opportunities = []
        for child in ast.walk(node):
            # String concatenation in loops
            if isinstance(child, ast.For):
                for subchild in ast.walk(child):
                    if isinstance(subchild, ast.AugAssign) and isinstance(subchild.op, ast.Add):
                        opportunities.append('Use join() instead of string concatenation in loops')
            
            # List comprehension opportunities
            if isinstance(child, ast.For) and any(isinstance(c, ast.Append) for c in ast.walk(child)):
                opportunities.append('Consider list comprehension for better performance')
        
        return opportunities

# Analyze all Python files
analysis_results = {}
for py_file in Path('src').rglob('*.py'):
    try:
        with open(py_file) as f:
            tree = ast.parse(f.read())
        analyzer = ComplexityAnalyzer()
        analyzer.visit(tree)
        analysis_results[str(py_file)] = analyzer.functions
    except Exception as e:
        print(f'Error analyzing {py_file}: {e}')

with open('agents/reports/complexity-big-o-analysis.json', 'w') as f:
    json.dump(analysis_results, f, indent=2)
"
```

### 3. Memory Optimization Analysis
```bash
# Memory usage pattern analysis
python -c "
import ast
import json
from pathlib import Path
from typing import List, Dict, Any

class MemoryOptimizationAnalyzer(ast.NodeVisitor):
    def __init__(self):
        self.memory_issues = []
        self.optimization_opportunities = []
    
    def visit_ListComp(self, node):
        # Large list comprehensions
        if self.is_potentially_large(node):
            self.optimization_opportunities.append({
                'type': 'generator_expression',
                'line': node.lineno,
                'suggestion': 'Consider generator expression for memory efficiency'
            })
        self.generic_visit(node)
    
    def visit_For(self, node):
        # Check for range() with large numbers
        if isinstance(node.iter, ast.Call) and isinstance(node.iter.func, ast.Name):
            if node.iter.func.id == 'range' and len(node.iter.args) > 0:
                if isinstance(node.iter.args[-1], ast.Constant) and node.iter.args[-1].value > 10000:
                    self.memory_issues.append({
                        'type': 'large_range',
                        'line': node.lineno,
                        'suggestion': 'Large range detected, consider itertools or generators'
                    })
        self.generic_visit(node)
    
    def visit_Call(self, node):
        # dict() constructor vs literal
        if isinstance(node.func, ast.Name) and node.func.id == 'dict':
            self.optimization_opportunities.append({
                'type': 'dict_literal',
                'line': node.lineno,
                'suggestion': 'Use dict literal {} instead of dict() constructor'
            })
        
        # list() constructor vs literal
        if isinstance(node.func, ast.Name) and node.func.id == 'list':
            self.optimization_opportunities.append({
                'type': 'list_literal',
                'line': node.lineno,
                'suggestion': 'Use list literal [] instead of list() constructor'
            })
        
        self.generic_visit(node)
    
    def is_potentially_large(self, node):
        # Heuristic to detect potentially large comprehensions
        for child in ast.walk(node):
            if isinstance(child, ast.Call) and isinstance(child.func, ast.Name):
                if child.func.id in ['range', 'enumerate'] and child.args:
                    if isinstance(child.args[-1], ast.Constant) and child.args[-1].value > 1000:
                        return True
        return False

# Analyze memory patterns
memory_analysis = {}
for py_file in Path('src').rglob('*.py'):
    try:
        with open(py_file) as f:
            tree = ast.parse(f.read())
        analyzer = MemoryOptimizationAnalyzer()
        analyzer.visit(tree)
        memory_analysis[str(py_file)] = {
            'memory_issues': analyzer.memory_issues,
            'optimization_opportunities': analyzer.optimization_opportunities
        }
    except Exception as e:
        print(f'Error analyzing {py_file}: {e}')

with open('agents/reports/memory-optimization-analysis.json', 'w') as f:
    json.dump(memory_analysis, f, indent=2)
"
```

### 4. Database Optimization Analysis
```bash
# Database query optimization analysis
python -c "
import ast
import re
import json
from pathlib import Path
from typing import List, Dict, Any

class DatabaseOptimizationAnalyzer(ast.NodeVisitor):
    def __init__(self):
        self.query_issues = []
        self.orm_optimizations = []
        self.n_plus_one_risks = []
    
    def visit_Call(self, node):
        # Django ORM N+1 detection
        if self.is_django_query(node):
            self.analyze_django_query(node)
        
        # Raw SQL analysis
        if self.is_raw_sql(node):
            self.analyze_raw_sql(node)
        
        # SQLAlchemy analysis
        if self.is_sqlalchemy_query(node):
            self.analyze_sqlalchemy_query(node)
        
        self.generic_visit(node)
    
    def is_django_query(self, node):
        if isinstance(node.func, ast.Attribute):
            return node.func.attr in ['filter', 'get', 'all', 'select_related', 'prefetch_related']
        return False
    
    def analyze_django_query(self, node):
        # Check for missing select_related/prefetch_related
        if node.func.attr in ['filter', 'all'] and not self.has_related_optimization(node):
            self.n_plus_one_risks.append({
                'type': 'missing_select_related',
                'line': node.lineno,
                'suggestion': 'Consider adding select_related() or prefetch_related() for foreign key access'
            })
    
    def has_related_optimization(self, node):
        # Check if query chain includes select_related or prefetch_related
        parent = node
        while isinstance(parent, ast.Call) and isinstance(parent.func, ast.Attribute):
            if parent.func.attr in ['select_related', 'prefetch_related']:
                return True
            parent = parent.func.value if hasattr(parent.func, 'value') else None
        return False
    
    def is_raw_sql(self, node):
        if isinstance(node.func, ast.Attribute) and node.func.attr == 'execute':
            return True
        return False
    
    def analyze_raw_sql(self, node):
        if node.args:
            # Check for SQL injection risks and optimization opportunities
            if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
                sql = node.args[0].value.upper()
                if 'SELECT *' in sql:
                    self.query_issues.append({
                        'type': 'select_star',
                        'line': node.lineno,
                        'suggestion': 'Avoid SELECT * queries, specify needed columns'
                    })
                if 'ORDER BY' not in sql and 'LIMIT' in sql:
                    self.query_issues.append({
                        'type': 'limit_without_order',
                        'line': node.lineno,
                        'suggestion': 'LIMIT without ORDER BY can produce inconsistent results'
                    })
    
    def is_sqlalchemy_query(self, node):
        if isinstance(node.func, ast.Attribute):
            return node.func.attr in ['query', 'filter', 'join', 'options']
        return False
    
    def analyze_sqlalchemy_query(self, node):
        # SQLAlchemy-specific optimizations
        if node.func.attr == 'query' and not self.has_eager_loading(node):
            self.orm_optimizations.append({
                'type': 'lazy_loading_risk',
                'line': node.lineno,
                'suggestion': 'Consider eager loading with joinedload() or selectinload()'
            })

# Analyze database patterns
db_analysis = {}
for py_file in Path('src').rglob('*.py'):
    try:
        with open(py_file) as f:
            tree = ast.parse(f.read())
        analyzer = DatabaseOptimizationAnalyzer()
        analyzer.visit(tree)
        db_analysis[str(py_file)] = {
            'query_issues': analyzer.query_issues,
            'orm_optimizations': analyzer.orm_optimizations,
            'n_plus_one_risks': analyzer.n_plus_one_risks
        }
    except Exception as e:
        print(f'Error analyzing {py_file}: {e}')

with open('agents/reports/database-optimization-analysis.json', 'w') as f:
    json.dump(db_analysis, f, indent=2)
"
```

## Optimization Report Generation

I'll create comprehensive optimization reports with actionable recommendations:

```markdown
# Performance Optimization Report - {{timestamp}}

## Executive Summary
- **Optimization Score**: {{overall_score}}/100
- **Critical Issues**: {{critical_count}} performance bottlenecks
- **Optimization Opportunities**: {{opportunity_count}} improvements identified
- **Potential Performance Gain**: {{performance_gain_estimate}}%
- **Implementation Effort**: {{effort_estimate}} person-days

## Code Complexity Analysis

### Function Complexity Assessment
| Function | File | Complexity | Big O | Issues | Optimization Priority |
|----------|------|------------|-------|--------|----------------------|
{{complexity_table}}

### High-Complexity Functions (>10)
{{high_complexity_functions}}

### Big O Analysis Summary
- **O(n³) or worse**: {{cubic_functions}} functions
- **O(n²)**: {{quadratic_functions}} functions  
- **O(n)**: {{linear_functions}} functions
- **O(1)/O(log n)**: {{constant_functions}} functions

## Performance Anti-Patterns Detected

### Critical Performance Issues
{{critical_performance_issues}}

### String Concatenation Inefficiencies
| File | Line | Current Pattern | Optimized Pattern | Performance Gain |
|------|------|-----------------|-------------------|------------------|
{{string_concatenation_issues}}

### Loop Optimization Opportunities
{{loop_optimization_opportunities}}

### Data Structure Inefficiencies
{{data_structure_issues}}

## Memory Optimization Analysis

### Memory Usage Patterns
- **Large Object Allocations**: {{large_allocations}} detected
- **Generator Opportunities**: {{generator_opportunities}} list comprehensions
- **Memory Leak Risks**: {{memory_leak_risks}} potential issues
- **Object Lifecycle Issues**: {{lifecycle_issues}} patterns

### Memory Optimization Recommendations
{{memory_optimization_recommendations}}

### Constructor vs Literal Analysis
| Pattern | Occurrences | Performance Impact | Recommended Change |
|---------|-------------|-------------------|-------------------|
| dict() constructor | {{dict_constructor_count}} | {{dict_impact}}% slower | Use {} literal |
| list() constructor | {{list_constructor_count}} | {{list_impact}}% slower | Use [] literal |
| tuple() constructor | {{tuple_constructor_count}} | {{tuple_impact}}% slower | Use () literal |

## Database Optimization Analysis

### Query Performance Issues
{{database_query_issues}}

### N+1 Query Detection
| File | Line | Risk Level | Recommendation |
|------|------|------------|----------------|
{{n_plus_one_analysis}}

### ORM Optimization Opportunities
{{orm_optimization_opportunities}}

### Connection Pool Analysis
- **Pool Utilization**: {{pool_utilization}}%
- **Connection Leaks**: {{connection_leaks}} potential issues
- **Query Caching**: {{query_caching_opportunities}} opportunities

## Async/Concurrency Optimization

### Async Pattern Analysis
{{async_pattern_analysis}}

### Event Loop Efficiency
- **Blocking Operations**: {{blocking_operations}} detected
- **Async/Await Inefficiencies**: {{async_inefficiencies}}
- **Task Creation Overhead**: {{task_overhead_issues}}

### GIL Impact Assessment
{{gil_impact_analysis}}

### Thread Pool Optimization
{{thread_pool_optimization}}

## Framework-Specific Optimizations

### Django Optimizations (if detected)
- **QuerySet Optimizations**: {{django_queryset_optimizations}}
- **Template Rendering**: {{django_template_optimizations}}
- **Middleware Efficiency**: {{django_middleware_optimizations}}
- **Cache Strategy**: {{django_cache_optimizations}}

### FastAPI Optimizations (if detected)
- **Dependency Injection**: {{fastapi_di_optimizations}}
- **Async Route Patterns**: {{fastapi_async_optimizations}}
- **Serialization Efficiency**: {{fastapi_serialization_optimizations}}

### Flask Optimizations (if detected)
- **Route Handler Efficiency**: {{flask_route_optimizations}}
- **Request Processing**: {{flask_request_optimizations}}
- **Session Management**: {{flask_session_optimizations}}

## Integration with Profiling Data

### Profile-Guided Optimizations
{{profile_integration_analysis}}

### Hot Path Optimization
- **CPU Hotspots**: {{cpu_hotspot_optimizations}}
- **Memory Hotspots**: {{memory_hotspot_optimizations}}
- **I/O Bottlenecks**: {{io_optimization_opportunities}}

### Benchmark-Driven Recommendations
{{benchmark_integration_analysis}}

## Optimization Implementation Plan

### Phase 1: Quick Wins (0-1 week)
{{phase_1_optimizations}}

### Phase 2: Medium Impact (1-4 weeks)
{{phase_2_optimizations}}

### Phase 3: Architectural Changes (1-3 months)
{{phase_3_optimizations}}

## Performance Budget Impact

### Optimization ROI Analysis
| Optimization | Implementation Effort | Performance Gain | ROI Score |
|--------------|---------------------|------------------|-----------|
{{optimization_roi_table}}

### Budget Compliance Improvements
{{budget_compliance_improvements}}

## Code Quality Metrics

### Maintainability Index
- **Average MI Score**: {{maintainability_score}}/100
- **Functions Below Threshold**: {{low_maintainability_count}}
- **Refactoring Candidates**: {{refactoring_candidates}}

### Technical Debt Performance Impact
{{technical_debt_analysis}}

## Automated Optimization Tools

### Recommended Tool Integration
```bash
# Add performance optimization tools
uv add --group dev autopep8 isort autoflake
uv add --group dev ruff-performance vulture bandit

# Automated code optimization
uvx autopep8 --in-place --aggressive --aggressive src/
uvx autoflake --remove-all-unused-imports --in-place src/*.py
uvx vulture --remove src/
```

### CI/CD Performance Gate Integration
{{cicd_integration_recommendations}}

## Performance Monitoring Setup

### Continuous Optimization Monitoring
```python
# Performance monitoring decorator
import functools
import time
import logging
from typing import Callable, Any

performance_logger = logging.getLogger('performance')

def monitor_performance(threshold_ms: float = 100):
    def decorator(func: Callable) -> Callable:
        @functools.wraps(func)
        def wrapper(*args, **kwargs) -> Any:
            start = time.perf_counter()
            result = func(*args, **kwargs)
            end = time.perf_counter()
            
            duration_ms = (end - start) * 1000
            if duration_ms > threshold_ms:
                performance_logger.warning(
                    f'{func.__name__} took {duration_ms:.2f}ms (threshold: {threshold_ms}ms)'
                )
            
            return result
        return wrapper
    return decorator
```

### Alerting and Regression Detection
{{alerting_recommendations}}
```

## Optimization Validation Framework

### Before/After Comparison
```bash
# Pre-optimization baseline
/benchmark --store-baseline optimization-before
/profile --baseline --output pre-optimization-profile.json

# Post-optimization validation  
/benchmark --compare optimization-before
/profile --compare pre-optimization-profile.json
```

### A/B Testing for Optimizations
{{ab_testing_framework}}

### Performance Regression Prevention
{{regression_prevention_strategy}}

## UV-Native Optimization Toolchain

All optimization tools integrated via UV package management:
```bash
# Core optimization analysis tools
uv add --group dev vulture radon bandit complexity-validator

# Performance linting
uv add --group dev flake8-performance pylint-performance

# Memory analysis tools
uv add --group dev memray pympler memory-profiler

# Database optimization
uv add --group dev django-debug-toolbar sqlalchemy-utils

# Async/concurrency analysis
uv add --group dev aiohttp-devtools asyncio-telemetry

# Code quality tools
uv add --group dev autopep8 autoflake isort black
```

## Output Artifacts

- **Optimization Report**: `agents/reports/optimize-analysis-{{timestamp}}.md`
- **Complexity Analysis**: `agents/reports/complexity-big-o-analysis.json`
- **Memory Optimization**: `agents/reports/memory-optimization-analysis.json`  
- **Database Analysis**: `agents/reports/database-optimization-analysis.json`
- **Performance Issues**: `agents/reports/performance-anti-patterns.json`
- **Implementation Plan**: `agents/reports/optimization-implementation-plan.md`
- **ROI Analysis**: `agents/reports/optimization-roi-analysis.json`

This command provides enterprise-grade performance optimization analysis suitable for organizations requiring comprehensive code analysis, actionable optimization recommendations, and integration with existing profiling and benchmarking workflows for continuous performance improvement.