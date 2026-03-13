# Book of Shumer

> The Sorcerer. CEO of OthersideAI. Runs 10+ agent swarms. Invented Concept Elevation.

> Compiled from [@mattshumer_](https://x.com/mattshumer_) X threads, public talks, and open-source projects.
> CEO of OthersideAI/HyperWrite, prolific prompt engineer, agent orchestration pioneer, and author of the viral essay "Something Big Is Happening" (80M+ views).

---

## Chapter 1: Agent Orchestration & Multi-Agent Workflows

### Shumer 1:1 — Run 10+ Agents in Parallel on a Single Task
> "Speedrunning my way through my Claude Max rate limits. Pretty crazy watching 10+ agents collaborate on one task. My laptop fans are blaring (turns out Claude Code is a memory hog)."

- Get Claude Max ($100-200/mo) -- Anthropic subsidizes usage, giving you thousands of dollars' worth of compute.
- Spin up multiple Claude Code sessions working on the same codebase simultaneously.
- Each agent can own a separate piece of work (feature, module, test suite).
- Expect high memory usage -- Claude Code is a known memory hog when running multiple instances.
- Use git worktrees so agents don't step on each other's files.

**Source:** [X post](https://x.com/mattshumer_/status/2012581787575206178)

### Shumer 1:2 — Build Long-Running Agent Swarms
> "Super inspired by @cursor_ai's amazing work, so I decided to build my own long-running agent swarm. Six hours in, they're making real progress towards a working browser."

- Agent swarms can run for hours on complex multi-file projects.
- Give high-level outcome descriptions, not step-by-step instructions.
- The agents self-coordinate, pick up tasks, and iterate autonomously.
- Shumer ran a swarm for 6+ hours building a browser from scratch, making real progress.
- He offered to open-source the project if there was enough interest.

**Source:** [X post](https://x.com/mattshumer_/status/2012307116082471161)

### Shumer 1:3 — Walk Away and Let the Agent Work
> "I tell the AI what I want, walk away from my computer for four hours, and come back to find the work done."

- The latest models (Opus 4.5+) demonstrate something resembling "taste" and "judgment" -- making intelligent design choices rather than merely executing explicit instructions.
- The agent opens the app itself, clicks through buttons, tests features, uses the app the way a person would. If it doesn't like how something looks or feels, it goes back and changes it on its own.
- Describe desired outcomes and application behavior in plain English; let the agent handle architecture, design, and testing autonomously.
- This is a paradigm shift: stop micro-managing the AI. Give it entire, substantial tasks.

**Source:** [Something Big Is Happening](https://shumer.dev/something-big-is-happening)

---

## Chapter 2: Prompt Engineering Techniques

### Shumer 2:1 — Concept Elevation — Meta-Prompt to Improve Any Prompt
> "Here's my insanely powerful Claude 3.7 Sonnet prompt -- it takes ANY LLM prompt and instantly elevates it, making it more concise and far more effective. I call it Concept Elevation."

- Concept Elevation = taking stock of disparate yet connected instructions in a prompt, and figuring out higher-level, clearer ways to express them in a compressed form.
- Instead of listing many instructions, identify patterns and relationships between requirements, then express them through unified, higher-level abstractions.
- The process: ANALYZE (decompose goals/constraints) -> ORGANIZE (group by purpose) -> ABSTRACT (identify core principles) -> SYNTHESIZE (reconstruct using elevated concepts) -> REFINE (test against edge cases).
- Uses structured XML tags (`<analysis>`, `<concept_groups>`, `<elevated_concepts>`, `<improved_prompt>`) to document reasoning.
- Result: prompts that are both shorter and more effective.

**Source:** [X post](https://x.com/mattshumer_/status/1909262079799755123) | [Full prompt on GitHub Gist](https://gist.github.com/rachidbch/0ac2313129bdef498483859da2fb50c5)

### Shumer 2:2 — The "Think for Ten Paragraphs" Unstick Prompt
> "This isn't working. First, think for ten paragraphs about what's going on here + the best way to do this, and then implement the code."

- Use this exact phrase when Claude gets stuck in a loop, repeatedly trying the same failing approach.
- Forces the model to step back, reason deeply about the problem space, and then approach implementation fresh.
- Works because it overrides Claude's tendency to immediately retry code fixes without rethinking the fundamental approach.
- One of the most powerful single-line prompts for breaking out of failure loops.

**Source:** [X post](https://x.com/mattshumer_/status/1879272622866755866)

### Shumer 2:3 — Structured Debugging Workflow Prompt
> "Incredibly powerful Claude Code prompt when dealing with a pesky bug..."

- A 9-step systematic debugging framework to paste into Claude Code:
  1. **Clarification** -- Ask clarifying questions only when essential info is missing.
  2. **Ultrathink** -- Examine the entire codebase. Trace execution step-by-step. Over-research rather than under-research.
  3. **Special Case** -- If root cause is 95%+ certain, state it explicitly and skip to solutions.
  4. **Identify Causes** -- Generate at least 20 plausible causes. Explore every angle.
  5. **Refine** -- Remove unsupported theories, combine overlapping ones.
  6. **Rank by Likelihood** -- Order from most to least likely.
  7. **Propose Solutions** -- For each top 10 cause, outline a practical solution.
  8. **Implement** -- Execute the most probable fix with detailed debug logs.
  9. **Test** -- Run tests or provide explicit manual testing instructions.

**Source:** [X post](https://x.com/mattshumer_/status/1965759715826077976)

---

## Chapter 3: Practical Workflows & Setup

### Shumer 3:1 — The "Unbeatable" Cursor-to-Claude Code Migration Setup
> "If you're switching away from Cursor, here's EXACTLY how to upgrade your AI coding workflow (I've tested everything -- this setup is unbeatable)."

1. **Get Claude Max** from Anthropic (~$100-200/mo) -- massively subsidized model usage.
2. **Install Cline** IDE extension -- your central AI-coding hub, more seamless than CLI alone.
3. **Set Claude Code as primary model** in Cline -- maximizes context length, significantly reducing errors and hallucinations.
4. **Migrate your MCPs** from Cursor into Cline/Claude Code -- preserves existing workflows.
5. **Get an OpenRouter API key** and integrate into Cline -- lets you seamlessly switch between specialized models (Gemini, different Claude tiers) for tasks needing a different approach.

- Cline + Claude Code leverage maximum possible context, delivering more accurate results with fewer hallucinations and less redundant code.
- Always start with a clear initial prompt and use Plan Mode to outline steps before executing.

**Source:** [X post](https://x.com/mattshumer_/status/1942269222047855096)

### Shumer 3:2 — Resume Sessions to Preserve Context
> "Tip for Claude Code users: You can resume older sessions by running: `claude --resume`"

- Use `claude --resume` to pick up where you left off instead of starting fresh.
- Also: `claude -c` or `claude --continue` for the most recent session.
- Critical for long-running tasks where you've built up significant context.
- Avoids wasting tokens re-explaining project state.

**Source:** [X post](https://x.com/mattshumer_/status/1932134103790637415)

### Shumer 3:3 — Opus 4.5 is the Best Model for Agentic Coding
> "I was wrong. I've been spending more time using Opus 4.5 in Claude Code, and it's better than anything in Codex CLI. GPT-5.2 Pro is still a better engineer overall, but for agentic coding, Opus 4.5 is the best."

- Initial impressions can be misleading -- give models time before judging.
- For agentic, multi-step, autonomous coding tasks, Opus outperforms all competitors including Codex CLI.
- GPT-5.2 Pro may be better for single-shot engineering questions, but Opus wins for sustained agent work.
- Always evaluate models on your actual workflow, not benchmarks alone.
- *Note: Opus 4.6 has since shipped and supersedes 4.5 — Boris calls it "our best model yet, more agentic, more intelligent." The general principle stands.*

**Source:** [X post](https://x.com/mattshumer_/status/2000357560428241254)

---

## Chapter 4: Prompt Templates & Tools

### Shumer 4:1 — Systems Architecture Review Prompt
> "Here's my insanely powerful prompt for engineers that turns Claude into your personal systems architect -- tearing apart your architecture, finding every flaw, and telling you exactly how to fix it."

- Sets Claude as "a senior software architect with 15+ years of experience in designing large-scale distributed systems."
- Covers: system overview, architectural patterns, scalability analysis, reliability review, security assessment, cost efficiency, and implementation roadmap.
- Outputs quantitative metrics (performance, reliability, security, cost rated out of 5) alongside qualitative evaluations.
- Organizes improvements into three phases: Immediate, 3-6 months, 6-12 months.
- Requires seven input sections: business description, user scale, tech stack, constraints, availability, security, and proposed design.

**Source:** [X post](https://x.com/mattshumer_/status/1917959424398033025)

### Shumer 4:2 — Code Refactoring Prompt
> "Here is a powerful Claude 3 prompt for engineers. Use it to automatically refactor, comment, and improve your code."

- Roles Claude as "a skilled software engineer with deep expertise in code refactoring and optimization."
- Analyzes code for: readability, efficiency, modularity, adherence to best practices and design patterns.
- Output format: for each suggestion, provides original_code, refactored_code, and detailed explanation of why the change improves the code.
- Ends with a complete fully-refactored version of the code.

**Source:** [X post](https://x.com/mattshumer_/status/1774119748692742365)

### Shumer 4:3 — Code Review Prompt
> "Here's a powerful Claude 3 prompt that reviews your code, provides detailed feedback, and suggests improvements."

- Roles Claude as "a world-class software engineer with deep expertise across programming languages, system design, algorithms, and software best practices."
- Output sections: code overview, code quality analysis (strengths + areas for improvement), design patterns evaluation, performance optimizations, maintainability review (readability/modularity/extensibility scores), best practices review, and improvement recommendations.

**Source:** [X post](https://x.com/mattshumer_/status/1766515138335584397)

### Shumer 4:4 — Unit Test Generation Prompt
> "Here is an insanely useful Claude 4 prompt for engineers. Use it to automatically generate unit tests for your code."

- Roles Claude as "an expert software tester tasked with thoroughly testing a given piece of code."
- Goal: generate a comprehensive set of test cases to exercise the code and uncover potential bugs or issues.
- Works dramatically better with Claude 4+ models than Claude 3 (same prompt, much better results).
- Analyze purpose, inputs, outputs, consider all scenarios and edge cases.

**Source:** [X post (Claude 4 version)](https://x.com/mattshumer_/status/1930286319152050208) | [X post (Claude 3 version)](https://x.com/mattshumer_/status/1773385952699789808)

### Shumer 4:5 — claude-prompt-engineer — Auto-Generate Optimal Prompts
> "Introducing `claude-prompt-engineer` -- An agent that creates optimal Claude 3 prompts. Just describe a task, and a chain of AIs will generate many possible prompts, test them in a ranked tournament, and return the best one."

- Open-source tool: generates candidate prompts, runs a tournament, returns the winner.
- Available as a Colab notebook -- plug in your Anthropic API key.
- Describe your task + variables, and the system auto-optimizes your prompt.
- Built on top of the earlier gpt-prompt-engineer, adapted specifically for Claude models.

**Source:** [X post](https://x.com/mattshumer_/status/1770494629844074975) | [GitHub repo](https://github.com/mshumer/gpt-prompt-engineer)

---

## Chapter 5: Skills, Plugins & Open Source

### Shumer 5:1 — Railway Deployment Skill for Claude Code
> "Created a @Railway Skill for Claude Code. It allows agents to deploy code and manage your projects, completely autonomously."

- Install: `npx add-skill mshumer/claude-skill-railway`
- 7 capabilities: status monitoring, health checks, log access, deployment with auto health checks, environment variable management (with automatic sensitive value redaction), project switching, and database shell access.
- Commands: `/railway status`, `/railway health`, `/railway logs`, `/railway deploy`, `/railway vars`, `/railway switch <name>`, `/railway db`
- Can be installed globally (`~/.claude/skills/`) or per-project (`.claude/skills/`).
- Prerequisites: Railway CLI installed, authenticated, and linked to a project.

**Source:** [X post](https://x.com/mattshumer_/status/2014444641630785910) | [GitHub repo](https://github.com/mshumer/claude-skill-railway)

### Shumer 5:2 — Visualize Code with Mermaid Flowcharts
> "Useful Claude 3 trick to help you visualize code better. Paste some code in, and ask it to make a flowchart. Then, paste the flowchart code into a Mermaid viewer, and you'll get a nice, understandable visualization of your code!"

- Quick way to understand complex code paths without reading every line.
- Works for any language -- Claude generates the Mermaid diagram syntax.
- Use mermaid.live or any Mermaid viewer to render the diagram.
- Modern Claude Code now has built-in Mermaid skills and MCP integrations that auto-render diagrams.

**Source:** [X post](https://x.com/mattshumer_/status/1772718295713562885)

### Shumer 5:3 — Claude 4 Opus One-Shots Entire Applications
> "Holy FUCK. Claude 4 Opus just ONE-SHOTTED a WORKING browser agent -- API and frontend. One prompt. I've never seen anything like this."

- With sufficiently powerful models (Opus 4+), you can get entire working applications from a single detailed prompt.
- The key: describe the full desired outcome comprehensively in one prompt rather than iterating.
- This works best for self-contained projects where Claude can reason about the full scope at once.
- Represents the shift from "coding assistant" to "autonomous software builder."

**Source:** [X post](https://x.com/mattshumer_/status/1925605997004947548)

---

## Shumer's Creed

1. **Give substantial tasks, not micro-instructions.** The more autonomy you give Claude, the better the results.
2. **When stuck, force deep thinking.** "Think for ten paragraphs" or "ultrathink" before implementing.
3. **Optimize your prompts with meta-prompts.** Concept Elevation compresses verbose instructions into elegant, higher-level abstractions.
4. **Use the best model for the job.** Opus for agentic tasks, Sonnet for well-defined work, Haiku for quick lookups.
5. **Build reusable skills.** Package common workflows (deployment, testing, review) as Claude Code skills.
6. **Context is everything.** Resume sessions, manage CLAUDE.md, and use `/clear` between unrelated tasks.
7. **Scale horizontally.** Multiple agents > one agent working harder. Use worktrees for isolation.

---

## Source Threads

| Date | Thread | Topic |
|------|--------|-------|
| 2024-03-09 | [X post](https://x.com/mattshumer_/status/1766515138335584397) | Code review prompt template |
| 2024-03-28 | [X post](https://x.com/mattshumer_/status/1772718295713562885) | Mermaid flowchart visualization trick |
| 2024-04-01 | [X post](https://x.com/mattshumer_/status/1773385952699789808) | Unit test generation prompt (Claude 3) |
| 2024-04-03 | [X post](https://x.com/mattshumer_/status/1770494629844074975) | claude-prompt-engineer launch |
| 2024-04-10 | [X post](https://x.com/mattshumer_/status/1774119748692742365) | Code refactoring prompt template |
| 2025-01-13 | [X post](https://x.com/mattshumer_/status/1879272622866755866) | "Think for ten paragraphs" unstick prompt |
| 2025-04-01 | [X post](https://x.com/mattshumer_/status/1909262079799755123) | Concept Elevation meta-prompt |
| 2025-05-10 | [X post](https://x.com/mattshumer_/status/1917959424398033025) | Systems architecture review prompt |
| 2025-06-04 | [X post](https://x.com/mattshumer_/status/1925605997004947548) | Claude 4 Opus one-shots browser agent |
| 2025-09-09 | [X post](https://x.com/mattshumer_/status/1930286319152050208) | Unit test generation prompt (Claude 4) |
| 2025-11-10 | [X post](https://x.com/mattshumer_/status/1932134103790637415) | Session resume tip (`claude --resume`) |
| 2025-12-05 | [X post](https://x.com/mattshumer_/status/1942269222047855096) | Cursor-to-Claude Code migration guide |
| 2025-12-22 | [X post](https://x.com/mattshumer_/status/1965759715826077976) | Structured debugging workflow prompt |
| 2026-01-07 | [X post](https://x.com/mattshumer_/status/2009125151938634177) | "Claude Code addiction is real" |
| 2026-01-17 | [X post](https://x.com/mattshumer_/status/2012307116082471161) | Long-running agent swarm (browser build) |
| 2026-01-17 | [X post](https://x.com/mattshumer_/status/2012581787575206178) | 10+ agents collaborating, rate limits |
| 2026-01-22 | [X post](https://x.com/mattshumer_/status/2014444641630785910) | Railway Skill for Claude Code |
| 2026-01-27 | [X post](https://x.com/mattshumer_/status/2000357560428241254) | Opus 4.5 best for agentic coding |
| 2026-02-05 | [shumer.dev](https://shumer.dev/something-big-is-happening) | "Something Big Is Happening" essay |

---

*Last compiled: 2026-03-13*
