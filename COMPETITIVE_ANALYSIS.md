# CC Bible — Competitive Analysis

> Compiled 2026-03-13. Landscape of curated Claude Code knowledge resources.

---

## Summary

The CC Bible (10 experts, 202 tips, Bible verse format, Ten Commandments) occupies a **unique niche** in the Claude Code ecosystem. There are many repos that aggregate tools, skills, and how-to guides — but **none** combine multi-expert wisdom curation with a creative literary format. The closest competitor in concept is `howborisusesclaudecode.com`, but it's single-author. The closest in scale is `everything-claude-code`, but it's a plugin system, not a wisdom document.

No one has done the Bible format. No one has cross-referenced 10 experts to extract consensus commandments. That is the CC Bible's moat.

---

## Competitor Breakdown

### 1. everything-claude-code (affaan-m)

| Field | Detail |
|---|---|
| **URL** | https://github.com/affaan-m/everything-claude-code |
| **Stars** | ~74.5k |
| **Author** | Affaan Mustafa (Anthropic hackathon winner) |
| **Format** | Claude Code plugin (installable via marketplace) |
| **Covers** | 16 agents, 65+ skills, 40+ commands, hooks, rules, cross-platform support (Claude Code, Cursor, Codex, OpenCode) |

**What they have that we DON'T:**
- Installable plugin system — users can `/plugin install` and get agents/skills/commands immediately
- Cross-platform support (Cursor, Codex, OpenCode)
- Security scanning (AgentShield), hook runtime controls
- Continuous learning with instinct extraction
- Shorthand + Longform technical guides

**What we have that they DON'T:**
- Multi-expert attribution — every tip traced to a named expert with source link
- Cross-referencing consensus across 10 different practitioners
- The Ten Commandments (distilled universal truths)
- Creative literary format that makes tips memorable
- Curated wisdom vs. kitchen-sink tooling
- Human editorial judgment on what matters most

---

### 2. awesome-claude-code (hesreallyhim)

| Field | Detail |
|---|---|
| **URL** | https://github.com/hesreallyhim/awesome-claude-code |
| **Stars** | ~27.9k |
| **Author** | @hesreallyhim |
| **Format** | Awesome-list (categorized links) |
| **Covers** | Skills, agents, plugins, hooks, slash-commands, CLAUDE.md files, IDE integrations, orchestrators, alternative clients |

**What they have that we DON'T:**
- Breadth — hundreds of linked tools and resources across 10+ categories
- CSV resource table for structured browsing
- Tool discovery (links to actual repos you can install)
- Multiple viewing styles (Awesome, Extra, Classic, Flat)

**What we have that they DON'T:**
- Depth of wisdom — they link to tools, we explain *how experts think*
- Expert attribution and sourcing
- Synthesized consensus (Ten Commandments)
- Narrative format that teaches principles, not just lists tools
- Original analysis of what 10 experts agree on independently

---

### 3. howborisusesclaudecode.com

| Field | Detail |
|---|---|
| **URL** | https://howborisusesclaudecode.com |
| **Stars** | N/A (website, not a repo) |
| **Author** | Boris Cherny (creator of Claude Code) |
| **Format** | Website with 45 tips across 6 volumes |
| **Covers** | Parallel sessions, model selection, worktrees, CLAUDE.md, hooks, MCP, permissions, customization, scheduled tasks |

**What they have that we DON'T:**
- Direct from the source — Boris is the creator of Claude Code
- Continuously updated (6 volumes and counting, Jan-Mar 2026)
- Practical walkthroughs with exact commands and configs
- Team workflow details from the actual Claude Code team at Anthropic

**What we have that they DON'T:**
- 9 other experts beyond Boris (Karpathy, Shumer, Levels, Pocock, etc.)
- Cross-expert consensus — shows what *everyone* agrees on, not just one person
- Tips from outside Anthropic (indie hackers, TypeScript experts, AI researchers)
- The Ten Commandments synthesis
- Bible verse format for memorability

**Closest competitor conceptually.** Boris's site is the single-expert version of what we do across 10 experts.

---

### 4. claude-code-best-practice (shanraisshan)

