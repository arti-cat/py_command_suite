---
name: profile
description: Comprehensive Python application profiling with CPU, memory, and I/O performance analysis
---

# Performance Profiling Command

Enterprise-grade performance analysis suite for Python applications implementing comprehensive CPU profiling, memory analysis, and performance bottleneck identification with actionable optimization recommendations.

## Multi-Layer Performance Analysis

I'll perform comprehensive performance profiling using industry-standard tools:

### 1. Real-Time Application Profiling
```bash
# Install profiling tools via UV
uv add --group dev py-spy line-profiler memory-profiler cProfile-viz pympler

# py-spy - Real-time profiler for live applications
uvx py-spy record -o agents/reports/profile-cpu-flame.svg --duration 60 --pid {{PID}}
uvx py-spy record -o agents/reports/profile-cpu-flame.svg --duration 60 -- python your_app.py

# Generate interactive flame graph
uvx py-spy record -o agents/reports/profile-flame-interactive.html --format speedscope --duration 30 -- python your_app.py
```

### 2. Statistical Performance Profiling
```bash
# cProfile - Built-in statistical profiler
python -m cProfile -o agents/reports/profile-stats.prof your_app.py

# Generate visual call graph
uvx gprof2dot -f pstats agents/reports/profile-stats.prof | dot -Tsvg -o agents/reports/profile-callgraph.svg

# Profile specific functions with line_profiler
uvx kernprof -l -v your_script.py > agents/reports/line-profile-results.txt
```

### 3. Memory Performance Analysis
```bash
# memory_profiler - Line-by-line memory usage
uvx python -m memory_profiler your_script.py > agents/reports/memory-profile.txt

# mprof - Memory usage over time
uvx mprof run your_script.py
uvx mprof plot -o agents/reports/memory-usage-timeline.png

# pympler - Advanced memory analysis
python -c "
from pympler import tracker
tr = tracker.SummaryTracker()
# Run your code here
tr.print_diff()
" > agents/reports/memory-objects-analysis.txt
```

### 4. Framework-Specific Performance Analysis
**Framework Detection & Optimization:**
- **Django**: Database query profiling, template rendering analysis
- **FastAPI**: Async performance patterns, dependency injection overhead
- **Flask**: Request handling bottlenecks, template processing
- **Celery**: Task execution profiling, worker utilization

## Performance Report Generation

I'll create a comprehensive performance assessment:

```markdown
# Performance Profiling Report - {{timestamp}}

## Executive Summary
- **Overall Performance Score**: {{score}}/100
- **Critical Bottlenecks**: {{critical_count}}
- **CPU Hotspots Identified**: {{cpu_hotspots}}
- **Memory Issues**: {{memory_issues}}
- **Optimization Potential**: {{optimization_potential}}%

## CPU Performance Analysis

### Top CPU Consumers (Functions)
{{cpu_hotspots_table}}

### Call Graph Analysis
- **Most Called Function**: {{most_called_function}} ({{call_count}} calls)
- **Slowest Function**: {{slowest_function}} ({{avg_time}}ms avg)
- **Recursive Patterns**: {{recursive_analysis}}

### Flame Graph Insights
{{flame_graph_analysis}}

## Memory Performance Assessment

### Memory Usage Patterns
- **Peak Memory**: {{peak_memory}}MB
- **Memory Growth Rate**: {{growth_rate}}MB/min
- **Potential Leaks**: {{leak_indicators}}

### Memory Hotspots
{{memory_hotspots_table}}

### Garbage Collection Impact
- **GC Frequency**: {{gc_frequency}} collections/min
- **GC Impact**: {{gc_impact_percent}}% of execution time
- **Large Object Analysis**: {{large_objects}}

## I/O Performance Analysis

### Database Performance (if applicable)
- **Query Count**: {{query_count}}
- **Slow Queries**: {{slow_queries_count}} (>{{threshold}}ms)
- **N+1 Query Patterns**: {{n_plus_one_issues}}
- **Connection Pool Utilization**: {{connection_pool_usage}}%

### File I/O Analysis
- **File Operations**: {{file_ops_count}}
- **Large File Reads**: {{large_reads}}
- **Blocking I/O Time**: {{blocking_io_time}}ms

## Async/Concurrency Analysis

### Async Performance Patterns
- **Event Loop Utilization**: {{event_loop_usage}}%
- **Async Task Overhead**: {{async_overhead}}ms
- **Blocking Operations in Async**: {{blocking_in_async}}

### Concurrency Bottlenecks
- **Thread Pool Saturation**: {{thread_pool_status}}
- **Lock Contention**: {{lock_contention_analysis}}
- **GIL Impact Analysis**: {{gil_analysis}}

## Framework-Specific Insights

### Django Performance (if detected)
- **Database Query Analysis**: {{django_db_analysis}}
- **Template Rendering Time**: {{template_time}}ms
- **Middleware Overhead**: {{middleware_overhead}}ms
- **Cache Hit Ratio**: {{cache_hit_ratio}}%

### FastAPI Performance (if detected)
- **Request Processing Time**: {{request_time}}ms
- **Dependency Injection Overhead**: {{di_overhead}}ms
- **Async Route Performance**: {{async_route_analysis}}

### Flask Performance (if detected)
- **Route Handler Performance**: {{flask_route_analysis}}
- **Template Engine Overhead**: {{template_overhead}}ms
- **Session Management Impact**: {{session_impact}}ms

## Optimization Recommendations

### Immediate Optimizations (0-1 week)
{{immediate_optimizations}}

### Performance Improvements (1-4 weeks)
{{performance_improvements}}

### Architecture Optimizations (1-3 months)
{{architecture_optimizations}}

## Performance Budget Recommendations

### Response Time Targets
- **P50**: <{{p50_target}}ms
- **P95**: <{{p95_target}}ms  
- **P99**: <{{p99_target}}ms

### Resource Utilization Targets
- **CPU**: <{{cpu_target}}% sustained
- **Memory**: <{{memory_target}}MB peak
- **Database**: <{{db_connections_target}} connections

## Code Optimization Opportunities

### Algorithmic Improvements
{{algorithmic_improvements}}

### Data Structure Optimizations
{{data_structure_optimizations}}

### Caching Opportunities
{{caching_opportunities}}
```

