---
description: Run fast, deterministic tests with coverage reporting
allowed-tools: Bash, Write, Read
argument-hint: "[test-pattern]"
---
Run pytest with optimized settings for fast, deterministic testing:

`uv run pytest -q --maxfail=1 -k "not slow" --random-order --random-order-seed=0 --cov --cov-report=term $ARGUMENTS`

Key features:
- Quick mode (-q) for minimal output
- Stop on first failure (--maxfail=1) 
- Skip slow tests (-k "not slow")
- Deterministic test order (seeded random)
- Coverage reporting

On test failures, capture minimal logs and write to `agents/reports/test-fail-${SESSION_ID}.md` with:
- Failed test names
- Error messages (truncated)
- Suggested next steps

Keep failure reports concise and actionable.