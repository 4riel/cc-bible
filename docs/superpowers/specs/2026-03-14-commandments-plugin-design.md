# The Commandments Plugin — Design Spec

> The 10 Commandments of Claude Code, turned into a Claude Code plugin.
> 10 experts, 202 tips, distilled into 11 commands, 4 agents, 3 skills, 2 hooks.

## Overview

A Claude Code plugin that materializes the CC Bible's Ten Commandments as installable artifacts. Each command traces to one or more commandments. Prompts synthesize the best techniques from all 10 experts. Stack-agnostic — works in any project, any language.

## Decisions

- **Format:** Claude Code plugin (`.claude-plugin/plugin.json`)
- **Scope:** Curated best-of, not maximal — quality over quantity
- **Stack:** Agnostic. Detects project conventions at runtime
- **Architecture:** Command → Agent → Skill (3-layer pipeline where applicable)
- **Prompting style:** Concept Elevation (Shumer), concise (Pocock), declarative (Karpathy), confidence-filtered

## Directory Structure

```
cc-bible-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── plan-first.md            # I. Plan Before You Code
│   ├── feedback-loop.md         # II. Give Claude a Feedback Loop
│   ├── tdd.md                   # II. (TDD variant)
│   ├── compounding-eng.md       # IV. Invest in CLAUDE.md
│   ├── compact-strategic.md     # V. Guard Your Context Window
│   ├── review.md                # II + VI. Code Review with Subagents
│   ├── research.md              # VI. Use Subagents
│   ├── interview.md             # VIII. Let Claude Interview You
│   ├── unstick.md               # IX. Force Deeper Thinking
│   ├── debug.md                 # IX. Structured Debugging
│   └── setup.md                 # III + VII + X. Bootstrap
├── agents/
│   ├── plan-reviewer.md
│   ├── tdd-guide.md
│   ├── code-reviewer.md
│   └── researcher.md
├── skills/
│   ├── planning-patterns/
│   │   └── SKILL.md
│   ├── tdd-patterns/
│   │   └── SKILL.md
│   └── debugging-patterns/
│       └── SKILL.md
├── hooks/
│   └── hooks.json
└── scripts/
    └── format-check.sh
```

## Manifest

```json
{
  "name": "cc-bible",
  "version": "1.0.0",
  "description": "The 10 Commandments of Claude Code — turned into skills, agents, hooks, and commands. 10 experts, 202 tips, distilled into one plugin.",
  "author": "4riel"
}
```

---

## Commands (11)

### `/plan-first` — Commandment I

**Frontmatter:**
```yaml
description: Plan before writing code. Explore codebase, produce concise plan, list unresolved questions. Optionally dispatch plan-reviewer agent.
allowed-tools: Read, Grep, Glob, Agent
```

**Behavior:**
1. Enter plan mode mentally — read relevant files via subagent to build context
2. Produce a concise plan (Pocock: sacrifice grammar for concision)
3. List unresolved questions FIRST — immediately actionable
4. Ask user: "Want me to dispatch the plan-reviewer agent to review this as a staff engineer?"
5. Do NOT write code until user approves the plan

**Expert synthesis:**
- Boris: two-Claude pattern (one plans, one reviews)
- Cat: plan mode 2-3x success rate on complex tasks
- Pocock: "plan mode is night and day"
- Karpathy: declarative success criteria in the plan

---

### `/feedback-loop` — Commandment II

**Frontmatter:**
```yaml
description: Auto-detect and run project verification. Find tests, linters, build scripts. Run all, iterate on failures up to 3x.
allowed-tools: Bash, Read, Glob
```

**Behavior:**
1. Detect project stack:
   - Test runner: `package.json` scripts (`test`, `jest`, `vitest`), `pytest.ini`, `go.mod`, `Cargo.toml`, `Makefile`
   - Linter: `.eslintrc*`, `biome.json`, `.flake8`, `.golangci.yml`, `clippy`
   - Build: `package.json` build script, `go build`, `cargo build`, `make`
