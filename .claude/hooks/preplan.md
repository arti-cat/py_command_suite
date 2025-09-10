---
name: preplan
on: PrePlan
description: Enriches planning requests with acceptance criteria and resource budgets
---

# Pre-Plan Hook

This hook executes before any planning task to ensure all necessary context and constraints are in place.

## Actions Performed

### 1. Inject Missing Acceptance Criteria
If the planning request lacks clear acceptance criteria:
- Add generic success conditions based on task type
- Include measurable outcomes where possible
- Set quality gates from `.claude/policies/limits.json`

### 2. Add Resource Budgets
Automatically inject resource limits:
- Token budgets from `limits.json`
- Time estimates based on task complexity
- Context pack size limits
- Agent capability constraints

### 3. Context Validation
Ensure the planner has sufficient context:
- Check if background context is available
- Verify project structure understanding
- Add creator lens if missing

### 4. Planning Template Injection

```markdown
## Planning Requirements Added:

**Acceptance Criteria:**
- [ ] All tasks have clear, measurable outcomes
- [ ] Each task fits within token/time budgets  
- [ ] Agent assignments follow routing policies
- [ ] Context packs are under size limits

**Resource Budgets:**
- Max tokens per task: {max_tokens_per_task}
- Max minutes per task: {max_minutes_per_task}
- Max context pack size: {max_context_pack_size}

**Quality Gates:**
- All outputs must conform to JSON schemas
- Context packs must include version pins
- Tasks must be atomic and focused
```

## Hook Implementation

```bash
#!/usr/bin/env bash
# This would be the actual hook script that Claude Code calls

INPUT=$(cat)  # Read JSON input from stdin
TASK_TYPE=$(echo "$INPUT" | jq -r '.task_type // "unknown"')
LIMITS=$(cat .claude/policies/limits.json)

# Add acceptance criteria if missing
if ! echo "$INPUT" | jq -e '.acceptance_criteria' >/dev/null; then
    echo "Adding default acceptance criteria for $TASK_TYPE task"
fi

# Add resource budgets from limits.json
MAX_TOKENS=$(echo "$LIMITS" | jq -r '.global_limits.max_tokens_per_task')
MAX_MINUTES=$(echo "$LIMITS" | jq -r '.global_limits.max_minutes_per_task')

echo "Resource budgets: ${MAX_TOKENS} tokens, ${MAX_MINUTES} minutes"
```

## Configuration

The hook uses these configuration sources:
- `.claude/policies/limits.json` - Resource limits and budgets
- `.claude/policies/routing.json` - Agent capabilities and routing rules
- `.claude/background/creator-lens.md` - Project context and constraints

## Error Handling

If the hook fails:
1. **Missing policies**: Create default limits with conservative values
2. **Invalid JSON**: Pass through original input with warning
3. **Configuration errors**: Use hardcoded fallback values
4. **Timeout**: Allow planning to proceed with basic enrichment

## Integration Notes

This hook works in conjunction with:
- `predelegate.md` - Adds context packs before task delegation
- `pretooluse.md` - Enforces safety rules during execution
- Agent routing policies for proper task assignment