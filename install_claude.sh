#!/usr/bin/env bash
set -euo pipefail

# Python Command Suite - Claude Code Template Installer
# Installs the R&D Framework template structure into target projects

TEMPLATE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_ROOT="${1:-$(pwd)}"

echo "🚀 Installing Claude Code R&D Framework template..."
echo "Template source: $TEMPLATE_ROOT"
echo "Target directory: $TARGET_ROOT"
echo

# Sanity checks
if [[ ! -d "$TARGET_ROOT" ]]; then
  echo "❌ Error: Target directory does not exist: $TARGET_ROOT" >&2
  exit 1
fi

if [[ ! -d "$TEMPLATE_ROOT/.claude" ]]; then
  echo "❌ Error: Template .claude directory not found in: $TEMPLATE_ROOT" >&2
  echo "   Make sure you're running this script from the template directory" >&2
  exit 1
fi

# Create skeleton directory structure
echo "📁 Creating directory structure..."
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

# Helper function to copy files without clobbering existing ones
copy_if_absent() {
  local src="$1"
  local dst="$2"
  
  if [[ -e "$dst" ]]; then
    echo "   ⏭️  Skip (exists): $(basename "$dst")"
  else
    cp -v "$src" "$dst"
    echo "   ✅ Copied: $(basename "$dst")"
  fi
}

# Copy CLAUDE.md template
echo
echo "📋 Installing CLAUDE.md..."
if [[ -f "$TEMPLATE_ROOT/CLAUDE_template.md" ]]; then
  copy_if_absent "$TEMPLATE_ROOT/CLAUDE_template.md" "$TARGET_ROOT/CLAUDE.md"
else
  echo "   ⚠️  Warning: CLAUDE_template.md not found in template"
fi

# Copy core .claude structure using rsync with --ignore-existing flag
echo
echo "🔧 Installing core .claude structure..."

# Function to copy directory with progress
copy_directory() {
  local src_dir="$1"
  local dst_dir="$2"
  local desc="$3"
  
  if [[ -d "$src_dir" ]]; then
    echo "   Installing $desc..."
    rsync -av --ignore-existing "$src_dir/" "$dst_dir/"
  else
    echo "   ⚠️  Warning: $desc directory not found: $src_dir"
  fi
}

copy_directory "$TEMPLATE_ROOT/.claude/agents"        "$TARGET_ROOT/.claude/agents"        "agents"
copy_directory "$TEMPLATE_ROOT/.claude/commands"      "$TARGET_ROOT/.claude/commands"      "commands" 
copy_directory "$TEMPLATE_ROOT/.claude/hooks"         "$TARGET_ROOT/.claude/hooks"         "hooks"
copy_directory "$TEMPLATE_ROOT/.claude/output-styles" "$TARGET_ROOT/.claude/output-styles" "output-styles"
copy_directory "$TEMPLATE_ROOT/.claude/policies"      "$TARGET_ROOT/.claude/policies"      "policies"

# Create helpful starter files in background directory
echo
echo "📚 Creating starter files..."

if [[ ! -f "$TARGET_ROOT/.claude/background/project-context.md" ]]; then
  cat > "$TARGET_ROOT/.claude/background/project-context.md" << 'EOF'
# Project Context

## Domain and Purpose
[Describe what this project does and its main business domain]

## Architecture Overview  
[Key architectural decisions, patterns, and constraints]

## Development Standards
[Team conventions, coding standards, and quality requirements]

## Integration Points
[External APIs, databases, services this project depends on]

## Deployment and Operations
[How this project is built, tested, and deployed]

---
*This file provides stable context for all agents. Update as the project evolves.*
EOF
  echo "   ✅ Created: .claude/background/project-context.md"
fi

if [[ ! -f "$TARGET_ROOT/.claude/background/creator-lens.md" ]]; then
  cat > "$TARGET_ROOT/.claude/background/creator-lens.md" << 'EOF'
# Creator Lens - Planning and Orchestration Context

Use this context when planning, coordinating, or breaking down complex tasks.

## Planning Priorities
- Maintain R&D framework discipline (reduce context, delegate effectively)
- Create focused, single-purpose tasks for specialist agents
- Ensure all Context Packs are under token limits
- Include clear acceptance criteria and success measures

## Task Decomposition Guidelines
- Break complex features into atomic, testable units
- Consider dependencies and execution order
- Assign appropriate specialist agents for each task type
- Plan for context continuity across agent handoffs

