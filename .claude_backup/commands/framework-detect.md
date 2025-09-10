---
name: framework-detect
description: Intelligent framework detection and optimization recommendations for Python projects
---

# Framework Detection Command

Foundational command for intelligent framework detection, dependency analysis, and optimization recommendations. Provides structured data for framework-specific optimization commands.

## Multi-Layer Framework Detection

I'll perform comprehensive framework analysis using pattern matching, dependency analysis, and code structure inspection:

### 1. Dependency Analysis Framework Detection
```bash
# Install framework detection tools via UV
uv add --group dev toml ast-grep pipreqs pip-audit

# Parse project dependencies
python -c "
import toml
import json
import subprocess
from pathlib import Path
from typing import Dict, List, Any, Optional

class FrameworkDetector:
    def __init__(self):
        self.frameworks = {}
        self.dependencies = []
        self.optimization_recommendations = []
        
    def analyze_dependencies(self) -> Dict[str, Any]:
        \"\"\"Analyze project dependencies for framework detection.\"\"\"
        dependency_sources = []
        
        # Parse pyproject.toml
        if Path('pyproject.toml').exists():
            with open('pyproject.toml') as f:
                pyproject = toml.load(f)
                deps = pyproject.get('project', {}).get('dependencies', [])
                dev_deps = pyproject.get('project', {}).get('optional-dependencies', {}).get('dev', [])
                dependency_sources.extend(deps + dev_deps)
        
        # Parse requirements.txt variants
        for req_file in ['requirements.txt', 'requirements-dev.txt', 'dev-requirements.txt']:
            if Path(req_file).exists():
                with open(req_file) as f:
                    deps = [line.strip() for line in f if line.strip() and not line.startswith('#')]
                    dependency_sources.extend(deps)
        
        # Parse setup.py (legacy)
        if Path('setup.py').exists():
            try:
                result = subprocess.run(['python', 'setup.py', '--requires'], 
                                      capture_output=True, text=True, timeout=10)
                if result.returncode == 0:
                    dependency_sources.extend(result.stdout.strip().split('\n'))
            except Exception:
                pass
        
        self.dependencies = list(set(dependency_sources))
        return self._detect_frameworks_from_dependencies()
    
    def _detect_frameworks_from_dependencies(self) -> Dict[str, Any]:
        \"\"\"Map dependencies to frameworks and versions.\"\"\"
        framework_patterns = {
            'django': {
                'patterns': ['django>=', 'django==', 'django ', 'django['],
                'indicators': ['djangorestframework', 'django-', 'celery'],
                'type': 'web_framework',
                'confidence': 'high'
            },
            'fastapi': {
                'patterns': ['fastapi>=', 'fastapi==', 'fastapi ', 'uvicorn'],
                'indicators': ['starlette', 'pydantic', 'httpx'],
                'type': 'web_framework', 
                'confidence': 'high'
            },
            'flask': {
                'patterns': ['flask>=', 'flask==', 'flask ', 'flask['],
                'indicators': ['werkzeug', 'jinja2', 'click'],
                'type': 'web_framework',
                'confidence': 'high'
            },
            'streamlit': {
                'patterns': ['streamlit>=', 'streamlit==', 'streamlit '],
                'indicators': [],
                'type': 'data_app',
                'confidence': 'high'
            },
            'jupyter': {
                'patterns': ['jupyter>=', 'jupyter==', 'jupyterlab', 'notebook'],
                'indicators': ['ipykernel', 'ipywidgets'],
                'type': 'notebook',
                'confidence': 'medium'
            },
            'data_science': {
                'patterns': ['pandas>=', 'numpy>=', 'scipy>=', 'scikit-learn'],
                'indicators': ['matplotlib', 'seaborn', 'plotly'],
                'type': 'data_science',
                'confidence': 'medium'
            },
            'ml_framework': {
                'patterns': ['tensorflow>=', 'torch>=', 'pytorch>='],
                'indicators': ['transformers', 'datasets', 'accelerate'],
                'type': 'machine_learning',
                'confidence': 'high'
            },
            'openai': {
                'patterns': ['openai>=', 'openai=='],
                'indicators': ['tiktoken', 'anthropic', 'langchain'],
                'type': 'ai_sdk',
                'confidence': 'high'
            }
        }
        
        detected_frameworks = {}
        dep_string = ' '.join(self.dependencies).lower()
        
        for framework, config in framework_patterns.items():
            confidence_score = 0
            
            # Check primary patterns
            for pattern in config['patterns']:
                if pattern.lower() in dep_string:
                    confidence_score += 3
                    break
            
            # Check indicator patterns
            for indicator in config['indicators']:
                if indicator.lower() in dep_string:
                    confidence_score += 1
            
            if confidence_score > 0:
                detected_frameworks[framework] = {
                    'confidence_score': confidence_score,
                    'type': config['type'],
                    'confidence': config['confidence'],
                    'version': self._extract_version(framework, dep_string)
                }
        
        return detected_frameworks

    def _extract_version(self, framework: str, dep_string: str) -> Optional[str]:
        \"\"\"Extract version information for detected framework.\"\"\"
        import re
        patterns = [
            rf'{framework}>=([0-9.]+)',
            rf'{framework}==([0-9.]+)',
            rf'{framework} ([0-9.]+)'
        ]
        
        for pattern in patterns:
            match = re.search(pattern, dep_string, re.IGNORECASE)
            if match:
                return match.group(1)
        return None

# Initialize detection
detector = FrameworkDetector()
framework_deps = detector.analyze_dependencies()

# Save dependency analysis
with open('agents/reports/framework-dependencies.json', 'w') as f:
    json.dump({
        'detected_frameworks': framework_deps,
        'all_dependencies': detector.dependencies,
        'analysis_timestamp': '$(date -Iseconds)'
    }, f, indent=2)

print(f'Detected frameworks from dependencies: {list(framework_deps.keys())}')
"
```

