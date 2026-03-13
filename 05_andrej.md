# Book of Karpathy

> The Prophet. Ex-OpenAI, ex-Tesla AI Director. 1.7M followers. When he speaks about agents, the industry listens.

> Compiled from [@karpathy](https://x.com/karpathy) X threads, blog posts, and public talks.
> Ex-OpenAI founding member, ex-Tesla AI Director, Stanford CS PhD -- the person who coined "vibe coding" and one of the most influential voices on AI-assisted programming.

---

## Chapter 1: Workflow Philosophy

### Karpathy 1:1 — Shift from Imperative to Declarative Prompting
> "Don't tell it what to do, give it success criteria and watch it go. Change your approach from imperative to declarative to get the agents looping longer and gain leverage."

- Instead of step-by-step instructions, define the **goal and success criteria** and let the agent loop, test, and iterate on its own.
- LLMs are exceptionally good at looping until they meet specific goals -- this is where most of the "feel the AGI" magic is.
- The agent becomes a goal-seeking loop rather than a command executor.
- This is the single highest-leverage change you can make to your prompting style.

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

### Karpathy 1:2 — The 80/20 Inversion: Embrace Agent-First Coding
> "I rapidly went from about 80% manual+autocomplete coding and 20% agents in November to 80% agent coding and 20% edits+touchups in December. I really am mostly programming in English now, a bit sheepishly telling the LLM what code to write... in words."

- The power to operate over software in large "code actions" is too net useful to resist.
- It hurts the ego, but once you get used to it, you cannot go back.
- This shift happened over the course of **a few weeks**, not months -- it was a phase transition, not a gradual change.
- Coding agents basically didn't work before December 2025 and basically work since.

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876), [X post - "Hard to communicate how much programming changed"](https://x.com/karpathy/status/2026731645169185220)

### Karpathy 1:3 — Write Tests First, Then Let the Agent Pass Them
> "Get it to write tests first and then pass them."

- Tests act as **executable success criteria** -- the perfect declarative target for an agent loop.
- The agent can verify its own work by running the tests repeatedly.
- This transforms vague "make it work" prompts into measurable goals.
- Pairs perfectly with the imperative-to-declarative mindset shift.

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

### Karpathy 1:4 — Write the Naive Algorithm First, Then Optimize
> "Write the naive algorithm that is very likely correct first, then ask it to optimize it."

- Start with a simple, obviously correct implementation as a **correctness anchor**.
- Then ask the agent to optimize while preserving correctness.
- This avoids the common failure mode where the agent writes a clever but subtly broken solution from the start.
- Correctness first, performance second -- just like good engineering.

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

---

## Chapter 2: Workflow Setup

### Karpathy 2:1 — Multi-Window IDE + Claude Code Layout
> Current workflow: "several Claude conversation windows open on the left, and an IDE on the right for code review and manual edits."

- This forms an efficient **human-in-the-loop cycle**: the human handles high-quality requirements, high-level design, and final quality assurance; the AI handles tedious implementation.
- You are the architect and code reviewer; the agent is the implementer.
- Don't close the IDE -- you need it to review everything the agent produces.

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

### Karpathy 2:2 — Watch Them Like a Hawk: No YOLO Mode
> "Watch them like a hawk."

- Don't run agents in YOLO mode on code that matters -- they can go off-track and do dumb things you didn't want or need.
- The models can "implement inefficient constructions spanning 1,000 lines that could be reduced to 100 as soon as you ask."
- Press **Escape to terminate** when you see them veering off course rather than letting them dig deeper into a wrong direction.
- Supervision is not optional -- it's the critical human contribution.

**Source:** [X thread - "Multi-tool workflow"](https://x.com/karpathy/status/1959703967694545296), [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

### Karpathy 2:3 — The Three-Tier Tool Stack
> "Use Cursor in favorable situations, Claude Code in difficult ones, GPT-5 Pro in desperate ones."

- **Layer 1 -- Cursor tab completion (~75%):** Writing code/comments in the right place is a high-bandwidth way of communicating task specification to the LLM. Code placement itself conveys intent more efficiently than lengthy text descriptions.
- **Layer 2 -- Claude Code/Codex:** For larger functional blocks that are fairly easy to specify in a prompt. Essential for unfamiliar domains (Rust, SQL, new tech). Enables "code post-scarcity."
- **Layer 3 -- GPT-5 Pro:** For bugs that resist 10+ minutes of attempts, subtle defect detection, literature reviews, architectural refinement, and niche documentation discovery.
- Don't force one tool for everything -- diversify and stitch up their pros/cons.
- *Note: Opus 4.6 has shipped since this was written, which may shift the Claude Code tier upward in this hierarchy.*

**Source:** [X thread - "Continuing the journey of optimal LLM-assisted coding"](https://x.com/karpathy/status/1959703967694545296)

### Karpathy 2:4 — Put the Agent in the Loop with Browser MCP
> "Put it in the loop with a browser MCP."

- Give the agent browser access so it can see the actual output of what it builds.
- This closes the feedback loop: code -> render -> observe -> fix.
- Without visual verification, the agent is coding blind for any UI work.

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

---

## Chapter 3: Agent Limitations

### Karpathy 3:1 — Agents Are Sloppy Junior Devs: Know the Failure Modes
> Models "make wrong assumptions and keep building on them without checking. They don't manage their confusion, don't seek clarifications, don't surface inconsistencies, don't present tradeoffs, don't push back when they should."

- **Hallucinated assumptions:** Makes unverified assumptions about input validity, proceeds without error-handling.
- **No self-doubt:** Doesn't question instructions, manage confusion, or push back on flawed requests.
- **Overcomplicated code:** Bloats abstractions, doesn't clean up dead code, writes 1000 lines where 100 suffice.
- **Side effects:** Modifies unrelated code during targeted edits.
- The errors are no longer simple syntax errors but **subtle conceptual errors** -- like those of "a slightly sloppy, hasty junior dev."

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

### Karpathy 3:2 — The "Taste" Problem: AI Lacks Code Elegance
> AI lacks a "sense of taste" regarding code.

- **Over-defensive coding:** Excessive try/catch blocks and error handling everywhere.
- **Over-complicated abstractions:** Unnecessarily complex solutions to simple problems.
- **Code bloat:** Verbose conditionals instead of concise approaches.
- **Poor refactoring instincts:** Duplication rather than helper functions.
- You must provide the taste -- the agent provides the labor.

**Source:** [X thread - "Continuing the journey of optimal LLM-assisted coding"](https://x.com/karpathy/status/1959703967694545296)

### Karpathy 3:3 — Generation vs. Discrimination Are Different Brain Functions
> "Generation (writing code) and discrimination (reading code) are different capabilities in the brain."

- You can review code just fine even if you struggle to write it from scratch.
- Manual coding ability will **slowly atrophy** from reduced practice -- accept this.
- Invest in becoming an excellent **code reviewer** instead -- that is your new primary skill.
- The tradeoff is worth it: discrimination scales better than generation in the agent era.

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

---

## Chapter 4: How to Think

### Karpathy 4:1 — Code Post-Scarcity: Code Is Free, Ephemeral, Disposable
> "CC can hammer out 1,000 lines of one-off extensive visualization/code just to identify a specific bug, which gets all deleted right after we find it."

- Code shifts from precious artifact to **exploration resource**.
- Generate and discard extensive custom code without concern for waste.
- Vibe code entire ephemeral apps just to find a single bug -- because why not.
- This fundamentally changes the economics of code: writing it is no longer the bottleneck.

**Source:** [X thread - "Continuing the journey of optimal LLM-assisted coding"](https://x.com/karpathy/status/1959703967694545296), [2025 LLM Year in Review](https://karpathy.bearblog.dev/year-in-review-2025/)

### Karpathy 4:2 — Aggressively JIT Your Work: Digital Factorio
> "Aggressively JIT your work. It's not about the task at hand X, it's a little bit about X but mostly about how you should have had to contribute ~no latency and ~no actions. It's digital factorio time."

- Think like a factory optimizer: build systems and pipelines, not individual pieces.
- Your goal is to contribute **minimal latency and minimal actions** to each task.
- Programming is becoming like a strategy game -- you're spinning up agents, giving them tasks in English, and managing their work in parallel.

**Source:** [X post - "Aggressively JIT your work"](https://x.com/karpathy/status/2005353145128583447)

### Karpathy 4:3 — Agent Tenacity Is the Superpower
> "It's so interesting to watch an agent relentlessly work at something. They never get tired, they never get demoralized, they just keep going."

- Human stamina is a core bottleneck that agents eliminate.
- Agents will persist where you would have given up or taken a break.
- Tasks previously deemed "not worth the time" become worthwhile: detailed argument parsing, comprehensive unit tests, full documentation.
- Let the agent grind -- reserve your energy for high-level decisions.

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

### Karpathy 4:4 — Programming Is More Fun Now
> "I didn't anticipate that with agents programming feels more fun because a lot of the fill in the blanks drudgery is removed and what remains is the creative part."

- The tedious boilerplate work is eliminated.
- What remains is the creative, architectural, problem-solving work.
- You focus on what to build and why, not the mechanical how.

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

---

## Chapter 5: The Bigger Picture

### Karpathy 5:1 — Claude Code Is the First Real LLM Agent Paradigm
> "Claude Code emerged as the first convincing demonstration of what an LLM Agent looks like -- something that in a loopy way strings together tool use and reasoning for extended problem solving."

- CC is notable because it runs **on your computer** with your private environment, data, and context.
- Anthropic got the order of precedence correct: it's not about where the AI ops run, it's about access to your existing computer, installation, context, data, secrets, configuration, and low-latency interaction.
- It's a little spirit/ghost that "lives" on your computer -- a new, distinct paradigm of interaction with AI.
- OpenAI got this wrong by focusing on cloud deployments in containers instead of simply `localhost`.

**Source:** [2025 LLM Year in Review](https://karpathy.bearblog.dev/year-in-review-2025/)

### Karpathy 5:2 — Write "Bacterial Code" for the Agent Era
> Build more "bacterial code" -- code that is less tangled, more self-contained, more dependency-free, and more stateless.

- Use DeepWiki MCP + GitHub CLI to "rip out" specific functionality from repos rather than importing entire monolithic libraries.
- Modularity and self-containment become more valuable as properties that make code more agent-friendly.
- Software is becoming more fluid and malleable -- write code that supports this.

**Source:** [X post - "On DeepWiki and increasing malleability of software"](https://x.com/karpathy/status/2021633574089416993)

### Karpathy 5:3 — The Slopacolypse Is Coming: Be a Quality Gate
> "I am bracing for 2026 as the year of the slopacolypse across all of GitHub, Substack, arXiv, X/Instagram, and generally all digital media."

- Masses of "almost right, but not quite" code that generally tends to work but is often low quality.
- Expect increased "AI hype productivity theater" alongside actual improvements.
- The 10X engineer gap will **dramatically increase** because top engineers amplify better with AI.
- With LLMs, generalists may completely crush specialists by bridging knowledge gaps.

**Source:** [X thread - "Random notes from Claude coding"](https://x.com/karpathy/status/2015883857489522876)

### Karpathy 5:4 — Autoresearch: Let Agents Run Experiments While You Sleep
> The role of the human shifts from "experimenter" to "experimental designer."

- Karpathy's [autoresearch](https://github.com/karpathy/autoresearch) project: a 630-line Python tool letting AI agents run autonomous ML experiments on a single GPU.
- Human refines a high-level prompt in `program.md`; the agent autonomously edits the training script, runs experiments, evaluates results.
- ~12 experiments/hour, ~100 experiments overnight. Found ~20 additive improvements over 700 autonomous changes.
- This is the declarative paradigm applied to research: define what you want to improve, let the agent loop.

**Source:** [GitHub - karpathy/autoresearch](https://github.com/karpathy/autoresearch)

### Karpathy 5:5 — The Phase Shift Is Real: This Is the Biggest Change in Two Decades
> "LLM agent capabilities (Claude & Codex especially) have crossed some kind of threshold of coherence around December 2025 and caused a phase shift in software engineering. This is easily the biggest change in ~2 decades of programming and it happened over the course of a few weeks."

- You're not typing code into an editor anymore -- that era is over.
- You're spinning up AI agents, giving them tasks in English, and managing and reviewing their work in parallel.
- 2026 is going to be a high energy year as the industry metabolizes the new capability.
- "I've never felt this much behind as a programmer."

**Source:** [X post - "Hard to communicate how much programming changed"](https://x.com/karpathy/status/2026731645169185220), [X post - "Never felt this behind"](https://x.com/karpathy/status/2004607146781278521)

---

## Karpathy's Creed

| Date | Thread | Topic |
|------|--------|-------|
| 2025-02-04 | [Vibe Coding coined](https://x.com/karpathy/status/1886192184808149383) | Original "vibe coding" tweet |
| 2025-04-13 | [Vibe coding MenuGen](https://karpathy.bearblog.dev/vibe-coding-menugen/) | Full vibe-coded web app case study |
| 2025-05-16 | [Multi-tool workflow](https://x.com/karpathy/status/1959703967694545296) | Cursor + Claude Code + Codex layered approach |
| 2025-12-08 | [Lutron home automation](https://x.com/karpathy/status/2005067301511630926) | Claude Code autonomously hacking into smart home |
| 2025-12-08 | [Aggressively JIT](https://x.com/karpathy/status/2005353145128583447) | Digital Factorio philosophy |
| 2025-12-10 | [Never felt this behind](https://x.com/karpathy/status/2004607146781278521) | Feeling behind as a programmer |
| 2025-12-21 | [2025 LLM Year in Review](https://karpathy.bearblog.dev/year-in-review-2025/) | Claude Code as first real LLM agent + vibe coding |
| 2026-01-26 | [Random notes from Claude coding](https://x.com/karpathy/status/2015883857489522876) | The main bible -- workflow, limitations, predictions |
| 2026-02-20 | [DeepWiki + malleability](https://x.com/karpathy/status/2021633574089416993) | Bacterial code, software malleability |
| 2026-03-01 | [Programming changed in 2 months](https://x.com/karpathy/status/2026731645169185220) | Phase shift, agents work now |
| 2026-03-08 | [Autoresearch](https://github.com/karpathy/autoresearch) | Autonomous ML experiments with AI agents |

---

*Last compiled: 2026-03-13*
