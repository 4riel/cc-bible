# The Ten Commandments of Claude Code

> 10 experts. 202 tips. These are the 10 things they all say independently.

---

## I. Plan Before You Code

9 out of 10 experts say this. The only one who doesn't is Pieter Levels — his whole thing is skipping ceremony.

Enter plan mode (`Shift+Tab` twice, `/plan`, or `--permission-mode plan`) before writing anything. Go back and forth with Claude until the plan is solid, then switch to auto-accept and let it one-shot the implementation. If something breaks mid-way, don't push through — go back to plan mode and re-plan.

Boris has one Claude write the plan and a second Claude review it as a staff engineer. Cat Wu says plan mode 2-3x your success rate on complex tasks. Pocock calls it "night and day."

---

## II. Give Claude a Feedback Loop

This is Boris's #1 tip. He says it 2-3x the quality of the final result — and he means literally, not as a figure of speech.

The idea: Claude needs a way to check if its code actually works. Tests, linters, build commands, browser testing, screenshots — anything that gives it a yes/no signal. Without this, Claude produces code that looks right but silently breaks. With it, Claude iterates until the code provably works.

Pocock takes this further with TDD — write the failing test first, then let Claude implement until it passes. "Pretty hard to cheat for an LLM."

---

## III. Run Multiple Claude Sessions in Parallel

Boris calls this "the single biggest productivity unlock" and the top tip from the entire Claude Code team.

The setup: 3-5 git worktrees, each running its own Claude session. One writes a feature, another fixes bugs, a third does code review. They don't conflict because each worktree is an isolated copy of the repo. Boris runs 5 terminal sessions + 5-10 web sessions simultaneously.

Use `claude --worktree` to start a session in its own worktree. Create shell aliases (`za`, `zb`, `zc`) to switch between them. Set up system notifications so you know when Claude needs input.

---

## IV. Invest in Your CLAUDE.md

Boris's team shares one CLAUDE.md per repo, checked into git. The whole team contributes multiple times a week. Whenever Claude does something wrong, they add a rule so it doesn't happen again. They call it "Compounding Engineering" — Claude trains itself on its own failures over time.

The trick: after every correction, tell Claude "Update your CLAUDE.md so you don't make that mistake again." Boris says Claude is eerily good at writing rules for itself.

But keep it lean. Cat Wu warns that bloated CLAUDE.md files cause Claude to ignore your actual instructions. Pocock says to sacrifice grammar for conciseness. Every line should answer: "Would removing this cause Claude to make a mistake?"

---

## V. Guard Your Context Window

Cat Wu puts it simply: "Most best practices come down to one constraint — Claude's context fills up fast, and performance degrades as it fills."

Every file Claude reads, every error message, every back-and-forth correction eats context. Once it's full, Claude gets dumber — it forgets earlier instructions, makes wrong assumptions, and loops on problems it already solved.

What to do: use `/clear` between unrelated tasks. Use `/compact` at logical milestones. Delegate file reading to subagents so your main context stays clean. If you've corrected Claude more than twice on the same thing, don't correct it a third time — start a fresh session with a better prompt.

Elvis found a hack that cuts token usage by ~90% by running MCP tools through bash instead of loading them into the system prompt.

---

## VI. Use Subagents

Subagents are separate Claude instances that run a task and report back a summary. They have their own context window, so they don't pollute yours.

Boris says: append "use subagents" to any request where you want Claude to throw more compute at the problem. Cat Wu uses them for exploration — "subagents read files and report back summaries without cluttering your main conversation." Alex Albert describes a map-reduce pattern: primary agent generates a to-do list, 10 subagents execute in parallel.

The key insight from Affaan: each subagent should get ONE clear input and produce ONE clear output. Give orchestrator agents broad tool access; give specialized agents only what they need.

---

## VII. Turn Repetitive Work into Skills and Commands

If you do something more than once a day, turn it into a skill. Store them in `.claude/skills/`, commit to git. (`.claude/commands/` still works but is the legacy path — skills are the recommended abstraction.)

Boris uses a `/commit-push-pr` command dozens of times every day. Elvis says skills are the #1 way to steer Claude Code. Thariq says skills are the more powerful abstraction — they subsume everything slash commands did. Pocock maintains a public repo with 16 installable skills including TDD, git guardrails, and PRD-to-issues.

Skills load on-demand (saving context), encode procedural knowledge that persists across sessions, and get better as models improve. Your skills library is compounding value.

---

## VIII. Let Claude Interview You Before Building

For complex features, don't write a giant prompt. Give Claude a one-liner and tell it to interview you.

Thariq says for complex features, expect 40+ questions. The interview surfaces decisions you didn't know you were making and edge cases you'd discover halfway through implementation. Cat Wu says to start with a minimal prompt and let Claude ask about architecture, edge cases, and tradeoffs.

Once the interview produces a complete spec, open a fresh session to execute it. Clean context, zero interview noise, just the spec and a plan.

---

## IX. Force Deeper Thinking When Claude Gets Stuck

When Claude loops or produces mediocre output, the problem is usually that it's not thinking hard enough. You can fix this literally — by telling it to think more.

Cat Wu: put "think" in your prompt to trigger extended thinking. Use `/effort` to control thinking depth (low/medium/high) — default is now medium, not high. "ultrathink" in a prompt bumps that single turn to high effort. Shumer's technique when stuck: "This isn't working. First, think for ten paragraphs about what's going on here, and then implement the code."

Pocock's version: always ask for 2 implementation plans. Agents greedily sample the first plan that comes to mind — forcing alternatives often produces better architecture. Karpathy says to write the naive algorithm first (the one that's likely correct), then ask Claude to optimize.

---

## X. Describe the Outcome, Not the Steps

Tell Claude what you want, not how to get there. Give it the destination and the success criteria, then get out of the way.

Karpathy calls this shifting from imperative to declarative: define the goal and let the agent loop. Boris says "just say 'Go fix the failing CI tests' — don't micromanage how." Shumer walks away for four hours and comes back to finished features. Levels says the bottleneck is his creativity, not how fast he can ship.

The models are better at finding creative solutions when you don't constrain their approach. Your job is to define what "done" looks like. Claude's job is to figure out how to get there.

---

*Cross-referenced from all 10 Books of the CC Bible · 2026-03-13*
