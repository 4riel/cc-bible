# The Commandments Plugin

The 10 Commandments of Claude Code — turned into installable commands, agents, skills, and hooks.

10 experts. 202 tips. Distilled into one plugin.

## Install

### Local (global)

```bash
ln -s /path/to/cc-bible-plugin ~/.claude/plugins/local/cc-bible-plugin
```

### From source

Clone this repo and symlink the `cc-bible-plugin/` directory.

## What's Included

### Commands (11)

| Command | Commandment | What it does |
|---------|-------------|--------------|
| `/plan-first` | I | Plan before coding. Explore, produce plan, list unresolved questions |
| `/feedback-loop` | II | Auto-detect and run build + lint + test. Iterate on failures |
| `/tdd` | II | Test-driven development with vertical slicing (RED-GREEN-REFACTOR) |
| `/compounding-eng` | IV | Capture corrections as CLAUDE.md rules |
| `/compact-strategic` | V | Smart compaction with state preservation |
| `/review` | II + VI | Code review via subagent. Confidence-based filtering |
| `/research` | VI | Deep codebase exploration without polluting main context |
| `/interview` | VIII | Claude interviews you before building. Writes SPEC.md |
| `/unstick` | IX | 4 escalating techniques when Claude is stuck |
| `/debug` | IX | Systematic 9-step debugging framework |
| `/setup` | III + VII + X | Bootstrap project with best practices |

### Agents (4)

| Agent | Dispatched by | Purpose |
|-------|---------------|---------|
| `plan-reviewer` | `/plan-first` | Reviews plans as a staff engineer |
| `tdd-guide` | `/tdd` | Enforces vertical slicing TDD |
| `code-reviewer` | `/review` | Security, quality, conventions review |
| `researcher` | `/research` | Deep exploration in isolated context |

### Skills (3)

| Skill | Consulted by | Contains |
|-------|--------------|----------|
| `planning-patterns` | `plan-reviewer`, `/plan-first` | Planning workflows, formats, evaluation criteria |
| `tdd-patterns` | `tdd-guide` | Vertical slicing, interface design, mocking rules |
| `debugging-patterns` | `/debug`, `/unstick` | 9-step framework, escalating strategies |

### Hooks (2)

| Hook | Event | What it does |
|------|-------|--------------|
| Auto-format | PostToolUse (Edit/Write) | Detects and runs project formatter |
| Git guardrail | PreToolUse (Bash) | Blocks destructive git operations |

## The 10 Commandments

1. **Plan Before You Code** — Enter plan mode. Read before writing
2. **Give Claude a Feedback Loop** — Tests, linters, build. Let Claude self-correct
3. **Run Parallel Sessions** — Worktrees. One plans, one tests, one implements
4. **Invest in CLAUDE.md** — Compounding engineering. Capture every correction
5. **Guard Your Context Window** — Compact strategically. Preserve state
6. **Use Subagents** — Throw compute at the problem. Map-reduce pattern
7. **Turn Work into Skills** — Extract patterns. Build your own toolkit
8. **Let Claude Interview You** — Ask before building. Spec first
9. **Force Deeper Thinking** — Ultrathink. Compare plans. Naive-first
10. **Prompt Declaratively** — Tell Claude WHAT, not HOW

## License

CC BY-SA 4.0 — Same as the CC Bible.
