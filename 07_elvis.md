# Book of Elvis

> The Optimizer. Co-founder of DAIR.AI. Cut token usage by 90%. Skills are his religion.

> Compiled from [@omarsar0](https://x.com/omarsar0) X threads and public talks.
> Co-founder of DAIR.AI, prompt engineering educator, and one of the most prolific Claude Code power users -- known for token optimization, skills engineering, and subagent orchestration.

---

## Chapter 1: Token & Context Optimization

### Elvis 1:1 — The ~90% Token Reduction Hack: MCP Tools via Bash
> "This simple Claude Code hack has reduced token usage by ~90%. It adopts the 'Code Execution with MCP' concept published by Anthropic. Remove preloaded MCP tools from context and use Python to execute tools via bash instead. BTW, this can be optimized much further. Insane!"

- Instead of loading MCP tool definitions into the LLM's context window, offload tool execution to lightweight Python scripts run via bash.
- Based on Anthropic's "Code Execution with MCP" framework.
- Massive reduction in per-turn token cost because tool schemas never enter the context.
- Elvis notes this can be optimized even further beyond 90%.

**Source:** [X post (Nov 2025)](https://x.com/omarsar0/status/1988269255604007275)

### Elvis 1:2 — Dynamic Tool Loading to Kill Context Bloat
> "This is a big deal. Claude Code now has dynamic tool loading. I use MCP tools a lot for integrations that my work depends on. Enabling this to reduce all of that context bloat is going to make it more effective and faster to integrate agents with tools."

- Enable via the `ENABLE_TOOL_SEARCH` environment variable (not a settings.json key). Set `ENABLE_TOOL_SEARCH=auto:5` for custom thresholds, or add it to the `"env"` block in settings.json. MCP tools drop from ~25% to ~14% of context window.
- Tools load on-demand instead of all at once.
- Automatically enabled when tools exceed 10% of model context.
- Combine with the bash-execution hack above for compounding savings.

**Source:** [X post (Jan 2026)](https://x.com/omarsar0/status/2011589983090688262)

### Elvis 1:3 — Prompt Caching Is Everything for Agent Workloads
> "If you are building with agents like Claude Code & Codex, you regularly hit context window limits. It also happens a lot when building long-running or proactive agents."

- Long-running agentic products like Claude Code are made feasible by prompt caching.
- Prompt caching reuses computation from previous roundtrips, significantly decreasing latency and cost.
- Critical for proactive agents and long-running sessions that would otherwise blow through context limits.

**Source:** [X post (Feb 2026)](https://x.com/omarsar0/status/2024587792127340731)

---

## Chapter 2: Skills — The Compounding Superpower

### Elvis 2:1 — Skills Are the #1 Way to Steer Claude Code
> "Don't sleep on Skills. Skills is easily one of the most effective ways to steer Claude Code. Impressive for optimization. I built a skill inside of Claude Code that automatically builds, tests, and optimizes MCP tools. It runs in a loop, loading context and tools."

- Skills provide a tiered context loading system -- more efficient than dumping everything into a prompt.
- Build a skill that auto-builds, tests, and optimizes MCP tools in a loop.
- Claude Code understands the problem, pulls the right context, and fully leverages the filesystem.
- Skills are the primary mechanism for context engineering in Claude Code.

**Source:** [X post (May 2025)](https://x.com/omarsar0/status/1979242073372164306)

### Elvis 2:2 — Skills > Agents: Procedural Knowledge Compounds
> "The more skills you build, the more useful Claude Code gets. And it makes perfect sense. Procedural knowledge and continuous learning for the win! Skills essentially are the way you make Claude Code more knowledgeable over time."

- Based on Anthropic's own talk: "Skills > Agents."
- Skills encode procedural knowledge that persists across sessions.
- Each new skill makes Claude Code incrementally smarter for your workflow.
- Think of skills as your agent's growing expertise library.

**Source:** [X post (Jun 2025)](https://x.com/omarsar0/status/1998383154181361813)

### Elvis 2:3 — Skills for Context Engineering & Continual Learning
> "At a high level, Skills is great for context engineering and steering Claude Code. Skills are a bigger deal than I initially thought. I wrote yesterday about how great it is at optimizing tools (with an MCP tuning approach that can generalize to self-improving/evolving agents through adaptive skills)."

- Build a high-level skill that monitors interactions and feedback.
- Document learnings in skills, subagents, CLAUDE.md, or other forms.
- This enables Claude Code to learn from mistakes and adapt -- self-improving agents.
- MCP tool tuning via skills generalizes to any self-evolving agent pattern.

**Source:** [X post (May 2025)](https://x.com/omarsar0/status/1979547649519899019)

### Elvis 2:4 — Skills vs. Subagents: Know When to Use Which
> "On Skills vs. Subagents. Subagents are useful for handing off subtasks (i.e., separation of concerns) from the main task. Skills are about loading context efficiently with a neat tiered system."

- **Subagents**: Separation of concerns, each manages its own context, keeps orchestrator clean.
- **Skills**: Context engineering and efficient context loading with tiered system.
- Subagents can also leverage Skills -- they're complementary, not competing.
- Use subagents for delegation; use skills for knowledge and steering.

**Source:** [X post (May 2025)](https://x.com/omarsar0/status/1981798842866557281)

### Elvis 2:5 — Auto-Memory: Claude Remembers Across Sessions
> "Claude Code now supports auto-memory. This is huge!"

- Claude remembers project context, debugging patterns, and preferred approaches across sessions.
- No manual documentation needed -- it recalls learnings automatically.
- Combines with skills for a powerful continual learning loop.

**Source:** [X post (Feb 2026)](https://x.com/omarsar0/status/2027117473229676864)

---

## Chapter 3: Subagent Architecture & Parallelization

### Elvis 3:1 — Subagents Are All You Need
> "Claude Code subagents are all you need. Some will complain on # of tokens. However, the output this spits out will save you days. The code quality is mindblowing! Agentic search works exceptionally well. The subagents run in parallel. ChatGPT's deep research is no match!"

- Yes, subagents use more tokens -- but the output quality saves days of work.
- Agentic search via subagents is exceptionally effective.
- Subagents run in parallel for massive throughput.
- Each subagent has its own clean context -- no cross-contamination.

**Source:** [X post (May 2025)](https://x.com/omarsar0/status/1978235329237668214)

### Elvis 3:2 — Async Subagents for Uninterrupted Workflows
> "Claude Code can now run agents asynchronously. Huge for productivity. You can run many subagents in the background to explore your codebase. Work continues uninterrupted. When subagents complete tasks, they wake up/report to the main agent. Workflows feel faster already!"

- Run subagents in the background while your main task continues.
- Background agents report back to the main orchestrator when done.
- Ideal for codebase exploration, log monitoring, and build processes.
- Offload individual work to parallel subagents to keep the orchestrator lean.

**Source:** [X post (Jun 2025)](https://x.com/omarsar0/status/1998774531188830304)

### Elvis 3:3 — Chain Subagents with /commands for Reliability
> "Claude Code sub-agents is probably the easiest way to build complex, custom agentic systems. Not just for code, but for anything you can imagine. Watch me build a multi-agent deep research system with Claude Code subagents. Chain subagents with /commands for reliability."

- Use `/commands` to chain subagents into reliable multi-step pipelines.
- Build multi-agent deep research systems entirely within Claude Code.
- Not limited to code -- works for any complex task you can imagine.
- The orchestrator-subagent pattern is one of the most powerful agentic architectures.

**Source:** [X post (Jan 2025)](https://x.com/omarsar0/status/1949204315350216789)

### Elvis 3:4 — MCP Servers + /commands (Not Everything Needs Subagents)
> "More fun use of Claude Code. This time, I pair MCP servers with custom /commands. Watch how I use MCP to combine model capabilities (Claude 4 + Gemini 2.5 Pro). Not everything needs subagents; MCP servers are quite capable when used along with /commands."

- Pair MCP servers with custom `/commands` for simpler orchestration.
- Combine multiple model capabilities (e.g., Claude + Gemini) via MCP.
- Reserve subagents for true delegation; use MCP + commands for lighter coordination.

**Source:** [X post (Jan 2025)](https://x.com/omarsar0/status/1949922050069365046)

---

## Chapter 4: Planning, Brainstorming & Workflow

### Elvis 4:1 — Brainstorming with Claude Code Is Underrated
> "Brainstorming with Claude Code for a longer time is underrated."

- Don't over-invest in the initial prompt. Instead, interact for multiple turns.
- Provide just enough details iteratively -- you'll know it's "just right" when the agent is eager to implement.
- This iterative approach produces better-specified implementations than one-shot prompting.
- More turns = more context for Claude to understand what you actually need.

**Source:** [X post (May 2025)](https://x.com/omarsar0/status/1977062473036423169)

### Elvis 4:2 — Shift+Tab: Cycle Between Brainstorm, Plan, and Execute
> "Simplicity is at the heart of great software. I use Shift + Tab a lot to cycle between brainstorming, planning, and building."

- Use `Shift+Tab` to cycle between brainstorming, planning, and execution modes.
- Be very involved during planning, less involved during execution.
- Plan mode keeps everything read-only -- safe to explore without modifying files.
- Opus Plan Mode (Opus for planning, Sonnet for implementation) is a great cost/quality balance.

**Source:** [X post (May 2025)](https://x.com/omarsar0/status/1984641893519839281)

### Elvis 4:3 — Planning Is Critical for Long-Running Tasks
> "Planning is critical to be productive and effective with AI Agents. It's aligned with how I get Claude Code to effectively work on long-running tasks."

- Better planning + tuned CLAUDE.md = effective long-running agent sessions.
- Create an initial plan in plan mode, then execute.
- Offload subtasks to subagents -- they manage their own context, keeping the orchestrator clean.
- Planning is core for multi-agent coordination to work.

**Source:** [X post (Jan 2026)](https://x.com/omarsar0/status/2011823468468379782)

### Elvis 4:4 — Use Plan Mode for Front-End Design
> "Opus 4.5 + Claude Code's front-end design plugin is a great combo for designing apps. Just one-shotted a few designs, and it feels like a huge improvement. Use plan mode to get much better results."

- Install the frontend-design plugin from the marketplace.
- Always use plan mode when designing -- significantly better results.
- Opus models + design plugin = one-shot quality UI generation.

**Source:** [X post (May 2025)](https://x.com/omarsar0/status/1993822868820652258)

### Elvis 4:5 — Brainstorming with AI When Stuck
> "One little trick that has worked out well: 'brainstorming with AI'. When I feel stuck or behind, I use Claude Code + a deep research subagent to read and research on new tools, papers, and ideas. Then I prompt CC to start brainstorming sessions and implement new skills with emerging ideas."

- Use a deep research subagent to scan tools, papers, and ideas.
- Feed research output into brainstorming sessions.
- Immediately implement promising ideas as new skills.
- Breaks creative blocks by combining research + ideation + implementation.

**Source:** [X post (Dec 2025)](https://x.com/omarsar0/status/2004636797347996040)

---

## Chapter 5: Reusable Patterns & Advanced Workflows

### Elvis 5:1 — Build Reusable Workflows -- They Compound Exponentially
> "On maximizing Claude Code. Early on, I spent time building reusable workflows/patterns. Tedious to build, but this had a wild compounding effect as models and agent harnesses improved. I think these effects will continue to compound exponentially. No point in starting fresh."

- Invest upfront in building reusable subagents, skills, commands, MCP tools.
- These patterns transfer across model upgrades and agent harnesses.
- The compounding effect accelerates as models improve -- your workflows get better for free.
- Never start from scratch; build on your accumulated patterns.

**Source:** [X post (Dec 2025)](https://x.com/omarsar0/status/2006390906371629222)

### Elvis 5:2 — Claude-in-Chrome for Visual Iteration
> "It's insane how good this Claude-in-Chrome tool is. I use the tool by default to fix all design issues with Claude Code. Fixes 100% of design issues. I don't even bother fixing design issues myself. I now just queue them for Claude Code to fix them automatically in one go."

- Claude-in-Chrome lets Claude Code see and interact with your browser.
- Queue all design issues and let Claude Code batch-fix them automatically.
- Combine with Remotion for motion video creation workflows.
- Eliminates manual visual debugging entirely.

**Source:** [X post (Dec 2025)](https://x.com/omarsar0/status/2006004138220605920)

### Elvis 5:3 — Skills + External Models via API
> "I have built a Skill for Claude Code that leverages the nano banana image generation model via API. My skill has a self-improving loop."

- Build skills that call external model APIs (image gen, other LLMs, etc.).
- Create self-improving loops where the skill iterates on its own output.
- Use the Claude Code Playground plugin for precise annotations during improvement.
- Skills can combine Claude with Gemini, image models, or any API.

**Source:** [X post (Feb 2026)](https://x.com/omarsar0/status/2017321172845941026)

### Elvis 5:4 — n8n + Claude Code for Automation
> "Don't sleep on Claude Code + n8n's automation powers. It's one of the easiest ways to connect Claude Code agents with MCP tools."

- Use n8n's MCP Server node to connect Claude Code with external automations.
- Example: tracking and sharing AI news automatically.
- n8n provides the workflow orchestration; Claude Code provides the intelligence.

**Source:** [X post (Jan 2025)](https://x.com/omarsar0/status/1952117892863983792)

### Elvis 5:5 — Ralph Wiggum Plugin for Autonomous Loops
> "The era of agent harnesses is officially here! A simple Ralph Wiggum plugin in Claude Code can already give you a huge edge."

- Ralph Wiggum puts Claude Code in self-drive mode: one prompt, one goal condition, walk away.
- The plugin keeps feeding the same prompt back -- Claude sees its previous work and iterates.
- Useful for long-running tasks that benefit from repeated refinement.
- For more control, combine with an MCP-powered Kanban board.

**Source:** [X post (Jan 2026)](https://x.com/omarsar0/status/2009061265864262111)

### Elvis 5:6 — Prompting 101: Structure Matters
> Prompting tips from Elvis's Claude Code Community talk: "Be explicit: Clearly define the model's role, objective, inputs, and exact output format. Prioritize structure: Organize prompts with distinct sections and use XML/JSON tags."

- Define the model's role, objective, inputs, and exact output format explicitly.
- Use XML/JSON tags to organize prompt sections -- models adhere better to well-defined formats.
- Structure > length. A well-structured short prompt beats a rambling long one.

**Source:** [Claude Code Community on X](https://x.com/claude_code/status/1958812351647346960)

### Elvis 5:7 — Context Engineering > Context Windows
> "Google just published a banger guide on effective context engineering for multi-agent systems. Context windows aren't the bottleneck. Context engineering is."

- The size of your context window doesn't matter if you're filling it with noise.
- For complex, long-horizon tasks, what you put in context matters more than how much fits.
- Use the "handle pattern" for large payloads: store data externally, keep only lightweight references in context, load on-demand.
- Context engineering is the core discipline for effective agent building.

**Source:** [X post (Jun 2025)](https://x.com/omarsar0/status/1997348089888374918)

---

## Elvis's Creed

| Date | Thread | Topic |
|------|--------|-------|
| Jan 2025 | [1949204315350216789](https://x.com/omarsar0/status/1949204315350216789) | Building multi-agent deep research with subagents + /commands |
| Jan 2025 | [1949922050069365046](https://x.com/omarsar0/status/1949922050069365046) | MCP servers + /commands, not everything needs subagents |
| Jan 2025 | [1952117892863983792](https://x.com/omarsar0/status/1952117892863983792) | Claude Code + n8n automation via MCP |
| Jan 2025 | [1955339275806884016](https://x.com/omarsar0/status/1955339275806884016) | Opus Plan Mode discovery |
| Feb 2025 | [1958812351647346960](https://x.com/claude_code/status/1958812351647346960) | Prompting 101 talk recap (Claude Code Community) |
| Feb 2025 | [1960877597191245974](https://x.com/omarsar0/status/1960877597191245974) | AI subagents across Claude Code, LangGraph, n8n |
| Apr 2025 | [1973488599283929210](https://x.com/omarsar0/status/1973488599283929210) | Claude Agent SDK loop for building effective agents |
| May 2025 | [1977062473036423169](https://x.com/omarsar0/status/1977062473036423169) | Brainstorming with Claude Code is underrated |
| May 2025 | [1978235329237668214](https://x.com/omarsar0/status/1978235329237668214) | Subagents are all you need |
| May 2025 | [1979242073372164306](https://x.com/omarsar0/status/1979242073372164306) | Skills for auto-building/testing/optimizing MCP tools |
| May 2025 | [1979547649519899019](https://x.com/omarsar0/status/1979547649519899019) | Skills for context engineering & continual learning |
| May 2025 | [1981798842866557281](https://x.com/omarsar0/status/1981798842866557281) | Skills vs. Subagents comparison |
| May 2025 | [1984641893519839281](https://x.com/omarsar0/status/1984641893519839281) | Shift+Tab for brainstorm/plan/execute cycling |
| Nov 2025 | [1988269255604007275](https://x.com/omarsar0/status/1988269255604007275) | ~90% token reduction hack via bash MCP execution |
| May 2025 | [1993101718041903565](https://x.com/omarsar0/status/1993101718041903565) | Skill using Gemini 3 Pro for web design |
| May 2025 | [1993822868820652258](https://x.com/omarsar0/status/1993822868820652258) | Opus 4.5 + frontend-design plugin + plan mode |
| Jun 2025 | [1997348089888374918](https://x.com/omarsar0/status/1997348089888374918) | Context engineering > context windows |
| Jun 2025 | [1998383154181361813](https://x.com/omarsar0/status/1998383154181361813) | Skills > Agents (Anthropic talk notes) |
| Jun 2025 | [1998774531188830304](https://x.com/omarsar0/status/1998774531188830304) | Async subagents for background work |
| Dec 2025 | [2004636797347996040](https://x.com/omarsar0/status/2004636797347996040) | Brainstorming with AI when stuck |
| Dec 2025 | [2006004138220605920](https://x.com/omarsar0/status/2006004138220605920) | Claude-in-Chrome for design issue fixing |
| Dec 2025 | [2006390906371629222](https://x.com/omarsar0/status/2006390906371629222) | Reusable workflows compound exponentially |
| Jan 2026 | [2009061265864262111](https://x.com/omarsar0/status/2009061265864262111) | Agent harnesses & Ralph Wiggum plugin |
| Jan 2026 | [2011589983090688262](https://x.com/omarsar0/status/2011589983090688262) | Dynamic tool loading for MCP |
| Jan 2026 | [2011823468468379782](https://x.com/omarsar0/status/2011823468468379782) | Planning is critical for long-running tasks |
| Feb 2026 | [2017296558169952517](https://x.com/omarsar0/status/2017296558169952517) | Self-improving skill loops with Playground plugin |
| Feb 2026 | [2017321172845941026](https://x.com/omarsar0/status/2017321172845941026) | Skills calling external model APIs |
| Feb 2026 | [2021222728393687217](https://x.com/omarsar0/status/2021222728393687217) | Remotion + Claude-in-Chrome for video creation |
| Feb 2026 | [2024511304535593287](https://x.com/omarsar0/status/2024511304535593287) | Cowork UI for knowledge work |
| Feb 2026 | [2024587792127340731](https://x.com/omarsar0/status/2024587792127340731) | Prompt caching for agent workloads |
| Feb 2026 | [2027117473229676864](https://x.com/omarsar0/status/2027117473229676864) | Auto-memory support |

---

*Last compiled: 2026-03-13*
