---
description: "Capture a correction or learning as a CLAUDE.md rule. Detects scope, checks duplicates, writes concise rule."
allowed-tools: "Read, Write, Edit, Glob, Grep"
argument-hint: "[learning or correction to capture]"
---

# Commandment IV: Compounding Engineering

Capture a learning or correction as a persistent CLAUDE.md rule so Claude never makes the same mistake twice.

## Process

1. **Identify** — From recent context or the user's message, identify the correction or learning to capture.

2. **Determine scope:**
   - Is this a global pattern (applies to all projects)? → `~/.claude/CLAUDE.md`
   - Is this project-specific? → `./CLAUDE.md`

3. **Check for duplicates** — Read the target CLAUDE.md. Search for existing rules that:
   - Say the same thing (duplicate)
   - Contradict the new rule (update needed)
   - Could be merged with the new rule (consolidation)

4. **Format the rule** — Write it concisely. Every word must earn its place.
   - `- (-) Don't X because Y` for corrections
   - `- (+) Keep doing X because Y` for reinforcements
   - Include the WHY — without it, the rule can't be applied to edge cases

5. **Show the user** — Display the exact rule you'll write and where. Wait for approval before writing.

## Hard Rules

- Never write without showing the user first
- Keep rules under 2 lines — if it's longer, it's not concise enough
- Include WHY, not just WHAT
- Check for duplicates before adding
- One rule per learning — don't batch unrelated things

**Learning to capture:** $ARGUMENTS
