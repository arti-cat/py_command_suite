#!/bin/bash

# Manual Changelog Update Script
# This script can be run locally to update the changelog with current commands

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✅${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}❌${NC} $1"
}

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
COMMANDS_DIR="$PROJECT_DIR/.claude/commands"
CHANGELOG_FILE="$PROJECT_DIR/CHANGELOG.md"

print_info "Updating changelog for Claude Code commands..."

# Check if commands directory exists
if [ ! -d "$COMMANDS_DIR" ]; then
    print_error "Commands directory not found: $COMMANDS_DIR"
    exit 1
fi

# Count commands
TOTAL_COMMANDS=$(find "$COMMANDS_DIR" -name "*.md" | wc -l)
print_info "Found $TOTAL_COMMANDS command files"

# Extract command information
extract_command_info() {
    local file="$1"
    local filename=$(basename "$file" .md)
    
    # Extract title (first line starting with #)
    local title=$(head -n 10 "$file" | grep "^# " | head -n 1 | sed 's/^# //')
    
    # Extract description (first non-empty line after title that doesn't start with #)
    local description=$(head -n 10 "$file" | sed -n '/^# /,$p' | tail -n +2 | grep -v "^#" | grep -v "^$" | head -n 1 | sed 's/^[[:space:]]*//')
    
    # If no description found, use title
    if [ -z "$description" ]; then
        description="$title"
    fi
    
    echo "- \`/project:$filename\` - $description"
}

# Get current date
CURRENT_DATE=$(date +%Y-%m-%d)

# Create new changelog entry
NEW_ENTRY="## [Manual Update] - $CURRENT_DATE"
NEW_ENTRY="$NEW_ENTRY"$'\n'"### Updated"
NEW_ENTRY="$NEW_ENTRY"$'\n'"- Manual changelog update with all current commands"
NEW_ENTRY="$NEW_ENTRY"$'\n'"- Total commands: $TOTAL_COMMANDS"

# List all commands by category
print_info "Categorizing commands..."

# Analysis Commands
ANALYSIS_COMMANDS=$(find "$COMMANDS_DIR" -name "*.md" | xargs basename -s .md | grep -E "(architecture-review|code-review|security-audit|performance-audit|dependency-audit|explain-code|test-coverage)" | sort)
if [ -n "$ANALYSIS_COMMANDS" ]; then
    NEW_ENTRY="$NEW_ENTRY"$'\n'"#### Analysis Commands"
    while IFS= read -r cmd; do
        if [ -n "$cmd" ]; then
            NEW_ENTRY="$NEW_ENTRY"$'\n'"$(extract_command_info "$COMMANDS_DIR/$cmd.md")"
        fi
    done <<< "$ANALYSIS_COMMANDS"
fi

# Development Commands
DEVELOPMENT_COMMANDS=$(find "$COMMANDS_DIR" -name "*.md" | xargs basename -s .md | grep -E "(create-feature|fix-issue|refactor-code|debug-error|optimize-build|optimize-bundle-size|write-tests)" | sort)
if [ -n "$DEVELOPMENT_COMMANDS" ]; then
    NEW_ENTRY="$NEW_ENTRY"$'\n'"#### Development Commands"
    while IFS= read -r cmd; do
        if [ -n "$cmd" ]; then
            NEW_ENTRY="$NEW_ENTRY"$'\n'"$(extract_command_info "$COMMANDS_DIR/$cmd.md")"
        fi
    done <<< "$DEVELOPMENT_COMMANDS"
fi

# Setup Commands
SETUP_COMMANDS=$(find "$COMMANDS_DIR" -name "*.md" | xargs basename -s .md | grep -E "(init-project|setup-|migrate-to-typescript|ci-setup|add-package)" | sort)
if [ -n "$SETUP_COMMANDS" ]; then
    NEW_ENTRY="$NEW_ENTRY"$'\n'"#### Setup Commands"
    while IFS= read -r cmd; do
        if [ -n "$cmd" ]; then
            NEW_ENTRY="$NEW_ENTRY"$'\n'"$(extract_command_info "$COMMANDS_DIR/$cmd.md")"
        fi
    done <<< "$SETUP_COMMANDS"
fi

# Testing Commands
TESTING_COMMANDS=$(find "$COMMANDS_DIR" -name "*.md" | xargs basename -s .md | grep -E "(test|e2e|mutation|property-based|load-testing|visual-testing|generate-test-cases)" | sort)
if [ -n "$TESTING_COMMANDS" ]; then
    NEW_ENTRY="$NEW_ENTRY"$'\n'"#### Testing Commands"
    while IFS= read -r cmd; do
        if [ -n "$cmd" ]; then
            NEW_ENTRY="$NEW_ENTRY"$'\n'"$(extract_command_info "$COMMANDS_DIR/$cmd.md")"
        fi
    done <<< "$TESTING_COMMANDS"
fi

print_info "Creating backup of current changelog..."
cp "$CHANGELOG_FILE" "$CHANGELOG_FILE.backup"

print_info "Updating changelog..."

# Create temporary file with new content
{
    echo "# Changelog"
    echo ""
    echo "All notable changes to this project will be documented in this file."
    echo ""
    echo "$NEW_ENTRY"
    echo ""
    
    # Add existing content (skip the header)
    tail -n +5 "$CHANGELOG_FILE"
} > "$CHANGELOG_FILE.tmp"

# Replace original file
mv "$CHANGELOG_FILE.tmp" "$CHANGELOG_FILE"

print_success "CHANGELOG.md updated successfully"
print_info "Backup saved as: $CHANGELOG_FILE.backup"
print_info "Total commands included: $TOTAL_COMMANDS"

echo
print_info "To commit the changes, run:"
echo "  git add CHANGELOG.md"
echo "  git commit -m 'docs: update changelog with current commands'"