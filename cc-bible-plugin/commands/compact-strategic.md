---
description: "Smart compaction. Summarize modified files, current task state, key decisions before compacting."
allowed-tools: "Bash, Read"
---

# Commandment V: Guard Your Context Window

Before compacting, capture critical state so nothing is lost.

## Process

1. **Capture current state:**

   Run `git diff --name-only` to get modified files. Then build a preservation summary:

   ```
   ## Preservation Summary

   **Current objective:** [one sentence]

   **Modified files:**
   - [list each file with one-line description of changes]

   **Key decisions made:**
   - [list decisions that inform future work]

   **Verification commands:**
   - [test commands to re-run after compaction]

   **Blockers / open questions:**
   - [anything unresolved]
   ```

2. **Compact with instructions** — Use the preservation summary as the compaction instruction so the compressed context retains what matters.

3. **Confirm** — After compaction, briefly confirm what was preserved.

## When to Use

- Context is getting long and responses are slowing
- You've been corrected more than twice on the same thing (start fresh instead)
- Before a major context shift (switching from feature A to feature B)

## Hard Rules

- Always capture modified files before compacting — losing track of changes is the #1 compaction failure
- Include verification commands — after compaction, you need to know how to check your work
- If you've been going in circles, suggest starting a fresh session instead of compacting
