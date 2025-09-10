---
name: benchmark
description: Performance benchmarking with statistical analysis and regression detection
---

# Performance Benchmarking Command

Enterprise-grade performance benchmarking suite implementing statistical analysis, regression detection, and CI/CD integration with pytest-benchmark, timeit, and hyperfine for comprehensive performance measurement and baseline comparison.

## Multi-Layer Benchmarking Analysis

I'll perform comprehensive performance benchmarking using industry-standard tools:

### 1. pytest-benchmark Integration
```bash
# Install benchmarking tools via UV
uv add --group dev pytest-benchmark hyperfine timeit-compare statistics

# Run pytest benchmarks with statistical analysis
uvx pytest --benchmark-only --benchmark-json=agents/reports/benchmark-results.json
uvx pytest --benchmark-only --benchmark-autosave --benchmark-compare=0001

# Generate comparison reports
uvx pytest --benchmark-only --benchmark-compare-fail=min:5% --benchmark-compare-fail=mean:10%
```

### 2. Function-Level Benchmarking
```bash
# timeit-based micro-benchmarks
python -c "
import timeit
import statistics
import json
from datetime import datetime

def benchmark_function(func_code, setup='', number=1000000):
    times = []
    for _ in range(10):  # 10 runs for statistical significance
        result = timeit.timeit(func_code, setup=setup, number=number)
        times.append(result)
    
    return {
        'mean': statistics.mean(times),
        'median': statistics.median(times),
        'stdev': statistics.stdev(times) if len(times) > 1 else 0,
        'min': min(times),
        'max': max(times),
        'runs': times
    }

# Save baseline for regression detection
results = benchmark_function('sum(range(1000))')
with open('agents/reports/benchmark-baseline.json', 'w') as f:
    json.dump({'timestamp': datetime.now().isoformat(), 'results': results}, f)
"
```

### 3. API Endpoint Benchmarking
```bash
# hyperfine - Command-line benchmarking tool
uvx hyperfine --export-json agents/reports/api-benchmark.json \
  --warmup 3 --runs 100 \
  'curl -s http://localhost:8000/api/endpoint1' \
  'curl -s http://localhost:8000/api/endpoint2'

# Load testing with benchmarking
uvx locust -f benchmark_load.py --headless -u 50 -r 10 -t 60s \
  --html agents/reports/load-benchmark.html \
  --csv agents/reports/load-benchmark
```

### 4. Database Performance Benchmarking
```bash
# Database operation benchmarking
python -c "
import time
import statistics
import psycopg2  # or your DB driver

def benchmark_query(query, iterations=1000):
    times = []
    conn = psycopg2.connect('your_connection_string')
    cursor = conn.cursor()
    
    for _ in range(iterations):
        start = time.perf_counter()
        cursor.execute(query)
        cursor.fetchall()
        end = time.perf_counter()
        times.append(end - start)
    
    conn.close()
    return {
        'mean_ms': statistics.mean(times) * 1000,
        'p50_ms': statistics.median(times) * 1000,
        'p95_ms': statistics.quantiles(times, n=20)[18] * 1000,
        'p99_ms': statistics.quantiles(times, n=100)[98] * 1000
    }
"
```

## Performance Report Generation

I'll create comprehensive benchmarking reports with statistical analysis:

```markdown
# Performance Benchmark Report - {{timestamp}}

## Executive Summary
- **Benchmark Score**: {{overall_score}}/100
- **Performance Budget Status**: {{budget_status}}
- **Regression Detected**: {{regression_count}} issues
- **Performance Improvements**: {{improvement_count}} optimizations
- **Statistical Significance**: {{confidence_level}}% confidence

## Benchmark Results Overview

### Function-Level Benchmarks
| Function | Mean (ms) | Median (ms) | P95 (ms) | P99 (ms) | Baseline Δ | Status |
|----------|-----------|-------------|----------|----------|------------|--------|
{{function_benchmarks_table}}

### API Endpoint Performance
| Endpoint | Mean (ms) | P50 (ms) | P95 (ms) | P99 (ms) | RPS | Budget Status |
|----------|-----------|----------|----------|----------|-----|---------------|
{{api_benchmarks_table}}

### Database Query Performance
| Query Type | Mean (ms) | P50 (ms) | P95 (ms) | P99 (ms) | Baseline Δ |
|------------|-----------|----------|----------|----------|------------|
{{db_benchmarks_table}}

## Statistical Analysis

### Performance Distribution
- **Normal Distribution**: {{distribution_analysis}}
- **Outlier Detection**: {{outlier_count}} outliers ({{outlier_percentage}}%)
- **Variance Analysis**: σ = {{standard_deviation}}ms
- **Confidence Intervals**: 95% CI [{{ci_lower}}, {{ci_upper}}]ms

### Regression Detection
{{regression_analysis}}

### Performance Trends
- **Week-over-Week**: {{wow_change}}%
- **Month-over-Month**: {{mom_change}}%
- **Performance Velocity**: {{velocity_trend}}

## Framework-Specific Benchmarks

### Django Performance (if detected)
- **View Response Times**: {{django_view_times}}
- **Database Query Efficiency**: {{django_db_efficiency}}
- **Template Rendering**: {{django_template_times}}
- **Middleware Overhead**: {{django_middleware_overhead}}

### FastAPI Performance (if detected)
- **Async Endpoint Performance**: {{fastapi_async_performance}}
- **Dependency Injection Cost**: {{fastapi_di_cost}}
- **Serialization Overhead**: {{fastapi_serialization}}

### Flask Performance (if detected)
- **Route Handler Performance**: {{flask_route_performance}}
- **Request Processing**: {{flask_request_processing}}
- **Session Management**: {{flask_session_cost}}

## Performance Budget Analysis

### Budget Compliance
| Metric | Target | Current | Status | Headroom |
|--------|--------|---------|--------|-----------|
| API P95 Response Time | <500ms | {{current_p95}}ms | {{p95_status}} | {{p95_headroom}}ms |
| Database Query P95 | <100ms | {{db_p95}}ms | {{db_status}} | {{db_headroom}}ms |
| Memory Usage Peak | <512MB | {{memory_peak}}MB | {{memory_status}} | {{memory_headroom}}MB |
| CPU Utilization | <80% | {{cpu_usage}}% | {{cpu_status}} | {{cpu_headroom}}% |

### Budget Trend Analysis
{{budget_trend_analysis}}

## Benchmark Comparison

### Baseline Comparison
{{baseline_comparison_analysis}}

### A/B Test Results (if applicable)
| Variant | Mean (ms) | Improvement | Statistical Significance |
|---------|-----------|-------------|-------------------------|
{{ab_test_results}}

### Competitive Benchmarking
{{competitive_analysis}}

## Performance Optimization Opportunities

### Immediate Wins (0-1 week)
{{immediate_optimizations}}

### Performance Improvements (1-4 weeks)
{{performance_improvements}}

### Architecture Optimizations (1-3 months)
{{architecture_optimizations}}

## Benchmark Quality Metrics

### Test Reliability
- **Coefficient of Variation**: {{cv_percentage}}%
- **Test Stability**: {{stability_score}}/10
- **Environment Consistency**: {{env_consistency}}%

### Statistical Power
- **Sample Size**: {{sample_size}} measurements
- **Effect Size**: {{effect_size}}
- **Power Analysis**: {{statistical_power}}%

## Recommendation Engine

### Performance Alerts
{{performance_alerts}}

### Optimization Priorities
1. **High Impact, Low Effort**: {{high_impact_low_effort}}
2. **High Impact, Medium Effort**: {{high_impact_medium_effort}}
3. **Medium Impact, Low Effort**: {{medium_impact_low_effort}}

### Technical Debt Impact
{{tech_debt_performance_impact}}
```

## CI/CD Performance Integration

