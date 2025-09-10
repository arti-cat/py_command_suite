#!/bin/bash
# Python Command Suite (PCS) Deployment Script
# Deploys PCS configuration to any Python project with Claude Code

set -e

# Configuration
PCS_SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-$(pwd)}"

echo "🚀 Deploying Python Command Suite (PCS) to: $TARGET_DIR"

# Validate target directory
if [[ ! -d "$TARGET_DIR" ]]; then
    echo "❌ Error: Target directory does not exist: $TARGET_DIR"
    exit 1
fi

# Check for Python project indicators
if [[ ! -f "$TARGET_DIR/pyproject.toml" ]] && [[ ! -f "$TARGET_DIR/setup.py" ]] && [[ ! -f "$TARGET_DIR/requirements.txt" ]]; then
    echo "⚠️  Warning: No Python project files found in target directory"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create .claude directory structure
echo "📁 Creating .claude directory structure..."
mkdir -p "$TARGET_DIR/.claude"/{agents,commands,hooks,context-bundles,background,plans,policies,reports,sessions,output-styles}

# Copy core configuration files
echo "⚙️  Copying PCS configuration files..."

# Copy agents (Python-specialized subagents)
cp -r "$PCS_SOURCE_DIR/.claude/agents/"* "$TARGET_DIR/.claude/agents/"

# Copy commands (UV-first Python workflows) 
cp -r "$PCS_SOURCE_DIR/.claude/commands/"* "$TARGET_DIR/.claude/commands/"

# Copy hooks (R&D Framework enforcement)
cp -r "$PCS_SOURCE_DIR/.claude/hooks/"* "$TARGET_DIR/.claude/hooks/"

# Copy settings with Python-focused permissions
cp "$PCS_SOURCE_DIR/.claude/settings.local.json" "$TARGET_DIR/.claude/settings.local.json"

# Copy output styles if they exist
if [[ -d "$PCS_SOURCE_DIR/.claude/output-styles" ]]; then
    cp -r "$PCS_SOURCE_DIR/.claude/output-styles/"* "$TARGET_DIR/.claude/output-styles/" 2>/dev/null || true
fi

# Create minimal CLAUDE.md following R&D Framework
cat > "$TARGET_DIR/CLAUDE.md" << 'EOF'
# Python Command Suite (PCS) Agent

You are a Python development specialist operating under the **R&D Framework** (Reduce & Delegate context).

## Core Principles
- **UV-first** package management and tooling
- **Context discipline** via slim memory files and delegation
- **Focused agents** for specialized tasks

## Quick Start Commands
- `/uv-setup` - Initialize UV environment
- `/test` - Run pytest with coverage
- `/lint` - Run ruff linting
- `/format` - Format with ruff
- `/prime-rd` - Context priming for R&D workflows

Use `/agents` to see available subagents for delegation.

**Remember**: A focused agent is a performant agent.
EOF

# Create .gitignore entries for Claude artifacts
if [[ -f "$TARGET_DIR/.gitignore" ]]; then
    if ! grep -q "\.claude/context-bundles" "$TARGET_DIR/.gitignore"; then
        echo "📝 Adding PCS entries to .gitignore..."
        cat >> "$TARGET_DIR/.gitignore" << 'EOF'

# Python Command Suite (PCS) - Claude Code artifacts
.claude/context-bundles/
.claude/background/
.claude/sessions/
.claude/reports/
EOF
    fi
else
    echo "📝 Creating .gitignore with PCS entries..."
    cat > "$TARGET_DIR/.gitignore" << 'EOF'
# Python Command Suite (PCS) - Claude Code artifacts
.claude/context-bundles/
.claude/background/
.claude/sessions/
.claude/reports/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# UV
.uv/
EOF
fi

echo "✅ PCS deployment complete!"
echo ""
echo "🔧 Next steps:"
echo "   1. cd $TARGET_DIR"
echo "   2. claude"
echo "   3. /uv-setup    # Initialize UV environment"
echo "   4. /prime-rd    # Prime for R&D workflows"
echo ""
echo "🏗️  Available agents: orchestrator, coder, reviewer, researcher, doc-scraper, background-runner"
echo "⚡ Key commands: /test, /lint, /format, /package, /git"
echo ""
echo "📚 R&D Framework enforced through functional hooks - context stays clean!"