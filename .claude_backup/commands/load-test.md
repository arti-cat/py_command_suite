---
name: load-test
description: Comprehensive load testing and stress analysis with distributed testing, realistic traffic simulation, and scalability assessment
---

# Load Testing Command

Enterprise-grade load testing suite implementing distributed testing, concurrent user simulation, and comprehensive stress analysis with locust, httpx, and asyncio for scalability assessment, bottleneck identification, and performance validation under realistic traffic patterns.

## Multi-Layer Load Testing Analysis

I'll perform comprehensive load testing using industry-standard tools:

### 1. Distributed Load Testing with Locust
```bash
# Install load testing tools via UV
uv add --group dev locust httpx aiohttp websockets asyncio-mqtt

# Basic load test with web UI
uvx locust -f agents/load_tests/basic_load_test.py --host http://localhost:8000
uvx locust -f agents/load_tests/basic_load_test.py --headless -u 100 -r 10 -t 300s

# Distributed load testing (multiple workers)
uvx locust -f agents/load_tests/distributed_test.py --master --master-bind-host=* --master-bind-port=5557
uvx locust -f agents/load_tests/distributed_test.py --worker --master-host=localhost --master-port=5557

# Export results for analysis
uvx locust -f agents/load_tests/api_test.py --headless -u 200 -r 20 -t 600s \
  --html agents/reports/load-test-report.html \
  --csv agents/reports/load-test-data
```

### 2. API Load Testing Suite
```bash
# REST API load testing
python -c "
import asyncio
import aiohttp
import time
import statistics
import json
from concurrent.futures import ThreadPoolExecutor

class APILoadTester:
    def __init__(self, base_url, concurrent_users=50):
        self.base_url = base_url
        self.concurrent_users = concurrent_users
        self.results = []
    
    async def simulate_user_session(self, session, user_id):
        '''Simulate realistic user behavior'''
        session_results = []
        
        # Login simulation
        start_time = time.perf_counter()
        async with session.post(f'{self.base_url}/api/login') as response:
            login_time = time.perf_counter() - start_time
            session_results.append({'endpoint': 'login', 'time': login_time, 'status': response.status})
        
        # Browse/search simulation
        for _ in range(5):  # 5 page views per user
            start_time = time.perf_counter()
            async with session.get(f'{self.base_url}/api/data') as response:
                page_time = time.perf_counter() - start_time
                session_results.append({'endpoint': 'data', 'time': page_time, 'status': response.status})
        
        # Transaction simulation
        start_time = time.perf_counter()
        async with session.post(f'{self.base_url}/api/transaction') as response:
            transaction_time = time.perf_counter() - start_time
            session_results.append({'endpoint': 'transaction', 'time': transaction_time, 'status': response.status})
        
        return session_results
    
    async def run_load_test(self, duration_seconds=300):
        '''Run concurrent load test'''
        end_time = time.time() + duration_seconds
        
        async with aiohttp.ClientSession() as session:
            tasks = []
            user_id = 0
            
            while time.time() < end_time:
                # Spawn new user sessions
                for _ in range(self.concurrent_users):
                    task = asyncio.create_task(self.simulate_user_session(session, user_id))
                    tasks.append(task)
                    user_id += 1
                
                # Wait for current batch to complete
                batch_results = await asyncio.gather(*tasks, return_exceptions=True)
                for result in batch_results:
                    if not isinstance(result, Exception):
                        self.results.extend(result)
                
                tasks.clear()
                await asyncio.sleep(1)  # Pacing
        
        return self.analyze_results()
    
    def analyze_results(self):
        '''Analyze load test results'''
        endpoint_stats = {}
        
        for result in self.results:
            endpoint = result['endpoint']
            if endpoint not in endpoint_stats:
                endpoint_stats[endpoint] = []
            endpoint_stats[endpoint].append(result['time'])
        
        analysis = {}
        for endpoint, times in endpoint_stats.items():
            analysis[endpoint] = {
                'requests': len(times),
                'mean_ms': statistics.mean(times) * 1000,
                'median_ms': statistics.median(times) * 1000,
                'p95_ms': statistics.quantiles(times, n=20)[18] * 1000,
                'p99_ms': statistics.quantiles(times, n=100)[98] * 1000,
                'rps': len(times) / max(times) if times else 0
            }
        
        return analysis

# Save as load test module
with open('agents/load_tests/api_load_test.py', 'w') as f:
    f.write('''
# Generated API Load Test
import asyncio
from api_load_tester import APILoadTester

async def main():
    tester = APILoadTester('http://localhost:8000', concurrent_users=100)
    results = await tester.run_load_test(duration_seconds=300)
    
    with open('agents/reports/api-load-results.json', 'w') as f:
        json.dump(results, f, indent=2)

if __name__ == '__main__':
    asyncio.run(main())
    ''')
"
```

