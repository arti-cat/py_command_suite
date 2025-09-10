#!/usr/bin/env bash
set -euo pipefail

# Python Command Suite - Claude Code Template Updater  
# Updates existing .claude/ installations with new defaults (non-destructive)

TEMPLATE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_ROOT="${1:-$(pwd)}"

echo "🔄 Updating Claude Code R&D Framework installation..."
echo "Template source: $TEMPLATE_ROOT"
echo "Target directory: $TARGET_ROOT"
echo

# Sanity checks
if [[ ! -d "$TARGET_ROOT" ]]; then
  echo "❌ Error: Target directory does not exist: $TARGET_ROOT" >&2
  exit 1
fi

if [[ ! -d "$TARGET_ROOT/.claude" ]]; then
  echo "❌ Error: No existing .claude/ installation found in: $TARGET_ROOT" >&2
  echo "   Use install_claude.sh for new installations" >&2
  exit 1
fi

if [[ ! -d "$TEMPLATE_ROOT/.claude" ]]; then
  echo "❌ Error: Template .claude directory not found in: $TEMPLATE_ROOT" >&2
  echo "   Make sure you're running this script from the template directory" >&2
  exit 1
fi

# Backup existing configuration before update
BACKUP_DIR="$TARGET_ROOT/.claude_backup_$(date +%Y%m%d_%H%M%S)"
echo "📋 Creating backup at: $BACKUP_DIR"
cp -r "$TARGET_ROOT/.claude" "$BACKUP_DIR"
echo "   ✅ Backup created"
echo

# Track what gets updated
UPDATED_FILES=()
SKIPPED_FILES=()
NEW_FILES=()

# Helper function for non-destructive updates
update_if_different() {
  local src="$1"
  local dst="$2"
  local file_desc="$3"
  
  if [[ ! -e "$dst" ]]; then
    # New file - copy it
    cp "$src" "$dst"
    NEW_FILES+=("$file_desc")
    echo "   ✅ Added: $file_desc"
  elif ! cmp -s "$src" "$dst"; then
    # File exists but differs - create .new version for manual review
    cp "$src" "${dst}.new"
    UPDATED_FILES+=("$file_desc")
    echo "   🔄 Updated (manual review): $file_desc → ${file_desc}.new"
  else
    # File exists and is identical - skip
    SKIPPED_FILES+=("$file_desc")
    echo "   ⏭️  Skip (unchanged): $file_desc"
  fi
}

echo "🔧 Updating core framework files..."

# Update agents (careful with customizations)
if [[ -d "$TEMPLATE_ROOT/.claude/agents" ]]; then
  for agent_file in "$TEMPLATE_ROOT"/.claude/agents/*.md; do
    if [[ -f "$agent_file" ]]; then
      agent_name=$(basename "$agent_file")
      update_if_different "$agent_file" "$TARGET_ROOT/.claude/agents/$agent_name" "agents/$agent_name"
    fi
  done
fi

# Update commands (may have local customizations)
if [[ -d "$TEMPLATE_ROOT/.claude/commands" ]]; then
  for command_file in "$TEMPLATE_ROOT"/.claude/commands/*.md; do
    if [[ -f "$command_file" ]]; then
      command_name=$(basename "$command_file")
      # Skip prime.md as it's often project-specific
      if [[ "$command_name" != "prime.md" ]]; then
        update_if_different "$command_file" "$TARGET_ROOT/.claude/commands/$command_name" "commands/$command_name"
      fi
    fi
  done
fi

# Update hooks (may have local modifications)
if [[ -d "$TEMPLATE_ROOT/.claude/hooks" ]]; then
  for hook_file in "$TEMPLATE_ROOT"/.claude/hooks/*.md; do
    if [[ -f "$hook_file" ]]; then
      hook_name=$(basename "$hook_file")
      update_if_different "$hook_file" "$TARGET_ROOT/.claude/hooks/$hook_name" "hooks/$hook_name"
    fi
  done
fi

# Update output styles (should be safe to overwrite)
echo
echo "📐 Updating output style schemas..."
if [[ -d "$TEMPLATE_ROOT/.claude/output-styles" ]]; then
  rsync -av "$TEMPLATE_ROOT/.claude/output-styles/" "$TARGET_ROOT/.claude/output-styles/"
  echo "   ✅ Output style schemas updated"
fi

# Update policies (CAREFUL - these are often customized)
echo
echo "⚙️  Checking policy updates..."
if [[ -d "$TEMPLATE_ROOT/.claude/policies" ]]; then
  for policy_file in "$TEMPLATE_ROOT"/.claude/policies/*.json; do
    if [[ -f "$policy_file" ]]; then
      policy_name=$(basename "$policy_file")
      update_if_different "$policy_file" "$TARGET_ROOT/.claude/policies/$policy_name" "policies/$policy_name"
    fi
  done
fi

# Check for new template features
echo
echo "🆕 Checking for new template features..."

# Check if new directories were added to template
for template_dir in "$TEMPLATE_ROOT"/.claude/*/; do
  if [[ -d "$template_dir" ]]; then
    dir_name=$(basename "$template_dir")
    target_dir="$TARGET_ROOT/.claude/$dir_name"
    
    if [[ ! -d "$target_dir" ]]; then
      echo "   🆕 New directory found: $dir_name"
      mkdir -p "$target_dir"
      rsync -av "$template_dir/" "$target_dir/"
      echo "   ✅ Copied new directory: .claude/$dir_name"
      NEW_FILES+=("directory: $dir_name/")
    fi
  fi