| Field | Detail |
|---|---|
| **URL** | https://github.com/shanraisshan/claude-code-best-practice |
| **Stars** | ~14.6k |
| **Author** | shanraisshan |
| **Format** | Reference implementation repo with docs |
| **Covers** | 40+ best practices, Command-Agent-Skill architecture, orchestration workflows, memory, MCP, hooks, cross-model workflows |

**What they have that we DON'T:**
- Working code examples (agents, skills, hooks you can copy)
- Implementation patterns (not just advice — actual `.claude/` directory structures)
- Orchestration workflow documentation with architecture diagrams
- RPI methodology and autonomous development patterns
- Actively updated (last update: 2026-03-13)

**What we have that they DON'T:**
- Named expert attribution for every tip
- Cross-expert consensus analysis
- Creative format that makes content shareable and memorable
- Tips from high-profile devs (Karpathy, Levels) who bring outside perspective
- The "why" behind practices, not just the "how"

---

### 5. claude-code-ultimate-guide (FlorianBruniaux)

| Field | Detail |
|---|---|
| **URL** | https://github.com/FlorianBruniaux/claude-code-ultimate-guide |
| **Stars** | ~1.4k |
| **Author** | Florian Bruniaux |
| **Format** | Massive educational document (22,000+ lines, 16 sections) |
| **Covers** | Core concepts, configuration, TDD/SDD/BDD, security (24 CVEs, 655 malicious skills tracked), multi-agent systems, DevOps/SRE, 41 Mermaid diagrams |

**What they have that we DON'T:**
- Sheer depth — 22K lines, 204 templates, 271-question quiz
- Security threat database (CVE tracking, malicious skill detection)
- Visual learning (41 Mermaid diagrams)
- Progressive learning paths for 5+ user profiles
- Decision frameworks and assessment systems

**What we have that they DON'T:**
- Real expert attribution (their content is author-synthesized, not expert-sourced)
- Conciseness — 202 tips you can scan in 30 minutes vs. 22K lines
- Cross-referencing of independent expert opinions
- The Ten Commandments as a starting point for beginners
- Literary format that's actually enjoyable to read

---

### 6. claude-code-tips (ykdojo)

| Field | Detail |
|---|---|
| **URL** | https://github.com/ykdojo/claude-code-tips |
| **Stars** | ~4.5k |
| **Author** | ykdojo (YK, content creator) |
| **Format** | Numbered tips list (0-45) |
| **Covers** | Slash commands, voice input, git workflows, context management, terminal aliases, Playwright, tmux testing, system prompt hacks |

