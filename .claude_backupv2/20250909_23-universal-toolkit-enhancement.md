# Python Command Suite Universal Toolkit Enhancement Plan
*Generated: 2025-09-09 23:XX*

# DO NOT USE - OUT OF DATE 

## Objective
Transform the Python Command Suite into the definitive universal Python development toolkit that any developer would want to clone for immediate productivity gains.

## Current State Analysis

### Existing Strengths
- R&D framework implementation with context priming (`/prime`, `/prime-bug`)
- UV-native workflow integration (`/uv-setup`, `/lint`, `/types`, `/test`)
- Basic agent delegation system (`planner`, `implementer`, `/background`)
- Session continuity via context bundles and load bundle system
- Quality automation with ruff/mypy integration
- Context engineering enforcement (guardrails, minimal memory)

### Critical Gaps Identified
1. **Security & Dependencies**: No vulnerability scanning, dependency auditing, or secrets detection
2. **Framework Integration**: Missing Django, FastAPI, Flask-specific commands
3. **Performance Tooling**: No profiling, benchmarking, or optimization commands
4. **CI/CD Integration**: Limited deployment, Docker, or GitHub Actions support
5. **Documentation System**: No automated documentation generation
6. **Project Lifecycle**: Missing scaffolding, migration, and release management
7. **Data Science/ML**: No Jupyter, data pipeline, or ML workflow support
8. **Database Management**: No migration, setup, or management commands

## Implementation Plan

### Phase 1: Core Command Extensions (Priority: Critical)

#### 1.1 Security Suite ✅ COMPLETED
- ✅ `/secrets-scan` - Secrets detection with detect-secrets/truffleHog (critical first)
- ✅ `/security` - Comprehensive security analysis with bandit, safety, semgrep
- ✅ `/deps-audit` - Dependency vulnerability scanning with safety/pip-audit
- ✅ `/license-check` - License compatibility analysis

#### 1.2 Performance Tooling ✅ COMPLETED
- ✅ `/profile` - Application profiling with py-spy, cProfile integration
- ✅ `/benchmark` - Performance benchmarking with pytest-benchmark
- ✅ `/optimize` - Code optimization suggestions and memory analysis
- ✅ `/load-test` - Basic load testing setup with locust integration

#### 1.3 Framework Commands 🔄 PARTIALLY COMPLETED (3/7)
- ✅ `/framework-detect` - Intelligent framework detection and optimization (foundational)
- ✅ `/project-init` - Universal Python project scaffolding (pyproject.toml, src/, CI basics) ⚠️ Needs mypy hook fix
- ✅ `/supabase-init` - Complete Supabase project initialization and best practices
- ⏳ `/postgres-init` - PostgreSQL setup and migration management
- ⏳ `/openai-init` - OpenAI API project scaffolding with async patterns
- ⏳ `/fastapi-init` - FastAPI project scaffolding with async patterns
- ⏳ `/flask-init` - Flask application factory setup with blueprints

#### 1.4 Database Management
- `/db-migrate` - Universal database migration management (Django, Alembic, custom)
- `/db-setup` - Database initialization and connection testing
- `/db-reset` - Safe database reset with backup creation
- `/db-backup` - Automated database backup with compression

#### 1.5 Documentation System
- `/glossary-gen` - Auto-generate AI_DOCS/glossary.md from command usage patterns
- `/docs-gen` - Comprehensive project documentation generation

### Phase 2: Advanced Agent Architecture (Priority: High)

#### 2.1 Specialized Agents
- `doc-scraper` - External documentation and best practices research
- `security-auditor` - Comprehensive security analysis and recommendations
- `performance-analyzer` - Performance profiling and optimization suggestions
- `framework-specialist` - Framework-specific pattern implementation
- `fixer` - Bug hunting and minimal patch creation

