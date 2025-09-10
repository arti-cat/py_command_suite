# R&D Framework - Context Engineering Essentials

> "A focused agent is a performant agent" - Context engineering is the name of the game for high-value engineering in the age of agents.

## The R&D Framework

There are only **two ways** to manage your context window:

### **Reduce (R)**
- Read only necessary files; summarize aggressively; keep context lean
- Context Packs cap at 6000 tokens max
- Include only essential snippets with version pins
- Prefer URLs + excerpts over full documents
- Store verbose context externally in `.claude/background/`

### **Delegate (D)**  
- Push heavy work to subagents or background primary agents
- Route tasks based on `.claude/policies/routing.json`
- Ensure each agent gets exactly what it needs, nothing more
- Enforce strict I/O contracts
- One agent, one purpose, one focused task

## Context Engineering Levels

### **Beginner: Avoid MCP Bloat**
- Don't load MCP servers unless you need them
- A default MCP.json can chew up 24,000+ tokens (12% of context window)
- Fire up MCP servers by hand when needed
- Be very conscious with state going into your context window

### **Intermediate: Context Priming Over CLAUDE.md**
- Use dynamic `/prime` commands instead of large always-loaded memory files
- CLAUDE.md should contain only absolute universal essentials (100% sure, 100% of time)
- Context priming gives full control over initial context for specific task types
- Build focused prime commands: `/prime-bug`, `/prime-feature`, `/prime-review`

### **Advanced: Subagent Delegation**
- Subagents create "partially forked context windows"
- System prompts (agents) vs user prompts (commands) - massive difference
- Delegate work off primary agent's context window
- Keep contexts out of primary agent's window

### **Agentic: Multi-Agent Systems**
- Background primary agent delegation
- Context bundles for session continuity
- One-prompt agent delegation systems
- Get out of the loop - set up focused agents that do one thing extraordinarily well

## Context Discipline Rules

### **Always Apply**
1. **Measure and manage** your agent's context window
2. **Reduce** context entering your primary agent
3. **Delegate** context to specialist agents
4. **Focus** each agent on one purpose
5. **Monitor** context usage and optimize continuously

### **Never Do**
- Use oversized CLAUDE.md files that grow indefinitely
- Load unnecessary MCP servers by default
- Let context windows grow without management
- Use agents for multiple, unfocused purposes
- Ignore context budget and token consumption

## Implementation Patterns

### **Context Pack Structure**
```json
{
  "objective": "Clear task description",
  "inputs": {"files": [], "data": {}},
  "constraints": {"write_root": ".claude/", "max_tokens": 6000},
  "doc_snippets": [{"source": "url", "version": "v1.0", "content": "..."}],
  "io_contract": {"format": "json.patch", "required_fields": []},
  "success_checks": ["All outputs conform to schema"]
}
```

### **Agent Specialization**
- **Orchestrator**: Planning, context pack creation, multi-agent coordination
- **Coder**: Implementation with TDD, focused on json.patch output
- **Reviewer**: Quality/security analysis, focused on json.review output  
- **Researcher**: Documentation gathering, context pack preparation

### **Session Continuity**
- Context bundles capture 60-70% of previous agent's work
- Session manifests track progress and artifacts
- Resumable workflows after context window explosion
- Background task delegation for long-running work

## Success Metrics

**Good Context Engineering:**
- 90%+ context window free on startup
- Context packs under 6000 tokens each
- Clear agent specialization and routing
- Successful task completion in single attempts

**Poor Context Engineering:**
- Agents struggling with oversized context
- Multiple retry attempts due to confusion
- Wasted tokens on irrelevant information
- Agents taking on multiple unfocused responsibilities

Remember: **It's not about saving tokens, it's about spending them properly.** We manage context windows to avoid wasting time and tokens correcting agent mistakes. The goal is one-shot, out-of-loop agent execution with focused, specialized agents.