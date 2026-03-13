# Book of Cat

> The Shepherd. PM for Claude Code at Anthropic. Wrote the official best practices. Guides the flock.

> Compiled from [@_catwu](https://x.com/_catwu) X threads, public talks, podcasts, and the official best practices guide she co-authored.
> Cat Wu is PM/Product Lead for Claude Code at Anthropic. Co-created Claude Code with Boris Cherny. Briefly joined Cursor as Head of Product, returned to Anthropic after two weeks.

---

## Chapter 1: The Fundamentals That 2-3x Your Success Rate

### Cat 1:1 — Give Claude a way to verify its own work

> "Including tests, screenshots, or expected outputs so Claude can check itself is the single highest-leverage thing you can do."
> -- [Official Best Practices Guide](https://code.claude.com/docs/en/best-practices)

- Always provide verification criteria: tests, linters, build commands, screenshots
- Tell Claude to **run tests after implementing**, not just write them
- For UI: paste a screenshot, ask Claude to implement it, take a screenshot, compare, and fix differences
- Address root causes: paste the actual error, don't just say "the build is failing"
- Invest in making your verification rock-solid -- this is the feedback loop that replaces you

Source: [Best Practices Guide](https://code.claude.com/docs/en/best-practices) | [Cat Wu best practices announcement](https://x.com/_catwu/status/1913354716001739173)

### Cat 1:2 — Explore first, then plan, then code

> "You can double or triple your chances of success on complex tasks by switching to plan mode -- which has Claude map out what it's going to do step-by-step -- and aligning on an approach before any code gets written."
> -- [Every.to Podcast with Cat Wu & Boris Cherny](https://every.to/podcast/how-to-use-claude-code-like-the-people-who-built-it)

Four-phase workflow:
1. **Explore** -- Enter Plan Mode (`Shift+Tab` twice). Claude reads files and answers questions without making changes
2. **Plan** -- Ask Claude to create a detailed implementation plan. Press `Ctrl+G` to edit the plan in your text editor
3. **Implement** -- Switch back to Normal Mode and let Claude code against the plan
4. **Commit** -- Ask Claude to commit with a descriptive message and open a PR

Skip planning when the scope is clear and the fix is small. Planning is most useful when you're uncertain about the approach, when the change modifies multiple files, or when you're unfamiliar with the code.

Source: [Best Practices Guide](https://code.claude.com/docs/en/best-practices) | [Cat Wu Plan Mode announcement](https://x.com/_catwu/status/1932857816131547453)

### Cat 1:3 — Run multiple sessions in parallel

> "Spin up 3-5 git worktrees at once, each running its own Claude session in parallel. It's the single biggest productivity unlock, and the top tip from the team."
> -- [Boris Cherny (co-creator)](https://x.com/bcherny/status/2017742743125299476)

- Use `claude --worktree` to run Claude Code in its own git worktree
- Each agent gets its own worktree and can work independently without edits clobbering each other
- Name worktrees or set up shell aliases (`za`, `zb`, `zc`) to hop between them in one keystroke
- Pass `--tmux` to launch Claude in its own tmux session
- The Claude Code Desktop app has built-in worktree support

Source: [Boris Cherny thread](https://x.com/bcherny/status/2017742743125299476) | [Cat Wu on multi-clauding](https://x.com/_catwu/status/1993428129197834741)

---

## Chapter 2: CLAUDE.md, Thinking, and Context

### Cat 2:1 — Invest in your CLAUDE.md

> "We use it to remember project conventions, architecture decisions, or coding standards that we want to reference across sessions."
> -- [Cat Wu on memory](https://x.com/_catwu/status/1904941906867413054)

- Run `/init` to generate a starter CLAUDE.md based on your project structure
- Press `#` to add memories on the fly during a session
- Include: bash commands Claude can't guess, code style rules that differ from defaults, test runners, repo etiquette, architectural decisions, environment quirks, common gotchas
- Exclude: anything Claude can figure out from reading code, standard language conventions, long tutorials, self-evident practices like "write clean code"
- Keep it short -- bloated CLAUDE.md files cause Claude to **ignore your actual instructions**
- Add emphasis (`IMPORTANT`, `YOU MUST`) for critical rules
- Check CLAUDE.md into git so your team contributes. It compounds in value over time
- After corrections, tell Claude: "add this to CLAUDE.md so next time it just knows this automatically"

Source: [Cat Wu memory feature](https://x.com/_catwu/status/1904941904812220787) | [Best Practices Guide](https://code.claude.com/docs/en/best-practices)

### Cat 2:2 — Use extended thinking for complex tasks

> "Ask Claude Code to 'think' to trigger extended thinking. Great for larger tasks that require planning, like refactors."
> -- [Cat Wu](https://x.com/_catwu/status/1903130883814723636)

Thinking depth is now controlled by `/effort` (low/medium/high). Default for Opus 4.6 is **medium**, not high. Keywords like `"think"`, `"think hard"`, and `"ultrathink"` still work as per-turn overrides — `"ultrathink"` bumps that single turn to high effort. The specific token counts per keyword (4K, 10K, 31,999) are no longer documented and may not be accurate.

Use it when: the task requires multi-step reasoning, architectural decisions, complex refactors, or debugging tricky issues.

Source: [Cat Wu extended thinking announcement](https://x.com/_catwu/status/1900246771374387651) | [Cat Wu thread](https://x.com/_catwu/status/1903130883814723636)

### Cat 2:3 — Manage context aggressively

> "Most best practices are based on one constraint: Claude's context window fills up fast, and performance degrades as it fills."
> -- [Best Practices Guide](https://code.claude.com/docs/en/best-practices)

- Use `/clear` frequently between unrelated tasks to reset context entirely
- Run `/compact <instructions>` (e.g., `/compact Focus on the API changes`) for controlled summarization
- Use `Esc + Esc` or `/rewind` to selectively summarize from a checkpoint
- Use `/btw` for quick questions that don't need to stay in context (dismissible overlay, never enters history)
- Microcompact: clears old tool calls to extend session length
- Customize compaction in CLAUDE.md: `"When compacting, always preserve the full list of modified files and any test commands"`
- If you've corrected Claude more than twice on the same issue, run `/clear` and start fresh -- a clean session with a better prompt almost always outperforms a long session with accumulated corrections

Source: [Cat Wu on auto-compact](https://x.com/_catwu/status/1903130894132711441) | [Cat Wu on microcompact](https://x.com/_catwu/status/1952488684579873195)

### Cat 2:4 — Use Opus for plan mode, Sonnet for execution

> "Claude Code has a new /model option: Opus for plan mode. This setting uses Opus for plan mode and Sonnet for all other work -- getting the best of both models while maximizing your usage."
> -- [Cat Wu](https://x.com/_catwu/status/1955694117264261609)

- Run `/model` to select the model or toggle Opus Plan Mode
- Opus for intelligence during planning, Sonnet for speed during execution (current models: Opus 4.6, Sonnet 4.6)
- Toggle between modes (default, auto-accept, plan) with `Shift+Tab`
- For entire feature requests, use Opus and let it run for an hour+ in the background

Source: [Cat Wu /model announcement](https://x.com/_catwu/status/1955694117264261609) | [Cat Wu on Opus 4](https://x.com/_catwu/status/1925593032600310180)

---

## Chapter 3: Subagents, Interviews, and Slash Commands

### Cat 3:1 — Use subagents to keep your context clean

> "Subagents -- separate instances of Claude working in parallel -- can catch issues before code gets merged."
> -- [Every.to Podcast](https://every.to/podcast/how-to-use-claude-code-like-the-people-who-built-it)

- Tell Claude: `"use subagents to investigate how our auth system handles token refresh"`
- The subagent explores, reads files, and reports back summaries **without cluttering your main conversation**
- Use after implementation: `"use a subagent to review this code for edge cases"`
- For code review: spawn multiple specialized subagents (style, git history, bugs), then use more subagents to deduplicate false positives
- Press `Ctrl+B` to run agents in the background
- Use `@-mention` support and model selection for agents

Source: [Cat Wu subagent features](https://x.com/_catwu/status/1952488684579873195) | [Cat Wu agent teams](https://x.com/_catwu/status/1948496854712295492)

### Cat 3:2 — Let Claude interview you before building

> "For larger features, have Claude interview you first. Start with a minimal prompt and ask Claude to interview you using the AskUserQuestion tool."
> -- [Best Practices Guide](https://code.claude.com/docs/en/best-practices)

The prompt:
```
I want to build [brief description]. Interview me in detail using the AskUserQuestion tool.
Ask about technical implementation, UI/UX, edge cases, concerns, and tradeoffs.
Don't ask obvious questions, dig into the hard parts I might not have considered.
Keep interviewing until we've covered everything, then write a complete spec to SPEC.md.
```

Then start a **fresh session** to execute the spec -- clean context focused entirely on implementation.

Source: [Best Practices Guide](https://code.claude.com/docs/en/best-practices) | [Community adoption thread](https://x.com/trq212/status/2005315275026260309)

### Cat 3:3 — Build custom slash commands for repeatable workflows

> "Slash commands use templating to pre-run bash commands, embed them, and pre-allow tool invocations -- reducing permission friction."
> -- [Every.to Podcast](https://every.to/podcast/how-to-use-claude-code-like-the-people-who-built-it)

Examples from the Claude Code team:
- `/PR commit` -- exact bash commands for commits with pre-allowed permissions
- `/feature dev` -- structured step-by-step feature development (specification -> plan -> to-do list)
- `/code review` -- Claude performs first-pass code review (used internally at Anthropic)
- `/techdebt` -- finds duplicated code and improvement opportunities

Store custom skills in `.claude/skills/` and commit to git so teammates benefit from identical workflows.

Source: [Every.to Podcast](https://every.to/podcast/how-to-use-claude-code-like-the-people-who-built-it) | [Best Practices Guide](https://code.claude.com/docs/en/best-practices)

### Cat 3:4 — Steer Claude in real time

> "Send feedback to Claude Code while it's working, without waiting for completion. Claude incorporates your input immediately, adjusting its approach based on new requirements or clarifications."
> -- [Cat Wu](https://x.com/_catwu/status/1922352915076849743)

- `Esc` -- stop Claude mid-action, context preserved, redirect
- `Esc + Esc` or `/rewind` -- restore previous conversation and code state
- `"Undo that"` -- have Claude revert its changes
- Type while Claude works to steer it without waiting for completion

Source: [Cat Wu real-time steering](https://x.com/_catwu/status/1922352915076849743)

---

## Chapter 4: Environment Setup and Permissions

### Cat 4:1 — Auto-accept mode for rapid prototyping

> "Press Shift+Tab to toggle on auto-accept for file edits. This reduces friction while keeping you in the driver's seat."
> -- [Cat Wu](https://x.com/_catwu/status/1902045862068678933)

- `Shift+Tab` cycles through: Default -> Auto-accept -> Plan Mode
- Use auto-accept when prototyping or on trusted tasks
- Use `--dangerously-skip-permissions` only in sandboxed environments without internet
- Configure `/permissions` to allowlist safe commands (e.g., `npm run lint`, `git commit`)
- Use `settings.json` checked into the repo to pre-allow commands and block dangerous paths

Source: [Cat Wu auto-accept](https://x.com/_catwu/status/1902045862068678933)

### Cat 4:2 — Use CLI tools and MCP servers

> "CLI tools are the most context-efficient way to interact with external services."
> -- [Best Practices Guide](https://code.claude.com/docs/en/best-practices)

- Install `gh` for GitHub, `aws`, `gcloud`, `sentry-cli` etc.
- Claude learns new CLI tools: `"Use 'foo-cli-tool --help' to learn about foo tool, then use it to solve A, B, C"`
- Run `claude mcp add` to connect Notion, Figma, databases, and other external tools
- Use MCP to paste Slack bug reports directly into Claude for autonomous investigation

Source: [Best Practices Guide](https://code.claude.com/docs/en/best-practices) | [Every.to Podcast](https://every.to/podcast/how-to-use-claude-code-like-the-people-who-built-it)

### Cat 4:3 — Use hooks for deterministic guarantees

> "Unlike CLAUDE.md instructions which are advisory, hooks are deterministic and guarantee the action happens."
> -- [Best Practices Guide](https://code.claude.com/docs/en/best-practices)

- Ask Claude: `"Write a hook that runs eslint after every file edit"`
- Or: `"Write a hook that blocks writes to the migrations folder"`
- Run `/hooks` for interactive configuration
- Use stop hooks to enforce "keep going until tests pass"

Source: [Best Practices Guide](https://code.claude.com/docs/en/best-practices)

### Cat 4:4 — Background tasks and long-running work

> "Claude Code can now handle long-running tasks in the background. Start your dev server, run tests, or build your project without blocking your workflow."
> -- [Cat Wu](https://x.com/_catwu/status/1953926541370630538)

- Hand Claude entire feature requests and let it run for an hour+ in the background
- Use `/remote-control` to continue local sessions from your phone
- Emerging patterns: issue deduplication with auto PR generation, log aggregation from Sentry, framework migrations across large codebases

Source: [Cat Wu background tasks](https://x.com/_catwu/status/1953926541370630538) | [Cat Wu /remote-control](https://x.com/_catwu/status/2026421789476401182)

---

## Chapter 5: Team Patterns and Non-Engineering Use

### Cat 5:1 — How Anthropic's non-engineering teams use Claude Code

> "Since we originally built Claude Code as an internal tool, we've heard a ton of questions about how our teams use it at Anthropic."
> -- [Cat Wu](https://x.com/_catwu/status/1930703532715626587)

Real use cases from Anthropic teams:
- **Growth Marketing**: agentic workflow processing hundreds of CSV ads, identifying underperformers, generating variations in minutes
- **Legal**: built prototype phone tree systems connecting team members to appropriate lawyers
- **Data Scientists**: build React visualizations in TypeScript without knowing the language
- **Security**: stack trace analysis reduced troubleshooting 3x; TDD workflow with Claude writing pseudocode first
- **Product Design**: feed Figma designs to Claude, it writes code + runs tests + iterates. Built Vim key bindings for itself with minimal review
- **Inference Team**: research time reduced 80% -- Claude explains model-specific functions in 10-20 minutes vs. 1 hour
- **Data Infrastructure**: during Kubernetes outages, Claude diagnosed pod IP exhaustion from screenshots and provided exact fix commands

Source: [Cat Wu on Anthropic teams](https://x.com/_catwu/status/1930703532715626587) | [Anthropic blog](https://claude.com/blog/how-anthropic-teams-use-claude-code)

### Cat 5:2 — Ship demos, not docs

> "The source of truth is the code base."
> -- [Cat Wu, Creator Economy podcast](https://creatoreconomy.so/p/inside-claude-code-how-an-ai-native-actually-works-cat-wu)

How the Claude Code team works:
- Prototype -> Dogfood -> Ship what resonates
- Engineers own features end-to-end, from conception through launch
- Designers and PMs check in code directly
- Collect feedback every 10 minutes from 1,000+ internal users
- If internal users don't organically adopt a feature, it needs refinement
- Best features came from an engineer prototyping an idea and shipping it to internal users

Source: [Creator Economy podcast](https://creatoreconomy.so/p/inside-claude-code-how-an-ai-native-actually-works-cat-wu) | [Peter Yang on Cat Wu](https://x.com/petergyang/status/1966487035281367177)

### Cat 5:3 — Use Claude Code to onboard to codebases

> "Claude Code is the fastest way to get up to speed on a new codebase."
> -- [Every.to Podcast](https://every.to/podcast/how-to-use-claude-code-like-the-people-who-built-it)

Ask the same questions you'd ask a senior engineer:
- "How does logging work?"
- "How do I make a new API endpoint?"
- "What edge cases does `CustomerOnboardingFlowImpl` handle?"
- "Why does this code call `foo()` instead of `bar()` on line 333?"
- "Look through ExecutionFactory's git history and summarize how its API came to be"

Claude can query GitHub directly and find how people implemented a similar feature in the past -- tacit code sharing without APIs.

Source: [Best Practices Guide](https://code.claude.com/docs/en/best-practices) | [Every.to Podcast](https://every.to/podcast/how-to-use-claude-code-like-the-people-who-built-it)

---

## Anti-Patterns: What NOT to Do

From the official best practices guide co-authored by Cat Wu:

| Anti-Pattern | Problem | Fix |
|---|---|---|
| **Kitchen sink session** | One task, then unrelated question, then back to first task. Context full of irrelevant info | `/clear` between unrelated tasks |
| **Correcting over and over** | Context polluted with failed approaches | After 2 failed corrections, `/clear` and write a better initial prompt |
| **Over-specified CLAUDE.md** | Too long, Claude ignores half of it | Ruthlessly prune. If Claude does it correctly without the instruction, delete it |
| **Trust-then-verify gap** | Plausible-looking code that doesn't handle edge cases | Always provide verification (tests, scripts, screenshots) |
| **Infinite exploration** | Unscoped investigation, Claude reads hundreds of files | Scope narrowly or use subagents for research |

Source: [Best Practices Guide](https://code.claude.com/docs/en/best-practices)

---

## Source Threads

| Date | Source | Topic |
|---|---|---|
| 2025-02-24 | [X thread](https://x.com/_catwu/status/1894100230313808185) | Claude Code launch announcement |
| 2025-03-20 | [X thread](https://x.com/_catwu/status/1900246771374387651) | Extended thinking launch |
| 2025-03-21 | [X thread](https://x.com/_catwu/status/1903130883814723636) | Extended thinking tips thread (8 tips) |
| 2025-03-21 | [X thread](https://x.com/_catwu/status/1902045862068678933) | Auto-accept mode, web fetch, auto-compact |
| 2025-03-25 | [X thread](https://x.com/_catwu/status/1904941904812220787) | Memory feature with # key |
| 2025-04-18 | [X thread](https://x.com/_catwu/status/1913354716001739173) | Best practices guide announcement |
| 2025-04-28 | [X thread](https://x.com/_catwu/status/1917652098889703900) | Resume past conversations |
| 2025-05-13 | [X thread](https://x.com/_catwu/status/1922352910731534524) | Multipaste and real-time steering |
| 2025-06-12 | [X thread](https://x.com/_catwu/status/1925593032600310180) | Opus 4 in Claude Code |
| 2025-07-10 | [X thread](https://x.com/_catwu/status/1930703532715626587) | How Anthropic teams use Claude Code |
| 2025-08-07 | [X thread](https://x.com/_catwu/status/1932857816131547453) | Plan mode launch |
| 2025-08-29 | [X thread](https://x.com/_catwu/status/1955694117264261609) | Opus plan mode model option |
| 2025-10-24 | [X thread](https://x.com/_catwu/status/1948496854712295492) | Custom agent teams |
| 2025-11-07 | [X thread](https://x.com/_catwu/status/1952488684579873195) | Microcompact, subagent @-mentions, PDF support |
| 2025-11-11 | [X thread](https://x.com/_catwu/status/1953926541370630538) | Background tasks |
| 2025-12-12 | [X thread](https://x.com/_catwu/status/1993428129197834741) | Multi-clauding in Claude Desktop |
| 2026-02-17 | [X thread](https://x.com/bcherny/status/2017742743125299476) | Boris Cherny's 10 tips from the team |
| 2026-03-05 | [X thread](https://x.com/_catwu/status/2026421789476401182) | /remote-control launch |
| -- | [Every.to Podcast](https://every.to/podcast/how-to-use-claude-code-like-the-people-who-built-it) | Cat Wu & Boris Cherny deep dive |
| -- | [Creator Economy](https://creatoreconomy.so/p/inside-claude-code-how-an-ai-native-actually-works-cat-wu) | How an AI Native Team Actually Works |
| -- | [Anthropic Blog](https://claude.com/blog/how-anthropic-teams-use-claude-code) | How Anthropic teams use Claude Code |
| -- | [Best Practices Docs](https://code.claude.com/docs/en/best-practices) | Official best practices guide |
| -- | [Anthropic Webinar](https://www.anthropic.com/webinars/claude-code-live) | The Story of Claude Code |

---

*Last compiled: 2026-03-13*