2. Run detected verifications in order: build → lint → test
3. On failure: read error output, fix, re-run (max 3 iterations)
4. Report final status: all pass / remaining failures

**Expert synthesis:**
- Boris: "2-3x the quality of the final result"
- Cat: "include tests, screenshots, or expected outputs so Claude can check itself"
- Pocock: "RGR + Claude Code is so good — pretty hard to cheat for an LLM"

---

### `/tdd` — Commandment II (TDD variant)

**Frontmatter:**
```yaml
description: Test-driven development with vertical slicing. ONE test, ONE implementation, repeat. Dispatch tdd-guide agent.
allowed-tools: Read, Write, Edit, Bash, Grep, Agent
```

**Behavior:**
Dispatches the `tdd-guide` agent which enforces:
1. Ask user which behavior to test first
2. Write ONE failing test (RED)
3. Run test — verify it fails for the right reason
4. Write minimal code to pass (GREEN)
5. Run test — verify it passes
6. Refactor only when all tests pass (REFACTOR)
7. Repeat with next behavior

**Hard rules:**
- NEVER write all tests first then all implementation (horizontal slicing)
- Tests verify behavior through public interfaces, not implementation details
- Mock only at system boundaries (external APIs, databases, time/randomness)
- Accept dependencies, don't create them: `processOrder(order, gateway)` not internal instantiation

**Expert synthesis:**
- Pocock: vertical slicing, interface design principles, mocking rules
- Karpathy: "tests as executable success criteria"
- Boris: "invest in making verification rock-solid"

---

### `/compounding-eng` — Commandment IV

**Frontmatter:**
```yaml
description: Capture a correction or learning as a CLAUDE.md rule. Detects scope, checks duplicates, writes concise rule.
allowed-tools: Read, Write, Edit, Glob, Grep
```

**Behavior:**
1. Identify the correction/learning from recent context
2. Determine scope:
   - Global pattern → `~/.claude/CLAUDE.md`
   - Project-specific → `./CLAUDE.md`
3. Read existing CLAUDE.md, check for duplicates or contradictions
4. Write concise rule (Pocock: sacrifice grammar for concision)
5. Format: `- (-) Don't do X` for corrections, `- (+) Keep doing Y` for reinforcements
6. Confirm with user before writing

**Expert synthesis:**
- Boris: "Compounding Engineering — Claude trains itself on its own failures"
- Boris: "after every correction, tell Claude: update your CLAUDE.md"
- Cat: "keep it short — bloated CLAUDE.md files cause Claude to ignore your instructions"
- Pocock: "every line should answer: would removing this cause Claude to make a mistake?"

---

### `/compact-strategic` — Commandment V

**Frontmatter:**
```yaml
description: Smart compaction. Summarize modified files, current task state, key decisions before compacting.
allowed-tools: Bash, Read
```

**Behavior:**
1. Before compacting, capture:
   - List of all modified files (via `git diff --name-only`)
   - Current task/objective in one sentence
   - Key decisions made so far
   - Any test commands or verification steps to remember
2. Compact with these preservation instructions
3. Confirm compaction happened and what was preserved

**Expert synthesis:**
- Cat: "most best practices come down to one constraint — context fills up fast"
- Cat: "customize compaction in CLAUDE.md: when compacting, always preserve the full list of modified files"
- Elvis: set `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=50`
- Cat: "if you've corrected Claude more than twice on the same thing, start fresh"

---

### `/review` — Commandments II + VI

**Frontmatter:**
```yaml
description: Code review with parallel subagents. Security, quality, and conventions. Confidence-based filtering.
allowed-tools: Read, Grep, Glob, Bash, Agent
```