### 3. Database Load Testing
```bash
# Database connection pool stress testing
python -c "
import asyncio
import asyncpg  # or your async DB driver
import time
import statistics
import concurrent.futures
from contextlib import asynccontextmanager

class DatabaseLoadTester:
    def __init__(self, connection_string, max_connections=50):
        self.connection_string = connection_string
        self.max_connections = max_connections
        self.results = []
    
    @asynccontextmanager
    async def connection_pool(self):
        pool = await asyncpg.create_pool(
            self.connection_string,
            min_size=10,
            max_size=self.max_connections
        )
        try:
            yield pool
        finally:
            await pool.close()
    
    async def simulate_database_operations(self, pool, operation_count=1000):
        '''Simulate realistic database workload'''
        operations = []
        
        for _ in range(operation_count):
            # Mix of read/write operations
            operation_type = 'read' if _ % 3 == 0 else 'write'
            
            start_time = time.perf_counter()
            async with pool.acquire() as connection:
                if operation_type == 'read':
                    await connection.fetch('SELECT * FROM users LIMIT 10')
                else:
                    await connection.execute('INSERT INTO logs (message) VALUES ($1)', f'Test {_}')
            
            end_time = time.perf_counter()
            operations.append({
                'type': operation_type,
                'time': end_time - start_time,
                'timestamp': time.time()
            })
        
        return operations
    
    async def run_connection_pool_test(self, concurrent_clients=20, operations_per_client=500):
        '''Test database under concurrent load'''
        async with self.connection_pool() as pool:
            tasks = []
            
            for client_id in range(concurrent_clients):
                task = asyncio.create_task(
                    self.simulate_database_operations(pool, operations_per_client)
                )
                tasks.append(task)
            
            results = await asyncio.gather(*tasks)
            
            # Flatten results
            all_operations = []
            for client_results in results:
                all_operations.extend(client_results)
            
            return self.analyze_database_results(all_operations)
    
    def analyze_database_results(self, operations):
        '''Analyze database load test results'''
        read_times = [op['time'] for op in operations if op['type'] == 'read']
        write_times = [op['time'] for op in operations if op['type'] == 'write']
        
        return {
            'total_operations': len(operations),
            'read_operations': {
                'count': len(read_times),
                'mean_ms': statistics.mean(read_times) * 1000,
                'p95_ms': statistics.quantiles(read_times, n=20)[18] * 1000,
                'ops_per_second': len(read_times) / max(read_times) if read_times else 0
            },
            'write_operations': {
                'count': len(write_times),
                'mean_ms': statistics.mean(write_times) * 1000,
                'p95_ms': statistics.quantiles(write_times, n=20)[18] * 1000,
                'ops_per_second': len(write_times) / max(write_times) if write_times else 0
            }
        }
"
```

### 4. WebSocket Load Testing
```bash
# WebSocket connection stress testing
python -c "
import asyncio
import websockets
import json
import time
import statistics

class WebSocketLoadTester:
    def __init__(self, ws_url, concurrent_connections=100):
        self.ws_url = ws_url
        self.concurrent_connections = concurrent_connections
        self.results = []
    
    async def websocket_client_session(self, client_id, duration=300):
        '''Simulate WebSocket client behavior'''
        session_results = []
        end_time = time.time() + duration
        
        try:
            async with websockets.connect(self.ws_url) as websocket:
                message_count = 0
                
                while time.time() < end_time:
                    # Send message
                    start_time = time.perf_counter()
                    await websocket.send(json.dumps({
                        'client_id': client_id,
                        'message_id': message_count,
                        'timestamp': time.time()
                    }))
                    
                    # Wait for response
                    response = await websocket.recv()
                    end_time_msg = time.perf_counter()
                    
                    session_results.append({
                        'client_id': client_id,
                        'message_id': message_count,
                        'round_trip_time': end_time_msg - start_time,
                        'timestamp': time.time()
                    })
                    
                    message_count += 1
                    await asyncio.sleep(0.1)  # Message frequency
                    
        except Exception as e:
            session_results.append({
                'client_id': client_id,
                'error': str(e),
                'timestamp': time.time()
            })
        
        return session_results
    
    async def run_websocket_load_test(self, duration=300):
        '''Run concurrent WebSocket load test'''
        tasks = []
        
        for client_id in range(self.concurrent_connections):
            task = asyncio.create_task(
                self.websocket_client_session(client_id, duration)
            )
            tasks.append(task)
        
        results = await asyncio.gather(*tasks, return_exceptions=True)
        
        # Process results
        all_messages = []
        connection_errors = 0
        
        for client_results in results:
            if isinstance(client_results, Exception):
                connection_errors += 1
            else:
                for result in client_results:
                    if 'error' not in result:
                        all_messages.append(result)
        
        return self.analyze_websocket_results(all_messages, connection_errors)
    
    def analyze_websocket_results(self, messages, errors):
        '''Analyze WebSocket load test results'''
        if not messages:
            return {'error': 'No successful messages'}
        
        round_trip_times = [msg['round_trip_time'] for msg in messages]
        
        return {
            'total_messages': len(messages),
            'connection_errors': errors,
            'success_rate': (len(messages) / (len(messages) + errors)) * 100,
            'round_trip_stats': {
                'mean_ms': statistics.mean(round_trip_times) * 1000,
                'median_ms': statistics.median(round_trip_times) * 1000,
                'p95_ms': statistics.quantiles(round_trip_times, n=20)[18] * 1000,
                'p99_ms': statistics.quantiles(round_trip_times, n=100)[98] * 1000
            },
            'messages_per_second': len(messages) / max([msg['timestamp'] for msg in messages])
        }
"
```