## Resource Management
- Monitor token usage and context pack sizes
- Set realistic time and complexity budgets
- Plan for error handling and retry scenarios
- Consider session boundaries and checkpointing
EOF
  echo "   ✅ Created: .claude/background/creator-lens.md"
fi

if [[ ! -f "$TARGET_ROOT/.claude/background/target-lens.md" ]]; then
  cat > "$TARGET_ROOT/.claude/background/target-lens.md" << 'EOF'  
# Target Lens - Implementation and Execution Context

Use this context when implementing, coding, or executing specific tasks.

## Implementation Standards
- Follow existing code patterns and conventions
- Write tests alongside implementation (TDD when possible)  
- Include appropriate error handling and validation
- Document public interfaces and complex logic

## Quality Requirements
- Code must pass existing linting and formatting standards
- All changes must include or update relevant tests
- Performance considerations for user-facing features
- Security patterns for authentication and data handling

## Output Guidelines
- All code changes must produce json.patch format
- Include citations for external documentation used
- Provide clear commit messages and change summaries
- Organize artifacts under appropriate .claude/ subdirectories
EOF
  echo "   ✅ Created: .claude/background/target-lens.md"
fi

# Create session tracking infrastructure
if [[ ! -f "$TARGET_ROOT/.claude/sessions/.gitkeep" ]]; then
  touch "$TARGET_ROOT/.claude/sessions/.gitkeep"
  echo "   ✅ Created: .claude/sessions/.gitkeep"
fi

if [[ ! -f "$TARGET_ROOT/.claude/context-bundles/.gitkeep" ]]; then
  touch "$TARGET_ROOT/.claude/context-bundles/.gitkeep"
  echo "   ✅ Created: .claude/context-bundles/.gitkeep"
fi

# Create example priming command
if [[ ! -f "$TARGET_ROOT/.claude/commands/prime.md" ]]; then
  cat > "$TARGET_ROOT/.claude/commands/prime.md" << 'EOF'
# Prime Command - Project Context Loading

Load essential project context for focused development sessions.

## Purpose
Efficiently prime agents with project-specific knowledge without overloading context windows.

## Usage
```
/prime
```

## What This Command Does

1. **Load Project Context**: Read key project files and documentation
2. **Set Development Focus**: Establish current goals and priorities  
3. **Prepare Agent Environment**: Configure tools and permissions for current session
4. **Create Context Baseline**: Establish known state for session continuity

## Files Loaded
- README.md - Project overview and setup instructions
- CLAUDE.md - Framework rules and agent configuration
- .claude/background/project-context.md - Domain knowledge and architecture
- Recent git status and changes - Current development state

## Context Discipline
This command is designed to load exactly the right amount of context - enough for effective work, not so much that it overwhelms agent focus. The R&D framework's "reduce" principle guides what gets included.

## Session Benefits  
After priming, agents will have shared understanding of:
- Project purpose and architecture
- Development standards and conventions
- Current state and recent changes
- Available tools and permissions
EOF
  echo "   ✅ Created: .claude/commands/prime.md"
fi

# Set execute permissions on hook files if they contain shell scripts
echo
echo "🔐 Setting permissions..."
find "$TARGET_ROOT/.claude/hooks" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
echo "   ✅ Hook scripts made executable"

# Final verification
echo
echo "✅ Installation complete!"
echo
echo "📋 Summary:"
echo "   • .claude/ directory structure created"
echo "   • $(find "$TARGET_ROOT/.claude" -name "*.md" | wc -l) configuration files installed"
echo "   • $(find "$TARGET_ROOT/.claude" -name "*.json" | wc -l) policy and schema files installed"
echo "   • Background context and starter files created"
echo "   • Session tracking infrastructure prepared"
echo

echo "🎯 Next Steps:"
echo "   1. Review and customize .claude/policies/ files for your project"
echo "   2. Update .claude/background/project-context.md with project details"
echo "   3. Start a Claude session and run '/prime' to load project context"
echo "   4. Use 'Use the orchestrator agent to...' for complex, multi-step tasks"
echo

echo "📖 Documentation:"
echo "   • CLAUDE.md - Complete framework documentation"
echo "   • .claude/agents/ - Agent specializations and capabilities"
echo "   • .claude/commands/ - Available commands and safety limits"
echo

echo "🚀 Ready to use the R&D Framework! A focused agent is a performant agent."