### Performance Gate Configuration
```bash
# Performance regression CI/CD pipeline
cat > .github/workflows/performance-gates.yml << 'EOF'
name: Performance Gates
on: [push, pull_request]
jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup UV
        run: curl -LsSf https://astral.sh/uv/install.sh | sh
      - name: Benchmark Tests
        run: |
          /benchmark --ci --fail-on-regression=5%
          # Compare against main branch baseline
      - name: Performance Budget Check
        run: |
          /benchmark --budget-check --fail-threshold=exceeded
EOF
```

### Automated Baseline Management
```bash
# Baseline storage and comparison
python -c "
import json
import subprocess
from datetime import datetime

def store_baseline():
    # Run benchmarks
    result = subprocess.run(['uvx', 'pytest', '--benchmark-only', 
                           '--benchmark-json=current-benchmark.json'], 
                          capture_output=True)
    
    with open('current-benchmark.json') as f:
        current = json.load(f)
    
    # Store as baseline
    baseline = {
        'timestamp': datetime.now().isoformat(),
        'commit': subprocess.check_output(['git', 'rev-parse', 'HEAD']).decode().strip(),
        'benchmarks': current
    }
    
    with open('agents/reports/benchmark-baseline.json', 'w') as f:
        json.dump(baseline, f, indent=2)

def compare_with_baseline():
    try:
        with open('agents/reports/benchmark-baseline.json') as f:
            baseline = json.load(f)
        with open('current-benchmark.json') as f:
            current = json.load(f)
        
        # Performance regression detection
        regressions = []
        for test in current['benchmarks']:
            baseline_test = next((t for t in baseline['benchmarks']['benchmarks'] 
                                if t['name'] == test['name']), None)
            if baseline_test:
                current_mean = test['stats']['mean']
                baseline_mean = baseline_test['stats']['mean']
                regression_pct = ((current_mean - baseline_mean) / baseline_mean) * 100
                
                if regression_pct > 5:  # 5% regression threshold
                    regressions.append({
                        'test': test['name'],
                        'regression': f'{regression_pct:.1f}%',
                        'current': f'{current_mean:.4f}s',
                        'baseline': f'{baseline_mean:.4f}s'
                    })
        
        if regressions:
            print('PERFORMANCE REGRESSIONS DETECTED:')
            for reg in regressions:
                print(f'- {reg[\"test\"]}: {reg[\"regression\"]} slower')
            exit(1)
        else:
            print('No performance regressions detected')
    
    except FileNotFoundError:
        print('No baseline found, storing current results as baseline')
        store_baseline()
"
```

## Advanced Benchmarking Features

### Memory Benchmarking
```bash
# Memory usage benchmarking
python -c "
import memory_profiler
import time
import statistics

@memory_profiler.profile
def benchmark_memory_function():
    # Function to benchmark
    data = [i for i in range(1000000)]
    return sum(data)

# Memory usage over time
memory_usage = memory_profiler.memory_usage((benchmark_memory_function, ()))
peak_memory = max(memory_usage)
avg_memory = statistics.mean(memory_usage)

print(f'Peak Memory: {peak_memory:.2f}MB')
print(f'Average Memory: {avg_memory:.2f}MB')
"
```

### Concurrent Performance Testing
```bash
# Async/concurrent benchmarking
python -c "
import asyncio
import aiohttp
import time
import statistics

async def benchmark_concurrent_requests(url, concurrent=50, total=1000):
    async with aiohttp.ClientSession() as session:
        semaphore = asyncio.Semaphore(concurrent)
        
        async def fetch(url):
            async with semaphore:
                start = time.perf_counter()
                async with session.get(url) as response:
                    await response.text()
                return time.perf_counter() - start
        
        tasks = [fetch(url) for _ in range(total)]
        times = await asyncio.gather(*tasks)
        
        return {
            'mean': statistics.mean(times),
            'median': statistics.median(times),
            'p95': statistics.quantiles(times, n=20)[18],
            'p99': statistics.quantiles(times, n=100)[98],
            'rps': total / sum(times)
        }

# Example usage
# results = asyncio.run(benchmark_concurrent_requests('http://localhost:8000/api'))
"
```