**Behavior:**
1. Get changed files via `git diff --name-only`
2. Dispatch `code-reviewer` agent which checks:
   - **CRITICAL (security):** hardcoded credentials, injection, XSS, path traversal, auth bypasses
   - **HIGH (quality):** large functions >50 lines, deep nesting >4 levels, missing error handling, dead code
   - **MEDIUM (patterns):** project convention violations (read from CLAUDE.md)
3. Confidence filter: only report findings with >80% confidence
4. Consolidate similar issues (e.g., "5 functions missing error handling" not 5 findings)
5. Output severity table + verdict: APPROVE / WARNING / BLOCK

**Hard rules:**
- Stack agnostic — no hardcoded React/Next.js/Node patterns
- Read project conventions from CLAUDE.md and adapt
- Skip stylistic preferences unless they violate project conventions
- Skip issues in unchanged code unless CRITICAL security

**Expert synthesis:**
- Boris: "the model code reviews its code using a fresh context window"
- Cat: "spawn multiple specialized subagents, then deduplicate false positives"
- Affaan: confidence-based filtering from ECC pattern

---

### `/research` — Commandment VI

**Frontmatter:**
```yaml
description: Dispatch deep research subagent. Reads files, searches codebase, returns concise summary without polluting main context.
allowed-tools: Agent
```

**Behavior:**
1. Take user's research question
2. Dispatch `researcher` agent with its own context window
3. Agent explores: reads files, greps codebase, checks git history if relevant
4. Agent returns structured summary:
   - What it found
   - What it didn't find
   - Recommendations
5. Main context stays clean — only the summary enters

**Expert synthesis:**
- Boris: "append 'use subagents' to throw more compute at the problem"
- Cat: "subagents read files and report back summaries without cluttering your main conversation"
- Alex: map-reduce pattern — primary generates questions, subagent investigates
- Affaan: "each subagent gets ONE clear input, produces ONE clear output"

---

### `/interview` — Commandment VIII

**Frontmatter:**
```yaml
description: Claude interviews you about a feature before building it. Asks questions one at a time, writes SPEC.md when done.
allowed-tools: Read, Write, Grep, Glob
```

**Behavior:**
1. Read current codebase for context (via subagent if large)
2. Ask clarifying questions one at a time
3. Focus on non-obvious decisions:
   - Edge cases the user hasn't considered
   - Tradeoffs between approaches
   - Architecture implications
   - Error handling strategy
   - Performance constraints
4. Don't ask obvious questions — dig into the hard parts
5. Keep interviewing until user says "enough" or "that's everything"
6. Write complete spec to `SPEC.md`
7. Suggest: "Open a fresh session to execute this spec — clean context, zero interview noise"

**Expert synthesis:**
- Thariq: "expect 40+ questions for complex features"
- Cat: "start with a minimal prompt and let Claude ask about architecture, edge cases, and tradeoffs"
- Thariq: "open a new session to execute the spec — fresh context"

---

### `/unstick` — Commandment IX

**Frontmatter:**
```yaml
description: Escalating strategy when Claude is stuck or looping. 4 techniques from 4 experts.
allowed-tools: Read, Grep, Glob
```

**Behavior:**
Apply in order — escalate if previous step didn't work:

1. **Shumer's technique:** "Stop. Think for ten paragraphs about what's going on here and the best way to do this, then implement the code."
2. **Pocock's technique:** "Generate 2 different implementation plans. Compare their tradeoffs. Pick the better one."
3. **Karpathy's technique:** "Write the naive algorithm that is very likely correct first. Then optimize it."
4. **Cat's technique:** Bump to high effort for this turn. "ultrathink about this problem before responding."

**Expert synthesis:**
- Shumer: "forces the model to step back and rethink the fundamental approach"
- Pocock: "agents greedily sample the first plan — forcing alternatives often produces better architecture"
- Karpathy: "start with a correctness anchor, then optimize"
- Cat: "ultrathink gives maximum thinking budget for a single turn"

---

### `/debug` — Commandment IX (Structured variant)

