You’re right—the docs + “one agent, one purpose” principle point strongly to an **embedded-only** model. Let’s lock in a template/scaffolding approach so each project has its own self-contained `.claude/` setup and agents stay laser-focused on local context.

Here’s a concrete, copy-paste plan that matches your four bullets.

# What we’ll ship

## 1) A **template repo** to copy from

```
python-command-suite-template/
├─ CLAUDE.md
├─ install_claude.sh            # one-shot installer for target projects
├─ update_claude.sh             # optional updater (rsync)
└─ .claude/
   ├─ agents/
   │  ├─ orchestrator.md
   │  ├─ coder.md
   │  ├─ reviewer.md
   │  └─ researcher.md
   ├─ commands/
   │  ├─ read.md  grep.md  write.md  bash.md  http.md  git.md
   ├─ hooks/
   │  ├─ preplan.md  predelegate.md  pretooluse.md  posttooluse.md  onerror.md
   ├─ output-styles/
   │  ├─ json.plan.schema.json
   │  ├─ json.patch.schema.json
   │  ├─ json.review.schema.json
   │  └─ json.report.schema.json
   ├─ policies/
   │  ├─ permissions.json
   │  ├─ routing.json
   │  └─ limits.json
   ├─ background/          # human-curated, long-lived context
   ├─ context-bundles/     # machine-built Context Packs (least context)
   ├─ plans/               # planner outputs (json.plan)
   ├─ reports/             # reviews/handoffs (json.review/json.report)
   └─ sessions/            # run manifests & lineage
```

### Why this is safe (per docs)

* Claude works **inside** the project; `.claude/` is part of the repo (like `.git/`).
* Your extra subdirs (`background`, `context-bundles`, `plans`, `reports`, `sessions`) are *additive*—Claude ignores them unless referenced by agents/hooks. They won’t confuse it.
* No cross-project write roots, no “foreign targets,” no extra coordination burden for agents.

---

## 2) A one-liner **installer** for any project

Drop this into `python-command-suite-template/install_claude.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

TEMPLATE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_ROOT="${1:-$(pwd)}"

echo "Installing Claude project structure into: $TARGET_ROOT"

# Sanity checks
if [[ ! -d "$TARGET_ROOT" ]]; then
  echo "Target directory does not exist: $TARGET_ROOT" >&2
  exit 1
fi

# Create skeleton if missing
mkdir -p "$TARGET_ROOT/.claude" \
         "$TARGET_ROOT/.claude/agents" \
         "$TARGET_ROOT/.claude/commands" \
         "$TARGET_ROOT/.claude/hooks" \
         "$TARGET_ROOT/.claude/output-styles" \
         "$TARGET_ROOT/.claude/policies" \
         "$TARGET_ROOT/.claude/background" \
         "$TARGET_ROOT/.claude/context-bundles" \
         "$TARGET_ROOT/.claude/plans" \
         "$TARGET_ROOT/.claude/reports" \
         "$TARGET_ROOT/.claude/sessions"

# Copy core files without clobbering local edits
copy_if_absent () {
  local src="$1" dst="$2"
  if [[ -e "$dst" ]]; then
    echo "Skip (exists): $dst"
  else
    cp -v "$src" "$dst"
  fi
}

# CLAUDE.md
copy_if_absent "$TEMPLATE_ROOT/CLAUDE.md" "$TARGET_ROOT/CLAUDE.md"

# Core policy/schema/agents/commands/hooks
rsync -av --ignore-existing \
  "$TEMPLATE_ROOT/.claude/agents/"         "$TARGET_ROOT/.claude/agents/"
rsync -av --ignore-existing \
  "$TEMPLATE_ROOT/.claude/commands/"       "$TARGET_ROOT/.claude/commands/"
rsync -av --ignore-existing \
  "$TEMPLATE_ROOT/.claude/hooks/"          "$TARGET_ROOT/.claude/hooks/"
rsync -av --ignore-existing \
  "$TEMPLATE_ROOT/.claude/output-styles/"  "$TARGET_ROOT/.claude/output-styles/"
rsync -av --ignore-existing \
  "$TEMPLATE_ROOT/.claude/policies/"       "$TARGET_ROOT/.claude/policies/"

echo "Done. Open CLAUDE.md and tailor routing/permissions to this project."
```

### Optional updater (pull new defaults without overwriting edits)

`python-command-suite-template/update_claude.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail
TEMPLATE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_ROOT="${1:-$(pwd)}"
echo "Updating Claude scaffolding in $TARGET_ROOT (non-destructive)…"
rsync -av --ignore-existing "$TEMPLATE_ROOT/.claude/" "$TARGET_ROOT/.claude/"
echo "Update complete."
```

---

## 3) Minimal, Claude-native files (ready to drop in)

### `CLAUDE.md` (project-local)

