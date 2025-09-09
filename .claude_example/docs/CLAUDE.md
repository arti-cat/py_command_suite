# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository contains custom slash commands for Claude Code that provide specialized workflows for common software development tasks. These commands are designed to work with Claude Code's built-in slash command system as `/project:command-name`.

## Repository Structure

- `.claude/commands/` - Contains 90 specialized command files that define workflows for development tasks
- `install.sh` - Installation script for setting up commands in projects (supports project-specific, global, and symlink installation)
- `README.md` - Comprehensive documentation for installation and usage

## Command Categories

The commands are organized into several categories:

**Analysis Commands (8):**
- `ultra-think` - Ultra-deep thinking mode for complex problem-solving
- `architecture-review` - Comprehensive architectural analysis
- `code-review` - Complete code quality review with security and performance analysis  
- `security-audit` - Security vulnerability assessment
- `performance-audit` - Performance bottleneck identification
- `dependency-audit` - Dependency security scanning
- `explain-code` - Explain complex code sections and architecture
- `test-coverage` - Analyze and improve test coverage

**Development Commands (7):**
- `create-feature` - End-to-end feature development workflow
- `fix-issue` - Structured GitHub issue resolution
- `refactor-code` - Safe refactoring workflow
- `debug-error` - Systematic debugging approach
- `write-tests` - Comprehensive testing implementation
- `optimize-build` - Build system improvements
- `optimize-bundle-size` - Reduce application bundle size

**Project Setup Commands (8):**
- `init-project` - Initialize new projects with best practices
- `setup-monorepo` - Configure monorepo structure
- `add-package` - Add new packages/modules
- `setup-development-environment` - Configure development environment
- `migrate-to-typescript` - Convert JavaScript to TypeScript
- `setup-linting` - Configure linting and code quality tools
- `setup-formatting` - Code formatting configuration
- `ci-setup` - Continuous integration setup

**Testing Commands (7):**
- `setup-comprehensive-testing` - Complete testing stack setup
- `generate-test-cases` - Auto-generate test cases
- `setup-visual-testing` - Visual regression testing
- `add-property-based-testing` - Property-based testing framework
- `setup-load-testing` - Performance and load testing
- `add-mutation-testing` - Mutation testing for test quality
- `e2e-setup` - End-to-end testing infrastructure

**Documentation Commands (7):**
- `generate-api-documentation` - Auto-generate API documentation
- `create-architecture-documentation` - Generate system architecture docs
- `create-onboarding-guide` - Comprehensive getting-started guide
- `doc-api` - Create detailed API documentation
- `add-changelog` - Automated changelog generation
- `migration-guide` - Create migration guides
- `troubleshooting-guide` - Generate troubleshooting documentation

**Security Commands (3):**
- `security-hardening` - Apply security best practices
- `add-authentication-system` - Implement authentication and authorization
- `setup-rate-limiting` - Configure API rate limiting

**DevOps Commands (10):**
- `containerize-application` - Create Docker configuration
- `setup-kubernetes-deployment` - Generate Kubernetes manifests
- `setup-monitoring-observability` - Add monitoring, logging, and tracing
- `add-performance-monitoring` - Implement performance monitoring
- `setup-cdn-optimization` - Configure CDN and asset optimization
- `hotfix-deploy` - Deploy critical fixes
- `rollback-deploy` - Safely rollback deployments
- `prepare-release` - Prepare production releases
- `clean-branches` - Clean up merged and stale branches
- `setup-automated-releases` - Implement automated release system with conventional commits

**Database Commands (3):**
- `design-database-schema` - Design and validate database schemas
- `create-database-migrations` - Generate safe database migrations
- `optimize-database-performance` - Optimize database queries

**API Commands (3):**
- `design-rest-api` - Design RESTful API endpoints
- `implement-graphql-api` - Implement GraphQL API layer
- `implement-caching-strategy` - Add intelligent caching systems

**Maintenance Commands (1):**
- `modernize-deps` - Update and modernize dependencies safely

**Utility Commands (4):**
- `all-tools` - List all available tools in TypeScript function signature format
- `git-status` - Comprehensive git repository status analysis
- `prime` - Load essential context for new agent sessions
- `sentient` - Test Claude Code hook protections (demonstration command)

**Project Management Commands (24):**
- Sprint Planning & Analysis (5 commands)
- Task Management (6 commands)  
- GitHub-Linear Synchronization (10 commands)
- Advanced Synchronization (3 commands)

## Command Structure

Each command file follows a consistent markdown structure:
- Title with `# Command Name`
- Brief description
- Detailed step-by-step instructions under `## Instructions`
- Commands accept arguments via `$ARGUMENTS` placeholder

## Installation Methods

The repository supports three installation methods via `install.sh`:
1. **Project-specific** (`--project`): Installs to `./.claude/commands/`
2. **Global** (`--global`): Installs to `~/.claude/commands/`
3. **Symlink** (`--symlink`): Creates symbolic links for development

## Key Features

- **Comprehensive Workflows**: Each command provides systematic, step-by-step approaches
- **Cross-Language Support**: Commands adapt to different programming languages and frameworks
- **Best Practices**: Built following Anthropic's Claude Code Best Practices
- **Modular Design**: Commands can be used independently or in sequence
- **Customizable**: Command files can be modified for project-specific needs

## Usage Patterns

Commands are typically used in workflows like:
```
/project:code-review                    # Assess current state
/project:create-feature user-dashboard  # Implement feature
/project:security-audit                 # Verify security
/project:performance-audit              # Check performance
```

## Development Notes

When working on this repository:
- Command files use markdown format with specific structure requirements
- The install script requires bash and handles cross-platform installation
- Commands are designed to be language-agnostic but provide specific guidance for common tech stacks
- Each command emphasizes thorough analysis before making changes