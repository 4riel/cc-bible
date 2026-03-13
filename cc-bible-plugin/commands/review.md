---
description: "Code review with subagent. Security, quality, and conventions. Confidence-based filtering — only reports findings >80% confidence."
allowed-tools: "Read, Grep, Glob, Bash, Agent"
argument-hint: "[files or branch to review]"
---

# Commandments II + VI: Code Review with Subagents

Dispatch the `code-reviewer` agent to review changed code for security, quality, and convention adherence.

## Process

1. **Determine scope:**
   - If `$ARGUMENTS` specifies files, review those
   - Otherwise, run `git diff --name-only` to get changed files
   - If no changes found, ask what to review

2. **Dispatch `code-reviewer` agent** with the file list. The agent reviews in its own context window and returns a structured report.

3. **Present results** — Show the severity table and verdict (APPROVE / WARNING / BLOCK).

## What Gets Reviewed

- **CRITICAL (security):** hardcoded credentials, injection vulnerabilities, XSS, path traversal, auth bypasses
- **HIGH (quality):** functions >50 lines, nesting >4 levels, missing error handling at system boundaries, dead code
- **MEDIUM (conventions):** violations of project conventions from CLAUDE.md

## Hard Rules

- Only report findings with >80% confidence — no guessing
- Consolidate similar issues ("5 functions missing error handling" not 5 separate findings)
- Stack agnostic — read conventions from CLAUDE.md, don't assume frameworks
- Skip stylistic preferences unless they violate documented project conventions
- Skip issues in unchanged code unless CRITICAL security

$ARGUMENTS