### 2. File Structure Pattern Analysis
```bash
# Analyze project structure for framework patterns
python -c "
import json
import os
from pathlib import Path
from typing import Dict, List, Any

class StructureAnalyzer:
    def __init__(self):
        self.structure_patterns = {}
        self.file_indicators = {}
        
    def analyze_project_structure(self) -> Dict[str, Any]:
        \"\"\"Analyze file and directory structure for framework patterns.\"\"\"
        
        framework_indicators = {
            'django': {
                'files': ['manage.py', 'settings.py', 'wsgi.py', 'asgi.py'],
                'directories': ['templates', 'static', 'migrations'],
                'patterns': ['models.py', 'views.py', 'forms.py', 'admin.py', 'urls.py'],
                'confidence_threshold': 2
            },
            'fastapi': {
                'files': ['main.py'],
                'directories': ['routers', 'schemas', 'dependencies'],
                'patterns': ['**/routers/*.py', '**/schemas/*.py'],
                'confidence_threshold': 1
            },
            'flask': {
                'files': ['app.py', 'run.py'],
                'directories': ['templates', 'static', 'blueprints'],
                'patterns': ['**/blueprints/*.py', '**/views/*.py'],
                'confidence_threshold': 1
            },
            'streamlit': {
                'files': [],
                'directories': ['pages', '.streamlit'],
                'patterns': ['streamlit_app.py', '*_app.py'],
                'confidence_threshold': 1
            },
            'jupyter': {
                'files': [],
                'directories': ['notebooks', '.ipynb_checkpoints'],
                'patterns': ['*.ipynb'],
                'confidence_threshold': 1
            },
            'data_science': {
                'files': [],
                'directories': ['data', 'models', 'notebooks'],
                'patterns': ['*.ipynb', 'train.py', 'evaluate.py'],
                'confidence_threshold': 2
            }
        }
        
        detected_patterns = {}
        
        for framework, indicators in framework_indicators.items():
            confidence_score = 0
            found_items = []
            
            # Check for specific files
            for file_name in indicators['files']:
                if Path(file_name).exists():
                    confidence_score += 2
                    found_items.append(f'file:{file_name}')
            
            # Check for directories
            for dir_name in indicators['directories']:
                if Path(dir_name).is_dir():
                    confidence_score += 1
                    found_items.append(f'dir:{dir_name}')
            
            # Check for file patterns
            for pattern in indicators['patterns']:
                matching_files = list(Path('.').glob(pattern))
                if matching_files:
                    confidence_score += len(matching_files)
                    found_items.extend([f'pattern:{f}' for f in matching_files[:3]])
            
            if confidence_score >= indicators['confidence_threshold']:
                detected_patterns[framework] = {
                    'confidence_score': confidence_score,
                    'found_items': found_items,
                    'threshold_met': True
                }
        
        return detected_patterns
    
    def analyze_import_patterns(self) -> Dict[str, Any]:
        \"\"\"Analyze Python files for framework import patterns.\"\"\"
        import ast
        from collections import defaultdict
        
        import_patterns = defaultdict(int)
        framework_imports = {
            'django': ['django', 'django.contrib', 'django.db', 'django.http'],
            'fastapi': ['fastapi', 'starlette', 'pydantic'],
            'flask': ['flask', 'werkzeug', 'jinja2'],
            'streamlit': ['streamlit'],
            'openai': ['openai', 'anthropic'],
            'data_science': ['pandas', 'numpy', 'scipy', 'sklearn', 'matplotlib']
        }
        
        framework_usage = defaultdict(list)
        
        for py_file in Path('.').rglob('*.py'):
            if '.venv' in str(py_file) or '__pycache__' in str(py_file):
                continue
                
            try:
                with open(py_file, 'r', encoding='utf-8') as f:
                    tree = ast.parse(f.read())
                
                for node in ast.walk(tree):
                    if isinstance(node, ast.Import):
                        for alias in node.names:
                            self._check_framework_import(alias.name, py_file, framework_imports, framework_usage)
                    elif isinstance(node, ast.ImportFrom):
                        if node.module:
                            self._check_framework_import(node.module, py_file, framework_imports, framework_usage)
                            
            except Exception as e:
                continue
        
        return dict(framework_usage)
    
    def _check_framework_import(self, module_name: str, file_path: Path, 
                               framework_imports: Dict, framework_usage: Dict):
        \"\"\"Check if import indicates framework usage.\"\"\"
        for framework, patterns in framework_imports.items():
            for pattern in patterns:
                if module_name.startswith(pattern):
                    framework_usage[framework].append({
                        'file': str(file_path),
                        'import': module_name,
                        'line': 'detected'
                    })
                    break

# Analyze structure and imports
analyzer = StructureAnalyzer()
structure_analysis = analyzer.analyze_project_structure()
import_analysis = analyzer.analyze_import_patterns()

# Save structure analysis
with open('agents/reports/framework-structure.json', 'w') as f:
    json.dump({
        'structure_patterns': structure_analysis,
        'import_patterns': import_analysis,
        'analysis_timestamp': '$(date -Iseconds)'
    }, f, indent=2)

print(f'Structure patterns detected: {list(structure_analysis.keys())}')
print(f'Import patterns detected: {list(import_analysis.keys())}')
"
```

