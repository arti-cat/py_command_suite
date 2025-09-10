Here’s Dan’s take, distilled straight from your transcript:

## What a “background agent” is

* A **separate, top-level Claude Code instance** you spawn from your main session to do long or token-heavy work.
* It writes progress to a **report file** (e.g., `agents/background/<timestamp>/report.md`) and leaves a **context bundle** (lightweight trail of READ/WRITE/BASH steps) you can reload later.

## Why use it

* **Delegate (the “D” in R\&D):** keep big reads, scraping, planning, or builds **out of your primary agent’s context window** so it stays fast and focused.
* **Get out of the loop:** kick off work you don’t need to babysit; continue using your main agent without ballooning tokens.
* **Scales compute & orchestration:** “agents orchestrating agents.” Once you master one clean context window, you can safely run more agents in parallel.

## When to use it

* Anything long-running or context-hungry: doc scraping, large planning passes, builds, tests, or multi-step workflows.
* When sub-agents aren’t enough and you want **full isolation** (a whole new primary instance with its own tools/limits).

## How Dan wires it up (pattern)

1. **Command:** a reusable `/background` command that:

   * Creates a **Background Brief** (purpose, inputs, *done-when*).
   * Spawns a new Claude Code instance with that brief.
   * Logs progress to a **report file** and appends entries to a **context bundle**.
2. **Context Bundles:** tiny, append-only trail (READ/WRITE/BASH bullets) so another agent can `/loadbundle` and **replay** just enough state without overflowing context.
3. **Strict focus:** background agent does **one thing** extraordinarily well, then exits.

## Guardrails & tips he stresses

* Keep the **brief concise** and include a concrete **done-when** (e.g., “wheel built in `dist/`”, “tests pass”).
* **Don’t preload** unnecessary MCP servers or giant `claude.md`; **prime** context for the task instead.
* Keep bundles **small**—enough story for replay, not a full transcript—so you don’t bloat the next agent.

### TL;DR

Dan treats a background agent as the **simplest, fastest path to multi-agent delegation**: one prompt launches a clean, isolated agent that reports to files and preserves a lean breadcrumb trail. It’s the practical way to **protect your main context window**, move faster, and scale to “better agents → more agents.”
