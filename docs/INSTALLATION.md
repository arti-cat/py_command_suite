# Installation Guide

This guide provides detailed installation methods for Claude Code custom slash commands.

## Quick Installation (Recommended)

Use the provided installation script for easy setup:

```bash
# Clone or download this repository
git clone https://github.com/qdhenry/Claude-Command-Suite.git
cd Claude-Command-Suite

# Make the installer executable and run it
chmod +x install.sh
./install.sh
```

The script provides an interactive menu with options to:
- Install to current project (creates `./.claude/commands/`)
- Install globally for all projects
- Create a symbolic link for development
- List all available commands

### Command Line Options

```bash
# Make executable first (if needed)
chmod +x install.sh

# Install to current project
./install.sh --project

# Install globally
./install.sh --global

# Create symbolic link
./install.sh --symlink

# List available commands
./install.sh --list

# Show help
./install.sh --help
```

## Manual Installation

### Method 1: Project-Specific Installation

This method adds the commands to a specific project directory, making them available as `/project:command-name` when working in that project.

1. **Navigate to Your Project:**
   ```bash
   cd /path/to/your/project
   ```

2. **Create Claude Commands Directory:**
   ```bash
   # Create the .claude/commands directory structure
   mkdir -p .claude/commands
   ```

3. **Copy the Command Files:**  
   ```bash
   # Copy all command files from this repository
   cp /path/to/claude-rules/.claude/commands/*.md ./.claude/commands/
   
   # Or if you cloned this repo, copy from the local path:
   cp ./.claude/commands/*.md ./.claude/commands/
   ```

4. **Verify Installation:**
   ```bash
   # Check that all commands were copied
   ls -la .claude/commands/
   
   # You should see:
   # architecture-review.md
   # code-review.md
   # create-feature.md
   # debug-error.md
   # dependency-audit.md
   # fix-issue.md
   # optimize-build.md
   # performance-audit.md
   # refactor-code.md
   # security-audit.md
   ```

### Method 2: Global Installation

This method makes the commands available as `/user:command-name` across all your projects.

1. **Create Personal Commands Directory:**
   ```bash
   # Create personal commands directory
   mkdir -p ~/.claude/commands
   ```

2. **Copy Command Files:**
   ```bash
   # Copy command files to personal directory
   cp /path/to/claude-rules/.claude/commands/*.md ~/.claude/commands/
   ```

### Method 3: Symbolic Links (for Development)

If you want to keep the commands updated with this repository:

1. **Create Symbolic Link:**
   ```bash
   # In your project directory (for project commands)
   ln -s /path/to/claude-rules/.claude ./.claude
   
   # Or for personal commands:
   ln -s /path/to/claude-rules/.claude/commands ~/.claude/commands
   ```

## Verification and Testing

1. **Test Command Detection:**
   ```bash
   # Start Claude Code in your project directory  
   claude code
   
   # Type / to see available slash commands
   # You should see your custom commands listed as:
   # /project:architecture-review
   # /project:code-review
   # /project:create-feature
   # etc.
   ```

2. **Test a Simple Command:**
   ```bash
   # In Claude Code, try a basic command:
   /project:code-review
   
   # Claude should recognize the command and begin the code review workflow
   ```

## Configuration Requirements

### Claude Code Version
Ensure you're using Claude Code version 1.0 or later, which supports the rules system:
```bash
claude --version
```

### Project Structure
Your project structure should look like this after installation:
```
your-project/
├── .claude/
│   └── commands/
│       ├── architecture-review.md
│       ├── code-review.md
│       ├── create-feature.md
│       ├── debug-error.md
│       ├── dependency-audit.md
│       ├── fix-issue.md
│       ├── optimize-build.md
│       ├── performance-audit.md
│       ├── refactor-code.md
│       └── security-audit.md
├── src/
├── package.json
└── other project files...
```

## Troubleshooting

### Commands Not Recognized
If Claude Code doesn't recognize your commands:

1. **Check Directory Structure:**
   ```bash
   # Ensure correct directory structure
   ls -la .claude/commands/
   ```

2. **Verify File Permissions:**
   ```bash
   # Make sure files are readable
   chmod 644 .claude/commands/*.md
   ```

3. **Check Claude Code Configuration:**
   ```bash
   # Start Claude Code and verify commands are detected
   claude code
   # Then type / to see if your commands appear
   ```

4. **Restart Claude Code:**
   Sometimes you need to restart Claude Code after adding new commands.

### Individual Command Not Working
If a specific command doesn't work:

1. **Check File Format:**
   ```bash
   # Ensure files have proper markdown format
   head -5 .claude/commands/code-review.md
   ```

2. **Validate Markdown:**
   Make sure each command file follows the proper format with `# Command Name` as the first line.

3. **Check for Syntax Errors:**
   Review the command file for any formatting issues that might prevent parsing.

### Permission Issues

If you encounter permission errors:

```bash
# Fix file permissions
chmod 644 .claude/commands/*.md
chmod 755 .claude/commands/

# Fix directory permissions
chmod 755 .claude/
```

## Updating Commands

To update the commands when new versions are available:

1. **Backup Your Customizations:**
   ```bash
   # If you've customized any commands, backup first
   cp -r .claude .claude-backup
   ```

2. **Update Command Files:**
   ```bash
   # Pull latest version from this repository
   cp /path/to/updated/claude-rules/.claude/commands/*.md ./.claude/commands/
   ```

3. **Merge Your Customizations:**
   If you had custom modifications, carefully merge them back into the updated files.

## Uninstalling

To remove the commands:

### Project-Specific Installation
```bash
# Remove the entire .claude directory
rm -rf .claude/

# Or remove just the commands
rm -rf .claude/commands/
```

### Global Installation
```bash
# Remove personal commands directory
rm -rf ~/.claude/commands/
```

### Symbolic Links
```bash
# Remove the symbolic link
unlink .claude
# or
unlink ~/.claude/commands
```

## Advanced Configuration

### Environment Variables

You can set environment variables to customize behavior:

```bash
# Custom commands directory
export CLAUDE_COMMANDS_DIR="/path/to/custom/commands"

# Enable debug mode for troubleshooting
export CLAUDE_DEBUG=1
```

### Multiple Command Sets

You can have different command sets for different types of projects:

```bash
# Web development commands
cp web-commands/*.md .claude/commands/

# Mobile development commands  
cp mobile-commands/*.md .claude/commands/

# Data science commands
cp datascience-commands/*.md .claude/commands/
```

## Getting Help

If you continue to have issues:

1. Check the main [README.md](README.md) for basic usage
2. Verify your Claude Code version supports custom commands
3. Review individual command files for specific requirements
4. Check Claude Code documentation for rules system updates