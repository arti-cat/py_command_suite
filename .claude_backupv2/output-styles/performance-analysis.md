---
name: performance-analysis
description: Standardized performance profiling and optimization report format
---

# Performance Analysis Output Style

Standardized format for performance analysis reports ensuring consistent, actionable performance assessment and optimization guidance.

## Report Structure

### Executive Summary
- **Overall Performance**: 🟢 EXCELLENT | 🟡 NEEDS OPTIMIZATION | 🔴 PERFORMANCE ISSUES
- **Analysis Date**: {{timestamp}}
- **Analysis Type**: {{analysis_type}} (Profile | Benchmark | Load Test | Optimization)
- **Key Findings**: {{executive_summary}}
- **Recommended Actions**: {{immediate_recommendations}}

### Performance Metrics

#### ⚡ **Core Performance Indicators**
- **Response Time**: {{avg_response_time}}ms (Target: <{{target_response_time}}ms)
- **Throughput**: {{requests_per_second}} req/s
- **CPU Usage**: {{cpu_utilization}}% (Peak: {{peak_cpu}}%)
- **Memory Usage**: {{memory_usage}}MB (Peak: {{peak_memory}}MB)
- **Error Rate**: {{error_rate}}% (Target: <{{target_error_rate}}%)

#### 🔥 **Performance Hotspots**
{{#each hotspots}}
**{{rank}}. {{function_name}}**
- **File**: {{filename}}:{{line_number}}
- **CPU Time**: {{cpu_time}}ms ({{percentage}}% of total)
- **Call Count**: {{call_count}}
- **Per-call Average**: {{per_call_time}}ms
- **Optimization Potential**: {{optimization_potential}}
{{/each}}

### Detailed Analysis

#### 🧮 **CPU Profiling Results**
- **Profiling Tool**: {{profiling_tool}}
- **Duration**: {{profile_duration}}s
- **Total CPU Time**: {{total_cpu_time}}ms
- **Function Calls**: {{total_function_calls}}

**Top CPU Consumers:**
{{#each cpu_consumers}}
- **{{function}}**: {{cpu_time}}ms ({{percentage}}%)
  - **Location**: {{file}}:{{line}}
  - **Issue**: {{performance_issue}}
  - **Fix**: {{optimization_suggestion}}
{{/each}}

#### 💾 **Memory Analysis**
- **Peak Memory**: {{peak_memory}}MB
- **Memory Growth Rate**: {{memory_growth_rate}}MB/s
- **Garbage Collection**: {{gc_count}} collections, {{gc_time}}ms total
- **Memory Leaks**: {{leak_status}}

**Memory Hotspots:**
{{#each memory_hotspots}}
- **{{object_type}}**: {{memory_size}}MB ({{count}} objects)
  - **Growth Pattern**: {{growth_pattern}}
  - **Recommended Action**: {{memory_recommendation}}
{{/each}}

#### 🔗 **I/O Performance**
- **Database Queries**: {{db_query_count}} queries, {{db_total_time}}ms
- **File I/O**: {{file_io_count}} operations, {{file_io_time}}ms
- **Network Requests**: {{network_requests}} calls, {{network_time}}ms

**I/O Bottlenecks:**
{{#each io_bottlenecks}}
- **{{io_type}}**: {{operation}} ({{time_taken}}ms)
  - **Frequency**: {{frequency}}
  - **Optimization**: {{io_optimization}}
{{/each}}

#### 📊 **Benchmark Results**
{{#if benchmark_data}}
- **Test Suite**: {{test_suite_name}}
- **Benchmarks Run**: {{benchmark_count}}
- **Baseline Comparison**: {{baseline_comparison}}

**Performance Trends:**
{{#each benchmark_results}}
- **{{test_name}}**: 
  - **Current**: {{current_time}}ms
  - **Previous**: {{previous_time}}ms
  - **Change**: {{performance_change}}% {{trend_direction}}
  - **Status**: {{status_emoji}} {{status_text}}
{{/each}}
{{/if}}

#### 🚀 **Load Testing Results**
{{#if load_test_data}}
- **Test Duration**: {{load_test_duration}}s
- **Concurrent Users**: {{max_concurrent_users}}
- **Total Requests**: {{total_requests}}
- **Peak RPS**: {{peak_rps}}

**Load Test Metrics:**
- **Success Rate**: {{success_rate}}%
- **Average Response**: {{avg_response_load}}ms
- **95th Percentile**: {{p95_response}}ms
- **99th Percentile**: {{p99_response}}ms
- **Breaking Point**: {{breaking_point}} concurrent users
{{/if}}

### Optimization Recommendations

#### 🎯 **High-Impact Optimizations**
{{#each high_impact_optimizations}}
**{{priority}}. {{title}}**
- **Current Impact**: {{current_impact}}
- **Expected Improvement**: {{expected_improvement}}
- **Implementation Effort**: {{effort}} (Low/Medium/High)
- **Code Location**: {{code_location}}
- **Specific Changes**: {{optimization_details}}
- **Testing Strategy**: {{testing_approach}}
{{/each}}

#### 🔧 **Code-Level Improvements**
{{#each code_improvements}}
- **{{improvement_type}}**: {{description}}
  - **File**: {{file_location}}
  - **Current**: {{current_implementation}}
  - **Optimized**: {{optimized_implementation}}
  - **Expected Gain**: {{expected_performance_gain}}
{{/each}}

#### 🏗️ **Architecture Recommendations**
{{#each architecture_recommendations}}
- **{{category}}**: {{recommendation}}
  - **Rationale**: {{rationale}}
  - **Implementation**: {{implementation_approach}}
  - **Trade-offs**: {{trade_offs}}
{{/each}}

### Performance Budget

#### Current vs Targets
| Metric | Current | Target | Status |
|--------|---------|---------|--------|
{{#each performance_budget}}
| {{metric}} | {{current_value}} | {{target_value}} | {{status_emoji}} {{status}} |
{{/each}}

#### Regression Detection
{{#if regressions}}
**Performance Regressions Detected:**
{{#each regressions}}
- 🔴 **{{metric}}**: {{current}} vs {{baseline}} ({{degradation}} worse)
{{/each}}
{{/if}}

### Action Plan

#### 🚨 **Immediate Actions (This Week)**
{{#each immediate_actions}}
1. **{{action}}**
   - **Expected Impact**: {{impact}}
   - **Effort**: {{effort_hours}} hours
   - **Owner**: {{owner}}
{{/each}}

#### 📅 **Short-term Goals (Next Month)**
{{#each short_term_goals}}
- {{goal}} (Expected improvement: {{improvement}})
{{/each}}

#### 🎯 **Long-term Performance Strategy**
{{#each long_term_strategy}}
- {{strategy_item}}
{{/each}}

### Monitoring and Alerting

#### Performance Monitoring Setup
- **Continuous Profiling**: {{continuous_profiling_status}}
- **Performance Alerts**: {{alerting_status}}
- **Benchmark Automation**: {{benchmark_automation}}

#### Recommended Alerts
{{#each recommended_alerts}}
- **{{alert_name}}**: Trigger when {{condition}}
{{/each}}

### Report Metadata

- **Generated by**: Python Command Suite Performance Analysis
- **Tools Used**: {{tools_used}}
- **Analysis Duration**: {{analysis_duration}}
- **Next Analysis**: {{next_analysis_date}}
- **Baseline Date**: {{baseline_date}}

---

**Performance Status**: This analysis provides comprehensive performance insights. Implement high-impact optimizations first and establish continuous monitoring for sustained performance.