### 3. Configuration File Analysis
```bash
# Analyze configuration files for framework-specific patterns
python -c "
import json
import toml
import configparser
from pathlib import Path
from typing import Dict, Any, List

class ConfigAnalyzer:
    def __init__(self):
        self.config_indicators = {}
        
    def analyze_configuration_files(self) -> Dict[str, Any]:
        \"\"\"Analyze configuration files for framework indicators.\"\"\"
        
        config_patterns = {
            'django': {
                'files': ['settings.py', 'django.conf', 'local_settings.py'],
                'env_vars': ['DJANGO_SETTINGS_MODULE', 'SECRET_KEY'],
                'config_keys': ['INSTALLED_APPS', 'MIDDLEWARE', 'DATABASES']
            },
            'fastapi': {
                'files': ['config.py', '.env'],
                'env_vars': ['API_HOST', 'API_PORT', 'ENVIRONMENT'],
                'config_keys': ['cors_origins', 'debug']
            },
            'flask': {
                'files': ['config.py', 'instance/config.py'],
                'env_vars': ['FLASK_APP', 'FLASK_ENV', 'SECRET_KEY'],
                'config_keys': ['SECRET_KEY', 'DEBUG', 'TESTING']
            },
            'streamlit': {
                'files': ['.streamlit/config.toml', 'streamlit_config.toml'],
                'env_vars': ['STREAMLIT_SERVER_PORT'],
                'config_keys': ['server', 'theme']
            }
        }
        
        detected_configs = {}
        
        for framework, patterns in config_patterns.items():
            confidence_score = 0
            found_configs = []
            
            # Check for configuration files
            for config_file in patterns['files']:
                if Path(config_file).exists():
                    confidence_score += 2
                    found_configs.append(f'config_file:{config_file}')
                    
                    # Analyze file content
                    content_analysis = self._analyze_config_content(config_file, patterns['config_keys'])
                    if content_analysis:
                        confidence_score += len(content_analysis)
                        found_configs.extend(content_analysis)
            
            # Check environment files for variables
            env_analysis = self._check_env_variables(patterns['env_vars'])
            if env_analysis:
                confidence_score += len(env_analysis)
                found_configs.extend(env_analysis)
            
            if confidence_score > 0:
                detected_configs[framework] = {
                    'confidence_score': confidence_score,
                    'found_configs': found_configs
                }
        
        return detected_configs
    
    def _analyze_config_content(self, config_file: str, config_keys: List[str]) -> List[str]:
        \"\"\"Analyze configuration file content for framework-specific keys.\"\"\"
        found_keys = []
        
        try:
            if config_file.endswith('.py'):
                with open(config_file, 'r') as f:
                    content = f.read()
                    for key in config_keys:
                        if key in content:
                            found_keys.append(f'config_key:{key}')
            
            elif config_file.endswith('.toml'):
                with open(config_file, 'r') as f:
                    config = toml.load(f)
                    for key in config_keys:
                        if key in str(config):
                            found_keys.append(f'toml_key:{key}')
            
            elif config_file.endswith(('.ini', '.cfg')):
                config = configparser.ConfigParser()
                config.read(config_file)
                for key in config_keys:
                    for section in config.sections():
                        if key in config[section]:
                            found_keys.append(f'ini_key:{key}')
                            
        except Exception:
            pass
            
        return found_keys
    
    def _check_env_variables(self, env_vars: List[str]) -> List[str]:
        \"\"\"Check for environment variables in .env files.\"\"\"
        found_vars = []
        
        for env_file in ['.env', '.env.local', '.env.production']:
            if Path(env_file).exists():
                try:
                    with open(env_file, 'r') as f:
                        content = f.read()
                        for var in env_vars:
                            if var in content:
                                found_vars.append(f'env_var:{var}')
                except Exception:
                    pass
        
        return found_vars

# Analyze configurations
config_analyzer = ConfigAnalyzer()
config_analysis = config_analyzer.analyze_configuration_files()

# Save configuration analysis
with open('agents/reports/framework-config.json', 'w') as f:
    json.dump({
        'config_analysis': config_analysis,
        'analysis_timestamp': '$(date -Iseconds)'
    }, f, indent=2)

print(f'Configuration patterns detected: {list(config_analysis.keys())}')
"
```