## Load Testing Report Generation

I'll create comprehensive load testing reports with scalability analysis:

```markdown
# Load Testing Report - {{timestamp}}

## Executive Summary
- **Load Test Score**: {{overall_score}}/100
- **Scalability Assessment**: {{scalability_rating}}
- **Breaking Point**: {{breaking_point_users}} concurrent users
- **Performance Under Load**: {{performance_degradation}}% degradation
- **Critical Issues**: {{critical_issues_count}} issues identified

## Load Test Configuration

### Test Parameters
| Parameter | Value | Rationale |
|-----------|-------|-----------|
| Peak Concurrent Users | {{max_users}} | {{user_rationale}} |
| Test Duration | {{duration_minutes}} minutes | {{duration_rationale}} |
| Ramp-up Rate | {{ramp_rate}} users/second | {{ramp_rationale}} |
| Geographic Distribution | {{geo_distribution}} | {{geo_rationale}} |

### Realistic Traffic Patterns
{{traffic_pattern_analysis}}

## Performance Under Load

### Response Time Analysis
| Load Level | Users | P50 (ms) | P95 (ms) | P99 (ms) | RPS | Error Rate |
|------------|-------|----------|----------|----------|-----|------------|
{{response_time_table}}

### Scalability Assessment
- **Linear Scaling Range**: 0-{{linear_limit}} users
- **Degradation Point**: {{degradation_point}} users ({{degradation_pct}}% slower)
- **Breaking Point**: {{breaking_point}} users ({{error_threshold}}% errors)
- **Recovery Time**: {{recovery_time}} seconds

### Throughput Analysis
{{throughput_analysis}}

## System Resource Impact

### CPU Utilization Under Load
| Load Level | CPU Usage | Memory Usage | Disk I/O | Network I/O |
|------------|-----------|--------------|----------|-------------|
{{resource_usage_table}}

### Memory Consumption Patterns
- **Baseline Memory**: {{baseline_memory}}MB
- **Peak Memory**: {{peak_memory}}MB ({{memory_growth}}x increase)
- **Memory Leak Detection**: {{memory_leak_status}}
- **GC Pressure**: {{gc_pressure_analysis}}

### Database Performance Under Load
{{database_load_analysis}}

## Bottleneck Identification

### Performance Bottlenecks
{{bottleneck_analysis}}

### Resource Constraints
1. **CPU Bottleneck**: {{cpu_bottleneck_analysis}}
2. **Memory Bottleneck**: {{memory_bottleneck_analysis}}
3. **I/O Bottleneck**: {{io_bottleneck_analysis}}
4. **Network Bottleneck**: {{network_bottleneck_analysis}}

### Application-Level Bottlenecks
{{application_bottleneck_analysis}}

## Framework-Specific Load Analysis

### Django Under Load (if detected)
- **Request Processing**: {{django_request_processing}}
- **Database Connection Pool**: {{django_db_pool_analysis}}
- **Static File Serving**: {{django_static_analysis}}
- **Cache Performance**: {{django_cache_analysis}}

### FastAPI Under Load (if detected)
- **Async Performance**: {{fastapi_async_analysis}}
- **WebSocket Handling**: {{fastapi_ws_analysis}}
- **Background Tasks**: {{fastapi_bg_tasks}}

### Flask Under Load (if detected)
- **WSGI Performance**: {{flask_wsgi_analysis}}
- **Session Handling**: {{flask_session_analysis}}
- **Blueprint Performance**: {{flask_blueprint_analysis}}

## Error Analysis

### Error Distribution
| Error Type | Count | Percentage | Impact Level |
|------------|-------|------------|--------------|
{{error_distribution_table}}

### Error Patterns
{{error_pattern_analysis}}

### Failure Mode Analysis
{{failure_mode_analysis}}

## Distributed Testing Results

### Multi-Node Performance
{{distributed_testing_analysis}}

### Geographic Load Distribution
{{geographic_analysis}}

### Network Latency Impact
{{network_latency_analysis}}

## Scalability Recommendations

### Immediate Scaling Actions (0-1 week)
{{immediate_scaling_actions}}

### Infrastructure Optimizations (1-4 weeks)
{{infrastructure_optimizations}}

### Architecture Scaling (1-3 months)
{{architecture_scaling_recommendations}}

## Performance Budget Under Load

### Load Performance Targets
| Metric | Target | Current | Status | Action Required |
|--------|--------|---------|--------|------------------|
| P95 Response Time @ 100 users | <500ms | {{p95_100_users}}ms | {{status}} | {{action}} |
| Error Rate @ Peak Load | <1% | {{error_rate_peak}}% | {{status}} | {{action}} |
| CPU Utilization @ Peak | <80% | {{cpu_peak}}% | {{status}} | {{action}} |
| Memory Growth Rate | <10MB/hour | {{memory_growth_rate}}MB/hour | {{status}} | {{action}} |

### Capacity Planning
{{capacity_planning_analysis}}

## Load Testing Automation

### CI/CD Load Testing Integration
{{ci_cd_integration_analysis}}

### Continuous Load Monitoring
{{continuous_monitoring_setup}}

## Recovery and Resilience Testing

### Circuit Breaker Testing
{{circuit_breaker_analysis}}

### Graceful Degradation
{{graceful_degradation_analysis}}

### Auto-scaling Validation
{{auto_scaling_analysis}}
```

