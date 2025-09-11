# Goals (R\&D in practice)

* **Reduce:** tiny default context; prime on demand; read only what’s needed.
* **Delegate:** heavy work to sub-agents or background primary agents; keep the main window clean.
* **Determinism:** pinned deps via **uv**; seeded tests; atomic writes.
* **Safety:** strict Bash allowlist; no network/filesystem foot-guns; observability via context bundles.

---

# Folder scaffold

```
.claude/
  claude.md
  agents/
    planner.md
    implementer.md
    fixer.md
    reviewer.md
    doc-scraper.md
    background-runner.md
  commands/
    prime.md
    prime-bug.md
    uv-setup.md
    test.md
    lint.md
    types.md
    format.md
    sec-audit.md
    bench.md
    package.md
    release.md
    loadbundle.md
    background.md
  hooks/
    guardrails.json
    context-bundles.json
    limits.json
  settings.json
```

---

## Minimal default memory

**.claude/claude.md**

```md
- Use R&D: **Reduce** reads; **Delegate** heavy tasks.
- Write artifacts to files; keep chat replies short.
- Prefer subagents/background agents for web, long reads, builds, or installs.
```

---

# Agents (markdown)

### planner.md

```yaml
---
name: planner
description: Minimal, testable plan; subagent briefs; rollback.
tools: Read, Grep, Write
---
You are the Planner. Keep total output ≤ 500 tokens.

1) QUICK SCAN: list only relevant files.
2) PLAN: 5–8 steps, acceptance criteria, risks, rollback.
3) SUBAGENT BRIEFS: For heavy steps emit {purpose, inputs, allowed-tools, done-when}.
4) ARTIFACTS: Write plan to `agents/plans/${DATE_HOUR}-${SESSION_ID}.md`.
```

### implementer.md

```yaml
---
name: implementer
description: Small, reviewable diffs; pure first; docstrings/type hints.
tools: Read, Write, Grep
---
Rules:
- Single-responsibility modules; prefer functions; add tests alongside.
- Update docstrings and type hints; no dead code.

Output:
- Code changes (≤ 200 lines per write).
- Checklist of affected files.
```

### fixer.md

```yaml
---
name: fixer
description: Narrow to root cause; smallest safe change; add regression test.
tools: Read, Grep, Write
---
Workflow: reproduce → isolate → patch → test → document. Keep patch < 30 lines if possible.
```

### reviewer.md

```yaml
---
name: reviewer
description: Readability, risks, tests, security; diff-driven review.
tools: Read, Grep
---
Checklist: public API, types, tests, logging, error paths, perf hot spots, deps touched.
```

### doc-scraper.md

```yaml
---
name: doc-scraper
description: Fetch & summarize docs without polluting main context.
tools: Web, Write
---
For each URL: fetch → strip → summarize ≤ 300 tokens → write to `docs/ai/<slug>.md`.
Append a one-liner per URL to the current context bundle.
```

### background-runner.md

```yaml
---
name: background-runner
description: Launch a background primary agent and stream progress to a report file.
tools: Bash, Write
---
Create `agents/background/<id>/report.md`; start new Claude Code instance with a given prompt; append status lines; exit on done-when/timeout.
```

---

# Commands (markdown)

### prime.md

```yaml
---
description: Context-prime for Python work (base|bug|feature|docs).
argument-hint: "[area]"
allowed-tools: Read, Grep, Write
---
# PURPOSE
Prime minimally for {{area}} tasks.

# READ
- README.md (≤ 200 tok summary)
- pyproject.toml (package name, scripts, deps)
- src/**/__init__.py top docstrings
- tests/ (list files only)

# RUN
Emit:
- Repo Fact Sheet (entrypoints, test framework, type checker)
- Risk Map (IO, network, secrets, large files)
- Suggested subagents

# REPORT
≤ 800 tokens total; no full file dumps.
```

### prime-bug.md

```yaml
---
description: Minimal priming for a failing test/traceback.
allowed-tools: Read, Grep
---
Read failing test, traceback, target module.
Emit hypothesis, smallest patch plan, and a one-file reproduction.
```

### uv-setup.md

```yaml
---
description: Create/refresh env with uv; lock and sync deterministically.
allowed-tools: Bash, Read, Write
---
Run (idempotent):
- `uv venv`
- `uv lock`
- `uv sync`
Write a short env report to `agents/reports/uv-setup-${DATE_HOUR}.md`.
```

### test.md

```yaml
---
description: Run fast, deterministic tests with coverage.
allowed-tools: Bash, Write, Read
---
Run:
- `uv run pytest -q --maxfail=1 -k "not slow" --random-order --random-order-seed=0 --cov --cov-report=term`
On fail: capture minimal logs and write to `agents/reports/test-fail-${SESSION_ID}.md`.
```

### lint.md

```yaml
---
description: Ruff lint (and fix if safe).
allowed-tools: Bash
---
Run `uvx ruff check --fix .`
```

### types.md

```yaml
---
description: Strict type checking.
allowed-tools: Bash
---
Run `uvx mypy --strict src tests`
```

### format.md

```yaml
---
description: Format code.
allowed-tools: Bash
---
Run `uvx ruff format .`
```

### sec-audit.md

```yaml
---
description: Dependency & code security pass.
allowed-tools: Bash, Read, Write
---
Run:
- `uvx pip-audit -r pyproject.toml || true`
- `uvx bandit -q -r src || true`
Summarize findings to `agents/reports/sec-${DATE_HOUR}.md`.
```

