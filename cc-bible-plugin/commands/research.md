---
description: "Dispatch deep research subagent. Reads files, searches codebase, returns concise summary without polluting main context."
allowed-tools: "Agent"
argument-hint: "<research question>"
---

# Commandment VI: Use Subagents for Research

Dispatch the `researcher` agent to explore the codebase in its own context window. Your main context stays clean — only the summary enters.

## Process

1. Take the user's research question: `$ARGUMENTS`

2. Dispatch `researcher` agent with the question. The agent will:
   - Read relevant files
   - Search the codebase with Grep/Glob
   - Check git history if relevant
   - Build a structured understanding

3. Present the agent's findings:
   - **Found:** what was discovered
   - **Not found:** what was looked for but missing
   - **Recommendations:** actionable next steps

## When to Use

- Before starting work on an unfamiliar part of the codebase
- When you need to understand how something works without reading 20 files in main context
- When the user asks "how does X work?" or "where is Y defined?"
- Before proposing architectural changes

## Hard Rules

- One clear input (the question), one clear output (the summary)
- The agent explores — you don't. Keep main context clean
- If the agent's findings are insufficient, ask the user before dispatching again

$ARGUMENTS
