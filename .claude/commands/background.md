---
description: Launch background primary agent for long-running tasks with progress tracking
argument-hint: "purpose sentence"
allowed-tools: Bash, Write
---
Launch a background Claude Code instance for long-running tasks that would consume too much primary context.

**Process:**
1. Create progress tracking directory: `agents/background/{{timestamp}}/`
2. Write initial report file: `agents/background/{{timestamp}}/report.md`
3. Launch background Claude Code instance with the provided purpose statement
4. Set up progress monitoring and status updates

**Background Agent Instructions:**
- Work independently on the specified task
- Write progress updates to the report file
- Keep context focused and avoid bloating primary agent
- Complete task and rename report file when finished (add "COMPLETE-" prefix)

**Return Information:**
- Path to progress report file for monitoring
- Latest context bundle path for session continuity
- Background task ID for reference

This enables out-of-loop agent execution following R&D Framework delegation principles.