### bench.md

```yaml
---
description: Microbench baseline with pytest-benchmark (if present).
allowed-tools: Bash, Read, Write
---
Run `uv run pytest tests/bench -q --benchmark-save=baseline || true`
Write summary to `agents/reports/bench-${DATE_HOUR}.md`.
```

### package.md

```yaml
---
description: Build wheel/sdist deterministically.
allowed-tools: Bash, Read, Write
---
Run `uv build`
Output to `dist/` and write checksums to `agents/reports/artifacts-${DATE_HOUR}.txt`.
```

### release.md

```yaml
---
description: Version bump, changelog, tag, build.
allowed-tools: Bash, Read, Write
---
Steps:
- Update version in pyproject.toml.
- Generate CHANGELOG.md section from conventional commits (if available).
- `uv build`
- Write release checklist to `agents/reports/release-${DATE_HOUR}.md`.
```

### loadbundle.md

```yaml
---
description: Replay prior context from a bundle.
argument-hint: "path/to/bundle.md"
allowed-tools: Read
---
Deduplicate reads; summarize prior objectives/artifacts; output a ≤10-step Replay Plan.
```

### background.md

```yaml
---
description: Launch a background primary agent for long tasks; log progress.
argument-hint: "purpose sentence"
allowed-tools: Bash, Write
---
Create `agents/background/{{timestamp}}/report.md`, then kick background-runner with the provided purpose. Return report path and latest bundle path.
```

---

# Hooks (json)

**guardrails.json** – deny dangerous ops; enforce uv-only env changes

```json
{
  "hooks": {
    "PreStartup": [
      {
        "matcher": ".*",
        "hooks": [
          {
            "type": "fail_if_file_exists",
            "path": "mcp.json",
            "message": "Avoid default MCP preload; use explicit per-task MCP config."
          },
          {
            "type": "fail_if_large_file",
            "path": ".claude/claude.md",
            "max_tokens_estimate": 1200,
            "message": "claude.md too large. Prefer /prime commands."
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "deny_if_command_matches",
            "patterns": [
              "curl .*",
              "wget .*",
              "rm -rf .*",
              "sudo .*",
              "docker .*",
              "apt .*",
              "brew .*"
            ],
            "message": "Disallowed command. Use uv and project-local tools."
          }
        ]
      }
    ],
    "PostWrite": [
      {
        "matcher": "\\.py$",
        "hooks": [
          { "type": "bash", "command": "uvx ruff format ${FILE}" },
          { "type": "bash", "command": "python -m compileall -q ${FILE}" }
        ]
      }
    ]
  }
}
```

**context-bundles.json** – tiny execution trail

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Read|Grep|Write|Bash",
        "hooks": [
          {
            "type": "append_file",
            "path": "agents/context-bundles/session-${DATE_HOUR}-${SESSION_ID}.md",
            "template": "- {{TOOL}} {{tool_input | safe_truncate:80}}"
          }
        ]
      }
    ]
  }
}
```

**limits.json** – focused reads & file size limits

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Read",
        "hooks": [
          {
            "type": "deny_if_path_not_in",
            "allowlist": ["src/", "tests/", "README.md", "pyproject.toml", "CHANGELOG.md"],
            "message": "Stay focused: read only whitelisted paths during priming."
          },
          {
            "type": "deny_if_file_too_large",
            "max_kb": 256,
            "message": "Large file; extract only necessary sections."
          }
        ]
      }
    ]
  }
}
```

---

# Settings (tight Bash allowlist for Python+uv)

**.claude/settings.json**

```json
{
  "permissions": {
    "allow": [
      "Bash(uv venv*)",
      "Bash(uv lock*)",
      "Bash(uv sync*)",
      "Bash(uv run pytest*)",
      "Bash(uvx ruff*)",
      "Bash(uvx mypy*)",
      "Bash(uvx bandit*)",
      "Bash(uvx pip-audit*)",
      "Bash(uv build*)",
      "Bash(git status*)",
      "Bash(git diff*)",
      "Bash(git add *)",
      "Bash(git commit -m*)"
    ],
    "deny": [
      "Bash(curl*)", "Bash(wget*)", "Bash(rm -rf*)", "Bash(sudo*)",
      "Bash(docker*)", "Bash(apt*)", "Bash(brew*)"
    ]
  }
}
```

---

# How you’d use it (common flows)

**New feature**

1. `/prime feature`
2. `planner` → plan + subagent briefs
3. `implementer` → small diff
4. `/types` → `/lint` → `/test`
5. `reviewer` → signoff
6. `/package` → `/release`

**Bugfix**

1. `/prime-bug`
2. `fixer` → minimal patch + regression test
3. `/test` (fast, seeded) → `reviewer`

**Docs sync**

1. `planner` emits doc-scraper brief
2. `doc-scraper` (subagent) fetches & writes summaries
3. `/loadbundle` to replay context if needed

**Long task**

* `/background "Generate quick plan for X and build wheel"`
  → background-runner writes progress to a report file

---

# Future-proofing (add later)

* **Perf agent** (profiling with `pyinstrument`/`pytest-benchmark`).
* **Migrations agent** (auto-create Alembic/Django migrations).
* **API surface map** (extract public symbols → markdown).
* **SBOM & license scan** (`uvx pip-licenses` or `pip-licenses` via uv).
* **SDK wrappers** (kick primary agents from CI