**Frontmatter:**
```yaml
description: Systematic 9-step debugging framework. Generate 20+ hypotheses, rank by likelihood, implement most probable fix.
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
```

**Behavior:**
Shumer's 9-step systematic framework:
1. **Clarify** — Ask essential clarifying questions only if info is missing
2. **Ultrathink** — Examine the entire codebase. Trace execution step-by-step. Over-research rather than under-research
3. **Special case** — If root cause is 95%+ certain, state it and skip to solutions
4. **Identify causes** — Generate at least 20 plausible causes. Explore every angle
5. **Refine** — Remove unsupported theories, combine overlapping ones
6. **Rank** — Order from most to least likely
7. **Propose solutions** — For each top 10 cause, outline a practical solution
8. **Implement** — Execute the most probable fix with detailed debug logs
9. **Test** — Run tests or provide explicit manual testing instructions

**Expert synthesis:**
- Shumer: the full 9-step framework
- Karpathy: "write the naive correct algorithm first" (step 3 shortcut)
- Boris: "just say 'go fix the failing CI tests' — don't micromanage how"

---

### `/setup` — Commandments III + VII + X (Bootstrap)

**Frontmatter:**
```yaml
description: Bootstrap your project with CC Bible best practices. Generate CLAUDE.md rules, settings.json entries, and a guide to non-automatable commandments.
allowed-tools: Read, Write, Edit, Bash, Glob
```

**Behavior:**
1. **Detect project:** Read `package.json`, `go.mod`, `Cargo.toml`, `requirements.txt`, `Makefile` etc.
2. **Generate CLAUDE.md rules** from all 10 experts:
   - Conciseness rule (Pocock)
   - Context management instructions (Cat)
   - Declarative prompting reminder (Karpathy)
   - Feedback loop instructions (Boris)
   - Compounding engineering pattern (Boris)
3. **Suggest settings.json entries:**
   - `ENABLE_TOOL_SEARCH` env var if MCP tools detected
   - Permission allowlists for project-specific commands
   - Effort level recommendation
4. **Print non-automatable commandments guide:**
   - **III. Parallel sessions:** `claude --worktree`, aliases (`za`, `zb`, `zc`), notification setup
   - **VII. Build your own skills:** `.claude/skills/` directory structure, SKILL.md format, this plugin as example
   - **X. Declarative prompting:** 3 before/after examples showing outcome-based vs step-based prompts
5. **Detect and suggest hooks:** If formatter found, suggest auto-format hook. If git repo, suggest git guardrails.

---

## Agents (4)

### `plan-reviewer`

```yaml
name: plan-reviewer
description: Use this agent to review implementation plans as a staff engineer. Dispatched by /plan-first command. Checks for missing edge cases, unclear scope, dependency risks, missing test strategy.
model: inherit
tools: ["Read", "Grep", "Glob"]
```

Reviews plans for: scope clarity, dependency ordering, missing edge cases, test strategy, risk assessment. Asks pointed questions. Pocock: "always ask for 2 implementation plans."

### `tdd-guide`

```yaml
name: tdd-guide
description: Use this agent to enforce test-driven development with vertical slicing. Dispatched by /tdd command. RED-GREEN-REFACTOR cycle, one test at a time.
model: inherit
tools: ["Read", "Write", "Edit", "Bash", "Grep"]
```

Enforces vertical slicing. Never horizontal. Tests verify behavior through public interfaces. Mock only at system boundaries. Reports RED/GREEN/REFACTOR state at each step.

### `code-reviewer`

```yaml
name: code-reviewer
description: Use this agent to review code for security, quality, and convention adherence. Dispatched by /review command. Confidence-based filtering, stack-agnostic.
model: sonnet
tools: ["Read", "Grep", "Glob", "Bash"]
```

