---
description: "Escalating strategy when Claude is stuck or looping. 4 techniques from 4 experts, applied in order."
allowed-tools: "Read, Grep, Glob"
---

# Commandment IX (Escalation): Force Deeper Thinking

You are stuck or looping. Apply these techniques in order — escalate if the previous step didn't work.

## Level 1: Step Back (Shumer)

Stop. Think for ten paragraphs about what's going on here and the best way to approach this. Consider:
- What have you tried so far?
- Why did each attempt fail?
- What fundamental assumption might be wrong?
- What would a senior engineer do differently?

Then propose a new approach.

## Level 2: Compare Plans (Pocock)

Generate 2 different implementation plans. For each:
- Describe the approach in 3-5 sentences
- List pros and cons
- Identify the main risk

Compare their tradeoffs. Pick the better one and explain why. Agents greedily sample the first plan they think of — forcing alternatives often produces better architecture.

## Level 3: Naive First (Karpathy)

Write the naive algorithm that is very likely correct first. Don't optimize. Don't be clever. Get something working that you can verify, then improve it. Start with a correctness anchor.

## Level 4: Ultrathink (Cat)

This is the nuclear option. Bump to maximum thinking effort for this turn. Think deeply and exhaustively about this problem before responding. Consider every angle, every edge case, every possible failure mode.

## Hard Rules

- Try Level 1 first. Only escalate if it doesn't help
- If you're still stuck after Level 4, tell the user — don't loop silently
- If you've been going in circles for 3+ attempts, suggest starting a fresh session
