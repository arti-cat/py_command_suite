# Understanding Gaps & Improvements Needed

## What I Need to Understand Better

### 1. Command Types & Formats
**Gap**: Confusion between tool commands vs slash commands
- **Tool commands** (read.md, write.md, bash.md): YAML frontmatter with signature/returns/limits/safety
- **Slash commands** (/prime, /prime-rd): Simple markdown format for user-facing workflows
- **Need**: Clear documentation on when to use which format

### 2. Background Command Pattern
**Gap**: User opened `background_command.md` - this suggests there's a background command pattern I should understand
- **Need**: Study the background command implementation from IndyDevDan's approach
- **Context**: From transcript line 1061: "background.md" - single prompt that boots up background claude instance

### 3. Context Priming vs Always-On Memory
**Gap**: Current CLAUDE.md is now 25+ lines but transcript shows 43 lines as "slim"
- **Current**: CLAUDE.md has project-specific context always loaded
- **IDD Method**: Minimal CLAUDE.md + dynamic `/prime` commands for context loading
- **Need**: Better balance between essential always-on vs dynamic priming

### 4. User Journey & Onboarding
**Gap**: No clear path for new users to understand and use R&D Framework
- **Missing**: Step-by-step guidance for first-time users
- **Missing**: Examples of common workflows and how to execute them
- **Missing**: Context budget awareness and monitoring

## What We Need to Fix/Improve

### 1. Command Format Consistency
**Issue**: `/prime-rd` command doesn't follow established patterns
**Fix**: Create proper slash command format (simple markdown, not YAML frontmatter)

### 2. Context Discipline Implementation
**Issue**: No active context monitoring or budget tracking
**Fix**: 
- Add context size warnings in commands
- Implement token budget tracking
- Create context pack size validation

### 3. Agent Priming System
**Issue**: Main agent (me) doesn't have dynamic R&D Framework loading
**Fix**:
- Create `/prime-rd` as proper slash command
- Move detailed framework docs to `.claude/background/`
- Enable dynamic context loading based on task type

### 4. Background Command Understanding
**Issue**: Don't fully understand the background delegation pattern
**Fix**: Study the background command implementation and create proper background agent delegation

### 5. User Onboarding Flow
**Issue**: No guidance for new users on how to start using R&D Framework
**Fix**:
- Create `/onboard` command with step-by-step guidance
- Add workflow examples and templates
- Create "getting started" documentation

### 6. Session Continuity
**Issue**: Context bundles mentioned but not fully implemented
**Fix**: 
- Understand IndyDevDan's context bundle pattern
- Implement session replay capability
- Create proper `/loadbundle` command functionality

## Priority Order
1. **Understand background command pattern** (study existing implementation)
2. **Fix command format consistency** (create proper `/prime-rd` slash command)
3. **Implement context discipline** (monitoring, budgets, warnings)
4. **Create user onboarding flow** (`/onboard` command and examples)
5. **Session continuity** (context bundles and replay)