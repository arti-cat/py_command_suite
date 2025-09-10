Welcome to the R&D Framework! Here's your 5-step onboarding:

**Step 1**: Check context usage with `/context` - you want 90%+ free on startup
**Step 2**: Load framework knowledge with `/prime-rd` 
**Step 3**: See your specialists: `ls .claude/agents/` - you have orchestrator (planning), coder (implementation), reviewer (quality), researcher (documentation)
**Step 4**: Try delegation: "Task: Use the orchestrator agent to create a simple project plan"
**Step 5**: Monitor context after operations with `/context` - above 50% means delegate or reduce

**Workflows**: Planning (`/prime-rd` → orchestrator agent → focused context packs), Implementation (delegate to coder → json.patch contracts → monitor context), Quality (reviewer agent → json.review format), Research (researcher agent → version-pinned snippets → store in `.claude/background/`)

**Context Engineering Levels**: Beginner (avoid MCP bloat, slim CLAUDE.md), Intermediate (subagent delegation, token budgets), Advanced (context bundles, background agents), Agentic (one-prompt systems, out-of-loop execution)

**Success Metrics**: 90%+ context free on startup, context packs under 6000 tokens, clear specialization, single-attempt completion

Remember: "A focused agent is a performant agent" - Goal is one-shot, out-of-loop execution. It's not about saving tokens, it's about spending them properly.