---
description: Replay prior context from a session bundle for continuity
argument-hint: "path/to/bundle.md"
allowed-tools: Read
---
Load and replay context from a previous session bundle to restore agent state.

Read the specified bundle file and:
1. **Deduplicate operations** - Skip redundant read/grep operations already in current context
2. **Summarize objectives** - Extract the main goals and progress from the bundle
3. **Identify artifacts** - List files created or modified in the previous session
4. **Create replay plan** - Generate ≤10 focused steps to continue the work

Output a concise **Replay Plan** that includes:
- Context summary (what was being worked on)
- Key findings from previous session
- Next logical steps to continue
- Files that may need re-reading for current context

Keep replay focused and actionable - don't just repeat the entire previous session.