## Integration with Performance Commands

### Profile Integration
```bash
# Profile application under load
uvx locust -f load_test.py --headless -u 100 -r 10 -t 300s &
LOAD_TEST_PID=$!

# Profile during load test
/profile --duration 60 --under-load

# Cleanup
kill $LOAD_TEST_PID
```

### Benchmark Comparison
```bash
# Compare performance under different load levels
/benchmark --baseline
/load-test --light-load --duration 60
/benchmark --compare baseline --tag "light-load"

/load-test --heavy-load --duration 60  
/benchmark --compare baseline --tag "heavy-load"
```

## UV-Native Load Testing Toolchain

All load testing tools integrated via UV package management:
```bash
# Core load testing toolkit
uv add --group dev locust httpx aiohttp websockets

# Async testing tools
uv add --group dev asyncio-mqtt asyncpg aioredis

# Database load testing
uv add --group dev sqlalchemy psycopg2-binary redis

# Monitoring and metrics
uv add --group dev prometheus-client grafana-api

# Distributed testing
uv add --group dev celery dramatiq

# Report generation
uv add --group dev jinja2 matplotlib plotly
```

## CI/CD Load Testing Integration

### Performance Gate Configuration
```bash
# Load testing CI/CD pipeline
cat > .github/workflows/load-testing.yml << 'EOF'
name: Load Testing Gates
on: [push, pull_request]
jobs:
  load-test:
    runs-on: ubuntu-latest
    services:
      app:
        image: app:latest
        ports:
          - 8000:8000
    steps:
      - uses: actions/checkout@v4
      - name: Setup UV
        run: curl -LsSf https://astral.sh/uv/install.sh | sh
      - name: Light Load Test
        run: |
          /load-test --ci --users 50 --duration 60
      - name: Performance Validation
        run: |
          /load-test --validate-performance --fail-on-regression
EOF
```

## Output Artifacts

- **Load Test Report**: `agents/reports/load-test-analysis-{{timestamp}}.md`
- **Performance Metrics**: `agents/reports/load-test-metrics.json`
- **Resource Usage**: `agents/reports/resource-usage-under-load.csv`
- **Error Analysis**: `agents/reports/load-test-errors.json`
- **Scalability Assessment**: `agents/reports/scalability-analysis.md`
- **Bottleneck Report**: `agents/reports/bottleneck-identification.md`
- **Capacity Plan**: `agents/reports/capacity-planning.md`

This command provides enterprise-grade load testing capabilities suitable for organizations requiring comprehensive scalability assessment, performance validation under realistic traffic patterns, and automated load testing integration with CI/CD pipelines.