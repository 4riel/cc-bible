---
description: "Bootstrap your project with CC Bible best practices. Generate CLAUDE.md rules, settings suggestions, and a guide to non-automatable commandments."
allowed-tools: "Read, Write, Edit, Bash, Glob"
---

# Commandments III + VII + X: Project Bootstrap

Set up this project with best practices from 10 Claude Code experts. This command detects your stack and generates recommendations — it does NOT write anything without your approval.

## Step 1: Detect Project

Scan for project markers:
- `package.json` — Node/JS/TS project (check for framework: React, Next, Vue, Svelte, etc.)
- `go.mod` — Go project
- `Cargo.toml` — Rust project
- `requirements.txt` / `pyproject.toml` — Python project
- `Makefile` — check what it builds
- `tsconfig.json` — TypeScript configuration
- `.eslintrc*` / `biome.json` — linter configuration
- Existing `CLAUDE.md` — current instructions

Report what you found.

## Step 2: Propose CLAUDE.md Rules

Based on the detected stack, propose rules to add to `./CLAUDE.md`:

**Universal rules (all projects):**
- When planning, list unresolved questions FIRST
- Keep plans under 100 lines — decompose if larger
- Run build + lint + test after every change
- When stuck for 3+ attempts, step back and rethink the approach
- Capture corrections as CLAUDE.md rules (compounding engineering)

**Stack-specific rules:**
- Test commands for this project
- Build commands for this project
- Linter/formatter commands for this project
- Project-specific conventions detected from existing code

Show the proposed rules. Wait for approval before writing.

## Step 3: Suggest Settings

Recommend `.claude/settings.json` entries:
- Permission allowlists for frequently used commands (test, lint, build)
- `ENABLE_TOOL_SEARCH` env var if MCP servers detected
- Effort level recommendation based on project complexity

Show suggestions. These are for the user to apply manually.

## Step 4: Non-Automatable Commandments Guide

Print a guide for commandments that require human setup:

### III. Run Parallel Sessions
```
# Use worktrees for parallel Claude sessions
git worktree add ../project-feature feature-branch
cd ../project-feature && claude

# Set up terminal aliases for quick access
alias za="zellij action new-tab -- claude"
alias zb="zellij action new-tab -- claude"

# Or with tmux
alias ta="tmux new-window claude"
alias tb="tmux new-window claude"
```
One session plans. Another writes tests. Another implements. They share the same git repo via worktrees.

### VII. Turn Your Work Into Skills
```
# Skills live here:
.claude/skills/
  your-skill-name/
    SKILL.md        # Frontmatter: name, description

# SKILL.md format:
---
name: your-skill-name
description: "When to trigger this skill and what it does"
---

[Knowledge, patterns, and instructions for Claude]
```
Start by extracting patterns from your most repeated workflows. This plugin is itself an example.

### X. Declarative Prompting — Before/After Examples

**Bad (imperative):** "Read the auth file, then check for JWT validation, then look at the middleware, then..."
**Good (declarative):** "Ensure all API endpoints validate JWT tokens before processing requests."

**Bad:** "Open the test file, add a test for the login function, make it check the return value..."
**Good:** "Add tests for the login function covering: valid credentials, invalid password, expired token, rate limiting."

**Bad:** "Go to the config file and change the timeout from 30 to 60..."
**Good:** "Increase the API timeout to 60 seconds to handle slow upstream responses."

Tell Claude WHAT you want, not HOW to do it. Claude can figure out the how.

## Step 5: Detect Hook Opportunities

If a formatter is found, suggest the auto-format hook from this plugin.
If this is a git repo, suggest the git push guardrail hook from this plugin.

Show suggestions — don't install without approval.