## Framework Detection Synthesis and Optimization Recommendations

I'll combine all detection methods and generate optimization recommendations:

```bash
# Synthesize framework detection results and generate recommendations
python -c "
import json
from pathlib import Path
from typing import Dict, Any, List
from datetime import datetime

class FrameworkSynthesizer:
    def __init__(self):
        self.final_results = {}
        self.optimization_recommendations = {}
        
    def synthesize_detection_results(self) -> Dict[str, Any]:
        \"\"\"Combine all detection methods for final framework identification.\"\"\"
        
        # Load detection results
        deps_data = self._load_json('agents/reports/framework-dependencies.json')
        structure_data = self._load_json('agents/reports/framework-structure.json')
        config_data = self._load_json('agents/reports/framework-config.json')
        
        # Combine confidence scores
        all_frameworks = set()
        if deps_data:
            all_frameworks.update(deps_data.get('detected_frameworks', {}).keys())
        if structure_data:
            all_frameworks.update(structure_data.get('structure_patterns', {}).keys())
            all_frameworks.update(structure_data.get('import_patterns', {}).keys())
        if config_data:
            all_frameworks.update(config_data.get('config_analysis', {}).keys())
        
        framework_scores = {}
        
        for framework in all_frameworks:
            total_score = 0
            evidence = []
            
            # Dependency evidence (weight: 3)
            if deps_data and framework in deps_data.get('detected_frameworks', {}):
                dep_score = deps_data['detected_frameworks'][framework]['confidence_score']
                total_score += dep_score * 3
                evidence.append(f'dependencies:{dep_score}')
            
            # Structure evidence (weight: 2) 
            if structure_data:
                if framework in structure_data.get('structure_patterns', {}):
                    struct_score = structure_data['structure_patterns'][framework]['confidence_score']
                    total_score += struct_score * 2
                    evidence.append(f'structure:{struct_score}')
                
                if framework in structure_data.get('import_patterns', {}):
                    import_count = len(structure_data['import_patterns'][framework])
                    total_score += import_count * 2
                    evidence.append(f'imports:{import_count}')
            
            # Configuration evidence (weight: 1)
            if config_data and framework in config_data.get('config_analysis', {}):
                config_score = config_data['config_analysis'][framework]['confidence_score']
                total_score += config_score * 1
                evidence.append(f'config:{config_score}')
            
            framework_scores[framework] = {
                'total_confidence_score': total_score,
                'evidence': evidence,
                'confidence_level': self._calculate_confidence_level(total_score)
            }
        
        # Sort by confidence score
        sorted_frameworks = sorted(framework_scores.items(), 
                                 key=lambda x: x[1]['total_confidence_score'], 
                                 reverse=True)
        
        return dict(sorted_frameworks)
    
    def _calculate_confidence_level(self, score: int) -> str:
        \"\"\"Calculate confidence level based on total score.\"\"\"
        if score >= 15:
            return 'very_high'
        elif score >= 10:
            return 'high'
        elif score >= 5:
            return 'medium'
        else:
            return 'low'
    
    def _load_json(self, file_path: str) -> Dict[str, Any]:
        \"\"\"Safely load JSON file.\"\"\"
        try:
            with open(file_path, 'r') as f:
                return json.load(f)
        except Exception:
            return {}
    
    def generate_optimization_recommendations(self, frameworks: Dict[str, Any]) -> Dict[str, Any]:
        \"\"\"Generate framework-specific optimization recommendations.\"\"\"
        
        optimization_templates = {
            'django': {
                'performance': [
                    'Use select_related() and prefetch_related() for database queries',
                    'Implement database connection pooling',
                    'Enable Django caching (Redis/Memcached)',
                    'Use database indexes for frequently queried fields',
                    'Implement pagination for large datasets'
                ],
                'security': [
                    'Run django-admin check --deploy',
                    'Enable CSRF protection',
                    'Use HTTPS in production',
                    'Implement proper session security',
                    'Validate all user inputs'
                ],
                'tools': [
                    'uv add --group dev django-debug-toolbar',
                    'uv add --group dev django-extensions',
                    'uv add --group dev django-silk',
                    'uv add --group prod gunicorn',
                    'uv add --group prod whitenoise'
                ]
            },
            'fastapi': {
                'performance': [
                    'Use async/await for I/O operations',
                    'Implement connection pooling for databases',
                    'Use Pydantic models for request validation',
                    'Enable response caching',
                    'Use uvloop for better event loop performance'
                ],
                'security': [
                    'Implement proper authentication (OAuth2/JWT)',
                    'Use dependency injection for security',
                    'Enable CORS properly',
                    'Validate all request data with Pydantic',
                    'Use HTTPS in production'
                ],
                'tools': [
                    'uv add --group dev fastapi-users',
                    'uv add --group dev sqlalchemy',
                    'uv add --group dev alembic',
                    'uv add --group prod uvicorn[standard]',
                    'uv add --group prod gunicorn'
                ]
            },
            'flask': {
                'performance': [
                    'Use Flask-Caching for response caching',
                    'Implement database connection pooling',
                    'Use blueprints for better organization',
                    'Enable gzip compression',
                    'Use CDN for static assets'
                ],
                'security': [
                    'Enable CSRF protection with Flask-WTF',
                    'Use Flask-Security for authentication',
                    'Implement proper session management',
                    'Validate all user inputs',
                    'Use HTTPS in production'
                ],
                'tools': [
                    'uv add --group dev flask-debugtoolbar',
                    'uv add --group dev flask-migrate',
                    'uv add --group dev flask-wtf',
                    'uv add --group prod gunicorn',
                    'uv add --group prod gevent'
                ]
            },
            'streamlit': {
                'performance': [
                    'Use st.cache_data for expensive computations',
                    'Implement session state properly',
                    'Optimize data loading with lazy loading',
                    'Use st.columns for better layout',
                    'Minimize page reloads'
                ],
                'security': [
                    'Implement user authentication',
                    'Validate all user inputs',
                    'Use secrets management',
                    'Enable HTTPS in production',
                    'Implement rate limiting'
                ],
                'tools': [
                    'uv add --group dev streamlit-authenticator',
                    'uv add --group dev streamlit-aggrid',
                    'uv add --group dev plotly',
                    'uv add --group dev altair',
                    'uv add --group prod streamlit-cloud'
                ]
            },
            'data_science': {
                'performance': [
                    'Use vectorized operations with NumPy/Pandas',
                    'Implement data caching strategies',
                    'Use Dask for large datasets',
                    'Optimize memory usage with appropriate data types',
                    'Use parallel processing where applicable'
                ],
                'security': [
                    'Secure data access and storage',
                    'Implement data privacy measures',
                    'Use encrypted connections for data sources',
                    'Validate data integrity',
                    'Implement audit logging'
                ],
                'tools': [
                    'uv add --group dev jupyter',
                    'uv add --group dev matplotlib',
                    'uv add --group dev seaborn',
                    'uv add --group dev dask',
                    'uv add --group dev scikit-learn'
                ]
            },
            'openai': {
                'performance': [
                    'Implement proper async client usage',
                    'Use connection pooling for API calls',
                    'Implement response caching',
                    'Use streaming for long responses',
                    'Implement retry logic with exponential backoff'
                ],
                'security': [
                    'Secure API key management',
                    'Implement rate limiting',
                    'Validate API responses',
                    'Use environment variables for secrets',
                    'Monitor API usage and costs'
                ],
                'tools': [
                    'uv add --group dev tiktoken',
                    'uv add --group dev httpx',
                    'uv add --group dev pydantic',
                    'uv add --group dev tenacity',
                    'uv add --group prod python-dotenv'
                ]
            }
        }
        
        recommendations = {}
        
        for framework, details in frameworks.items():
            if details['confidence_level'] in ['high', 'very_high']:
                if framework in optimization_templates:
                    recommendations[framework] = optimization_templates[framework]
                    recommendations[framework]['priority'] = 'high' if details['confidence_level'] == 'very_high' else 'medium'
                    recommendations[framework]['confidence_score'] = details['total_confidence_score']
        
        return recommendations

# Synthesize all detection results
synthesizer = FrameworkSynthesizer()
final_frameworks = synthesizer.synthesize_detection_results()
optimization_recs = synthesizer.generate_optimization_recommendations(final_frameworks)

# Generate comprehensive report
timestamp = datetime.now().strftime('%Y%m%d_%H%M')
report_data = {
    'detection_summary': {
        'timestamp': timestamp,
        'detected_frameworks': final_frameworks,
        'optimization_recommendations': optimization_recs,
        'analysis_confidence': 'high' if final_frameworks else 'low'
    },
    'structured_data': {
        'primary_framework': max(final_frameworks.items(), key=lambda x: x[1]['total_confidence_score'])[0] if final_frameworks else None,
        'secondary_frameworks': [k for k, v in final_frameworks.items() if v['confidence_level'] in ['medium', 'high']],
        'framework_types': list(set([rec.get('type', 'unknown') for rec in optimization_recs.values()])),
        'recommended_tools': []
    }
}

# Collect all recommended tools
for framework, recs in optimization_recs.items():
    if 'tools' in recs:
        report_data['structured_data']['recommended_tools'].extend(recs['tools'])

# Save final framework detection report
Path('agents/reports').mkdir(exist_ok=True)
with open(f'agents/reports/framework-detect-{timestamp}.md', 'w') as f:
    f.write(f'''# Framework Detection Report - {timestamp}

## Executive Summary
- **Primary Framework**: {report_data['structured_data']['primary_framework'] or 'None detected'}
- **Secondary Frameworks**: {', '.join(report_data['structured_data']['secondary_frameworks']) or 'None'}
- **Analysis Confidence**: {report_data['detection_summary']['analysis_confidence']}
- **Total Frameworks Detected**: {len(final_frameworks)}

## Detected Frameworks

''')
    
    for framework, details in final_frameworks.items():
        f.write(f'''### {framework.title()}
- **Confidence Score**: {details['total_confidence_score']}
- **Confidence Level**: {details['confidence_level']}
- **Evidence**: {', '.join(details['evidence'])}

''')
    
    f.write('''## Optimization Recommendations

''')
    
    for framework, recs in optimization_recs.items():
        f.write(f'''### {framework.title()} Optimizations
**Priority**: {recs.get('priority', 'medium')}

#### Performance Optimizations
''')
        for perf in recs.get('performance', []):
            f.write(f'- {perf}\n')
        
        f.write(f'''
#### Security Recommendations
''')
        for sec in recs.get('security', []):
            f.write(f'- {sec}\n')
        
        f.write(f'''
#### Recommended Tools
```bash
''')
        for tool in recs.get('tools', []):
            f.write(f'{tool}\n')
        f.write('```\n\n')
    
    f.write(f'''## Structured Data for Framework Commands