done

# Update CLAUDE.md template if significantly different
echo
echo "📋 Checking CLAUDE.md updates..."
if [[ -f "$TEMPLATE_ROOT/CLAUDE_template.md" ]]; then
  if [[ -f "$TARGET_ROOT/CLAUDE.md" ]]; then
    # Create updated version for review if different
    if ! cmp -s "$TEMPLATE_ROOT/CLAUDE_template.md" "$TARGET_ROOT/CLAUDE.md"; then
      cp "$TEMPLATE_ROOT/CLAUDE_template.md" "$TARGET_ROOT/CLAUDE.md.updated"
      echo "   🔄 CLAUDE.md template updated - review CLAUDE.md.updated for new features"
      UPDATED_FILES+=("CLAUDE.md")
    else
      echo "   ⏭️  CLAUDE.md unchanged"
    fi
  else
    # No existing CLAUDE.md - copy template
    cp "$TEMPLATE_ROOT/CLAUDE_template.md" "$TARGET_ROOT/CLAUDE.md"
    echo "   ✅ Added missing CLAUDE.md"
    NEW_FILES+=("CLAUDE.md")
  fi
fi

# Clean up any backup directories older than 30 days
echo
echo "🧹 Cleaning old backups..."
find "$TARGET_ROOT" -maxdepth 1 -name ".claude_backup_*" -mtime +30 -exec rm -rf {} \; 2>/dev/null || true
echo "   ✅ Old backups cleaned"

# Summary report
echo
echo "📊 Update Summary:"
echo "   • Files added: ${#NEW_FILES[@]}"
echo "   • Files updated (requiring review): ${#UPDATED_FILES[@]}"
echo "   • Files skipped (unchanged): ${#SKIPPED_FILES[@]}"
echo

if [[ ${#NEW_FILES[@]} -gt 0 ]]; then
  echo "🆕 New files added:"
  for file in "${NEW_FILES[@]}"; do
    echo "   • $file"
  done
  echo
fi

if [[ ${#UPDATED_FILES[@]} -gt 0 ]]; then
  echo "🔄 Files requiring manual review:"
  for file in "${UPDATED_FILES[@]}"; do
    echo "   • $file (see .new version)"
  done
  echo
  
  echo "💡 Manual Review Process:"
  echo "   1. Compare existing files with their .new versions"
  echo "   2. Merge any improvements you want to keep"
  echo "   3. Replace original files with merged versions"
  echo "   4. Delete .new files when done: rm .claude/**/*.new"
  echo
fi

echo "✅ Update complete!"
echo
echo "🎯 Next Steps:"
echo "   1. Review any .new files and merge changes as needed"
echo "   2. Test the updated configuration with a simple Claude session"
echo "   3. Update project-specific context in .claude/background/ if needed"
echo "   4. Consider updating any custom commands or agents you've added"
echo

echo "💾 Backup Location: $BACKUP_DIR"
echo "   (Remove this backup once you've verified the update worked correctly)"
echo

echo "🚀 R&D Framework updated! A focused agent is a performant agent."