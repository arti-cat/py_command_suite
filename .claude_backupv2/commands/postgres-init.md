---
name: postgres-init
description: PostgreSQL integration setup via database-manager agent
orchestrates: database-manager
output-style: project-status
---

# PostgreSQL Integration Setup

I'll configure PostgreSQL integration for your Python project using our specialized database-manager agent.

## Agent Delegation

I'll delegate database setup to our `database-manager` agent with complete project context:

### Context Provided to Agent
- **Project Framework**: Django, FastAPI, Flask, or generic Python detection
- **Existing Database Config**: Current database settings and connections
- **UV Integration**: Add database dependencies via UV package manager
- **Environment Management**: .env files and configuration patterns
- **Migration Strategy**: Framework-appropriate database migration setup

### Database Integration Scope
- **PostgreSQL Dependencies**: asyncpg, psycopg2, SQLAlchemy as appropriate
- **Connection Configuration**: Environment variables and connection strings
- **Framework Integration**: ORM setup for detected framework
- **Development Tools**: Database management and migration utilities
- **Security Setup**: Credential management and connection security

## Expected Output

Results will be formatted using our `project-status` output style for:
- Database dependency installation status
- Framework-specific ORM configuration
- Environment variable setup
- Database connection verification
- Development workflow integration

## Agent Brief

**Database-Manager Agent Assignment:**
- **Tools**: Write, Bash (for dependency management and database setup)
- **Focus**: PostgreSQL integration with framework-appropriate patterns
- **Context**: Complete project structure and framework detection
- **Deliverables**: Production-ready database configuration
- **Integration**: Setup report saved to `agents/reports/postgres-init-{{timestamp}}.md`

The database-manager agent will configure PostgreSQL integration that follows framework best practices while maintaining universal compatibility across Python projects.