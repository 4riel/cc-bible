#!/usr/bin/env bash
# Git guardrail hook — blocks destructive/remote git operations.
# Exits 1 (BLOCK) if a dangerous command is detected, 0 (ALLOW) otherwise.
# PreToolUse command hook for Bash tool.

set -uo pipefail

# Read the tool input from stdin
INPUT=""
if [ ! -t 0 ]; then
  INPUT=$(cat)
fi

# Extract the command from JSON input
CMD=$(echo "$INPUT" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"command"[[:space:]]*:[[:space:]]*"//;s/"$//' || true)

if [ -z "$CMD" ]; then
  exit 0
fi

# Check for destructive git operations (each pattern on its own line for clarity)
BLOCKED=false

# Remote operations
echo "$CMD" | grep -qE 'git[[:space:]]+push' && BLOCKED=true

# History rewriting
echo "$CMD" | grep -qE 'git[[:space:]]+reset[[:space:]]+--hard' && BLOCKED=true
echo "$CMD" | grep -qE 'git[[:space:]]+rebase' && BLOCKED=true

# Destructive deletions
echo "$CMD" | grep -qE 'git[[:space:]]+clean[[:space:]]+-f' && BLOCKED=true
echo "$CMD" | grep -qE 'git[[:space:]]+branch[[:space:]]+-D' && BLOCKED=true
echo "$CMD" | grep -qE 'git[[:space:]]+stash[[:space:]]+drop' && BLOCKED=true

# Discard working changes
echo "$CMD" | grep -qE 'git[[:space:]]+checkout[[:space:]]+\.' && BLOCKED=true
echo "$CMD" | grep -qE 'git[[:space:]]+restore[[:space:]]+\.' && BLOCKED=true

if [ "$BLOCKED" = true ]; then
  echo "BLOCKED: Destructive or remote git operation detected. This requires explicit user confirmation." >&2
  exit 1
fi

exit 0
