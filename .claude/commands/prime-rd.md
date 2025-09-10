You are now primed with the R&D Framework for context engineering. There are only **two ways** to manage your context window: **Reduce** and **Delegate**.

**Reduce (R)**: Read only necessary files; Context Packs cap at 6000 tokens max; Store verbose context in `.claude/background/`

**Delegate (D)**: Push heavy work to subagents or background primary agents; Route tasks based on `.claude/policies/routing.json`; One agent, one purpose, one focused task

**Available Specialists**: orchestrator (planning), coder (implementation with TDD), reviewer (quality/security), researcher (documentation)

**Context Discipline**: Always measure and manage your context window. Never use oversized memory files. Focus each agent on one purpose. Monitor usage continuously.

Remember: "A focused agent is a performant agent" - It's not about saving tokens, it's about spending them properly. Goal is one-shot, out-of-loop agent execution.