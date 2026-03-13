# Book of Affaan

> The Scribe. Creator of Everything Claude Code (42K+ stars). Documented what others discovered. The definitive reference.

> Compiled from [@affaanmustafa](https://x.com/affaanmustafa) X threads, public guides, and the [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) repository.
> SF-based builder, co-founder of Ito, Anthropic x Forum Ventures hackathon winner (Sep 2025), creator of Everything Claude Code (73K+ GitHub stars), reaching an estimated 10M+ people across platforms.

---

## Chapter 1: Token Optimization & Cost Control

### Affaan 1:1 — Default to Sonnet, not Opus
> "Default to Sonnet for 90% of coding tasks."

Use model routing by task complexity:

| Task | Model | Why |
|------|-------|-----|
| File exploration | Haiku | Fast, cheap, sufficient |
| Single-file edits | Haiku | Clear instructions, no reasoning needed |
| Multi-file coding | Sonnet | Best coding balance |
| Complex architecture | Opus | Deep reasoning required |
| Security analysis | Opus | Can't afford misses |
| PR reviews | Sonnet | Context awareness |
| Documentation | Haiku | Simple structure |
| Complex debugging | Opus | System-wide reasoning |

Upgrade to Opus only when: first attempt failed, task spans 5+ files, architectural decisions, or security-critical code. Downgrade to Haiku for repetitive tasks, very clear instructions, or "worker" roles in multi-agent setups.

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 1:2 — The Quick-Win Settings That Cut Costs Immediately
> "Claude Code usage can be expensive if you don't manage token consumption. These settings significantly reduce costs without sacrificing quality."

Add to `~/.claude/settings.json`:
```json
{
  "model": "sonnet",
  "env": {
    "MAX_THINKING_TOKENS": "10000",
    "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE": "50",
    "CLAUDE_CODE_SUBAGENT_MODEL": "haiku"
  }
}
```

| Setting | Effect |
|---------|--------|
| Default Model = Sonnet | ~60% cost reduction vs Opus |
| Thinking Tokens = 10,000 | Reduces hidden thinking costs (though `/effort` is now the recommended way to control thinking depth) |
| Auto-Compact = 50% | Higher-quality context management (vs default 95%) |
| Subagent Model = Haiku | Cheap delegation for routine tasks (caveat: doesn't override built-in agents that have a hardcoded model) |

Daily habits: `/model sonnet` for most tasks, `/model opus` for architecture only, `/clear` between unrelated tasks (free reset), `/compact` at logical milestones, `/cost` to monitor spend.

**Source:** [Everything Claude Code README](https://github.com/affaan-m/everything-claude-code#token-optimization)

### Affaan 1:3 — Replace Heavy MCPs with CLI-Wrapped Skills
> "The MCP is a nice wrapper but it comes at a cost. Consider bundling the functionality into skills and commands."

Don't enable all MCPs at once. Each MCP tool description consumes tokens from your 200k window, potentially reducing usable context to ~70k. Rule of thumb: keep 20-30 MCPs in config but enable under 10 per project, under 80 tools active.

Migrate heavy MCPs to CLI skills:
- GitHub MCP -> `/gh-pr` command wrapping `gh pr create`
- Supabase MCP -> Skills using Supabase CLI directly
- Vercel/Railway MCPs -> CLI-based deployment commands

Strip out the convenient tools the MCP exposes and recreate them as commands. With lazy loading, context is mostly solved, but token usage and cost is not solved the same way.

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md), [The Shortform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md)

### Affaan 1:4 — Use mgrep Instead of grep/ripgrep
> "~50% token reduction on average"

mgrep is a drop-in replacement for grep/ripgrep that returns dramatically fewer tokens for the same search results. Install via plugin marketplace, then use the `/mgrep` skill. Supports local file search (`mgrep "function handleSubmit"`) and web search (`mgrep --web "Next.js 15 app router changes"`).

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md), [The Shortform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md)

---

## Chapter 2: Context Management & Memory Persistence

### Affaan 2:1 — Strategic Context Compaction (Don't Auto-Compact at 95%)
> "Disable auto-compact. Manually compact at logical intervals or create a skill that does so for you."

Set `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` to `50` instead of the default 95%. The `strategic-compact` skill (included in ECC) suggests `/compact` at logical breakpoints instead of relying on auto-compaction. Compact after finishing a feature, not mid-implementation. Use plan mode's default context clearing to shed exploration context before execution.

**Source:** [Everything Claude Code README](https://github.com/affaan-m/everything-claude-code), [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 2:2 — Memory Persistence via Hooks
> "Create a new file for each session so you don't pollute old context into new work."

Implement session persistence through hooks:
- **SessionStart Hook**: Auto-load previous context on new session
- **PreCompact Hook**: Save important state before compaction
- **Stop Hook (Session End)**: Persist learnings when session ends

Create skills/commands that summarize progress and save to `.tmp` files in the `.claude` folder. Each file should contain: approaches that worked (with evidence), attempted-but-failed approaches, untried approaches, and remaining work.

Why Stop hook over UserPromptSubmit? Stop runs once at session end (lightweight). UserPromptSubmit runs on every message and adds latency to each prompt.

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 2:3 — Dynamic System Prompt Injection (Don't Bloat CLAUDE.md)
> "Instead of solely putting everything in CLAUDE.md or .claude/rules/ which loads every session, use CLI flags to inject context dynamically."

Create context aliases:
```bash
alias claude-dev='claude --system-prompt "$(cat ~/.claude/contexts/dev.md)"'
alias claude-review='claude --system-prompt "$(cat ~/.claude/contexts/review.md)"'
alias claude-research='claude --system-prompt "$(cat ~/.claude/contexts/research.md)"'
```

This is more surgical about what context loads when. Inject different context per session based on what you're working on, rather than loading everything every time.

*Note: `--system-prompt` is best for headless/`-p` mode. For interactive sessions, the recommended approach is the CLAUDE.md hierarchy (global, project, directory) plus `.claude/rules/` for modular rules, plus skills for on-demand context. Using `--system-prompt` interactively may interfere with the built-in system prompt and caching.*

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 2:4 — Modular Rules Over Monolithic CLAUDE.md
> "Your .rules folder holds .md files with best practices Claude should ALWAYS follow."

Two approaches: single `CLAUDE.md` file or modular `.claude/rules/` with concern-based separation. The modular approach is preferred:

```
rules/
  common/        # Universal: coding-style, git-workflow, testing, security, performance
  typescript/    # Language-specific overrides
  python/
  golang/
```

Common rules define universal defaults; language dirs override where idioms differ. Project-level rules take precedence over user-level when they conflict. Install with `./install.sh typescript python golang` for only the languages you need.

**Source:** [The Shortform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md), [Rules README](https://github.com/affaan-m/everything-claude-code/blob/main/rules/README.md)

---

## Chapter 3: Workflow Patterns & Subagent Orchestration

### Affaan 3:1 — The Two-Instance Project Kickoff
> "Start an empty repo with 2 open Claude instances."

**Instance 1 -- Scaffolding Agent:**
- Lays down project structure
- Sets up configs (CLAUDE.md, rules, agents)
- Creates scaffold

**Instance 2 -- Deep Research Agent:**
- Connects to all services/web search
- Creates detailed PRD
- Generates architecture mermaid diagrams
- Compiles references with documentation clips
- Check `/llms.txt` on documentation sites for LLM-optimized versions

Use `/rename` to label both chats. Left terminal for coding, right terminal for questions.

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 3:2 — Sequential Phase Architecture for Subagents
> "Each agent gets ONE clear input, produces ONE clear output. Outputs become inputs for next phase."

The five-phase pipeline:
1. **RESEARCH** (Explore agent) -> `research-summary.md`
2. **PLAN** (Planner agent) -> `plan.md`
3. **IMPLEMENT** (TDD guide agent) -> code changes
4. **REVIEW** (Code reviewer agent) -> `review-comments.md`
5. **VERIFY** (Build error resolver if needed) -> done or loop back

Core rules: never skip phases, use `/clear` between agents, store intermediate outputs in files. Pass objective context, not just the query.

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 3:3 — Iterative Retrieval for Subagents
> "Pass objective context, not just the query."

Sub-agents save context by returning summaries but lack the orchestrator's semantic context about request purpose. Fix with iterative retrieval:
1. Orchestrator evaluates every sub-agent return
2. Ask follow-up questions before acceptance
3. Sub-agent retrieves answers from source
4. Loop until sufficient (max 3 cycles)

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 3:4 — Git Worktree Parallelization
> "How much can you get done with the minimum viable amount of parallelization."

Don't open arbitrary terminal counts. Add terminals only from genuine necessity, focused on 3-4 tasks maximum.

```bash
git worktree add ../project-feature-a feature-a
git worktree add ../project-feature-b feature-b
cd ../project-feature-a && claude
```

Use worktrees when multiple Claude instances work on overlapping code. Use `/rename` to label all chats. Scope management: main chat for code changes, forks for codebase questions and external service research, minimal overlap in code changes between forks.

**Cascade Method:** Open new tasks in new tabs to the right. Sweep left to right (oldest to newest). Focus on 3-4 tasks max.

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

---

## Chapter 4: Skills, Hooks, Agents & Continuous Learning

### Affaan 4:1 — Skills = Scoped Workflow Prompts
> "Skills operate like rules, constricted to certain scopes and workflows. They're shorthand to prompts when you need to execute a particular workflow."

Skills stored in `~/.claude/skills/` for broader workflow definitions. Commands stored in `~/.claude/commands/` for quick executable prompts. They overlap but are stored differently.

Essential skills to set up: `tdd-workflow`, `security-review`, `coding-standards`, `verification-loop`, `strategic-compact`, `continuous-learning`, `iterative-retrieval`, `search-first`.

Skills load on-demand (not resident), saving significant context space vs rules that load every session.

**Source:** [The Shortform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md)

### Affaan 4:2 — Hooks = Event-Driven Automation
> "Hooks are trigger-based automations that fire on specific events, and unlike skills, they're constricted to tool calls and lifecycle events."

Core hook types:
1. **PreToolUse** -- validation/reminders before tool execution (e.g., tmux reminders for long commands)
2. **PostToolUse** -- formatting/feedback after completion (e.g., auto-format with Prettier, TypeScript type checking)
3. **UserPromptSubmit** -- triggers on message submission
4. **Stop** -- fires when Claude finishes (e.g., console.log detection)
5. **SessionStart** -- runs when a new session begins (supports matchers like `compact`)
6. **PreCompact** -- activates before compaction

Pro tip: Use `/hookify` plugin to create hooks conversationally instead of writing JSON. Use Node.js scripts in `scripts/hooks/` instead of fragile inline one-liners.

Hook runtime controls:
```bash
export ECC_HOOK_PROFILE=minimal|standard|strict
export ECC_DISABLED_HOOKS="pre:bash:tmux-reminder,post:edit:typecheck"
```

**Source:** [The Shortform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md), [Everything Claude Code README](https://github.com/affaan-m/everything-claude-code)

### Affaan 4:3 — Continuous Learning v2: Instincts System
> "When Claude Code discovers something that isn't trivial -- a debugging technique, a workaround, some project-specific pattern -- save that knowledge as a new skill."

The instinct-based learning system turns sessions into reusable knowledge:
- Hooks capture every PreToolUse/PostToolUse event -> structured JSONL store
- Background observer detects patterns (user corrections, error resolutions, repeated workflows)
- Creates atomic "instincts" with domain tags, evidence, and confidence scores (0.3-0.9)

Commands:
- `/learn` -- extract patterns from current session
- `/learn-eval` -- extract, evaluate, and save patterns
- `/instinct-status` -- view learned instincts with confidence scores
- `/instinct-import` / `/instinct-export` -- share instincts between users
- `/evolve` -- cluster 3+ related instincts into reusable skills

Raw observations stay local (privacy); only compiled instincts are exportable.

**Source:** [Everything Claude Code README](https://github.com/affaan-m/everything-claude-code), [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 4:4 — Specialized Subagents With Scoped Tool Access
> "Subagents are processes your orchestrator can delegate tasks to with limited scopes, freeing up context for the main agent."

Create agent definitions in `~/.claude/agents/` with specific scopes and tool permissions. ECC ships with 16 agents:

| Agent | Role |
|-------|------|
| planner | Feature implementation planning |
| architect | System design decisions |
| tdd-guide | Test-driven development enforcement |
| code-reviewer | Quality, security, maintainability |
| security-reviewer | Vulnerability and OWASP analysis |
| build-error-resolver | Compilation and build error fixes |
| e2e-runner | Playwright end-to-end testing |
| refactor-cleaner | Dead code identification and removal |
| doc-updater | Documentation sync |
| go-reviewer / python-reviewer / database-reviewer | Language/domain-specific review |

Architectural principle: orchestrator agents (Planner, Architect) get broad tool access, specialized agents only access role-relevant tools.

**Source:** [Everything Claude Code README](https://github.com/affaan-m/everything-claude-code), [The Shortform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md)

---

## Chapter 5: Verification, Security, Tooling & Editor Setup

### Affaan 5:1 — Verification Loops & Evals (pass@k vs pass^k)
> "Use pass@k when it just needs to work; use pass^k when consistency is essential."

- **pass@k** (at least ONE of k attempts succeeds): k=1: 70%, k=3: 91%, k=5: 97%
- **pass^k** (ALL k attempts must succeed): k=1: 70%, k=3: 34%, k=5: 17%

Fork conversations and compare outputs with/without skills using `git diff` to measure impact. Set explicit checkpoints (`/checkpoint`), verify criteria, fix before proceeding. Run continuous evals every N minutes or after major changes with full test suite + lint.

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 5:2 — AgentShield Security Scanner
> "Scans your Claude Code configuration for vulnerabilities, misconfigurations, and injection risks."

```bash
npx ecc-agentshield scan          # Quick scan
npx ecc-agentshield scan --opus   # Deep analysis with Opus agents
npx ecc-agentshield scan --fix    # Auto-fix safe issues
```

Scans CLAUDE.md, settings.json, MCP configs, hooks, agent definitions, and skills across 5 categories. Detects secrets (14 patterns), permission issues, hook injection, MCP risks, config vulnerabilities. Exit code 2 on critical findings for CI/CD gating. 912 test rules, 98% code coverage, 102 static analysis rules.

**Source:** [AgentShield repo](https://github.com/affaan-m/agentshield), [Everything Claude Code README](https://github.com/affaan-m/everything-claude-code)

### Affaan 5:3 — Plankton: Write-Time Code Quality via Hooks
> "Prevents agents from modifying linter configs to circumvent checks."

Three-phase architecture on PostToolUse:
1. Auto-format silently (catches 40-50% of issues)
2. Collect remaining violations as structured JSON
3. Delegate fixes to a subprocess routed by violation complexity

Runs formatters and 20+ linters on every file edit. Blocks agents from modifying linter configs as a workaround.

**Source:** [Everything Claude Code README](https://github.com/affaan-m/everything-claude-code)

### Affaan 5:4 — Editor Choice: Zed for Claude Code
> "Zed is a Rust-based editor that's lightweight, fast, and highly customizable."

Zed is Affaan's preferred editor:
- Agent Panel tracks real-time file changes as Claude edits
- Written in Rust: opens instantly, handles large codebases without lag
- Won't compete with Claude for RAM/CPU
- `CMD+Shift+R` for command palette / custom slash commands
- Full vim keybinding support

Editor-agnostic tips: split screen (Claude on one side, editor on other), enable autosave so Claude reads current state, `Ctrl+G` to open Claude's current file, leverage editor git integration to review changes.

**Source:** [The Shortform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md), [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 5:5 — Voice Input with Superwhisper
> "Even with transcription errors, Claude understands intent."

Use superwhisper (Mac) or MacWhisper for voice-to-text dictation into Claude Code. Local-only, offline, on-device processing via Apple Silicon. Even imperfect transcription works because Claude infers intent.

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 5:6 — Custom Status Line & Terminal Aliases

Set up `/statusline` to show: user, directory, git branch with dirty indicator, context % remaining, model, time, and todo count.

Terminal aliases for speed:
```bash
alias c='claude'
alias gb='github'
alias co='code'
alias q='cd ~/Desktop/projects'
```

Use tmux for long-running command management: `tmux new -s dev` / `tmux attach -t dev`.

**Source:** [The Shortform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md), [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 5:7 — Essential Keyboard Shortcuts
- `Ctrl+U` -- delete entire line
- `$` -- bash command prefix (older versions used `!`, check your version)
- `@` -- file search
- `/` -- slash command initiation
- `Shift+Enter` -- multi-line input
- `Tab` -- toggle thinking display
- `Esc Esc` -- interrupt Claude or restore code

**Source:** [The Shortform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md)

### Affaan 5:8 — Keep Codebases Modular
> "Main files being in the hundreds of lines instead of thousands."

Modular codebases reduce tokens consumed during exploration and editing. Smaller files mean Claude reads and writes less per operation, compounding savings across a session.

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

### Affaan 5:9 — Affaan's Creed
> "Tedious to build, but this had a wild compounding effect as models and agent harnesses improved."

Invest time in systems that compound benefits: subagents, skills, commands, planning patterns, MCP tools, context engineering patterns. These all become more powerful as models improve. Don't overcomplicate -- treat configuration like fine-tuning, not architecture.

**Source:** [The Longform Guide](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md)

---

## Key Workflows (Quick Reference)

### New Feature
```
/plan "Add feature description"
  -> planner creates blueprint
/tdd
  -> enforces test-first
/code-review
  -> catches issues
```

### Bug Fix
```
/tdd (write failing test reproducing issue)
  -> implement fix -> verify test passes
/code-review
```

### Production Prep
```
/security-scan  (OWASP audit)
/e2e            (critical user flows)
/test-coverage  (verify 80%+)
```

### Learning Loop
```
(develop normally)
/learn-eval     (extract and evaluate patterns)
/instinct-status (review confidence scores)
/evolve         (cluster into reusable skills)
```

---

## Source Threads

| Date | Thread / Resource | Topic |
|------|-------------------|-------|
| Jan 2026 | [The Shorthand Guide to Everything Claude Code](https://x.com/affaanmustafa/status/2012378465664745795) | Complete setup: skills, hooks, subagents, MCPs, plugins (2.7M views) |
| Jan 2026 | [~7500 stars in <4 days](https://x.com/affaanmustafa/status/2013858150487822592) | Longform guide announcement, topic overview |
| Jan 2026 | [The Longform Guide to Everything Claude Code](https://x.com/affaanmustafa/status/2014040193557471352) | Token optimization, memory, evals, parallelization, subagents (322K views) |
| Jan 2026 | [Most comprehensive guide](https://x.com/affaanmustafa/status/2014054549422743989) | Token optimization, memory persistence, continuous learning, verification loops |
| Feb 2026 | [ECC v1.5.0 release](https://x.com/affaanmustafa/status/2021701065486594157) | 14 agents, 28 skills, 30 commands, 6 languages, cross-platform (Claude Code, OpenCode, Cursor) |
| Mar 2026 | [For anyone switching to Claude](https://x.com/affaanmustafa/status/2027727596608479430) | Most up-to-date and comprehensive repo for agent harness potential |
| Ongoing | [Everything Claude Code repo](https://github.com/affaan-m/everything-claude-code) | 73K+ stars, 16 agents, 65 skills, 40+ commands |
| Ongoing | [The Longform Guide (GitHub)](https://github.com/affaan-m/everything-claude-code/blob/main/the-longform-guide.md) | Full advanced guide |
| Ongoing | [The Shortform Guide (GitHub)](https://github.com/affaan-m/everything-claude-code/blob/main/the-shortform-guide.md) | Setup and foundations guide |
| Ongoing | [AgentShield](https://github.com/affaan-m/agentshield) | AI agent security scanner |
| Ongoing | [Personal site](https://affaanmustafa.com/) | Portfolio and background |

---

*Last compiled: 2026-03-13*
