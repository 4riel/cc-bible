---
name: debugging-patterns
description: "Knowledge base for systematic debugging. Consulted by /debug and /unstick commands. Contains Shumer's 9-step framework, escalating thinking strategies, and debugging principles from Claude Code experts."
---

# Debugging Patterns

## Shumer's 9-Step Framework

The full systematic debugging approach:

1. **Clarify** — Only ask if critical info is missing. If the error message is clear, move on
2. **Ultrathink** — Trace execution step-by-step. Read every file in the path. Over-research
3. **Special case** — If 95%+ certain of root cause, skip to solutions
4. **Identify causes** — Generate 20+ hypotheses. Explore every angle
5. **Refine** — Remove unsupported theories, combine overlapping ones (target: 8-15 candidates)
6. **Rank** — Order by likelihood based on evidence
7. **Propose solutions** — Practical fix for each top-5 cause
8. **Implement** — Execute most probable fix. Add debug logging if uncertain
9. **Test** — Run tests. Verify the original error is resolved

The key insight: generating 20+ hypotheses forces you past the obvious. The bug is often in hypothesis #7 or #12, not #1.

## Escalating Thinking Strategies

When stuck, apply in order:

### Level 1: Step Back (Shumer)
"Stop. Think for ten paragraphs about what's going on here."
Forces the model to reconsider fundamental assumptions rather than trying variations of the same approach.

### Level 2: Compare Plans (Pocock)
"Generate 2 different approaches. Compare tradeoffs. Pick the better one."
Agents greedily sample the first plan. Forcing alternatives breaks out of local optima.

### Level 3: Naive First (Karpathy)
"Write the naive algorithm that is very likely correct first."
Start with a correctness anchor. If the naive version works, the bug is in the optimization, not the logic.

### Level 4: Ultrathink (Cat)
Maximum thinking budget for a single turn. Use sparingly — this is the nuclear option.

## Debugging Principles

**Fix the root cause, not the symptom** — If a null check fixes the crash but the data shouldn't be null, find out WHY it's null.

**Trace, don't guess** — Read the actual code path. Don't hypothesize about what a function does — read it. Follow the chain: if A calls B which calls C, read all three.

**Minimal fix** — Change as little as possible. Don't refactor while debugging. Don't "improve" adjacent code. Fix the bug, verify the fix, commit. Refactor later.

**Let Claude debug** (Boris) — "Just say 'go fix the failing CI tests.' Stop micromanaging the debugging process." Give Claude the error, the context, and let it work.

**Fresh session for stubborn bugs** (Cat) — If you've been going in circles for 3+ attempts, the context is polluted with failed approaches. Start fresh. The clean context often finds the bug faster.

## Common Bug Categories

When generating hypotheses, systematically check:

- **Configuration:** env vars, config files, feature flags, wrong environment
- **Data:** shape mismatches, null/undefined, encoding, timezone, overflow
- **Timing:** race conditions, async ordering, stale closures, debounce/throttle
- **State:** mutations, shared references, cache staleness, session corruption
- **Boundaries:** API contract changes, version mismatches, serialization, CORS
- **Platform:** OS differences, browser quirks, node version, dependency versions
- **Permissions:** file access, network policy, RBAC, token scopes
