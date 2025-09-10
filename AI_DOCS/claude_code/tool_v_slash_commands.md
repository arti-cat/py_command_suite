# 🔧 Tool Commands (built-in + custom)

### Built-in tools Claude uses

* **File tools**

  * `Read` – read file contents
  * `Edit` / `MultiEdit` – apply patches to files
  * `Write` – create new files
  * `Grep`, `Glob`, `LS` – search/discovery helpers

* **Shell tool**

  * `Bash` – run terminal commands (`npm run build`, `pytest`, etc.).

    * Permissions can be exact or prefix matches:

      ```txt
      Bash(npm run test:*)
      Bash(git diff:*)
      ```

* **Network tool**

  * `WebFetch(domain:example.com)` – controlled web access.

* **MCP tools**

  * Added via `claude mcp add …` for integrations like GitHub, Jira, Datadog, etc.
  * Then available as `mcp__github__list_prs` or `mcp__jira__create_issue`.

### Controlling tool use

* In `.claude/settings.json`:

  ```json
  {
    "permissions": {
      "allow": ["Bash(npm run lint)", "Read(~/.zshrc)"],
      "deny": ["Bash(curl:*)", "Read(./.env)"]
    }
  }
  ```
* CLI overrides:

  ```sh
  claude --allowedTools "Read" --disallowedTools "Edit"
  claude --permission-mode plan   # read-only
  claude --dangerously-skip-permissions  # no confirmations
  ```
* **Hooks** let you:

  * Auto-approve safe commands (e.g. read `.md` files)
  * Block edits to sensitive files (`.env`, `.git/`)
  * Log every Bash command to `~/.claude/bash-command-log.txt`

### Custom tools via SDK/MCP

* Define a server that exposes type-safe functions, e.g.:

  ```ts
  tool("calculate_interest", "Compound interest calculator", { … }, async (args) => {
    return { content: [{ type: "text", text: `Result: ${amount}` }] }
  })
  ```
* Claude can then call `mcp__finance__calculate_interest` automatically in-session.

---

## ⌨️ Slash Commands (user-facing)

### Built-in slash commands

* `/help`, `/clear`, `/exit`
* `/login`, `/logout`
* `/config` – open settings interface
* `/agents` – manage subagents
* `/model sonnet` – switch model
* `/init` – bootstrap a `CLAUDE.md` memory file
* `/ide` – connect to IDE
* `/mcp` – manage external MCP servers

### Custom project or personal commands

* **Project-scoped**: `.claude/commands/optimize.md`
* **User-scoped**: `~/.claude/commands/security-review.md`

Example:

```sh
mkdir -p .claude/commands
echo "Analyze this code for performance issues and suggest optimizations:" > .claude/commands/optimize.md
```

Run with:

```
> /optimize
```

### Arguments

* `$ARGUMENTS` for free-form:

  ```md
  Fix issue #$ARGUMENTS following our coding standards
  ```

  ```
  > /fix-issue 123 high-priority
  # → expands to: "Fix issue #123 high-priority following our coding standards"
  ```

* `$1`, `$2` for positional:

  ```yaml
  ---
  argument-hint: [pr-number] [priority]
  description: Review pull request
  ---
  Review PR #$1 with priority $2
  ```

### Advanced slash command features

* **Frontmatter metadata**:

  ```yaml
  ---
  allowed-tools: Bash(git add:*), Bash(git commit:*)
  model: claude-3-5-haiku-20241022
  description: Create a git commit
  ---
  Create a git commit with message: $ARGUMENTS
  ```
* **Dynamic context injection with `!`**:

  ```yaml
  ## Context
  - Current git status: !`git status`
  - Current branch: !`git branch --show-current`
  ```

  → runs these Bash commands and includes their output in the prompt.

---

### ✅ Key takeaway

* **Tool commands** are what Claude can do (file edits, shell, integrations).
* **Slash commands** are how *you* tell Claude to do things in a structured, repeatable way (like macros or templates).
* Together they let you:

  * Guard and log sensitive actions (tools)
  * Create reusable developer shortcuts (slash commands)

---