#### 2.2 Documentation System
- `/docs-gen` - Automated documentation with Sphinx/MkDocs
- `/api-docs` - API documentation generation (OpenAPI, GraphQL)
- `/changelog` - Automated changelog generation from git history
- `/readme-gen` - Intelligent README.md generation

#### 2.3 CI/CD Integration
- `/docker-setup` - Multi-stage Dockerfile and docker-compose configuration
- `/github-actions` - Comprehensive CI/CD pipeline setup
- `/deploy-prep` - Deployment preparation and validation
- `/env-config` - Environment configuration management

### Phase 3: Universal Integration (Priority: Medium)

#### 3.1 Project Lifecycle Management
- `/new-project` - Complete project scaffolding with best practices
- `/add-feature` - Feature branch creation with boilerplate
- `/update-deps` - Intelligent dependency updates with conflict resolution
- `/cleanup` - Code cleanup and technical debt identification

#### 3.2 AI/ML Workflow Support  
- `/ai-workflow` - Common LLM development patterns and async best practices
- `/openai-test` - OpenAI API testing with mock responses and rate limiting
- `/ai-cost` - OpenAI usage tracking and cost optimization analysis
- `/prompt-optimize` - Prompt engineering and testing framework
- `/jupyter-setup` - Jupyter Lab setup with extensions and kernels
- `/data-pipeline` - Data processing pipeline scaffolding
- `/model-train` - ML model training setup with MLflow integration
- `/experiment` - Experiment tracking and reproducibility setup

#### 3.3 Release Management
- `/version-bump` - Semantic versioning with changelog updates
- `/release-prep` - Release preparation checklist and validation
- `/publish` - Package publishing to PyPI with validation
- `/hotfix` - Emergency hotfix workflow

### Phase 4: Advanced Features (Priority: Low)

#### 4.1 Monitoring and Observability
- `/monitoring-setup` - Application monitoring with Prometheus/Grafana
- `/logging-config` - Structured logging setup
- `/health-check` - Health check endpoint generation
- `/metrics` - Application metrics collection setup

#### 4.2 Collaboration Tools
- `/pr-template` - Pull request template generation
- `/issue-template` - GitHub issue template creation
- `/git-hooks` - Git hooks setup for quality enforcement
- `/team-setup` - Team development environment standardization

## Command Architecture Patterns

### Universal Command Structure
```markdown
# Command Template Structure
- **Purpose**: Single-line objective
- **UV Integration**: How command uses UV package manager
- **Framework Detection**: Automatic framework optimization
- **Delegation Strategy**: When to use subagents
- **Context Impact**: Token usage estimation
- **Quality Gates**: Built-in validation and testing
```

### Agent Integration Points
- **Planner**: Creates implementation plans with delegation briefs
- **Implementer**: Executes small-scope changes with testing
- **Doc-scraper**: Researches external patterns and best practices
- **Background**: Handles complex multi-step analysis
- **Security-auditor**: Specialized security analysis
- **Performance-analyzer**: Performance optimization focus

## Success Metrics

### Quantitative Goals
- **25+ Universal Commands**: Cover complete Python development lifecycle
- **5 Specialized Agents**: Focused delegation for heavy tasks
- **Framework Support**: Django, FastAPI, Flask, Data Science optimization
- **Context Efficiency**: ≤800 tokens for any project priming
- **Quality Integration**: 100% command coverage with ruff/mypy/pytest
                 
### Qualitative Goals
- **Clone and Go**: Any Python developer can immediately benefit
- **Universal Compatibility**: Works with any Python project structure
- **Framework Intelligence**: Automatic detection and optimization
- **Best Practices**: Implements current Python ecosystem standards
- **Security First**: Built-in security scanning and validation

## Risk Assessment

### High Risk Areas
- **Framework Detection Logic**: Complex detection across Django/FastAPI/Flask
- **Agent Delegation Patterns**: Maintaining clear delegation boundaries
- **Universal Compatibility**: Ensuring commands work across project types
- **Security Tool Integration**: Managing multiple security tool outputs