## Enterprise Performance Integration

### CI/CD Performance Monitoring
```bash
# Performance regression detection
cat > .github/workflows/performance.yml << 'EOF'
name: Performance Monitoring
on: [push, pull_request]
jobs:
  performance:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup UV
        run: curl -LsSf https://astral.sh/uv/install.sh | sh
      - name: Performance Baseline
        run: |
          /profile --baseline --duration 30
          # Upload results to performance dashboard
EOF
```

### Performance Budget Integration
```bash
# Performance budget configuration
cat > performance-budget.json << 'EOF'
{
  "response_time_p95": 500,
  "memory_peak_mb": 256,
  "cpu_usage_percent": 80,
  "database_queries_max": 50
}
EOF
```

## Advanced Profiling Features

### Production Performance Monitoring
```bash
# Continuous profiling setup (py-spy daemon mode)
uvx py-spy record --pid {{PID}} --duration 3600 --idle --output agents/reports/production-profile.svg &

# APM-style monitoring
python -c "
import atexit
from pympler import tracker
tr = tracker.SummaryTracker()
atexit.register(lambda: tr.print_diff())
"
```

### Custom Profiling Decorators
```python
# Performance monitoring decorator
import functools
import time
import memory_profiler

def profile_performance(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time.perf_counter()
        start_memory = memory_profiler.memory_usage()[0]
        
        result = func(*args, **kwargs)
        
        end_time = time.perf_counter()
        end_memory = memory_profiler.memory_usage()[0]
        
        print(f"{func.__name__}: {end_time - start_time:.4f}s, "
              f"Memory: {end_memory - start_memory:.2f}MB")
        return result
    return wrapper
```

### Distributed System Profiling
```bash
# Multi-service performance analysis
uvx py-spy record --pid {{SERVICE_1_PID}} --output service1-profile.svg &
uvx py-spy record --pid {{SERVICE_2_PID}} --output service2-profile.svg &

# Trace correlation analysis
uvx opentelemetry-instrument python your_distributed_app.py
```

## UV-Native Profiling Toolchain

All profiling tools integrated via UV package management:
```bash
# Core profiling toolkit
uv add --group dev py-spy line-profiler memory-profiler cProfile-viz

# Advanced analysis tools
uv add --group dev pympler gprof2dot graphviz

# Framework-specific profilers
uv add --group dev django-debug-toolbar flask-profiler fastapi-profiler

# Production monitoring
uv add --group monitoring opentelemetry-api py-spy
```

## Performance Testing Integration

### Load Testing Integration
```bash
# Concurrent profiling during load tests
uvx locust -f load_test.py --host http://localhost:8000 &
LOCUST_PID=$!

# Profile during load
uvx py-spy record --pid {{APP_PID}} --duration 300 --output load-test-profile.svg

# Cleanup
kill $LOCUST_PID
```

### Benchmark Comparison
```bash
# Performance regression testing
python -c "
import time
import memory_profiler

def benchmark_function():
    # Your function to benchmark
    pass

# Baseline measurement
start = time.perf_counter()
memory_before = memory_profiler.memory_usage()[0]

benchmark_function()

end = time.perf_counter()
memory_after = memory_profiler.memory_usage()[0]

# Store baseline for comparison
with open('performance-baseline.json', 'w') as f:
    json.dump({
        'execution_time': end - start,
        'memory_usage': memory_after - memory_before
    }, f)
"
```

## Profiling Automation

### Scheduled Performance Analysis
```bash
# Cron job for regular performance monitoring
# 0 2 * * * cd /path/to/project && /profile --automated --duration 600
```

### Performance Alert System
```bash
# Performance threshold monitoring
python -c "
import json
import sys

with open('agents/reports/performance-latest.json') as f:
    metrics = json.load(f)

if metrics['cpu_usage'] > 80:
    print('ALERT: High CPU usage detected')
    sys.exit(1)

if metrics['memory_mb'] > 512:
    print('ALERT: High memory usage detected') 
    sys.exit(1)
"
```

## Output Artifacts

- **Performance Report**: `agents/reports/performance-analysis-{{timestamp}}.md`
- **CPU Flame Graph**: `agents/reports/profile-cpu-flame.svg`
- **Memory Timeline**: `agents/reports/memory-usage-timeline.png`
- **Call Graph**: `agents/reports/profile-callgraph.svg`
- **Line Profile**: `agents/reports/line-profile-results.txt`
- **Performance Metrics**: `agents/reports/performance-metrics.json`
- **Optimization Plan**: `agents/reports/optimization-roadmap.md`

This command provides enterprise-grade performance analysis suitable for organizations requiring comprehensive application performance monitoring, optimization planning, and continuous performance regression detection.