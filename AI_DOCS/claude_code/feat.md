# 🤖 Agents (Subagents)

* **Purpose**: Specialized AI workers that handle focused tasks (reviewing, debugging, testing).
* **Managing agents**:

  * `/agents` → interactive menu for viewing, editing, creating, deleting subagents
  * Example:

    ```
    > use the code-reviewer subagent to check the auth module
    > have the debugger subagent investigate login failures
    ```
* **Creating agents**: Store configs in `.claude/agents/` (project) or `~/.claude/agents/` (personal).
  Example :

  ```yaml
  ---
  name: test-runner
  description: Run tests and fix failures
  ---
  You are a test automation expert. Proactively run tests when code changes,
  analyze failures, and fix them without altering intent.
  ```

---

# ⌨️ Commands (Slash Commands)

* **Built-ins**: `/help`, `/clear`, `/model`, `/agents`, `/ide`, `/init`, `/mcp`
* **File references**: Use `@` to inject file content :

  ```
  Review @src/utils/helpers.js
  Compare @src/old.js with @src/new.js
  ```
* **MCP commands**: Generated from integrations, format:

  ```
  /mcp__<server>__<prompt> [args]
  ```

  Example  :

  ```
  /mcp__github__list_prs
  ```
* **Custom commands**:

  * Stored in `.claude/commands/` or `~/.claude/commands/`
  * Can use `$ARGUMENTS`, `$1`, `$2`, etc. for parameterization
  * Example:

    ```yaml
    ---
    argument-hint: [pr-number] [priority]
    description: Review pull request
    ---
    Review PR #$1 with priority $2
    ```

---

# 🪝 Hooks

* **Purpose**: Run external scripts at lifecycle events or tool use.
* **Events**:

  * `SessionStart`
  * `UserPromptSubmit`
  * `PreToolUse`, `PostToolUse` 【5†context7\_claude\_code.md】
  * `Notification`
  * `Stop`, `SubagentStop`
* **Hook configuration** :
  {
  "PreToolUse": \[
  {
  "matcher": "Bash",
  "hooks": \[{ "type": "command", "command": "log-bash.sh" }]
  }
  ]
  }
  }

  ```
  ```
* **Examples**:

  * Log Bash commands before execution
  * Prevent edits to `.env`/sensitive files
  * Auto-format Markdown or TypeScript files after writes
  * Desktop notifications on user input requests

---

# 🎨 Output Styles

* **Custom styles**: Stored as `.claude/styles/*.md` with YAML + instructions :

  ```yaml
  ---
  name: My Custom Style
  description: Helpful debugging assistant
  ---
  # Custom Style Instructions
  Always explain errors step by step.

  ## Specific Behaviors
  - Provide minimal repro code
  - Suggest fixes with reasoning
  ```
* **CLI output formats**  :

  * `text` (default) → plain human-readable
  * `json` → structured machine-readable
  * `stream-json` → incremental JSON for live integrations

  ```sh
  claude -p "analyze code" --output-format json
  ```

---

✅ **In summary**:

* **Agents** = specialized personalities.
* **Commands** = reusable triggers (built-in, MCP, or custom).
* **Hooks** = automation for tool usage and lifecycle events.
* **Output styles** = how Claude presents results, both visually and structurally.

