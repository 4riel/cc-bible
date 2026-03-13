# Book of Thariq

> The Architect. Engineer at Anthropic. Sees agents like game engines. Thinks in prompt cache prefixes.

> Compiled from [@trq212](https://x.com/trq212) X threads, public talks, and blog posts.
> Engineer at Anthropic working on Claude Code. Serial entrepreneur (Multiverse, Chime/HubSpot), MIT Media Lab alum. "Trying to pay attention."

---

## Chapter 1: Highest Impact

### Thariq 1:1 — Spec-Based Development (The Interview Pattern)
> "My favorite way to use Claude Code to build large features is spec based -- start with a minimal spec or prompt and ask Claude to interview you using the AskUserQuestionTool then make a new session to execute the spec."

- Start with a minimal `SPEC.md` outlining your feature idea
- Use this exact prompt: `"Read this @SPEC.md and interview me in detail using the AskUserQuestionTool about literally anything: technical implementation, UI & UX, concerns, tradeoffs, etc. but make sure the questions are not obvious"`
- The AskUserQuestionTool presents 3 questions at a time in a terminal UI, lets you navigate with arrow keys, batches your responses, then asks more
- For complex features, expect 40+ questions -- this surfaces decisions you didn't realize you were making and edge cases you'd discover mid-implementation
- Once the interview is done, have Claude write the final spec to file
- **Open a new session** to execute the spec -- fresh context, no interview noise

**Source:** [X thread](https://x.com/trq212/status/2005315275026260309)

### Thariq 1:2 — Design Agents Around Prompt Caching First
> "One of the biggest realizations I've had working on Claude Code is that you fundamentally have to design agents for prompt caching first, almost every feature touches on it somehow."

- Prompt caching works by **prefix matching** -- the API caches everything from the start of the request up to each `cache_control` breakpoint
- **The order matters enormously**: static content first (system prompt, tool definitions, config), dynamic content last (conversation)
- Without caching, a long Opus coding session (100 turns with compaction) costs $50-100 in input tokens; with caching it costs $10-19
- Claude Code's prompt layout ensures: all users share the same system prompt cache, everyone in the same project shares the CLAUDE.md cache, only the conversation is unique per session
- **Cache misses are treated as production incidents** -- the team declares SEVs when cache hit rates drop
- Don't update the prompt when info changes (time, file contents) -- pass it via messages in the next turn instead, or you'll break the cache
- Switching models mid-conversation (e.g., Opus to Haiku) destroys the cache and can be **more expensive** than staying on Opus

**Source:** [X thread](https://x.com/trq212/status/2024574133011673516)

### Thariq 1:3 — Fewer, More Expressive Tools Beat Many Narrow Ones
> "One of the hardest parts of building an agent harness is constructing its action space."

- Fewer, more expressive tools outperform a long menu of narrow tools -- contrary to what most builders intuitively reach for
- Each new tool gives the model one more option to think about, increasing confusion
- Set a **high bar** for adding new tools -- subtract before adding
- When something breaks, resist adding more tools; consider whether existing ones are becoming constraints
- Example: Apple's CodeAct research found a single code execution primitive outperformed sprawling specialized toolkits by up to 20% on complex tasks
- Even the best designed tool doesn't work if Claude doesn't understand how to call it

**Source:** [X thread](https://x.com/trq212/status/2027463795355095314)

---

## Chapter 2: Core Workflow

### Thariq 2:1 — Claude Code Is a General Agent, Not Just for Code
> "When I first joined Anthropic I was surprised to learn that lots of the team used Claude Code as a general agent, not just for code. I've since become a convert!"

- Run Claude Code from your home directory (`~`)
- Create a `CLAUDE.md` that directs Claude to your important directories
- Organize folders by purpose: memory, journals, ideas, code, to-dos, scripts
- Use **descriptive file names** so Claude can search like you would -- "everything is a file, and it knows how to use your computer like you do"
- Use MCPs for external tools: Notion, Google Docs, Linear, GitHub, Slack
- Claude can access Apple Notes and iMessages through your filesystem -- ask Claude Code to build scripts for these, or use his shared gist
- Build custom HTML artifacts that access local file directories (e.g., a meme generator from a local folder)

**Source:** [X thread](https://x.com/trq212/status/1944877527044120655)

### Thariq 2:2 — Use /rewind to Explore Different Paths
> "When you rewind a conversation using /rewind or hitting ESC twice, Claude can summarize the part of the conversation that was rewound. Use this to explore different paths and take the learnings 'back in time'."

- Press **ESC twice** or type `/rewind` to go back to a previous checkpoint
- Choose to rewind: conversation only (code is fine but discussion went off-track), code only (keep what was discussed, try different implementation), or both
- The summarization of the rewound portion preserves the learnings even as you go back
- Removes the fear of trying experimental approaches -- failed paths still inform the next attempt

**Source:** [X thread](https://x.com/trq212/status/2019845028512952351)

### Thariq 2:3 — /btw for Side-Chain Conversations
> "We just added /btw to Claude Code! Use it to have side chain conversations while Claude is working."

- `/btw` lets you ask a question **without adding it to conversation history**
- The response doesn't become part of the context window and doesn't change what Claude "remembers"
- Runs in read-only mode -- no tools triggered, no file modifications
- Reuses the parent conversation's prompt cache, so additional cost is minimal
- Use it while Claude is actively processing a response -- it runs independently and doesn't interrupt the main turn
- Side questions answer only from what is already in context

**Source:** [X thread](https://x.com/trq212/status/2031506296697131352)

### Thariq 2:4 — Plan Mode in Slack
> "We've added Plan Mode to Claude Code in Slack. When you give Claude a complex task it will ask you clarifying questions and show you an implementation plan before proceeding."

- In Plan Mode, Claude can read your codebase, search files, deploy subagents, fetch web content, and ask clarifying questions
- It **cannot** create/edit/delete files, run modifying commands, or install packages
- Forces a think-first approach: Claude analyzes before acting
- Available both in the terminal and in the Slack integration

**Source:** [X thread](https://x.com/trq212/status/2021632916359655893)

---

## Chapter 3: Configuration & Customization

### Thariq 3:1 — Tool Search for MCP Context Optimization
> "We're rolling out Tool Search in Claude Code to reduce how much context MCP servers take up."

- MCP servers can have 50+ tools that consume massive amounts of context
- Tool Search replaces full tool definitions with lightweight stubs (just name + `defer_loading: true`)
- Full schemas load **only** when the model selects them via ToolSearch
- This keeps the cached prefix stable -- same stubs always present in the same order
- Triggers automatically when MCP tool descriptions would use more than 10% of context

**Source:** [X thread](https://x.com/trq212/status/2011523628773622234)

### Thariq 3:2 — Todos Evolved into Tasks
> "We're turning Todos into Tasks in Claude Code."

- Tasks are a new primitive for tracking and completing complex projects across multiple sessions or subagents
- Tasks support **dependencies** (directed acyclic graphs) -- Task 3 can't start until Tasks 1 and 2 are complete
- Stored in the filesystem (`~/.claude/tasks`) so multiple subagents or sessions can collaborate on them
- When one session updates a Task, it broadcasts to all sessions working on the same Task List
- You can set the TaskList as an environment variable to make sessions collaborate on a single list
- Replaced TodoWrite because as models improved, the rigid todo list was constraining rather than helping

**Source:** [X thread](https://x.com/trq212/status/2014480496013803643)

### Thariq 3:3 — Skills Absorbed Slash Commands
> "Merging Slash Commands into Skills in Claude Code."

- Skills are the more powerful abstraction -- they subsume everything slash commands did
- A file at `.claude/commands/deploy.md` and a skill at `.claude/skills/deploy/SKILL.md` both create `/deploy` and work the same way
- Simplifies the mental model: no more choosing between SlashCommand Tool and Skill Tool
- When making a new command, make a skill instead -- skills support extensions like subagent integration
- Skills can be user-invocable, model-invocable, or both (default)
- Set `user-invocable: false` if you don't want users triggering it via `/`

**Source:** [X thread](https://x.com/trq212/status/2014836841846132761)

### Thariq 3:4 — /insights for Workflow Self-Analysis
> "We've added a new command to Claude Code called /insights. When you run it, Claude Code will read your message history from the past month."

- Generates a comprehensive HTML report analyzing your usage patterns across all sessions
- Summarizes your projects, how you use Claude Code, and gives concrete suggestions to improve your workflow
- Uses your actual conversation history as the data source

**Source:** [X thread](https://x.com/trq212/status/2019173731042750509)

### Thariq 3:5 — Custom /journal and /todos Commands
- Create a `/journal` command that generates daily journal entries automatically
- Create a `/todos` command for managing tasks organized by topic (e.g., `claudecode.todos.md`)
- "Claude will often search my code, projects, etc. for more context when I add a to do, which is super helpful"
- Share configuration gists for others to adopt your setup

**Source:** [X thread](https://x.com/trq212/status/1944877527044120655)

---

## Chapter 4: Power Features

### Thariq 4:1 — Playgrounds Plugin for Visual Problems
> "Increasing communication bandwidth between humans and models is the key challenge for next-gen coding agents."

- The Playground plugin generates standalone HTML files with interactive controls (sliders, color pickers, dropdowns) for problems that are inherently visual
- Workflow: generate HTML playground -> adjust parameters visually -> copy the generated prompt -> paste back into Claude Code
- Six built-in templates: Design Playground, Data Explorer, Concept Map, Diff Review, Code Map, Document Critique
- Best for **high-dimensional configuration spaces** where iterating through text is tedious
- Unnecessary for straightforward requests where specs are already clear
- Example: tweaking animation parameters for a Remotion intro, visualizing codebase architecture, game balancing (damage values, cooldowns, resource costs)

**Source:** [X thread](https://x.com/trq212/status/2017024445244924382)

### Thariq 4:2 — Voice Mode for Input Friction Reduction
> "Voice mode is rolling out now in Claude Code. /voice to toggle it on!"

- Hold spacebar to talk (push-to-talk), release to send transcription
- Closes the 3.7x gap between speaking (~150 wpm) and typing (~40 wpm)
- Mix typing and voice mid-prompt -- type half, voice the complex description, continue typing
- Included at no extra cost for Pro, Max, Team, and Enterprise subscribers

**Source:** [X thread](https://x.com/trq212/status/2028628570692890800)

### Thariq 4:3 — Claude Code in Slack
> "How we use Claude Code in Slack."

- @mention Claude in a Slack thread and it gathers context from all messages in that thread
- Claude detects coding intent and creates a Claude Code session automatically
- Posts status updates to your Slack thread as work progresses
- When finished, @mentions you with a summary and action buttons
- Thread context enables Claude to spin up sessions using the right repository and full discussion context

**Source:** [X thread](https://x.com/trq212/status/2017350486756888917)

### Thariq 4:4 — Prompt Caching Architecture Details
- Claude Code keeps all tools present with lightweight stubs rather than removing them mid-conversation -- removing tools would break the cache
- Plan mode is implemented as a callable tool (EnterPlanMode/ExitPlanMode) rather than a config toggle -- tool definitions stay unchanged, preserving the cache
- Model switching uses **subagents** instead of switching mid-session -- the primary model packages focused handoff messages for separate sessions with their own caches
- Compaction inherits the same cached prefix as the parent session and diverges only in messages
- A 200K-token conversation compaction without prefix reuse processes ~18K tokens of system prompt from scratch ($0.09 on Opus); with prefix reuse, those same tokens cost $0.009

**Source:** [X thread](https://x.com/trq212/status/2024574133011673516)

---

## Chapter 5: Thariq's Creed

### Thariq 5:1 — See Like an Agent
> "You learn to see like an agent."

- Pay attention to Claude's outputs -- watch where it struggles, what it misuses, where it gets confused
- Tool design is "as much an art as it is a science" depending on the model, the goal, and the environment
- As model capabilities increase, tools that were once needed might now be **constraining** them
- The AskUserQuestion tool went through 3 iterations before they got it right: (1) adding params to ExitPlanTool confused Claude, (2) markdown formatting was unreliable, (3) a dedicated tool Claude could call at any point finally worked
- **Progressive disclosure** beats tool proliferation: provide search capabilities, link to documentation Claude can reference, use subagents for specific domains, allow nested file searching
- "Claude went from not really being able to build its own context... to being able to do nested search"

**Source:** [X thread](https://x.com/trq212/status/2027463795355095314)

### Thariq 5:2 — Claude Code Is a Small Game Engine
> "Most people's mental model of Claude Code is that 'it's just a TUI' but it should really be closer to 'a small game engine'."

- For each frame, the pipeline constructs a scene graph with React, layouts elements, rasterizes them to a 2D screen, diffs against the previous screen, then generates ANSI sequences to draw -- with a ~16ms frame budget
- This engineering depth explains why Claude Code's UX feels responsive and polished despite being a terminal application

**Source:** [X thread](https://x.com/trq212/status/2014051501786931427)

### Thariq 5:3 — Increasing Communication Bandwidth Is the Key Challenge
- The core challenge for next-gen coding agents is increasing the bandwidth of human-to-model communication
- Every feature Thariq builds (AskUserQuestion, Playgrounds, voice mode, /btw, Plan Mode) targets this same bottleneck
- The interview pattern (40+ questions) extracts more information upfront than any single prompt could
- Visual playgrounds handle what text can't efficiently describe
- Voice mode triples raw input speed
- /btw allows parallel communication channels without context pollution

**Source:** [X thread](https://x.com/trq212/status/2027463795355095314), [Playground thread](https://x.com/trq212/status/2017024445244924382)

### Thariq 5:4 — Design Around the Prefix, Not Around Model Capabilities
> "Long running agentic products like Claude Code are made feasible by prompt caching which allows us to reuse computation from previous roundtrips and significantly decrease latency and cost."

- Production AI agents must "design around the prefix" rather than around model capabilities or architectural elegance
- Cache efficiency directly determines infrastructure costs and pricing sustainability
- Monitor your cache hit rate like you monitor uptime
- A few percentage points of cache miss rate can dramatically affect cost and latency
- This is why Claude Code Pro at $20/month is economically viable

**Source:** [Simon Willison quote](https://simonwillison.net/2026/Feb/20/thariq-shihipar/), [X thread](https://x.com/trq212/status/2024574133011673516)

---

## Source Threads

| Date | Thread | Topic |
|------|--------|-------|
| 2025-07-14 | [Claude Code is All You Need](https://x.com/trq212/status/1944877527044120655) | Using Claude Code as a general agent, file organization, MCPs, Apple Notes, custom commands |
| 2025-12-28 | [Spec-Based Development](https://x.com/trq212/status/2005315275026260309) | Interview pattern with AskUserQuestionTool for building large features |
| 2026-01-08 | [Tool Search in Claude Code](https://x.com/trq212/status/2011523628773622234) | Reducing MCP context usage with deferred tool loading |
| 2026-01-16 | [Claude Code TUI as Game Engine](https://x.com/trq212/status/2014051501786931427) | Internal rendering architecture of Claude Code |
| 2026-01-17 | [Todos to Tasks](https://x.com/trq212/status/2014480496013803643) | Tasks primitive with dependencies and cross-session collaboration |
| 2026-01-18 | [Merging Slash Commands into Skills](https://x.com/trq212/status/2014836841846132761) | Skills as the unified abstraction replacing slash commands |
| 2026-02-01 | [Making Playgrounds](https://x.com/trq212/status/2017024445244924382) | Visual HTML playgrounds for problems text can't solve |
| 2026-02-02 | [Claude Code in Slack](https://x.com/trq212/status/2017350486756888917) | Slack integration, thread context, automatic session creation |
| 2026-02-04 | [/insights Command](https://x.com/trq212/status/2019173731042750509) | Monthly usage analysis and workflow improvement suggestions |
| 2026-02-05 | [/rewind Feature](https://x.com/trq212/status/2019845028512952351) | Conversation rewind with summarization for path exploration |
| 2026-02-11 | [Plan Mode in Slack](https://x.com/trq212/status/2021632916359655893) | Read-only planning with clarifying questions before execution |
| 2026-02-13 | [Claude Code Web Updates](https://x.com/trq212/status/2022064852995649620) | Multi-repo sessions, diff visualization, slash commands on web |
| 2026-02-20 | [Prompt Caching Is Everything](https://x.com/trq212/status/2024574133011673516) | Cache architecture, cost analysis, design principles |
| 2026-03-01 | [Seeing like an Agent](https://x.com/trq212/status/2027463795355095314) | Tool design philosophy, action space, progressive disclosure |
| 2026-03-03 | [Voice Mode Launch](https://x.com/trq212/status/2028628570692890800) | Push-to-talk voice input in the terminal |
| 2026-03-11 | [/btw Side-Chain Chats](https://x.com/trq212/status/2031506296697131352) | Side conversations without polluting context |
| 2026-01-XX | [Agent SDK Workshop](https://x.com/trq212/status/2008229496244081070) | 2-hour workshop at AI Engineer on Claude Agent SDK |

---

*Last compiled: 2026-03-13*
