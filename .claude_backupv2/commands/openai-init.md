---
name: openai-init
description: OpenAI API integration setup via ai-integrator agent
orchestrates: ai-integrator
output-style: project-status
---

# OpenAI API Integration Setup

I'll configure OpenAI API integration for your Python project using our specialized ai-integrator agent.

## Agent Delegation

I'll delegate AI integration setup to our `ai-integrator` agent with complete project context:

### Context Provided to Agent
- **Project Framework**: Framework-specific integration patterns
- **Existing AI Dependencies**: Current AI/ML libraries and configurations
- **UV Package Management**: Add OpenAI dependencies via UV
- **Environment Security**: API key management and security patterns
- **Usage Patterns**: Chat completions, embeddings, assistants, function calling

### AI Integration Scope
- **OpenAI Dependencies**: openai, tiktoken, and related packages
- **API Configuration**: Client setup with environment-based configuration
- **Security Patterns**: API key management and usage monitoring
- **Framework Integration**: Web framework endpoints and middleware
- **Development Tools**: Testing utilities and rate limiting

## Expected Output

Results will be formatted using our `project-status` output style for:
- OpenAI package installation status
- API client configuration
- Environment variable setup
- Framework-specific integration patterns
- Security and monitoring setup

## Agent Brief

**AI-Integrator Agent Assignment:**
- **Tools**: Write, Bash (for dependency management and API setup)
- **Focus**: OpenAI API integration with security and monitoring
- **Context**: Complete project structure and framework detection
- **Deliverables**: Production-ready AI integration with best practices
- **Integration**: Setup report saved to `agents/reports/openai-init-{{timestamp}}.md`

The ai-integrator agent will configure OpenAI API integration following security best practices while providing framework-appropriate patterns for immediate development productivity.