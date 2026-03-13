# Book of Boris

> The Creator. Head of Claude Code at Anthropic. Built it as a side project in September 2024. Hasn't written a line of code by hand since November 2025.

> Compiled from [@bcherny](https://x.com/bcherny) X threads and public talks.
> In 30 days: 259 PRs, 497 commits, 40k lines added, 38k removed. Every line written by Claude + Opus.

---

## Chapter 1: The Commandments (Highest Impact)

### Boris 1:1 — Give Claude a Way to Verify Its Work

> "Probably the most important thing to get great results out of Claude Code — give Claude a way to verify its work. If Claude has that feedback loop, it will 2-3x the quality of the final result."

- For UI changes: use the Claude Chrome extension to open a browser, test the UI, and iterate until the code works and the UX feels good
- For backend: run test suites, bash commands, or simulators
- Claude tests every single change Boris lands to claude.ai/code
- **Invest in making verification rock-solid** — this is the #1 force multiplier

**Sources:** [Thread 1, Tip 13](https://x.com/bcherny/status/2007179861115511237) · [Reply to Karpathy](https://x.com/bcherny/status/2004711722926616680)

---

### Boris 1:2 — Start Every Complex Task in Plan Mode

> "Pour your energy into the plan so Claude can 1-shot the implementation."

- Enter plan mode with `Shift+Tab` twice
- Go back and forth with Claude until you like the plan, then switch to auto-accept edits mode
- One team pattern: have one Claude write the plan, spin up a second Claude to review it as a staff engineer
- **The moment something goes sideways, switch back to plan mode and re-plan** — don't push through
- Explicitly tell Claude to enter plan mode for verification steps, not just implementation

**Sources:** [Thread 2, Tip 2](https://x.com/bcherny/status/2017742745365057733) · [Reply to Karpathy](https://x.com/bcherny/status/2004711722926616680)

---

### Boris 1:3 — Accepting a Plan Clears Context (By Design)

> "When you accept a plan, Claude automatically clears your context, so your plan gets a fresh context window."

- This is intentional — helps Claude stay on track longer and significantly improves plan adherence
- The plan itself is preserved; only the messy back-and-forth discussion is cleared
- If you prefer not to clear context, the option exists to disable it

**Source:** [Fresh context announcement](https://x.com/bcherny/status/2012663636465254662)

---

### Boris 1:4 — Invest in Your CLAUDE.md

> "After every correction, end with: 'Update your CLAUDE.md so you don't make that mistake again.' Claude is eerily good at writing rules for itself."

- Share a single CLAUDE.md per repo, checked into git — the whole team contributes
- Anytime Claude does something incorrectly, add it to the CLAUDE.md
- **Ruthlessly edit** over time until Claude's mistake rate measurably drops
- Tag `@.claude` on coworkers' PRs during code review to update CLAUDE.md as part of the PR
- One engineer maintains a `notes/` directory for every task/project, updated after every PR, and points CLAUDE.md at it
- This is **"Compounding Engineering"** — Claude trains itself on its own failures

**Sources:** [Thread 1, Tip 5-6](https://x.com/bcherny/status/2007179832300581177) · [Thread 2, Tip 3](https://x.com/bcherny/status/2017742741636321619)

---

### Boris 1:5 — Run Parallel Sessions (The Biggest Productivity Unlock)

> "Spin up 3–5 git worktrees at once, each running its own Claude session in parallel. This is the single biggest productivity unlock, and the top tip from the team."

- Boris runs 5 Claude instances in terminal tabs (numbered 1-5) + 5-10 additional sessions on claude.ai/code
- Each session gets its own git checkout/worktree so changes don't conflict
- Use system notifications (iTerm2 or custom hook) to know when Claude needs input
- Create shell aliases (`za`, `zb`, `zc`) to switch between worktrees in one keystroke
- Maintain a dedicated "analysis" worktree exclusively for logs and BigQuery
- Use `--teleport` to pull web sessions down to your terminal (one-way: web→local). For the reverse, use `/remote-control` to expose a local session to web/mobile
- Start sessions from Claude iOS app, pick up on computer later

**Sources:** [Thread 1, Tip 1-2](https://x.com/bcherny/status/2007179832300581177) · [Thread 2, Tip 1](https://x.com/bcherny/status/2017742741636321619) · [Worktree thread](https://x.com/bcherny/status/2025007393290272904)

---

## Chapter 2: Core Workflow (Daily Essentials)

### Boris 2:1 — Use Opus with Thinking for Everything

> "It's the best coding model I've ever used, and even though it's bigger & slower than Sonnet, since you have to steer it less and it's better at tool use, it is almost always faster than using a smaller model in the end."

- Less steering + better tool use = faster overall despite larger model
- Set effort to **High** via `/effort` (default is now medium, not high)
- The time saved by not having to correct and re-prompt outweighs the speed difference

**Source:** [Thread 1, Tip 3](https://x.com/bcherny/status/2007179832300581177)

---

### Boris 2:2 — Opus 4.6 Update

> "Opus 4.6 is our best model yet. It is more agentic, more intelligent, runs for longer, and is more careful and exhaustive."

- Use `/model` and arrow left/right to precisely tune how much the model thinks
- Fast mode now available for Opus 4.6 — great for back-and-forth on tricky problems
- Boris has been building with it for weeks; calls it "a huge unlock"

**Sources:** [Opus 4.6 tweet](https://x.com/bcherny/status/2019471487833706769) · [Fast mode](https://x.com/bcherny/status/2020223254297031110)

---

### Boris 2:3 — Create Slash Commands for Repetitive Workflows

> "I use slash commands for every 'inner loop' workflow that I end up doing many times a day."

- Store in `.claude/commands/` and check into git
- Use inline bash in commands to pre-compute context (git status, branch info, etc.)
- Example: `/commit-push-pr` — Boris uses it "dozens of times every day"
- If you do something more than once a day, turn it into a skill or command

**Source:** [Thread 1, Tip 7](https://x.com/bcherny/status/2007179847949500714)

---

### Boris 2:4 — Use Subagents Strategically

> "Append 'use subagents' to any request where you want Claude to throw more compute at the problem."

- Offload individual tasks to subagents to keep your main agent's context window clean and focused
- Route permission requests to Opus via a hook for attack scanning and auto-approval
- Boris uses regularly: `code-simplifier`, `verify-app`, `build-validator`, `code-architect`, `oncall-guide`
- Subagents now support worktree isolation for parallel work — powerful for large batched changes

**Sources:** [Thread 1, Tip 8](https://x.com/bcherny/status/2007179850139000872) · [Thread 2, Tip 8](https://x.com/bcherny/status/2017742755737555434)

---

### Boris 2:5 — Level Up Your Prompting

> "The more specific you are, the better the output."

- **Challenge Claude:** "Grill me on these changes and don't make a PR until I pass your test"
- **Demand proof:** "Prove to me this works" — request diffs comparing main vs feature branch behavior
- **Push for elegance:** "Knowing everything you know now, scrap this and implement the elegant solution"
- **Write detailed specs** to reduce ambiguity before delegating work
- Don't accept the first solution; push Claude to do better

**Source:** [Thread 2, Tip 6](https://x.com/bcherny/status/2017742741636321619)

---

### Boris 2:6 — Let Claude Debug — Stop Doing It Manually

> "Sometimes I start approaching a problem manually, and have to remind myself 'claude can probably do this'."

- Boris was debugging a memory leak the old-fashioned way: connecting a profiler, pausing, manually reading heap allocations
- His coworker just asked Claude to make a heap dump and read it for retained objects — **Claude 1-shotted it and put up a PR**
- Newer engineers and recent grads are often more effective with Claude because they don't have "legacy memories" of manual debugging
- Continuously recalibrate what the model can do — it improves monthly

**Source:** [Reply to Karpathy](https://x.com/bcherny/status/2004626064187031831)

---

### Boris 2:7 — Claude Fixes Most Bugs by Itself

> "Enable the Slack MCP, then paste a Slack bug thread into Claude and just say 'fix.' Zero context switching required."

- Or just say "Go fix the failing CI tests" — don't micromanage *how*
- Point Claude at docker logs to troubleshoot distributed systems
- The less you prescribe the approach, the more creative Claude's solutions

**Source:** [Thread 2, Tip 5](https://x.com/bcherny/status/2017742750473720121)

---

### Boris 2:8 — Have Claude Code Review Its Own Code

> "The model code reviews its code using a fresh context window; at Anthropic we use `claude -p` for this on every PR."

- Use a separate Claude session (fresh context) to review what another session wrote
- This catches issues the authoring session is blind to due to context anchoring
- Same principle as human code review — fresh eyes find different bugs

**Source:** [Reply to Karpathy](https://x.com/bcherny/status/2015979257038831967)

---

## Chapter 3: Configuration & Customization

### Boris 3:1 — Pre-Approve Common Permissions (Don't Skip Them)

> Use `/permissions` instead of `--dangerously-skip-permissions`

- Pre-allow common safe commands in `.claude/settings.json` and share with team
- Supports wildcard syntax: `"Bash(bun run build:*)"`, `"Edit(/docs/**)"`
- Examples: `bq query`, build/test/lint commands, doc editing
- Claude Code uses prompt injection detection, static analysis, sandboxing, and human oversight under the hood

**Sources:** [Thread 1, Tip 10](https://x.com/bcherny/status/2007179832300581177) · [Customization thread, Tip 5](https://x.com/bcherny/status/2021700332292911228)

---

### Boris 3:2 — Use PostToolUse Hooks for Formatting

- Claude generates well-formatted code 90% of the time; the hook catches the last 10%
- Avoids formatting errors showing up in CI later
- Config: `"matcher": "Write|Edit"` → `"command": "bun run format || true"`

**Source:** [Thread 1, Tip 9](https://x.com/bcherny/status/2007179832300581177)

---

### Boris 3:3 — Set Up Tool Integrations via MCP

- **Slack MCP:** Search and post to Slack autonomously. Paste a bug thread and say "fix"
- **BigQuery:** Run `bq` CLI queries — "I haven't written a line of SQL in 6+ months"
- **Sentry:** Grab error logs directly
- Config lives in `.mcp.json`, shared with team via git

**Source:** [Thread 1, Tip 11](https://x.com/bcherny/status/2007179832300581177)

---

### Boris 3:4 — Handle Long-Running Tasks Without Babysitting

- **Option A:** Prompt Claude to verify with a background agent when done
- **Option B:** Use an agent Stop hook for deterministic verification
- **Option C:** Use the ralph-wiggum plugin
- For sandboxed environments: `--permission-mode=bypassPermissions` lets Claude cook without being blocked (note: `dontAsk` does the opposite — it *denies* all tool usage unless explicitly pre-approved via allow rules)

**Source:** [Thread 1, Tip 12](https://x.com/bcherny/status/2007179858435281082)

---

### Boris 3:5 — Enable Sandboxing

- Run `/sandbox` to opt into the open-source sandbox runtime
- Runs locally with file and network isolation
- Three modes: sandbox + auto-allow, sandbox + normal permissions, no sandbox
- Reduces permission prompts while improving safety

**Source:** [Customization thread, Tip 6](https://x.com/bcherny/status/2021700506465579443)

---

### Boris 3:6 — Create Custom Agents

- Drop `.md` files in `.claude/agents/`
- Each agent can have: custom name, color, tool set, pre-allowed/disallowed tools, permission mode, model
- Set default agent via `"agent"` field in `settings.json` or `--agent` flag
- Add `isolation: worktree` to agent frontmatter to run in its own worktree

**Source:** [Customization thread, Tip 4](https://x.com/bcherny/status/2021700144039903699)

---

### Boris 3:7 — Customize Your Environment

- **Terminal:** Team loves Ghostty for synchronized rendering, 24-bit color, unicode
- **Status line:** `/statusline` — display model, directory, context remaining, cost, git branch
- **Keybindings:** `/keybindings` — every key binding is customizable, lives in `~/.claude/keybindings.json`
- **Output styles:** `/config` → "Explanatory" (for learning new codebases) or "Learning" (Claude coaches you)
- **Voice dictation:** Use `/voice` for Claude Code's native push-to-talk mode (hold Space). Alternatively, hit `fn` twice on macOS for system-level dictation (separate from Claude Code's voice mode)
- **Effort level:** `/effort` → Low/Medium/High (default is medium) — Boris uses High for everything

**Sources:** [Thread 2, Tip 7](https://x.com/bcherny/status/2017742741636321619) · [Customization thread](https://x.com/bcherny/status/2021701636075458648)

---

### Boris 3:8 — Check settings.json Into Git

> "When you do customize, check your settings.json into git so your team can benefit, too."

- Supports configuration at codebase, sub-folder, personal, or enterprise-wide level
- 37 settings, 84 environment variables available
- Use the `"env"` field in settings.json to avoid wrapper scripts

**Source:** [Customization thread, Tip 12](https://x.com/bcherny/status/2021701636075458648)

---

### Boris 3:9 — Use Voice Mode

> "I've been using voice mode to write much of my CLI code this last week."

- `/voice` to toggle on — hold Space to talk, release to send
- You speak 3x faster than you type, and prompts get way more detailed
- Mix typing and voice in the same prompt
- Transcription is free — doesn't consume tokens
- On macOS without voice mode: hit `fn` twice for system dictation

**Sources:** [Voice mode tweet](https://x.com/bcherny/status/2028629573722939789) · [Thread 2, Tip 7](https://x.com/bcherny/status/2017742741636321619)

---

### Boris 3:10 — Disable Auto-Generated Terminal Titles

```
CLAUDE_CODE_DISABLE_TERMINAL_TITLE=1 claude
```

- Or add to the `"env"` section of your `settings.json`
- Useful when you're managing many tabs with your own naming convention

**Source:** [Terminal title tweet](https://x.com/bcherny/status/2007957770725949686)

---

## Chapter 4: Power Features & Automation

### Boris 4:1 — /simplify — Post-PR Code Quality

- Append `/simplify` to any prompt after making changes
- Runs parallel agents reviewing for: reuse opportunities, quality issues, efficiency improvements
- All in one pass, automated

**Source:** [Skills announcement](https://x.com/bcherny/status/2027534984534544489)

---

### Boris 4:2 — /batch — Parallel Code Migrations

- Plan migrations interactively, then execute in parallel with dozens of agents
- Each agent runs with full isolation using git worktrees and tests before creating a PR
- Example: `/batch migrate src/ from Solid to React`

**Source:** [Skills announcement](https://x.com/bcherny/status/2027534984534544489)

---

### Boris 4:3 — /loop — Recurring Tasks

- Schedule tasks on interval, up to 3 days
- Examples:
  - "Babysit all my PRs. Auto-fix build issues and when comments come in, use a worktree agent to fix them"
  - "Every morning use the Slack MCP to give me a summary of top posts I was tagged in"

**Source:** [howborisusesclaudecode.com](https://howborisusesclaudecode.com)

---

### Boris 4:4 — /btw — Ask Questions While Claude Works

- Side-chain conversations during active work
- Single-turn, no tool calls, but full conversation context
- Example: Claude is refactoring auth middleware, you ask "/btw what does the retry logic do?"
- Built by @ErikSchluntz

**Source:** [/btw announcement](https://x.com/bcherny/status/2031545840398119288)

---

### Boris 4:5 — Code Review Agents on PRs

> "Code output per Anthropic engineer is up 200% this year, and reviews were the bottleneck."

- When a PR opens, Claude dispatches a team of specialized agents
- Each agent focuses on: logic errors, security, performance regressions
- Posts inline comments on real bugs

**Source:** [Code review announcement](https://x.com/bcherny/status/2031089411820228645)

---

### Boris 4:6 — Use Claude for Learning

> "Claude Code isn't just for writing code — it's a powerful learning tool."

- Enable "Explanatory" or "Learning" output style in `/config`
- Have Claude generate visual HTML presentations explaining unfamiliar code
- Ask for ASCII diagrams of protocols and codebases
- Build spaced-repetition learning skills: explain your understanding, Claude asks follow-ups, stores results

**Source:** [Thread 2, Tip 10](https://x.com/bcherny/status/2017742759218794768)

---

## Chapter 5: Team & Org Principles

### Boris 5:1 — Underfund Teams Strategically

> "What's better than doing something? Having Claude do it."

- Keep teams slightly under-resourced to force "Claude-ification" of workflows
- Give engineers generous token allocations — don't cost-cut at the beginning
- Optimize costs only after building successful products

### Boris 5:2 — Prioritize Speed

> "Encouraging people to go faster" — especially crucial early on when speed is competitive advantage

### Boris 5:3 — Automate Code Review

- Use `/code-review` or the Claude Code GitHub Action to automate most review
- Hold the same quality bar for human and Claude code

**Source:** [Reply to Karpathy](https://x.com/bcherny/status/2004711722926616680)

---

### Boris 5:4 — Hire Generalists, Not Specialists

> "We hire mostly generalists. We have a mix of senior engineers and less senior since not all of the things people learned in the past translate to coding with LLMs."

- 10x engineers now span multiple domains: product + design, product + business, product + infra
- The most effective Claude users cross over disciplines
- Newer team members without "legacy memories" often leverage AI more naturally
- At Anthropic: flat structure, everyone is "Member of Technical Staff," ideas come from everyone

**Source:** [Reply to Karpathy](https://x.com/bcherny/status/2015979257038831967)

---

### Boris 5:5 — Prototypes Over PRDs

- The Claude Code team builds hundreds of working prototypes before shipping a feature
- PRDs are dead — "There's just no way we could have shipped this if we started with static mocks and Figma or if we started with a PRD"
- When a prototype works, ship it. When it doesn't, throw it away. Both are fast with Claude

**Source:** [Karpathy reply thread](https://x.com/bcherny/status/2015979257038831967)

---

### Boris 5:6 — Use Claude Across Every Surface

- Boris uses Claude Code from: terminal (CLI), claude.ai/code (web), iOS app, Slack, Desktop app
- Start a session on your phone in the morning, pick it up on your computer later
- Use `--teleport` to pull web sessions down to your terminal (one-way: web→local). Use `/remote-control` for the reverse direction
- Use `&` to background a session and continue on another surface

**Sources:** [Thread 1, Tip 2](https://x.com/bcherny/status/2007179832300581177) · [Origin story](https://x.com/bcherny/status/2010923222813065308)

---

### Boris 5:7 — The Claude Code Origin Story

> It's late 2024. Boris walks into the office and sees his coworker Robert using the CLI prototype — a tool Boris thought "wasn't useful for anything yet."

- Robert was already using it to write code and manage git
- Adoption spread organically: data scientists ran SQL, designers built prototypes, finance built forecasting models, sales queried databases
- By launch: people were controlling ovens, recovering wedding photos, analyzing DNA, haggling with customer support
- This pattern led to Claude Cowork for non-coding use cases

**Source:** [Origin story thread](https://x.com/bcherny/status/2010923222813065308)

---

## Boris's Creed

> "Claude Code works great out of the box, so I personally don't customize it much."
>
> "There is no one correct way to use Claude Code: we intentionally build it in a way that you can use it, customize it, and hack it however you like."
>
> "Each person on the Claude Code team uses it very differently."
>
> "There is no one right way to use Claude Code — everyone's setup is different. You should experiment to see what works for you!"
>
> "Sometimes I start approaching a problem manually, and have to remind myself 'claude can probably do this'."
>
> "What's better than doing something? Having Claude do it."

---

## Source Threads (Chronological)

| Date | Thread | Topic |
|------|--------|-------|
| ~Jan 2026 | [Thread 1](https://x.com/bcherny/status/2007179832300581177) | Boris's personal setup (13 tips) |
| ~Jan 2026 | [Karpathy replies](https://x.com/bcherny/status/2004626064187031831) | Debugging, principles, hiring |
| ~Feb 2026 | [Thread 2](https://x.com/bcherny/status/2017742741636321619) | Team tips (10 tips) |
| ~Feb 2026 | [Customization thread](https://x.com/bcherny/status/2021701636075458648) | 12 customization tips |
| ~Feb 2026 | [Worktree thread](https://x.com/bcherny/status/2025007393290272904) | Git worktree support |
| ~Mar 2026 | [/simplify & /batch](https://x.com/bcherny/status/2027534984534544489) | New skills |
| ~Mar 2026 | [/loop](https://x.com/bcherny/status/2030193932404150413) | Recurring tasks |
| ~Mar 2026 | [Code review](https://x.com/bcherny/status/2031089411820228645) | Agent-based PR review |
| ~Mar 2026 | [/btw](https://x.com/bcherny/status/2031545840398119288) | Side-chain questions |
| ~Mar 2026 | [Voice mode](https://x.com/bcherny/status/2028629573722939789) | Voice coding |
| ~Jan 2026 | [Origin story](https://x.com/bcherny/status/2010923222813065308) | How Claude Code started |

---

*Last compiled: 2026-03-13 from Boris Cherny's X threads and public sources.*