This detection data can be consumed by other framework commands:

```json
{json.dumps(report_data, indent=2)}
```

## Usage in Other Commands

Framework-specific commands can load this data:
```bash
# Load detection results
FRAMEWORK_DATA=$(cat agents/reports/framework-detect-{timestamp}.md | grep -A 1000 'Structured Data' | tail -n +3)

# Use in optimization commands
/optimize --framework-data=\"$FRAMEWORK_DATA\"
/security --framework-focus=\"{report_data['structured_data']['primary_framework']}\"
```
''')

# Save JSON data for programmatic access
with open(f'agents/reports/framework-detect-{timestamp}.json', 'w') as f:
    json.dump(report_data, f, indent=2)

print(f'Framework detection complete!')
print(f'Primary framework: {report_data['structured_data']['primary_framework']}')
print(f'Report saved: agents/reports/framework-detect-{timestamp}.md')
print(f'JSON data: agents/reports/framework-detect-{timestamp}.json')
"
```

## Framework-Specific Integration Patterns

### Integration with Other Commands
```bash
# Example usage by other framework commands
FRAMEWORK_DETECTION=$(cat agents/reports/framework-detect-*.json | tail -1)
PRIMARY_FRAMEWORK=$(echo $FRAMEWORK_DETECTION | jq -r '.structured_data.primary_framework')

# Django-specific optimization
if [[ "$PRIMARY_FRAMEWORK" == "django" ]]; then
    /optimize --django-focus
    /security --django-patterns
fi

# FastAPI-specific optimization  
if [[ "$PRIMARY_FRAMEWORK" == "fastapi" ]]; then
    /optimize --async-focus
    /security --api-security
fi
```

### Caching Detection Results
The command automatically caches results to avoid repeated analysis:
- Results valid for 24 hours
- Invalidated by dependency changes
- Structured JSON output for easy consumption

### Framework Command Dependencies
This foundational command enables:
- `/optimize --framework-aware` - Framework-specific performance optimization
- `/security --framework-patterns` - Framework-specific security analysis  
- `/deps-audit --framework-focus` - Framework-specific dependency management
- `/benchmark --framework-baseline` - Framework-appropriate benchmarking

## UV-Native Framework Detection Toolchain

All detection tools integrated via UV package management:
```bash
# Core detection tools
uv add --group dev toml ast-grep pipreqs pip-audit

# Framework-specific analysis tools
uv add --group dev django-extensions fastapi-cli flask-migrate

# Static analysis for framework patterns
uv add --group dev bandit vulture radon complexity-validator
```

## Output Artifacts

- **Framework Report**: `agents/reports/framework-detect-{{timestamp}}.md`
- **Structured Data**: `agents/reports/framework-detect-{{timestamp}}.json`
- **Dependency Analysis**: `agents/reports/framework-dependencies.json`
- **Structure Analysis**: `agents/reports/framework-structure.json`  
- **Config Analysis**: `agents/reports/framework-config.json`

This foundational command provides the intelligence layer for all framework-specific optimization commands in the Python Command Suite, enabling precise, context-aware development tooling.