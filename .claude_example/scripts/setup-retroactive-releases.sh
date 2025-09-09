#!/bin/bash

# Script to create retroactive releases based on commit history
# This will create git tags and prepare for GitHub releases

echo "🚀 Setting up retroactive releases for Claude-Command-Suite"
echo "================================================"

# Version 1.0.0 - Initial Release (2024-12-13)
# Commit: 8608e52 feat: initialize claude-rules project with command templates and documentation
echo "Creating v1.0.0 tag..."
git tag -a v1.0.0 8608e52 -m "Release v1.0.0

Initial release of Claude-Command-Suite (originally claude-rules)

### Features
- 25+ specialized slash commands for Claude Code
- Interactive installation script with multiple installation methods
- Command templates for analysis, development, and maintenance workflows
- Support for project-specific, global, and symlink installations

### Commands Included
- **Analysis Commands**: architecture-review, code-review, security-audit, performance-audit, dependency-audit
- **Development Commands**: create-feature, fix-issue, refactor-code, debug-error, optimize-build
- **Cross-platform Support**: Works with any programming language or framework
- **Flexible Installation**: Project-specific, global, or development symlink options"

# Version 1.0.1 - Hotfix (2024-12-13)
# Commit: 1dee9cf Fix formatting and structure of hotfix-deploy.md command
echo "Creating v1.0.1 tag..."
git tag -a v1.0.1 1dee9cf -m "Release v1.0.1

### Fixed
- Fixed formatting and structure of hotfix-deploy.md command"

# Version 1.1.0 - Documentation Improvements (2024-12-13)
# Commit: e5863a4 organize: move documentation to docs/ and add roadmap
echo "Creating v1.1.0 tag..."
git tag -a v1.1.0 e5863a4 -m "Release v1.1.0

### Added
- Beginner-friendly README.md with simplified structure
- Comprehensive docs/INSTALLATION.md guide with detailed setup methods
- docs/CUSTOMIZATION.md guide for modifying and creating commands
- docs/DEVELOPMENT.md guide with testing and contribution guidelines
- docs/ROADMAP.md with development roadmap and new command ideas
- Contributing section encouraging community participation

### Changed
- Restructured documentation for better user experience
- Moved detailed installation methods from README to dedicated guide
- Simplified command descriptions to one-line summaries
- Organized documentation into docs/ directory for cleaner project structure"

# Version 1.2.0 - Roadmap Implementation (2024-12-14)
# Commit: 0d83ce6 feat: implement comprehensive project commands with extensive code samples
echo "Creating v1.2.0 tag..."
git tag -a v1.2.0 0d83ce6 -m "Release v1.2.0

### Added
- 30+ new commands from roadmap implementation
- Comprehensive project setup commands
- Advanced testing commands suite
- Infrastructure and DevOps commands
- Database and API development commands
- Extensive code samples and examples

### Commands Added
- init-project, setup-monorepo, add-package
- setup-comprehensive-testing, e2e-setup, visual-testing
- containerize-application, setup-kubernetes-deployment
- design-database-schema, create-database-migrations
- design-rest-api, implement-graphql-api
- And many more!"

# Version 1.3.0 - CI/CD and Automation (2024-12-14)
# Commit: 4262692 feat: add automated changelog generation system
echo "Creating v1.3.0 tag..."
git tag -a v1.3.0 4262692 -m "Release v1.3.0

### Added
- Automated changelog generation system
- GitHub Actions workflow for PR reviews
- CI/CD integration for command validation
- Bypass mechanism for automated workflows

### Fixed
- Installation directory name in documentation
- GitHub Actions workflow CI compatibility"

# Version 1.4.0 - Project Management Commands (2025-01-02)
# Commit: 7137945 feat: add comprehensive project management commands
echo "Creating v1.4.0 tag..."
git tag -a v1.4.0 7137945 -m "Release v1.4.0

### Added
- 24 comprehensive project management commands
- Sprint planning and analysis commands
- Task management integration with Linear
- GitHub-Linear synchronization commands
- Advanced synchronization features
- Command count badge (81 total commands)

### Fixed
- Missing Instructions sections in several commands
- Command validation errors"

# Version 1.5.0 - Ultra Think and Memory Commands (2025-01-07)
# Commit: 74eae13 feat: add three memory management commands from Thomas Landgraf
echo "Creating v1.5.0 tag..."
git tag -a v1.5.0 74eae13 -m "Release v1.5.0

### Added
- ultra-think command for deep analytical reasoning
- Three memory management commands (contributed by Thomas Landgraf):
  - analyze-memory-commands
  - setup-memory-system  
  - visualize-memory

### Fixed
- Command outputs properly quoted in changelog workflow"

# Version 1.6.0 - Utility Commands (2025-01-07)
# Commit: 749691a Add utility commands from IndyDevDan/DislerH claude-code-hooks-mastery
echo "Creating v1.6.0 tag..."
git tag -a v1.6.0 749691a -m "Release v1.6.0

### Added
- 4 utility commands (contributed by IndyDevDan/DislerH):
  - all-tools - List all available tools in TypeScript function signature format
  - git-status - Comprehensive git repository status analysis
  - prime - Load essential context for new agent sessions
  - sentient - Test Claude Code hook protections (demonstration command)

### Fixed
- Syntax error in update-changelog.yml workflow

Total commands: 89"

# Current development version will be 1.7.0
echo "Updating version.txt to 1.6.0 (last released version)..."
echo "1.6.0" > version.txt

echo ""
echo "✅ Tags created successfully!"
echo ""
echo "Next steps:"
echo "1. Review the tags: git tag -l -n"
echo "2. Push tags to GitHub: git push origin --tags"
echo "3. The GitHub release workflow will create releases automatically"
echo "4. Or create releases manually using GitHub CLI:"
echo "   gh release create v1.0.0 --title 'v1.0.0 - Initial Release' --notes-file release-notes-1.0.0.md"
echo ""
echo "Note: The automated release system will handle future releases starting from v1.7.0"