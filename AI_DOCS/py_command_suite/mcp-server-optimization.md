# MCP Server Optimization - Beginner Context Engineering (B2)

*Extracted from IDD Context Engineering transcript - First critical optimization for context window management*

## 🚨 **The Problem: MCP Token Drain**

### **Shocking Reality**
```
MCP Tools Token Usage: 24,100 tokens
Percentage of Context Window: 12%
Cost: Expensive Opus tokens chewed up before any work begins
```

> **"It's very likely you're wasting tokens with MCP servers you're not actively using"**

This is a **simple, easy, beginner context engineering mistake** that most engineers make. The solution is equally simple.

## 🎯 **The Solution: Purposeful MCP Loading**

### **Bad Practice** ❌
```json
// Default MCP.json that always loads
{
  "mcpServers": {
    "filesystem": { ... },
    "github": { ... },
    "linear": { ... },
    "context7": { ... },
    "database": { ... }
  }
}
```
**Result**: 20,000+ tokens consumed on every startup

### **Good Practice** ✅
```bash
# NO default MCP.json file
# Load only what you need, when you need it

# Example: Load specific MCP server
claude-mcp config path/to/specialized-4k.json

# Example: Strict override for globals
claude-mcp config path/to/firecrawl-only.json --strict
```
**Result**: Save 20,000+ tokens immediately

## 🔧 **Implementation Strategy**

### **Step 1: Audit Current Usage**
Check your current MCP token consumption:
```bash
claude context
# Look for "MCP Tools" section
# Note token usage and percentage
```

### **Step 2: Delete Default MCP.json**
```bash
# Remove the wasteful default configuration
rm .claude/mcp.json
# Or rename for backup
mv .claude/mcp.json .claude/mcp.json.backup
```

### **Step 3: Create Specialized Configurations**
Create targeted MCP configurations for specific use cases:

```json
// firecrawl-4k.json - Web scraping only
{
  "mcpServers": {
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "@firecrawl/mcp-server"],
      "env": {
        "FIRECRAWL_API_KEY": "${FIRECRAWL_API_KEY}"
      }
    }
  }
}
```

```json
// context7-research.json - Documentation research only  
{
  "mcpServers": {
    "context7": {
      "command": "mcp-context7",
      "args": ["--token", "${CONTEXT7_API_KEY}"]
    }
  }
}
```

```json
// python-dev.json - Python development tools
{
  "mcpServers": {
    "context7": { ... },
    "filesystem": { ... }
  }
}
```

### **Step 4: Load On-Demand**
```bash
# Load specialized configuration when needed
claude-mcp config ./configs/python-dev.json

# Check context savings
claude context
# Should show 90%+ free context on startup
```

## 📊 **Token Economics**

### **Before Optimization**
```
Startup Context Usage:
- MCP Servers: 24,100 tokens (12%)
- Claude.md: 23,000 tokens (10%)  
- Available: 78% context window
- Total Overhead: 47,100 tokens
```

### **After Optimization**
```
Startup Context Usage:
- MCP Servers: 0-6,000 tokens (0-3%) - only when needed
- Claude.md: 350 tokens (<1%) - trimmed  
- Available: 96%+ context window
- Total Overhead: <6,350 tokens
```

**Savings**: 40,000+ tokens = 20% of entire context window!

## 🐍 **Python Command Suite Application**

### **Our MCP Usage Strategy**
For Python development, we selectively need:

**Core Python Development**:
```json
// python-core.json
{
  "mcpServers": {
    "context7": { ... },     // Library research
    "filesystem": { ... }    // File operations
  }
}
```

**Web Development (Django/FastAPI)**:
```json  
// python-web.json
{
  "mcpServers": {
    "context7": { ... },     // Framework research
    "filesystem": { ... },   // File operations  
    "database": { ... }      // Database interactions
  }
}
```

**Documentation/Research**:
```json
// python-research.json  
{
  "mcpServers": {
    "context7": { ... },     // Documentation
    "firecrawl": { ... }     // Web scraping for research
  }
}
```

### **Command-Specific Loading**
Our Python commands can specify optimal MCP configurations:

```markdown
# py-setup-environment.md
## Prerequisites
Load specialized MCP configuration:
`claude-mcp config configs/python-core.json`

## Process
1. Use Context7 to research optimal environment setup
2. Use filesystem tools for project structure
3. No additional MCP overhead needed
```

## 🔄 **Dynamic Loading Patterns**

### **Task-Based Loading**
```bash
# Research phase - documentation heavy
claude-mcp config python-research.json  

# Development phase - core tools only
claude-mcp config python-core.json

# Deployment phase - infrastructure tools
claude-mcp config python-deploy.json
```

### **Agent-Specific Loading**
When we implement Python agents:
```bash
# python-environment-specialist needs minimal tools
claude-mcp config python-minimal.json

# python-research-specialist needs Context7 + web tools  
claude-mcp config python-research.json
```

## ⚡ **Performance Optimization**

### **MCP Configuration Sizes**
Target token usage by configuration:
- **Minimal**: <2k tokens (single MCP server)
- **Core Development**: 4k-6k tokens (2-3 essential servers)
- **Full Research**: 8k-10k tokens (all research tools)
- **Never Exceed**: 12k tokens (>6% context window)

### **Loading Strategies**
```bash
# Quick specialized agent with minimal context
claude-mcp config minimal.json && claude

# Research session with full documentation tools
claude-mcp config research.json && claude

# Reset to clean state
claude-mcp config --none && claude
```

## 🎯 **Best Practices**

### **Configuration Management**
1. **Name Descriptively**: `python-django-dev.json` not `config1.json`
2. **Document Purpose**: Comment why each MCP server is needed
3. **Track Token Usage**: Monitor actual usage vs expectations
4. **Regular Audits**: Review and remove unused configurations

### **Development Workflow**
1. **Start Clean**: No default MCP.json in project
2. **Load Purposefully**: Choose configuration based on task
3. **Monitor Usage**: Check context window before work begins
4. **Optimize Iteratively**: Adjust configurations based on actual needs

### **Team Coordination**
1. **Share Configurations**: Standard MCP configs for team consistency
2. **Document Usage**: When to use which configuration
3. **Training**: Ensure team understands MCP optimization
4. **Standards**: Establish token budget limits for MCP usage

## 🚨 **Critical Warnings**

### **Don't Default Everything**
> "There are many places to be wasteful as an engineer to move fast and break things. The context window of your agents is not one of them."

### **Be Conscious with State**
- Every MCP server loaded affects **every** conversation
- MCP servers persist across agent interactions
- Token costs accumulate quickly with multiple agents
- Always verify MCP loading before important work

### **Reference Explicitly**
When you need every MCP server, explicitly reference it. Be very conscious with the state going into your context window.

## 📈 **Success Metrics**

### **Context Window Health**
- **Target**: 90%+ free context on startup
- **Acceptable**: 85%+ free context on startup  
- **Warning**: <80% free context on startup
- **Critical**: <70% free context on startup

### **MCP Efficiency**
- **Optimal**: <3% context window for MCP servers
- **Acceptable**: <6% context window for MCP servers
- **Wasteful**: >10% context window for MCP servers
- **Broken**: >15% context window for MCP servers

---

**Key Takeaway**: MCP server optimization is the **first and easiest** context engineering win. Clean up your MCP usage before attempting more advanced context engineering techniques. This single change can save 20% of your context window immediately.

*This optimization applies the **R** (Reduce) principle from the R&D framework - reducing unnecessary context entering your primary agent.*