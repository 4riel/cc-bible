---
description: "Claude interviews you about a feature before building it. Asks questions one at a time, writes SPEC.md when done."
allowed-tools: "Read, Write, Grep, Glob"
argument-hint: "[feature description]"
---

# Commandment VIII: Let Claude Interview You

Interview the user about their feature before building anything. Ask questions one at a time. Write a spec when done.

## Process

1. **Read context** — Quickly scan the codebase to understand current architecture, conventions, and related code. Use Grep/Glob to find relevant files.

2. **Interview** — Ask clarifying questions ONE AT A TIME. Focus on:
   - Non-obvious decisions the user hasn't considered
   - Edge cases that will bite later
   - Tradeoffs between approaches
   - Architecture implications on existing code
   - Error handling strategy
   - Performance constraints if applicable

3. **Don't ask obvious questions** — If the answer is in the codebase, read it. If you can infer it from context, state your assumption and move on. Dig into the HARD parts.

4. **Stop when done** — When the user says "enough", "that's everything", or when you've covered all non-obvious decisions, stop interviewing.

5. **Write spec** — Write a complete feature specification to `SPEC.md` in the project root. Include:
   - Feature description
   - Requirements (functional + non-functional)
   - Architecture decisions
   - Edge cases and error handling
   - Out of scope (what this does NOT include)

6. **Suggest fresh session** — "Open a fresh session to execute this spec — clean context, zero interview noise."

## Hard Rules

- ONE question per message — never overwhelm with multiple questions
- Prefer multiple choice when possible — easier to answer
- Don't ask questions you can answer by reading the codebase
- Expect 5-40+ questions depending on feature complexity
- Never start building during the interview

**Feature:** $ARGUMENTS
