# Claude Project Charter

This repository uses the **R&D Framework (Reduce & Delegate)** to optimize Claude Code interactions and maintain focused, performant agents.

## Framework Principles

- **Reduce**: Keep context windows small with least-necessary, version-pinned Context Packs
- **Delegate**: Route focused tasks to dedicated agents with strict I/O contracts
- **A focused agent is a performant agent**

## Directory Structure

### Core Claude Code Directories
- `.claude/agents/` — Specialized agent definitions (orchestrator, coder, reviewer, researcher)
- `.claude/commands/` — Command specifications with safety limits (read, write, bash, git, grep, http)
- `.claude/hooks/` — Automation and policy enforcement (preplan, predelegate, pretooluse, posttooluse, onerror)
- `.claude/output-styles/` — JSON schemas for structured outputs (json.plan, json.patch, json.review, json.report)
- `.claude/policies/` — Access control and routing rules (permissions.json, routing.json, limits.json)

### R&D Framework Extensions
- `.claude/background/` — Stable, human-curated context and domain knowledge
- `.claude/context-bundles/` — Machine-generated Context Packs (least context, version-pinned)
- `.claude/plans/` — Planning outputs and task breakdowns (json.plan format)
- `.claude/reports/` — Reviews, handoffs, and session synthesis (json.review, json.report formats)
- `.claude/sessions/` — Run manifests, metrics, and continuity data

## Agent Specialization

**Orchestrator** (`orchestrator.md`):
- Planning and task decomposition
- Context Pack creation and management
- Multi-agent coordination and delegation
- Session synthesis and reporting

**Coder** (`coder.md`):
- Code implementation with TDD approach
- File operations under write_root restrictions
- Unified diff generation and artifact creation
- Integration with build and test workflows

**Reviewer** (`reviewer.md`):
- Code quality and security analysis
- Risk assessment with severity classifications
- Structured feedback with actionable suggestions
- Approval workflows with clear criteria

**Researcher** (`researcher.md`):
- Documentation gathering and synthesis
- Version-pinned snippet creation
- API reference and best practice research
- Context Pack preparation for other agents

## Safety & Scope

### Write Root Enforcement
- Agents can **only** write under `.claude/` by default
- File operations outside write_root are automatically rebased into `.claude/artifacts/`
- All write operations logged and tracked for audit

### Security Controls
- Commands filtered through whitelist-based validation
- Network access restricted to documentation sites
- File access blocked for secrets, credentials, environment files
- Resource limits enforced (tokens, time, output size)

### Context Discipline  
- Maximum 6000 tokens per Context Pack
- Version-pinned documentation snippets only
- Focused, single-purpose task delegation
- Automated context size monitoring and warnings

## Usage Patterns

### Start a Session
```
> /prime                    # Load project-specific context
> Use the orchestrator agent to plan the implementation of [feature]
```

### Code Implementation
```
> Use the coder agent to implement authentication module
> Use the reviewer agent to check the auth implementation
```

### Research and Documentation
```
> Use the researcher agent to gather OAuth2 best practices
> Use the orchestrator to create a Context Pack for OAuth2 implementation
```

### Session Continuity
```
> Load the context bundle from .claude/context-bundles/[timestamp]_[task].json
> Resume work on incomplete tasks from .claude/plans/
```

## Quality Gates

### Automated Enforcement
- All outputs must conform to JSON schemas in `.claude/output-styles/`
- Context Packs must include version pins and citations
- File operations must respect write_root boundaries
- Resource usage tracked against limits in `.claude/policies/limits.json`

### Code Quality Standards
- All code changes include appropriate tests
- Documentation updated for public interfaces
- Security patterns followed for authentication/authorization
- Performance considerations documented for complex operations

## Configuration

### Customization Points
Adjust these files to fit your project's specific needs:

**Routing** (`.claude/policies/routing.json`):
- Map task types to appropriate agents
- Define escalation paths for blocked operations
- Configure agent capabilities and specializations

**Permissions** (`.claude/policies/permissions.json`):
- Define allowed/denied commands and file patterns
- Set write_root and safety boundaries
- Configure resource limits and timeouts

**Limits** (`.claude/policies/limits.json`):
- Set token budgets and time limits per task
- Define quality gates and success criteria
- Configure resource quotas and monitoring thresholds

### Project-Specific Context
Add your project's specific information to:

**Background Knowledge** (`.claude/background/`):
- Domain-specific terminology and concepts
- Architectural decisions and constraints  
- Team conventions and coding standards
- Integration points and external dependencies

**Context Lenses**:
- Creator lens for planning and orchestration context
- Target lens for implementation-focused context
- Quality lens for review and analysis context
- Research lens for documentation and investigation context

## Workflow Integration

### Development Cycle
1. **Plan** → Orchestrator creates json.plan with Context Packs
2. **Research** → Researcher gathers version-pinned documentation
3. **Implement** → Coder creates json.patch with code and tests
4. **Review** → Reviewer generates json.review with quality analysis
5. **Synthesize** → Orchestrator creates json.report with session summary

### Git Integration
- Repository state monitoring through safe git commands
- Change tracking correlated with session artifacts
- Staged change analysis for review workflows
- Commit message generation based on session outputs

### Build Integration
- Test execution through controlled bash commands
- Build validation with appropriate timeouts
- Quality tool integration (linting, type checking)
- Artifact generation and cataloging

## Error Handling and Recovery

### Automatic Recovery
- Retry ladder: shrink scope → add context → switch agent → fail cleanly  
- Resource limit violations handled with optimization suggestions
- Context overflow managed through pack compression and filtering
- Network failures handled with cached fallbacks

### Manual Intervention Points
- Security violations require human review
- Resource exhaustion needs system administration
- Three consecutive failures trigger escalation
- Critical tool failures require manual resolution

## Session Continuity Features

### Resumable Sessions
- All operations logged to `.claude/sessions/[session_id].json`
- Context Packs preserved for task resumption
- Partial work artifacts maintained across interruptions
- Resource usage tracking for budget management

### Knowledge Accumulation
- Successful patterns cataloged for reuse
- Error patterns analyzed for prevention
- Context Pack templates improved over time
- Agent performance metrics tracked and optimized

---

## Getting Started

1. **Initialize**: The `.claude/` structure has been set up with working defaults
2. **Customize**: Edit `.claude/policies/` files to match your project needs  
3. **Prime**: Use `/prime` commands to load project-specific context
4. **Delegate**: Start with orchestrator agent for complex, multi-step tasks
5. **Iterate**: Use session continuity features to build on previous work

Remember: **A focused agent is a performant agent.** The R&D framework helps maintain that focus while enabling powerful, multi-agent workflows.