```md
# Claude Project Charter

This repository uses the **R&D Framework (Reduce & Delegate)**:
- **Reduce**: keep context windows small with least-necessary, version-pinned Context Packs.
- **Delegate**: route focused tasks to dedicated agents with strict I/O contracts.

## Directories
- `.claude/agents` — agent definitions (one agent, one purpose)
- `.claude/commands` — command specs
- `.claude/hooks` — policy/enrichment gates (PrePlan/PreDelegate/PreToolUse/etc.)
- `.claude/output-styles` — JSON schemas (json.plan/json.patch/json.review/json.report)
- `.claude/policies` — routing, permissions, limits
- `.claude/background` — stable human briefs
- `.claude/context-bundles` — generated Context Packs (per task)
- `.claude/plans` — planner outputs
- `.claude/reports` — reviews/handoffs
- `.claude/sessions` — run manifests

## Safety & Scope
- Agents must **only** write under `/.claude` unless a task explicitly grants a path.
- Hooks enforce least-context, version pins, and deny risky commands.

(Adjust anything here to fit your repo’s conventions.)
```

### `.claude/policies/permissions.json`

```json
{
  "write_root": ".claude/",
  "allow": [
    "read(**/*.md)",
    "read(**/*.py)",
    "grep(*,*)",
    "write(.claude/**)",
    "git(status|diff)"
  ],
  "deny": [
    "read(./.env)",
    "bash(curl:*)",
    "bash(wget:*)"
  ]
}
```

### `.claude/policies/routing.json`

```json
{
  "plan": "orchestrator",
  "research": "researcher",
  "coding": "coder",
  "review": "reviewer"
}
```

### `.claude/policies/limits.json`

```json
{
  "max_tokens": 6000,
  "max_minutes": 10,
  "max_bytes": 2000000
}
```

### `.claude/agents/orchestrator.md`

```md
---
name: orchestrator
description: R&D planner/delegator with strict meta-context discipline.
accepts: ["plan","delegate","scaffold"]
commands: ["read","grep","http","git","bash","write"]
policies:
  routing: "../policies/routing.json"
  permissions: "../policies/permissions.json"
  limits: "../policies/limits.json"
output_contracts: ["json.plan","json.report"]
---

When given a goal:
1) Produce `json.plan` with sub-tasks + acceptance criteria.
2) For each task, build a **Context Pack** (least context; version-pinned snippets).
3) Delegate to the mapped agent; require schema-compliant outputs.
4) Synthesize a run `json.report`. Store Context Packs in `.claude/context-bundles/`.
```

### `.claude/agents/coder.md`

```md
---
name: coder
description: Implements code & tests using TDD where possible.
accepts: ["coding","refactor","migrate"]
commands: ["read","grep","git","bash","write"]
requires_context: ["inputs","io_contract","doc_snippets"]
output_contracts: ["json.patch","json.report"]
---
Return a unified diff + manifest in `json.patch`. Include citations for any doc-dependent changes.
```

### `.claude/hooks/predelegate.md`

```md
---
name: predelegate
on: PreDelegate
---
- If the task lacks `doc_snippets`, fetch version-pinned docs (MCP or local).
- Enforce an `io_contract` by task type (plan→json.plan, coding→json.patch, review→json.review).
- Set `WRITE_ROOT=.claude/` and rebase any file outputs into that path.
```

### `.claude/hooks/pretooluse.md`

```md
---
name: pretooluse
on: PreToolUse
---
- Deny: `bash` when first arg in {curl,wget}
- Patch: `bash ["npm","test"]` → `["npm","run","test:ci"]` and extend timeout
- For `write`, if path not under `$WRITE_ROOT`, rebase into `.claude/` and continue
```

### `.claude/output-styles/json.plan.schema.json` (tiny)

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "json.plan",
  "type": "object",
  "required": ["tasks", "rationale"],
  "properties": {
    "tasks": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["id","objective","agent","io_contract","acceptance_criteria"],
        "properties": {
          "id": {"type": "string"},
          "objective": {"type": "string"},
          "agent": {"type": "string"},
          "io_contract": {"type": "string"},
          "acceptance_criteria": {"type": "array","items":{"type": "string"}}
        }
      }
    },
    "rationale": {"type": "string"}
  }
}
```

*(Mirror similarly small schemas for `json.patch`, `json.review`, `json.report`.)*

---

## 4) How teams use it (simple, local, focused)

**A) Initialize a project once**

```bash
git clone your-org/python-command-suite-template
cd your/app/project
../python-command-suite-template/install_claude.sh  .
git add .claude CLAUDE.md
git commit -m "Add Claude Code R&D scaffolding"
```

**B) Run the flow (inside the project)**

* Ask orchestrator to plan → `.claude/plans/0001_initial.json`
* Delegation produces:

  * Context Packs → `.claude/context-bundles/…`
  * Reviews/Reports → `.claude/reports/…`
  * Session manifest → `.claude/sessions/<ISO>.json`

**C) Keep agents focused**

* Agents only see the project’s own `.claude/` and codebase.
* No cross-project write roots. No extra “central suite” config to parse.

**D) Update scaffolding later (optional)**

```bash
python-command-suite-template/update_claude.sh  .
```

---

## 5) Does this satisfies the goals?

* **Claude-native**: exactly what the docs encourage—self-contained `.claude/` per project.
* **R\&D (Reduce & Delegate)**: Context Packs + strict hooks keep the window small and targeted; specialists do focused work.
* **Session continuity**: manifests + bundles live locally; agents load only what they need.
* **Low cognitive load**: one repo, one `.claude/`, one purpose; no foreign-target semantics.
