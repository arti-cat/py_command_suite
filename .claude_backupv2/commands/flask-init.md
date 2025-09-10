---
name: flask-init
description: Flask application scaffolding via web-scaffolder agent
orchestrates: web-scaffolder
output-style: project-status
---

# Flask Application Scaffolding

I'll scaffold a Flask web application structure using our specialized web-scaffolder agent.

## Agent Delegation

I'll delegate Flask setup to our `web-scaffolder` agent with complete project context:

### Context Provided to Agent
- **Project Structure**: Existing src/ layout and package organization
- **Dependencies**: UV package management with Flask ecosystem
- **Web Patterns**: Blueprint organization, templating, and static assets
- **Development Tools**: Flask-CLI, debugging, and testing integration
- **Production Readiness**: WSGI configuration, logging, and deployment setup

### Flask Integration Scope
- **Core Dependencies**: Flask, Flask-SQLAlchemy, Flask-Migrate with extensions
- **Application Structure**: Blueprints, templates, static files, and configuration
- **Database Integration**: SQLAlchemy models with migration support
- **Authentication**: Flask-Login with session management
- **Testing Framework**: pytest with Flask test client integration

## Expected Output

Results will be formatted using our `project-status` output style for:
- Flask dependency installation status
- Application factory pattern setup
- Blueprint and template structure
- Database and migration configuration
- Development server and testing setup

## Agent Brief

**Web-Scaffolder Agent Assignment:**
- **Tools**: Write, Bash (for Flask project setup and configuration)
- **Focus**: Flask web application scaffolding with modern patterns
- **Context**: Complete project understanding with existing structure integration
- **Deliverables**: Production-ready Flask application with best practices
- **Integration**: Setup report saved to `agents/reports/flask-init-{{timestamp}}.md`

The web-scaffolder agent will create a comprehensive Flask application structure that integrates with your existing project while following Flask best practices and modern web development patterns.