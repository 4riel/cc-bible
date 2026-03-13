---
description: "Systematic 9-step debugging framework. Generate 20+ hypotheses, rank by likelihood, implement most probable fix."
allowed-tools: "Read, Grep, Glob, Bash, Edit, Write"
argument-hint: "[bug description or error message]"
---

# Commandment IX (Structured): Shumer's Systematic Debugging

Follow this 9-step systematic framework. The only permitted shortcut is the Step 3 special case.

## The 9 Steps

### 1. Clarify
Ask essential clarifying questions ONLY if critical information is missing. If the error message and context are sufficient, skip to step 2.

### 2. Ultrathink
Examine the relevant codebase thoroughly. Trace execution step-by-step from the entry point to the failure. Over-research rather than under-research. Read every file in the execution path.

### 3. Special Case
If root cause is 95%+ certain after step 2, state it clearly and skip to step 7. Don't generate hypotheses you don't believe in.

### 4. Identify Causes
Generate at least 20 plausible causes. Explore EVERY angle:
- Configuration / environment
- Data shape / type mismatches
- Race conditions / timing
- State mutations / side effects
- Missing error handling
- Dependency version issues
- Edge cases in input
- Platform / OS differences
- Caching / stale state
- Permission / access issues

### 5. Refine
Remove unsupported theories. Combine overlapping ones. You should have 8-15 strong candidates.

### 6. Rank
Order from most to least likely. Base ranking on:
- Evidence from the error message and stack trace
- Code analysis from step 2
- Common patterns for this type of bug

### 7. Propose Solutions
For each top 5 cause, outline a practical solution in 1-2 sentences.

### 8. Implement
Execute the most probable fix. Add targeted debug logging if the fix isn't certain. Keep changes minimal — fix the bug, don't refactor.

### 9. Test
Run the relevant tests. If no tests exist, provide explicit manual testing instructions. Verify the fix addresses the original error.

## Hard Rules

- Don't guess — trace the code. Read every file in the path
- Minimum 20 hypotheses in step 4 (forces you to think beyond the obvious)
- The fix should be minimal — don't refactor while debugging
- If the first fix doesn't work, go back to step 6 and try the next ranked cause

**Bug:** $ARGUMENTS