**What they have that we DON'T:**
- Unique hacks (cutting system prompt in half, Gemini CLI as Claude Code's minion, voice input integration)
- Custom tooling (status line scripts, dx plugin)
- Container-based Claude Code execution tips

**What we have that they DON'T:**
- Multi-expert sourcing (they're single-author)
- Expert credibility (Boris, Karpathy, etc. vs. one content creator)
- Consensus analysis across practitioners
- Structured thematic organization (Books + Commandments)

---

### 7. Claude-Code-Everything-You-Need-to-Know (wesammustafa)

| Field | Detail |
|---|---|
| **URL** | https://github.com/wesammustafa/Claude-Code-Everything-You-Need-to-Know |
| **Stars** | ~1.2k |
| **Author** | wesammustafa |
| **Format** | Comprehensive tutorial/guide |
| **Covers** | Setup, prompt engineering, commands, hooks, workflows, automation, MCP servers, BMAD method, 2026 updates (Opus 4.6, Fast Mode, Agent Teams) |

**What they have that we DON'T:**
- Step-by-step tutorials for beginners
- BMAD method and Super Claude framework documentation
- 2026 feature coverage (Opus 4.6, Agent Teams, MCP Registry)

**What we have that they DON'T:**
- Expert-sourced tips with attribution
- Consensus-driven commandments
- Battle-tested wisdom from practitioners who've shipped real products
- Creative format

---

### 8. claude-code-guide (zebbern)

| Field | Detail |
|---|---|
| **URL** | https://github.com/zebbern/claude-code-guide |
| **Stars** | ~3.6k |
| **Author** | zebbern |
| **Format** | Community guide (386 commits) |
| **Covers** | Setup, commands, keyboard shortcuts, Vim mode, thinking/plan/fast modes, sandbox, MCP, subagents, skills, plugins, security, automation, troubleshooting |

**What they have that we DON'T:**
- Troubleshooting section (installation issues, MCP problems)
- Keyboard shortcut reference
- Third-party integration docs (DeepSeek)
- Actively community-maintained (386 commits)

**What we have that they DON'T:**
- Expert attribution and sourcing
- Opinionated wisdom vs. neutral documentation
- The "what matters most" filter (Ten Commandments)
- Literary format

---

### 9. bcherny-claude (0xquinto)

| Field | Detail |
|---|---|
| **URL** | https://github.com/0xquinto/bcherny-claude |
| **Stars** | 151 |
| **Author** | 0xquinto (extracted from Boris's public shares) |
| **Format** | Config files (CLAUDE.md, commands, agents, settings) |
| **Covers** | Boris's exact setup: 7 slash commands, 6 subagents, settings.json, CLAUDE.md |

**What they have that we DON'T:**
- Copy-paste-ready config files from Boris Cherny's actual setup
- Working subagent definitions (staff-reviewer, code-architect, etc.)
- Exact settings.json with permission pre-approvals

**What we have that they DON'T:**
- 9 other experts beyond Boris
- Explanation of *why* Boris does things, not just *what* his config is
- Broader wisdom that applies to any Claude Code setup
- The Ten Commandments synthesis

---

### 10. Advent of Claude (adocomplete / Ado Kukic)

| Field | Detail |
|---|---|
| **URL** | https://adocomplete.com/advent-of-claude-2025/ |
| **Stars** | N/A (blog series) |
| **Author** | Ado Kukic (Anthropic DevRel, ex-Auth0/MongoDB/DigitalOcean) |
| **Format** | 31-day advent calendar blog series (Dec 2025) |
| **Covers** | Getting started, shortcuts, session management, productivity, thinking/planning, agents/subagents/skills/plugins/SDK |

**What they have that we DON'T:**
- Daily drip format (one tip per day for engagement)
- Beginner-friendly progressive structure
- From an official Anthropic DevRel person

**What we have that they DON'T:**
- Multi-expert (they're single-author Anthropic perspective)
- External expert voices (Karpathy, Levels, Shumer bring non-Anthropic viewpoints)
- Consensus analysis
- More tips (202 vs 31)

---

### 11. claudecode-best-practices (rosmur)

| Field | Detail |
|---|---|
| **URL** | https://github.com/rosmur/claudecode-best-practices |
| **Stars** | 72 |
| **Author** | rosmur (Daniel Rosehill) |
| **Format** | AI-synthesized best practices from HN/Reddit posts |
| **Covers** | Aggregated best practices from high-performing Hacker News and Reddit posts, processed by Claude Opus |

**What they have that we DON'T:**
- Community-sourced (HN/Reddit) rather than expert-sourced
- Automated pipeline (article_fetcher.py + Claude analysis)
- Plans for continuous automated updates

**What we have that they DON'T:**
- Named expert attribution (not anonymous community posts)
- Hand-curated editorial judgment
- 10x more tips
- The Ten Commandments consensus
- Creative format

---

### 12. ClaudeLog (claudelog.com)

| Field | Detail |
|---|---|
| **URL** | https://claudelog.com |
| **Stars** | N/A (website) |
| **Author** | InventorBlack (Wilfred Kasekende), CTO at Command Stick, r/ClaudeAI moderator |
| **Format** | Blog/docs site with searchable knowledge base |
| **Covers** | Foundation guides, agent mechanics, performance optimization, development patterns, changelog tracking |

**What they have that we DON'T:**
- Searchable knowledge base
- Ongoing changelog tracking
- Community-driven insights from r/ClaudeAI (535K+ members)
- Website with proper navigation and search

**What we have that they DON'T:**
- Named expert sourcing from top practitioners
- Cross-expert consensus
- The Ten Commandments
- Creative format

---

### 13. awesome-claude-code-subagents (VoltAgent)

| Field | Detail |
|---|---|
| **URL** | https://github.com/VoltAgent/awesome-claude-code-subagents |
| **Stars** | ~13.6k |
| **Author** | VoltAgent |
| **Format** | Collection of 127+ subagent definitions across 10 categories |
| **Covers** | Core dev, language specialists (27), infra/DevOps, quality/security, data/AI, DX, business/product, meta/orchestration, research |

**What they have that we DON'T:**
- Installable subagent definitions (127+)
- Category-specific plugins
- Practical tooling you can use immediately

**What we have that they DON'T:**
- Wisdom about *when and why* to use subagents (not just agent definitions)
- Expert perspectives on subagent patterns
- Broader coverage beyond just subagents

---

## Competitive Positioning Matrix

| Resource | Stars | Format | Multi-Expert | Consensus | Tips | Installable | Creative Format |
|---|---|---|---|---|---|---|---|
| **CC Bible (ours)** | new | Markdown/Bible | **10 experts** | **Ten Commandments** | **202** | No | **Yes** |
| everything-claude-code | 74.5k | Plugin | No (1 author) | No | N/A | **Yes** | No |
| awesome-claude-code | 27.9k | Link list | No (curator) | No | 300+ links | No | No |
| shanraisshan best-practice | 14.6k | Repo + docs | Partial | No | 40+ | **Yes** | No |
| VoltAgent subagents | 13.6k | Agent defs | No | No | 127 agents | **Yes** | No |
| ykdojo tips | 4.5k | Tip list | No (1 author) | No | 45 | No | No |
| zebbern guide | 3.6k | Guide | No | No | N/A | No | No |
| ultimate-guide | 1.4k | Docs (22K lines) | No (1 author) | No | 204 templates | No | No |
| cheat-sheet | 1.4k | Cheat sheet | No | No | 8 levels | No | No |
| wesammustafa guide | 1.2k | Tutorial | No | No | N/A | No | No |
| howborisusesclaudecode | N/A | Website | No (1 expert) | No | 45 | No | No |
| Advent of Claude | N/A | Blog series | No (1 author) | No | 31 | No | No |
| bcherny-claude | 151 | Config files | No (1 expert) | No | N/A | **Yes** | No |
| rosmur best-practices | 72 | AI-generated | Community | No | ~20 | No | No |
| ClaudeLog | N/A | Website | Community | No | N/A | No | No |

---

## Our Unique Value Proposition

**No one else does all three of these:**

1. **Multi-expert sourcing with attribution** — Every tip is traced to a named expert (Boris Cherny, Andrej Karpathy, Pieter Levels, Matt Pocock, etc.) with links to original posts. Other resources are either single-author or aggregated without attribution.

2. **Cross-expert consensus analysis** — The Ten Commandments distill what 10 independent experts agree on. No other resource has attempted this synthesis. This is the CC Bible's strongest differentiator.

3. **Creative literary format** — Bible verse structure, Books named after experts, Ten Commandments, genesis narrative. This makes the content memorable, shareable, and fun to read. Every other resource uses standard technical documentation format.

---

## Gaps to Consider Filling

Based on what competitors offer that we currently lack:

| Gap | Who Has It | Priority |
|---|---|---|
| Installable plugin/skills | everything-claude-code, shanraisshan | Medium — could package our commandments as a CLAUDE.md template |
| Searchable web version | ClaudeLog, howborisusesclaudecode | High — a website would increase discoverability |
| Beginner tutorial path | ultimate-guide, wesammustafa, zebbern | Low — not our audience (we target practitioners) |
| Visual diagrams | ultimate-guide (41 Mermaid diagrams) | Low — our strength is prose |
| Ongoing updates | howborisusesclaudecode, shanraisshan | High — should add new experts/tips over time |
| Config files to copy-paste | bcherny-claude, shanraisshan | Medium — could add a `configs/` directory |
| Security coverage | ultimate-guide (CVE tracking) | Low — niche concern |

---

## Bottom Line

The Claude Code knowledge ecosystem is fragmented into **tools/plugins** (everything-claude-code, awesome lists, subagent collections) and **guides/docs** (ultimate-guide, zebbern, wesammustafa). The CC Bible sits in a third category that doesn't exist yet: **curated expert wisdom with editorial synthesis**.

Our closest analogue is a "Best Of" album — we don't create original tools, and we don't write beginner tutorials. We collect the greatest hits from the best practitioners and present them in a format that's both useful and memorable. That category is currently **unoccupied**.
