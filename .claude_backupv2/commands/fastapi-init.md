---
name: fastapi-init
description: FastAPI project scaffolding via api-scaffolder agent
orchestrates: api-scaffolder
output-style: project-status
---

# FastAPI Project Scaffolding

I'll scaffold a FastAPI application structure using our specialized api-scaffolder agent.

## Agent Delegation

I'll delegate FastAPI setup to our `api-scaffolder` agent with complete project context:

### Context Provided to Agent
- **Project Structure**: Existing src/ layout and package organization
- **Dependencies**: UV package management with FastAPI ecosystem
- **API Patterns**: RESTful endpoints, middleware, and async patterns
- **Development Tools**: Testing, documentation, and debugging setup
- **Production Readiness**: Docker, monitoring, and deployment configuration

### FastAPI Integration Scope
- **Core Dependencies**: FastAPI, Uvicorn, Pydantic with async support
- **Project Structure**: Routers, models, schemas, middleware organization
- **API Documentation**: OpenAPI/Swagger integration with custom schemas
- **Testing Framework**: pytest-asyncio with TestClient integration
- **Development Environment**: Hot reload, debugging, and logging setup

## Expected Output

Results will be formatted using our `project-status` output style for:
- FastAPI dependency installation status
- Project structure creation
- API endpoint scaffolding
- Testing and documentation setup
- Development server configuration

## Agent Brief

**API-Scaffolder Agent Assignment:**
- **Tools**: Write, Bash (for FastAPI project setup and configuration)
- **Focus**: FastAPI application scaffolding with modern async patterns
- **Context**: Complete project understanding with existing structure preservation
- **Deliverables**: Production-ready FastAPI application with best practices
- **Integration**: Setup report saved to `agents/reports/fastapi-init-{{timestamp}}.md`

The api-scaffolder agent will create a comprehensive FastAPI application structure that integrates seamlessly with your existing project while following FastAPI best practices and modern Python patterns.