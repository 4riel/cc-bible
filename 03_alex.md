# Book of Alex

> The Evangelist. Head of Claude Relations at Anthropic. Bridges the gap between the builders and the world.

> Compiled from [@alexalbert__](https://x.com/alexalbert__) X threads, public talks, and official Anthropic publications.

---

## Chapter 1: Highest Impact

### Alex 1:1 — CLAUDE.md Files Are the Hidden Gem
> "CLAUDE md files are the main hidden gem. Simple markdown files that give Claude context about your project - bash commands, code style, testing patterns. Claude loads them automatically."

- Run `/init` to generate a starter CLAUDE.md based on your project structure, then refine over time
- Include bash commands Claude can't guess, code style rules that differ from defaults, testing instructions, repo etiquette, architectural decisions, and common gotchas
- Exclude anything Claude can figure out by reading code, standard language conventions, detailed API docs (link instead), and file-by-file codebase descriptions
- Keep it concise. For each line ask: "Would removing this cause Claude to make mistakes?" If not, cut it
- Bloated CLAUDE.md files cause Claude to **ignore** your actual instructions
- Add emphasis ("IMPORTANT", "YOU MUST") to improve adherence on critical rules
- Check CLAUDE.md into git so your team contributes; the file compounds in value over time
- Layer them: `~/.claude/CLAUDE.md` (global defaults), project root (team-shared), child dirs (domain-specific)
- Use `@path/to/import` syntax to reference other docs like README.md or git-instructions.md

**Source:** [Alex Albert's internal patterns thread](https://x.com/alexalbert__/status/1914333333213073674) and [Best Practices docs](https://code.claude.com/docs/en/best-practices)

---

### Alex 1:2 — Give Claude a Way to Verify Its Own Work
> "Include tests, screenshots, or expected outputs so Claude can check itself. This is the single highest-leverage thing you can do."

- Without clear success criteria, Claude produces things that look right but don't work
- Write tests first, commit them, then let Claude implement until they pass
- For UI changes: paste a screenshot, have Claude implement the design, take a screenshot of the result, compare, and fix differences
- For bugs: paste the exact error, have Claude fix it and verify the build succeeds
- Your verification can be a test suite, a linter, or a bash command that checks output
- Invest in making your verification rock-solid -- it's the feedback loop that replaces you

**Source:** [Official best practices](https://code.claude.com/docs/en/best-practices) and [Alex Albert's internal patterns thread (tweet 4)](https://x.com/alexalbert__/status/1914333320877584397)

---

### Alex 1:3 — Explore First, Then Plan, Then Code
> "Quality improves dramatically with this approach."

- Use Plan Mode (`Shift+Tab`) to separate research from execution
- **Phase 1 - Explore**: Enter Plan Mode. Claude reads files and answers questions without making changes
- **Phase 2 - Plan**: Ask Claude to create a detailed implementation plan. Press `Ctrl+G` to edit the plan in your editor before proceeding (note: there's a known bug where edits via Ctrl+G may not always be passed back to Claude — verify Claude acknowledges your changes)
- **Phase 3 - Implement**: Switch to Normal Mode, let Claude code while verifying against the plan
- **Phase 4 - Commit**: Ask Claude to commit with a descriptive message and open a PR
- Use "think" or "ultrathink" for deeper reasoning during planning
- Skip planning for trivial tasks (typos, log lines, renames) -- if you could describe the diff in one sentence, skip the plan
- Plan Mode can 2-3x your success rate on complex tasks

**Source:** [Alex Albert's internal patterns thread (tweet 3)](https://x.com/alexalbert__/status/1914333320877584397) and [Best Practices docs](https://code.claude.com/docs/en/best-practices)

---

### Alex 1:4 — Context Window Is Your Most Important Resource
> "Most best practices are based on one constraint: Claude's context window fills up fast, and performance degrades as it fills."

- The context window holds your entire conversation, every file read, and every command output
- LLM performance degrades as context fills -- Claude starts "forgetting" earlier instructions
- Track context usage continuously with a custom status line
- Use `/clear` between unrelated tasks to reset context entirely
- Use `/compact <instructions>` to summarize selectively (e.g., `/compact Focus on the API changes`)
- After two failed corrections, `/clear` and write a better initial prompt
- Use `/btw` for quick questions that don't need to stay in context
- Delegate research to subagents so file-reading doesn't consume your main context

**Source:** [Official best practices](https://code.claude.com/docs/en/best-practices) and [How Anthropic teams use Claude Code](https://claude.com/blog/how-anthropic-teams-use-claude-code)

---

## Chapter 2: Core Workflow Patterns

### Alex 2:1 — Multi-Claude Writer/Reviewer Pattern
> "One [Claude] writes code, another reviews behind it. Git worktrees enable parallel Claude sessions on different features."

- Session A (Writer): implements the feature
- Session B (Reviewer): reviews the implementation in a fresh context, free from author bias
- Feed Session B's feedback back to Session A to address issues
- Also works for tests: one Claude writes tests, another writes code to pass them
- Use git worktrees to run parallel sessions on different features without conflicts
- The Claude Code Desktop app, web version, and CLI all support worktrees natively

**Source:** [Alex Albert's internal patterns thread (tweet 8)](https://x.com/alexalbert__/status/1914333320877584397) and [Best Practices docs](https://code.claude.com/docs/en/best-practices)

---

### Alex 2:2 — Headless Mode for Automation
> "Headless mode (claude -p) handles PR labeling and subjective code review."

- `claude -p "prompt"` runs Claude non-interactively, no session needed
- Use in CI pipelines, pre-commit hooks, GitHub Actions, or any automated workflow
- Output formats: plain text, JSON (`--output-format json`), or streaming JSON (`--output-format stream-json`)
- `--dangerously-skip-permissions` for contained workflows in sandboxed containers (never on your main machine)
- `--allowedTools` to scope what Claude can do when running unattended
- Fan out across files: generate a task list, then loop `claude -p` over each file for large migrations

**Source:** [Alex Albert's internal patterns thread (tweet 7)](https://x.com/alexalbert__/status/1914333320877584397) and [Best Practices docs](https://code.claude.com/docs/en/best-practices)

---

### Alex 2:3 — Use Claude Code for Codebase Onboarding
> "Engineers ask contextual questions and Claude searches git history and code, significantly reducing onboarding time."

- Feed Claude your entire codebase and CLAUDE.md documentation
- Ask the same questions you would ask a senior engineer: "How does logging work?", "How do I make a new API endpoint?"
- Claude can identify relevant files, explain data pipeline dependencies, and show upstream data sources
- New data scientists on Anthropic's Infrastructure team feed Claude Code their entire codebase to get productive quickly
- Also useful for long-time employees navigating unfamiliar parts of the codebase
- This reduces research time by ~80% (from 1 hour of searching to 10-20 minutes)

**Source:** [Alex Albert's internal patterns thread (tweet 6)](https://x.com/alexalbert__/status/1914333320877584397) and [How Anthropic teams use Claude Code](https://claude.com/blog/how-anthropic-teams-use-claude-code)

---

### Alex 2:4 — Use Keyboard Shortcuts to Course-Correct Fast
> "ESC interrupts Claude; double ESC edits previous prompts, saving wasted work when Claude heads the wrong direction."

- `Esc`: Stop Claude mid-action. Context is preserved so you can redirect
- `Esc + Esc` or `/rewind`: Open the rewind menu and restore previous conversation, code, or both
- `"Undo that"`: Have Claude revert its changes
- `/clear`: Reset context between unrelated tasks
- Correct Claude as soon as you notice it going off track -- tight feedback loops produce better solutions faster
- If you've corrected Claude more than twice on the same issue, the context is cluttered. `/clear` and start fresh

**Source:** [Alex Albert's internal patterns thread (tweet 5)](https://x.com/alexalbert__/status/1914333320877584397) and [Best Practices docs](https://code.claude.com/docs/en/best-practices)

---

## Chapter 3: Power User Techniques

### Alex 3:1 — /simplify and /batch Skills
> Alex Albert: "New skills in Claude Code" -- shared alongside Boris Cherny's announcement of /simplify and /batch.

- **/simplify**: Spawns three parallel reviewers examining code reuse, code quality, and efficiency on recently changed files. Run before opening PRs
  - Use optional focus: `/simplify focus on error handling`
  - Review diffs before committing
- **/batch**: Orchestrates large-scale parallel codebase migrations using isolated git worktrees
  - Phase 1: Research and decompose work into 5-30 independent units
  - Phase 2: Spawn one agent per unit, each in its own worktree
  - Phase 3: Each agent implements, runs tests, and opens a PR
  - Good for: framework migrations, API standardization, convention enforcement, dependency swaps
  - Not for: tightly coupled changes or exploratory refactoring

**Source:** [Alex Albert - New skills in Claude Code](https://x.com/alexalbert__/status/2028586246419996846) and [Boris Cherny's thread](https://x.com/bcherny/status/2027534984534544489)

---

### Alex 3:2 — Hooks for Deterministic Guarantees
> Alex Albert shared the Hooks feature announcement: "User-defined shell commands that execute at various points in Claude Code's agent loop."

- Unlike CLAUDE.md instructions (advisory), hooks are deterministic -- the action always happens
- Run linters/formatters after every file edit (PostToolUse)
- Block writes to .env, production config, or .git (PreToolUse)
- Create stop hooks that keep Claude running until tests pass
- Claude can write hooks for you: "Write a hook that runs eslint after every file edit"
- Use `/hooks` for interactive configuration or edit `.claude/settings.json` directly
- Anthropic's Security Engineering team uses 50% of all custom slash command implementations in the entire monorepo

**Source:** [Alex Albert on hooks](https://x.com/alexalbert__/status/1930309974661706173) and [Hooks guide](https://code.claude.com/docs/en/hooks-guide)

---

### Alex 3:3 — Subagents to Preserve Context
> "Subagents run in separate context windows and report back summaries -- all without cluttering your main conversation."

- Delegate research with `"use subagents to investigate X"` -- they explore in a separate context
- Use for verification after implementation: `"use a subagent to review this code for edge cases"`
- Spawn parallel verification agents, then dedupe with additional agents checking for false positives
- Use agents representing opposing viewpoints (auditor vs. advocate) to debate approaches
- Map-reduce pattern: primary agent generates a to-do list, 10 subagents work in parallel

**Source:** [Best Practices docs](https://code.claude.com/docs/en/best-practices) and [How Anthropic teams use Claude Code](https://claude.com/blog/how-anthropic-teams-use-claude-code)

---

### Alex 3:4 — Let Claude Interview You Before Building
> "Start with a minimal prompt and ask Claude to interview you using the AskUserQuestion tool."

- For larger features, have Claude ask about technical implementation, UI/UX, edge cases, and tradeoffs
- Claude asks about things you might not have considered
- Once the spec is complete, start a **fresh session** to execute it -- clean context focused entirely on implementation
- Prompt template: "I want to build [brief description]. Interview me in detail using the AskUserQuestion tool. Don't ask obvious questions, dig into the hard parts I might not have considered."

**Source:** [Best Practices docs](https://code.claude.com/docs/en/best-practices) and [Every.to podcast transcript](https://every.to/podcast/transcript-how-to-use-claude-code-like-the-people-who-built-it)

---

## Chapter 4: Environment & Configuration

### Alex 4:1 — CLI Tools Are the Most Context-Efficient Integration
> "Tell Claude Code to use CLI tools like gh, aws, gcloud, and sentry-cli when interacting with external services."

- Install the `gh` CLI for GitHub operations -- without it, unauthenticated API requests hit rate limits
- Claude is effective at learning CLI tools it doesn't know: "Use 'foo-cli-tool --help' to learn about foo tool, then use it to solve A, B, C"
- Check `settings.json` into your codebase to pre-allow certain commands and block dangerous operations
- Use `/permissions` to allowlist safe commands or `/sandbox` for OS-level isolation

**Source:** [Best Practices docs](https://code.claude.com/docs/en/best-practices) and [Alex Albert's internal patterns thread](https://x.com/alexalbert__/status/1914333320877584397)

---

### Alex 4:2 — Skills for On-Demand Knowledge
> Skills let you "package specialized knowledge into reusable capabilities that Claude loads on demand."

- Create `SKILL.md` files in `.claude/skills/` for domain knowledge and repeatable workflows
- Skills load on demand, unlike CLAUDE.md which loads every session -- keeps context lean
- Define workflows with `disable-model-invocation: true` for side-effect-producing commands you trigger manually
- Example: `/fix-issue 1234` reads the issue, searches code, implements fix, writes tests, creates PR

**Source:** [Alex Albert - Skills announcement](https://x.com/alexalbert__/status/2028586246419996846) and [Skills docs](https://code.claude.com/docs/en/skills)

---

### Alex 4:3 — MCP Servers for Secure External Access
> "Rather than using CLI tools directly, teams recommend MCP servers to maintain security control over what Claude Code can access."

- Connect Notion, Figma, databases, monitoring tools via `claude mcp add`
- Use MCP for sensitive data that requires logging or privacy controls
- Consolidate scattered documentation from wikis, code comments, and team members' knowledge into accessible formats
- The MCP Tool Search feature dynamically fetches tools only when needed, avoiding context bloat

**Source:** [How Anthropic teams use Claude Code](https://claude.com/blog/how-anthropic-teams-use-claude-code) and [Best Practices docs](https://code.claude.com/docs/en/best-practices)

---

## Chapter 5: Alex's Creed

### Alex 5:1 — Treat Claude Code as a Thought Partner, Not a Code Generator
> "The most successful teams treat Claude Code as a thought partner rather than a code generator."

- Explore possibilities, prototype rapidly, share discoveries across technical and non-technical users
- Ask questions you'd ask a senior engineer -- no special prompting required
- Agentic coding dissolves boundaries between technical and non-technical work
- At Anthropic, non-engineers (brand team, lawyers, marketers) ship PRs and build custom tools
- Boris Cherny hasn't manually edited a single line of code since November 2025 -- Claude Code writes 100% of his production code

**Source:** [How Anthropic teams use Claude Code](https://claude.com/blog/how-anthropic-teams-use-claude-code) and [Alex Albert conversation with Boris Cherny](https://x.com/alexalbert__/status/1930309974661706173)

---

### Alex 5:2 — Claude Transformed Coding in 2025; It Will Transform Knowledge Work in 2026
> "Claude transformed coding in 2025. In 2026, it will transform knowledge work."

- Over 70-80% of technical Anthropic employees use Claude Code every day
- Claude Code spread so quickly internally that in Boris Cherny's first performance review, Dario Amodei asked if he was forcing colleagues to use it
- Cowork extends the Claude Code paradigm to non-coders: handle multiple analyses, Excel models, PowerPoint presentations
- The Claude Code SDK was rebranded to the Claude Agent SDK to reflect its use for any general-purpose agent

**Source:** [Alex Albert on knowledge work](https://x.com/alexalbert__/status/2019477447868313634) and [Agent SDK rebrand](https://x.com/alexalbert__/status/1972718342197981194)

---

### Alex 5:3 — Avoid the Five Common Failure Patterns

1. **The kitchen sink session** -- You mix unrelated tasks in one session. Fix: `/clear` between tasks
2. **Correcting over and over** -- Context polluted with failed approaches. Fix: After two failures, `/clear` and write a better prompt
3. **The over-specified CLAUDE.md** -- Too long, Claude ignores half. Fix: Ruthlessly prune, convert to hooks
4. **The trust-then-verify gap** -- Plausible code that misses edge cases. Fix: Always provide verification
5. **The infinite exploration** -- Unscoped investigation fills context. Fix: Scope narrowly or use subagents

**Source:** [Best Practices docs](https://code.claude.com/docs/en/best-practices)

---

## Source Threads

| Date | Thread | Topic |
|------|--------|-------|
| 2025-02-24 | [Claude Code launch](https://x.com/alexalbert__/status/1894095793667412165) | Getting started with Claude Code |
| 2025-04-21 | [Internal patterns thread](https://x.com/alexalbert__/status/1914333320877584397) | "We wrote up what we've learned about using Claude Code internally at Anthropic" -- CLAUDE.md, explore-plan-code, TDD, keyboard shortcuts, onboarding, headless mode, multi-Claude, worktrees |
| 2025-04-21 | [CLAUDE.md hidden gem](https://x.com/alexalbert__/status/1914333333213073674) | "CLAUDE md files are the main hidden gem" |
| 2025-05-02 | [Max plan billing](https://x.com/alexalbert__/status/1918017889548026263) | Claude Code subscription billing for Max plan |
| 2025-05-23 | [IDE integration](https://x.com/alexalbert__/status/1925938725365624912) | Claude Code available in IDEs |
| 2025-06-06 | [Pro plan + Boris Cherny conversation](https://x.com/alexalbert__/status/1930309974661706173) | Claude Code in Pro plan; video on how Anthropic uses Claude Code, underrated tips, future of coding |
| 2025-06-16 | [GitHub Actions rollout](https://x.com/alexalbert__/status/1943332121814405412) | GitHub Actions integration for Pro and Max users |
| 2025-06-18 | [Windows native support](https://x.com/alexalbert__/status/1944836106320797982) | Claude Code natively available on Windows |
| 2025-09-17 | [Agent SDK rebrand](https://x.com/alexalbert__/status/1972718342197981194) | Claude Code SDK renamed to Claude Agent SDK |
| 2025-11-21 | [Opus 4.5 prompting guide](https://x.com/alexalbert__/status/1993365963706913257) | Prompting guide for Opus 4.5 from internal testing |
| 2026-01-10 | [Cowork launch](https://x.com/alexalbert__/status/2010806269188456756) | "The Claude Code but for non-coders moment is here" |
| 2026-01-28 | [Knowledge work vision](https://x.com/alexalbert__/status/2019477447868313634) | "Claude transformed coding in 2025. In 2026, it will transform knowledge work" |
| 2026-03-04 | [New skills](https://x.com/alexalbert__/status/2028586246419996846) | /simplify and /batch skills announcement |

### Additional Key Resources

| Resource | Link |
|----------|------|
| How Anthropic teams use Claude Code (official blog) | [claude.com/blog](https://claude.com/blog/how-anthropic-teams-use-claude-code) |
| Best Practices docs (official) | [code.claude.com/docs/en/best-practices](https://code.claude.com/docs/en/best-practices) |
| How Anthropic teams use Claude Code (PDF) | [anthropic.com PDF](https://www-cdn.anthropic.com/58284b19e702b49db9302d5b6f135ad8871e7658.pdf) |
| Conversation with Boris Cherny (video) | [YouTube](https://www.youtube.com/watch?v=if9iv4xponk) |
| "How to Use Claude Code Like the People Who Built It" (podcast transcript) | [every.to](https://every.to/podcast/transcript-how-to-use-claude-code-like-the-people-who-built-it) |

---

*Last compiled: 2026-03-13*