### Custom Benchmark Decorators
```python
# Performance benchmarking decorator
import functools
import time
import statistics
import json
from typing import Callable, Any

def benchmark(iterations: int = 1000, warmup: int = 10):
    def decorator(func: Callable) -> Callable:
        @functools.wraps(func)
        def wrapper(*args, **kwargs) -> Any:
            # Warmup runs
            for _ in range(warmup):
                func(*args, **kwargs)
            
            # Benchmark runs
            times = []
            for _ in range(iterations):
                start = time.perf_counter()
                result = func(*args, **kwargs)
                end = time.perf_counter()
                times.append(end - start)
            
            stats = {
                'function': func.__name__,
                'iterations': iterations,
                'mean': statistics.mean(times),
                'median': statistics.median(times),
                'stdev': statistics.stdev(times) if len(times) > 1 else 0,
                'min': min(times),
                'max': max(times)
            }
            
            # Store results
            with open(f'agents/reports/benchmark-{func.__name__}.json', 'w') as f:
                json.dump(stats, f, indent=2)
            
            print(f"Benchmark {func.__name__}: {stats['mean']:.6f}s ± {stats['stdev']:.6f}s")
            return result
        return wrapper
    return decorator

# Usage example:
@benchmark(iterations=10000)
def example_function():
    return sum(range(1000))
```

## UV-Native Benchmarking Toolchain

All benchmarking tools integrated via UV package management:
```bash
# Core benchmarking toolkit
uv add --group dev pytest-benchmark hyperfine timeit-compare

# Statistical analysis tools
uv add --group dev statistics numpy scipy pandas

# Load testing integration
uv add --group dev locust requests aiohttp

# Memory benchmarking
uv add --group dev memory-profiler pympler

# Database benchmarking
uv add --group dev psycopg2-binary sqlalchemy

# Visualization tools
uv add --group dev matplotlib seaborn plotly
```

## Performance Budget Management

### Budget Definition
```json
{
  "performance_budget": {
    "api_endpoints": {
      "p50_ms": 100,
      "p95_ms": 500,
      "p99_ms": 1000
    },
    "database_queries": {
      "p50_ms": 50,
      "p95_ms": 200,
      "p99_ms": 500
    },
    "memory_usage": {
      "peak_mb": 512,
      "growth_rate_mb_per_hour": 10
    },
    "cpu_utilization": {
      "sustained_percent": 80,
      "peak_percent": 95
    }
  },
  "regression_thresholds": {
    "warning_percent": 5,
    "failure_percent": 10
  }
}
```

### Budget Enforcement
```bash
# Performance budget validation
python -c "
import json
import sys

with open('performance-budget.json') as f:
    budget = json.load(f)

with open('agents/reports/benchmark-results.json') as f:
    results = json.load(f)

violations = []
for test in results['benchmarks']:
    if 'api' in test['name']:
        p95_ms = test['stats']['q95'] * 1000
        if p95_ms > budget['performance_budget']['api_endpoints']['p95_ms']:
            violations.append(f'{test[\"name\"]}: P95 {p95_ms:.1f}ms exceeds budget')

if violations:
    print('PERFORMANCE BUDGET VIOLATIONS:')
    for violation in violations:
        print(f'- {violation}')
    sys.exit(1)
else:
    print('All benchmarks within performance budget')
"
```

## Output Artifacts

- **Benchmark Report**: `agents/reports/benchmark-analysis-{{timestamp}}.md`
- **Statistical Results**: `agents/reports/benchmark-results.json`
- **Regression Analysis**: `agents/reports/regression-detection.json`
- **Performance Trends**: `agents/reports/performance-trends.csv`
- **Budget Compliance**: `agents/reports/budget-compliance.json`
- **Baseline Comparison**: `agents/reports/baseline-comparison.md`
- **Optimization Plan**: `agents/reports/performance-optimization-plan.md`

This command provides enterprise-grade performance benchmarking suitable for organizations requiring statistical performance analysis, automated regression detection, and continuous performance monitoring with CI/CD integration.