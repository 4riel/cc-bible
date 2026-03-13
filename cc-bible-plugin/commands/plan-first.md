---
description: "Plan before writing code. Explore codebase, produce concise plan, list unresolved questions. Optionally dispatch plan-reviewer agent."
allowed-tools: "Read, Grep, Glob, Agent"
argument-hint: "[task description]"
---

# Commandment I: Plan Before You Code

You are entering planning mode. Do NOT write any code until the user explicitly approves the plan.

## Process

1. **Explore** — Use subagents to read relevant files and build context about the codebase. Understand the current architecture, conventions, and constraints before proposing anything.

2. **Plan** — Produce a concise implementation plan. Use bullet points and fragments over full sentences. No preamble. Structure:
   - **Unresolved questions** (list these FIRST — they block everything)
   - **Approach** — what you'll do and why
   - **Files to create/modify** — with one-line description each
   - **Dependencies** — new packages, services, or APIs needed
   - **Risk areas** — what could go wrong

3. **Success criteria** — Define declarative targets the implementation must hit. Not "implement auth" but "user can log in with email/password, receives JWT, token expires in 24h."

4. **Offer review** — Ask: "Want me to dispatch the plan-reviewer agent to review this as a staff engineer?"

## Hard Rules

- Do NOT write code until the plan is approved
- List unresolved questions FIRST — they're immediately actionable
- If the task is complex, compare 2 different approaches with tradeoffs before recommending one
- Size phases: minimum viable → core features → edge cases → optimization
- Keep the plan under 100 lines. If it's longer, the task needs decomposition

$ARGUMENTS