### Medium Risk Areas
- **CI/CD Integration**: Platform-specific variations
- **Database Migrations**: Framework-specific migration patterns
- **Performance Tooling**: Tool compatibility across Python versions
- **Documentation Generation**: Consistent output across frameworks

### Mitigation Strategies
- **Incremental Rollout**: Deploy commands in small batches
- **Comprehensive Testing**: Each command includes extensive test coverage
- **Framework Isolation**: Separate command variants for different frameworks
- **Rollback Planning**: Git-based rollback for all changes

## Implementation Timeline

### Week 1: Security and Performance Foundation
- Implement security scanning suite (`/security`, `/deps-audit`, `/secrets-scan`)
- Add performance tooling (`/profile`, `/benchmark`, `/optimize`)
- Create security-auditor and performance-analyzer agents

### Week 2: Framework Integration
- Implement framework-specific commands (`/supabase-setup`, `/postgres-setup`, `/openai-setup`, `/fastapi-init`, `/flask-scaffold`)
- Add database management commands (`/migrate`, `/db-setup`, `/db-reset`)
- Create framework-specialist agent

### Week 3: CI/CD and Documentation
- Implement CI/CD integration (`/docker-setup`, `/github-actions`, `/deploy-prep`)
- Add documentation system (`/docs-gen`, `/api-docs`, `/changelog`)
- Create doc-scraper agent enhancements

### Week 4: Project Lifecycle and Polish
- Implement project lifecycle commands (`/new-project`, `/add-feature`, `/update-deps`)
- Add release management (`/version-bump`, `/release-prep`, `/publish`)
- Comprehensive testing and documentation

## Rollback Strategy

### Command-Level Rollback
```bash
# Individual command rollback
git revert <commit-hash>
# Validate with existing test suite
/test
```

### Agent-Level Rollback
```bash
# Remove agent and restore previous version
rm .claude/agents/<agent>.md
git checkout HEAD~1 .claude/agents/<agent>.md
```

### Full System Rollback
```bash
# Complete rollback to previous stable version
git tag -l | grep stable | tail -1 | xargs git checkout
# Validate system integrity
/prime base && /lint && /types && /test
```

## Acceptance Criteria

### Functional Requirements
- [ ] 25+ universal commands implemented with comprehensive testing
- [ ] Framework-specific optimization for Django, FastAPI, Flask
- [ ] Complete CI/CD integration with Docker and GitHub Actions
- [ ] Comprehensive security and dependency management
- [ ] Automated documentation generation system
- [ ] Performance profiling and optimization tooling
- [ ] Database management and migration support
- [ ] Release management and version control integration

### Non-Functional Requirements
- [ ] Context efficiency maintained (≤800 tokens for project priming)
- [ ] Universal compatibility across Python project types
- [ ] Quality gates enforced (ruff, mypy, pytest integration)
- [ ] Agent delegation patterns maintain clear boundaries
- [ ] Documentation coverage for all commands and agents
- [ ] Security-first approach with built-in vulnerability scanning

### User Experience Requirements
- [ ] "Clone and go" experience for any Python developer
- [ ] Intelligent framework detection and optimization
- [ ] Consistent command interface and behavior
- [ ] Clear error messages and helpful suggestions
- [ ] Comprehensive help system and examples

## Next Steps

1. **Begin Phase 1 Implementation**: Start with security suite and performance tooling
2. **Create Subagent Briefs**: Detailed delegation instructions for implementer agents
3. **Establish Testing Framework**: Comprehensive testing for all new commands
4. **Documentation Planning**: Structure for universal toolkit documentation
5. **Community Feedback**: Gather input from Python developers on command priorities

This plan transforms the Python Command Suite into the definitive universal toolkit that every Python developer would want to clone for immediate productivity gains while maintaining the R&D framework principles of reduced context and intelligent delegation.