Severity levels: CRITICAL/HIGH/MEDIUM/LOW. Only reports >80% confidence findings. Reads project conventions from CLAUDE.md. No hardcoded framework patterns.

### `researcher`

```yaml
name: researcher
description: Use this agent for deep codebase exploration without polluting main context. Dispatched by /research command. Returns structured summary.
model: inherit
tools: ["Read", "Grep", "Glob", "Bash"]
```

Explores in its own context window. Returns: what found, what missing, recommendations. One clear input, one clear output.

---

## Skills (3)

### `planning-patterns`

Knowledge base consulted by `plan-reviewer` agent and `/plan-first` command. Contains:
- Explore → Plan → Implement → Commit workflow (Cat)
- Concise plan format with unresolved questions first (Pocock)
- Two-plan comparison technique (Pocock)
- Phase sizing: minimum viable → core → edge cases → optimization
- Success criteria as declarative targets (Karpathy)

### `tdd-patterns`

Knowledge base consulted by `tdd-guide` agent. Contains:
- Vertical slicing rules (Pocock)
- Interface design principles: accept dependencies, return results, small surface area, deep modules
- Mocking rules: only at system boundaries
- Pass@k vs pass^k evaluation criteria (Affaan)
- Test types: unit (always), integration (always), E2E (critical paths)

### `debugging-patterns`

Knowledge base consulted by `/debug` command. Contains:
- Shumer's 9-step framework (full detail)
- Escalating thinking strategies (Shumer → Pocock → Karpathy → Cat)
- Naive-first correctness anchoring (Karpathy)
- Boris's "let Claude debug — stop doing it manually" principle

---

## Hooks (2)

### PostToolUse — Auto-format on Edit

```json
{
  "matcher": "Edit|Write",
  "hooks": [{
    "type": "command",
    "command": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/format-check.sh",
    "timeout": 30
  }]
}
```

`format-check.sh` detects: Prettier, Biome, Black, gofmt, rustfmt, clang-format, mix format. Runs the detected formatter on the changed file. Exits 0 always (non-blocking). Boris: "catches the last 10% of formatting issues."

### PreToolUse — Git push guardrail

```json
{
  "matcher": "Bash",
  "hooks": [{
    "type": "prompt",
    "prompt": "If this bash command contains 'git push', 'git reset --hard', 'git clean -f', 'git branch -D', 'git checkout .', or 'git restore .', BLOCK the command and warn the user that this is a destructive operation requiring explicit confirmation. Otherwise allow it.",
    "timeout": 10
  }]
}
```

Pocock's git guardrails principle. Blocks destructive git operations.

---

## Commandment Coverage Matrix

| Commandment | Artifact(s) |
|---|---|
| I. Plan Before You Code | `/plan-first` command + `plan-reviewer` agent + `planning-patterns` skill |
| II. Give Claude a Feedback Loop | `/feedback-loop` + `/tdd` + `/review` commands + `tdd-guide` + `code-reviewer` agents |
| III. Run Parallel Sessions | `/setup` (prints guide: `--worktree`, aliases, notifications) |
| IV. Invest in CLAUDE.md | `/compounding-eng` command |
| V. Guard Your Context | `/compact-strategic` command |
| VI. Use Subagents | `/research` + `/review` commands + `researcher` agent |
| VII. Turn Work into Skills | `/setup` (prints guide: `.claude/skills/` structure, this plugin as example) |
| VIII. Interview Before Building | `/interview` command |
| IX. Force Deeper Thinking | `/unstick` + `/debug` commands + `debugging-patterns` skill |
| X. Declarative Prompting | `/setup` (prints before/after examples) + embedded in all command prompts |

---

## Non-Goals

- Not a framework-specific plugin (no React, Next.js, Django patterns)
- Not a maximal collection (ECC already does that with 50+ commands)
- Not a replacement for CLAUDE.md (complements it)
- Does not include language-specific reviewers (agnostic only)
- Does not include deployment/CI commands (out of scope)
