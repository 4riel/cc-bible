#!/usr/bin/env bash
# Auto-detect and run the project's formatter on recently changed files.
# Exits 0 always (non-blocking hook) — formatting is best-effort.
# Detects: Prettier, Biome, Black, gofmt, rustfmt, clang-format, mix format, ruff

set -euo pipefail

# Get the file that was just edited from the hook context
# PostToolUse hooks receive the tool input as JSON on stdin
CHANGED_FILE=""
if [ -t 0 ]; then
  # No stdin — try git for recently changed files
  CHANGED_FILE=$(git diff --name-only HEAD 2>/dev/null | head -1 || true)
else
  # Parse file_path from JSON stdin
  INPUT=$(cat)
  CHANGED_FILE=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"//;s/"$//' || true)
fi

if [ -z "$CHANGED_FILE" ] || [ ! -f "$CHANGED_FILE" ]; then
  exit 0
fi

# Get file extension
EXT="${CHANGED_FILE##*.}"

# Detect and run formatter
format_file() {
  local file="$1"

  # JavaScript/TypeScript/CSS/HTML/JSON/YAML
  if [[ "$EXT" =~ ^(js|jsx|ts|tsx|css|scss|html|json|yaml|yml|md|mdx|vue|svelte)$ ]]; then
    if [ -f "biome.json" ] || [ -f "biome.jsonc" ]; then
      npx biome format --write "$file" 2>/dev/null && return 0
    fi
    if [ -f ".prettierrc" ] || [ -f ".prettierrc.json" ] || [ -f ".prettierrc.js" ] || [ -f "prettier.config.js" ] || [ -f "prettier.config.mjs" ]; then
      npx prettier --write "$file" 2>/dev/null && return 0
    fi
    # Check package.json for prettier dependency
    if [ -f "package.json" ] && grep -q '"prettier"' package.json 2>/dev/null; then
      npx prettier --write "$file" 2>/dev/null && return 0
    fi
  fi

  # Python
  if [ "$EXT" = "py" ]; then
    if command -v ruff &>/dev/null; then
      ruff format "$file" 2>/dev/null && return 0
    fi
    if command -v black &>/dev/null; then
      black "$file" 2>/dev/null && return 0
    fi
  fi

  # Go
  if [ "$EXT" = "go" ]; then
    if command -v gofmt &>/dev/null; then
      gofmt -w "$file" 2>/dev/null && return 0
    fi
  fi

  # Rust
  if [ "$EXT" = "rs" ]; then
    if command -v rustfmt &>/dev/null; then
      rustfmt "$file" 2>/dev/null && return 0
    fi
  fi

  # C/C++
  if [[ "$EXT" =~ ^(c|cpp|cc|h|hpp)$ ]]; then
    if command -v clang-format &>/dev/null; then
      clang-format -i "$file" 2>/dev/null && return 0
    fi
  fi

  # Elixir
  if [ "$EXT" = "ex" ] || [ "$EXT" = "exs" ]; then
    if command -v mix &>/dev/null; then
      mix format "$file" 2>/dev/null && return 0
    fi
  fi

  return 0
}

format_file "$CHANGED_FILE"
exit 0
