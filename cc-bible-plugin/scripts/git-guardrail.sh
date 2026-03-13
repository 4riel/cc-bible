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
CMD=$(echo "$INPUT" | grep -oE '"command"\s*:\s*"[^"]*"' | head -1 | sed 's/.*"command"\s*:\s*"//;s/"$//' || true)

if [ -z "$CMD" ]; then
  exit 0
fi

# Check for destructive git operations
if echo "$CMD" | grep -qE 'git\s+push\s+--force|git\s+push\s+-f\b|git\s+push\s+--force-with-lease|git\s+reset\s+--hard|git\s+clean\s+-f|git\s+branch\s+-D|git\s+checkout\s+\.|git\s+restore\s+\.|git\s+stash\s+drop|git\s+push(?!\s)'; then
  echo "BLOCKED: Destructive or remote git operation detected. This requires explicit user confirmation." >&2
  exit 1
fi

# Check for plain 'git push' (remote operation)
if echo "$CMD" | grep -qE 'git\s+push(\s|$)'; then
  echo "BLOCKED: git push detected. This is a remote operation requiring explicit user confirmation." >&2
  exit 1
fi

exit 0
