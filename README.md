![Tips](https://img.shields.io/badge/tips-202-blue)
![Experts](https://img.shields.io/badge/experts-10-green)
![License](https://img.shields.io/badge/license-CC%20BY--SA%204.0-lightgrey)

# The CC Bible

In the beginning, there was the terminal. And the terminal was without form, and void. And darkness was upon the face of the codebase.

And Boris said: *"Let there be Claude Code."*

And there was Claude Code. And Boris saw the code, and it was good. And he separated the plan from the implementation, and the worktree from the main branch. And there was evening, and there was morning — the first commit.

And developers from every land came and said: *"How do we use this thing?"*

And so the prophets spoke. And their wisdom was gathered here.

---

**202 tips. 10 books. 10 commandments.** Sourced from X threads, talks, podcasts, and interviews. Every tip links to the original post.

---

## Table of Contents

- [The Ten Commandments](#the-ten-commandments)
- [The Builders](#the-builders) — Boris, Thariq, Alex, Cat
- [The Disciples](#the-disciples) — Karpathy, Shumer, Elvis, Levels, Pocock, Affaan
- [The Plugin](#the-commandments-plugin) — Install the commandments as Claude Code artifacts

---

## The Ten Commandments

[00_the_ten_commandments.md](00_the_ten_commandments.md) — The 10 things all experts independently agree on.

---

## The Builders

[Book of Boris](01_boris.md) — **Boris Cherny** · [@bcherny](https://x.com/bcherny) · [GitHub](https://github.com/anthropics)
The Creator. Built Claude Code. 259 PRs in 30 days, every line by Claude. 29 verses.

[Book of Thariq](02_thariq.md) — **Thariq Shihipar** · [@trq212](https://x.com/trq212)
The Architect. Anthropic engineer. Prompt caching, agent internals, game engine mental model. 20 verses.

[Book of Alex](03_alex.md) — **Alex Albert** · [@alexalbert__](https://x.com/alexalbert__)
The Evangelist. Head of Claude Relations. Published Anthropic's internal patterns. 18 verses.

[Book of Cat](04_cat.md) — **Cat Wu** · [@_catwu](https://x.com/_catwu)
The Shepherd. PM for Claude Code. Wrote the official best practices guide. 18 verses.

## The Disciples

[Book of Karpathy](05_andrej.md) — **Andrej Karpathy** · [@karpathy](https://x.com/karpathy) · [GitHub](https://github.com/karpathy)
The Prophet. Ex-OpenAI, ex-Tesla. 1.7M followers. Went from 80% manual to 80% agent. 20 verses.

[Book of Shumer](06_matt_s.md) — **Matt Shumer** · [@mattshumer_](https://x.com/mattshumer_) · [GitHub](https://github.com/mshumer)
The Sorcerer. CEO OthersideAI. 10+ agent swarms. Walks away for 4 hours. 17 verses.

[Book of Elvis](07_elvis.md) — **Elvis Saravia** · [@omarsar0](https://x.com/omarsar0) · [GitHub](https://github.com/omarsar)
The Optimizer. DAIR.AI. Cut tokens by 90%. Skills are his religion. 24 verses.

[Book of Levels](08_pieter.md) — **Pieter Levels** · [@levelsio](https://x.com/levelsio) · [GitHub](https://github.com/levelsio)
The Heretic. Codes on production. Ships from his phone. No deployment pipeline. 17 verses.

[Book of Pocock](09_matt_p.md) — **Matt Pocock** · [@mattpocockuk](https://x.com/mattpocockuk) · [GitHub](https://github.com/mattpocock)
The Craftsman. Total TypeScript. Tests before he builds. 9 rules. 14 verses.

[Book of Affaan](10_affaan.md) — **Affaan Mustafa** · [@affaanmustafa](https://x.com/affaanmustafa)
The Scribe. Everything Claude Code (42K+ stars). 14 agents, 28 skills, 30 commands. 25 verses.

---

## The Commandments Plugin

The wisdom doesn't have to stay on the page. **[The Commandments Plugin](cc-bible-plugin/)** turns the Ten Commandments into installable Claude Code artifacts — 11 commands, 4 agents, 3 skills, 2 hooks.

```bash
# Install globally
ln -s /path/to/cc-bible/cc-bible-plugin ~/.claude/plugins/local/cc-bible-plugin
```

| Command | Commandment | What it does |
|---------|-------------|--------------|
| `/plan-first` | I | Plan before coding |
| `/feedback-loop` | II | Auto-detect and run verification |
| `/tdd` | II | Test-driven development (RED-GREEN-REFACTOR) |
| `/compounding-eng` | IV | Capture corrections as CLAUDE.md rules |
| `/compact-strategic` | V | Smart compaction with state preservation |
| `/review` | II + VI | Code review via subagent |
| `/research` | VI | Deep exploration in isolated context |
| `/interview` | VIII | Claude interviews you before building |
| `/unstick` | IX | 4 escalating techniques when stuck |
| `/debug` | IX | Systematic 9-step debugging |
| `/setup` | III + VII + X | Bootstrap project with best practices |

See the [plugin README](cc-bible-plugin/README.md) for full details.

---

*Compiled 2026-03-13 · All tips sourced from public X threads, talks, and interviews.*
