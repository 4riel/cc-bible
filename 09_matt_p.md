# Book of Pocock

> The Craftsman. TypeScript educator. Creator of Total TypeScript. Tests before he builds. 9 rules, no exceptions.

> Compiled from [@mattpocockuk](https://x.com/mattpocockuk) X threads, [AI Hero](https://www.aihero.dev) articles, and his public [skills repo](https://github.com/mattpocock/skills).

---

## Chapter 1: Highest Impact

### Pocock 1:1 — Plan Mode Is Non-Negotiable

> "Claude Code with and without plan mode is night and day. No plan mode: code is so bad it's basically a liability to keep it. Plan mode: basically as good as I could write it, with occasional bugs which I catch on review. Indispensable."

- Enter plan mode with `Shift+Tab` (cycles to plan mode), `--permission-mode plan`, or `/plan`
- The agent explores your repo, asks clarifying questions, and outputs a step-by-step plan you review before execution
- Plan mode builds agent context before coding begins -- the agent loads necessary files during planning
- Forces you to articulate requirements clearly, acting as a superior "rubber duck"
- Use plan mode for everything, even small bug fixes -- it builds your intuition about what AI can handle
- Exit plan mode once satisfied, then execute

**Source:** [x.com/mattpocockuk/status/1977369846162534555](https://x.com/mattpocockuk/status/1977369846162534555)

### Pocock 1:2 — TDD with Vertical Slicing (Red-Green-Refactor)

> "Before: dozens of shit tests, coupled to implementation. After: only the tests required, validating real behavior."

> "RGR + Claude Code is so good. Red test -> Implementation -> Green test ...is pretty hard to cheat for an LLM. Gives me a lot of confidence to move fast."

- Install the skill: `npx skills add mattpocock/skills/tdd`
- **Never** write all tests first then all implementation -- that is "horizontal slicing" and produces imagined behavior
- Use **vertical slices** (tracer bullets): ONE test -> ONE implementation -> repeat
- Each cycle: RED (one failing test) -> GREEN (minimal code to pass) -> REFACTOR (only when all tests pass)
- Tests must verify behavior through **public interfaces**, not implementation details
- Tests should read like specifications and survive complete internal refactors
- Confirm with the user which behaviors matter most -- prioritize critical paths over edge cases
- If a test fails first, the LLM can't fake it; it has to write real implementation

**Sources:**
- [x.com/mattpocockuk/status/2022036754648166527](https://x.com/mattpocockuk/status/2022036754648166527)
- [x.com/mattpocockuk/status/2025893402827489496](https://x.com/mattpocockuk/status/2025893402827489496)
- [aihero.dev/skill-test-driven-development-claude-code](https://www.aihero.dev/skill-test-driven-development-claude-code)
- [github.com/mattpocock/skills/blob/main/tdd/SKILL.md](https://github.com/mattpocock/skills/blob/main/tdd/SKILL.md)

### Pocock 1:3 — Conciseness Rule in CLAUDE.md

> "Be extremely concise. Sacrifice grammar for the sake of concision." -- Added this to my global claude md file and am extremely happy with the output.

- Add to your global `~/.claude/CLAUDE.md`:
  ```md
  ## Plan Mode

  - Make the plan extremely concise. Sacrifice grammar for the sake of concision.
  - At the end of each plan, give me a list of unresolved questions to answer, if any.
  ```
- Plans become scannable instead of unreadable walls of text
- The unresolved questions appear first, giving you immediately actionable items
- MUCH easier to scan, less reading overhead, cheaper to output

**Sources:**
- [x.com/mattpocockuk/status/1975533606048309573](https://x.com/mattpocockuk/status/1975533606048309573)
- [x.com/mattpocockuk/status/1978842333274620398](https://x.com/mattpocockuk/status/1978842333274620398)
- [x.com/mattpocockuk/status/2011092347254182097](https://x.com/mattpocockuk/status/2011092347254182097)
- [aihero.dev/my-agents-md-file-for-building-plans-you-actually-read](https://www.aihero.dev/my-agents-md-file-for-building-plans-you-actually-read)

---

## Chapter 2: Workflow Multipliers

### Pocock 2:1 — Explicitly Spawn Subagents

> "Explicitly spawning subagents with Claude Code is extremely freaking cool."

- Workflow: enter plan mode -> explicitly say how many subagents you want and which tasks they should perform -> let it rip
- Great for research across a large repo -- each subagent tackles a different area in parallel
- Subagents cannot spawn other subagents; chain them from the main conversation if needed

**Source:** [x.com/mattpocockuk/status/1976313665407099187](https://x.com/mattpocockuk/status/1976313665407099187)

### Pocock 2:2 — Save Plans in GitHub Issues, Not Markdown Files

> "Instead of markdown files, I've been getting my AI to save plans in GitHub issues. Claude Code is AWESOME at using the GitHub CLI. Means you don't have endless THROWAWAY_PLAN.md files spamming the repo."

- Claude Code works natively with `gh` CLI
- Plans stored as GitHub issues are searchable, commentable, and don't clutter the repo
- Eliminates disposable `PLAN.md` and `THROWAWAY_PLAN.md` files

**Source:** [x.com/mattpocockuk/status/1976932157521379574](https://x.com/mattpocockuk/status/1976932157521379574)

### Pocock 2:3 — Git Worktrees for Parallel Claude Instances

> "Worktrees let you run a bunch of Claude Code's at the same time. All shipping independently on the same repo. A huge throughput increase."

- Each worktree gets its own Claude Code session, working on a separate branch
- No file conflicts, no branch switching chaos, no context pollution
- Massive throughput increase for shipping multiple features simultaneously

**Source:** [x.com/mattpocockuk/status/2025568938449580342](https://x.com/mattpocockuk/status/2025568938449580342)

### Pocock 2:4 — Force the Agent to Interview You

> "Claude Code (or Opus 4.6) feels like it asks you far fewer questions during plan mode. Try: 'Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions.'"

- Newer models tend to ask fewer clarifying questions, which can lead to incorrect assumptions
- This prompt forces thorough requirement gathering before any code is written
- Resolves dependencies between design decisions one-by-one

**Source:** [x.com/mattpocockuk/status/2024576093894955369](https://x.com/mattpocockuk/status/2024576093894955369)

---

## Chapter 3: Architecture & Code Quality

### Pocock 3:1 — The 9 AI Coding Rules

> "9 AI coding rules to live by"

1. **Right-size your tasks** -- too small and you're slow; too big and you blow the context window
2. **Ask for 2 implementation plans** -- agents greedily sample the first plan; force alternatives
3. **Turn the chosen plan into a multi-step .md with checkboxes** -- figuring out how much to do per stage is an art
4. **Pass the whole plan into context** and say "implement stage 1" -- the full plan gives the agent context
5. **Let feedback loops do the work** -- VSCode squiggly lines auto-feed to the agent; tell it "RUN THE TESTS BEFORE SHOWING ME THE CODE"
6. **Iterate on your rules** -- rules help everything from task sizing to teaching the agent about repo scripts
7. **Pay attention to the code** -- especially early in a project when establishing abstractions; once patterns exist, the agent gets smarter
8. **Make code easier to delete** -- economics of refactoring have changed; highly decoupled systems benefit most from AI
9. **Use Gemini as a quality check** -- hook up Gemini's massive context window via MCP to review the whole codebase for duplication and patterns

**Source:** [x.com/mattpocockuk/status/1904177555143606649](https://x.com/mattpocockuk/status/1904177555143606649)

### Pocock 3:2 — TDD Interface Design Principles

- **Accept dependencies, don't create them** -- `processOrder(order, paymentGateway)` instead of instantiating internally
- **Return results, don't produce side effects** -- `calculateDiscount(cart): Discount` instead of `applyDiscount(cart): void`
- **Small surface area** -- fewer methods = fewer tests needed; fewer parameters = simpler test setup
- **Deep modules over shallow modules** -- small interface + lots of implementation; hide complexity behind simple APIs
- **Mock only at system boundaries** -- external APIs, databases, time/randomness; never mock your own code

**Sources:**
- [github.com/mattpocock/skills/blob/main/tdd/interface-design.md](https://github.com/mattpocock/skills/blob/main/tdd/interface-design.md)
- [github.com/mattpocock/skills/blob/main/tdd/deep-modules.md](https://github.com/mattpocock/skills/blob/main/tdd/deep-modules.md)
- [github.com/mattpocock/skills/blob/main/tdd/mocking.md](https://github.com/mattpocock/skills/blob/main/tdd/mocking.md)

### Pocock 3:3 — Git Guardrails Skill

- Install: `npx skills add mattpocock/skills/git-guardrails-claude-code`
- Blocks dangerous git commands before execution: `git push`, `git reset --hard`, `git clean -f`, `git branch -D`, `git checkout .`, `git restore .`
- Uses a `PreToolUse` hook that intercepts bash commands and pattern-matches against a danger list
- Customizable -- choose which commands to block during setup
- When blocked, Claude sees: "BLOCKED: 'git push origin main' matches dangerous pattern 'git push'"

**Sources:**
- [aihero.dev/this-hook-stops-claude-code-running-dangerous-git-commands](https://www.aihero.dev/this-hook-stops-claude-code-running-dangerous-git-commands)
- [github.com/mattpocock/skills/tree/main/git-guardrails-claude-code](https://github.com/mattpocock/skills/tree/main/git-guardrails-claude-code)

---

## Chapter 4: Workflow Refinements

### Pocock 4:1 — The Perfect Statusline

> "This is the perfect Claude Code statusline: repo, branch, Git staged/unstaged/added, Context used. Undefeated."

- Monitor context usage in real-time to know when you're approaching limits
- Track git state without leaving the Claude Code interface
- Configure via `/statusline` command

**Source:** [x.com/mattpocockuk/status/1983177470431166881](https://x.com/mattpocockuk/status/1983177470431166881)

### Pocock 4:2 — Use Dictation for Input

- Talk into a dictation tool to generate prompts -- AI accepts messy, stream-of-consciousness input
- Recommended tools: Superwhisper (Mac), Wispr Flow (Mac/Windows)
- No need for perfect grammar; the agent parses intent regardless

**Source:** [aihero.dev/plan-mode-introduction](https://www.aihero.dev/plan-mode-introduction)

### Pocock 4:3 — PRD-to-Issues Workflow

- Install: `npx skills add mattpocock/skills/prd-to-issues`
- Decomposes Product Requirements Documents into vertical-slice GitHub issues
- Each issue spans every layer (schema, API, UI, tests) and is independently demoable
- Issues classified as **HITL** (needs human review) or **AFK** (implementable without interaction)
- Created in dependency order with acceptance criteria

**Source:** [github.com/mattpocock/skills/tree/main/prd-to-issues](https://github.com/mattpocock/skills/tree/main/prd-to-issues)

### Pocock 4:4 — MCP for GitHub Integration

> "Watch me hook Claude Code up to GitHub (via MCP) to fix a OSS issue without leaving my terminal or touching a line of code."

- Claude Code can read issues, create PRs, and manage repos entirely through the GitHub CLI
- MCP prompts can create personal slash commands if you have a personal MCP server

**Sources:**
- [x.com/mattpocockuk/status/1900213538569797996](https://x.com/mattpocockuk/status/1900213538569797996)
- [x.com/mattpocockuk/status/1901189859575816426](https://x.com/mattpocockuk/status/1901189859575816426)

---

## Chapter 5: Pocock's Creed — Skills Collection

Matt maintains a public [skills repository](https://github.com/mattpocock/skills) with 16 installable Claude Code skills:

| Skill | Purpose |
|-------|---------|
| `tdd` | Test-driven development with vertical slicing |
| `git-guardrails-claude-code` | Block dangerous git commands |
| `prd-to-issues` | Decompose PRDs into GitHub issues |
| `prd-to-plan` | Transform PRDs into actionable plans |
| `write-a-prd` | Compose product requirement documents |
| `write-a-skill` | Create new skill modules |
| `improve-codebase-architecture` | Enhance structural design |
| `request-refactor-plan` | Develop refactoring strategies |
| `grill-me` | Interactive questioning/review |
| `design-an-interface` | UI design assistance |
| `triage-issue` | Categorize and prioritize issues |
| `setup-pre-commit` | Configure pre-commit hooks |
| `edit-article` | Revise written articles |
| `scaffold-exercises` | Generate practice materials |
| `obsidian-vault` | Obsidian note management |
| `migrate-to-shoehorn` | Platform migration |

Install any skill: `npx skills add mattpocock/skills/<skill-name>`

**Source:** [github.com/mattpocock/skills](https://github.com/mattpocock/skills)

---

## Source Threads

| Date | Thread | Topic |
|------|--------|-------|
| 2025-03-14 | [x.com/.../1900213538569797996](https://x.com/mattpocockuk/status/1900213538569797996) | MCP + GitHub CLI demo |
| 2025-03-15 | [x.com/.../1901189859575816426](https://x.com/mattpocockuk/status/1901189859575816426) | MCP prompts as personal commands |
| 2025-03-25 | [x.com/.../1904177555143606649](https://x.com/mattpocockuk/status/1904177555143606649) | 9 AI coding rules to live by |
| 2025-09-25 | [x.com/.../1974528553569137095](https://x.com/mattpocockuk/status/1974528553569137095) | "Sacrifice grammar for concision" (general) |
| 2025-09-28 | [x.com/.../1975533606048309573](https://x.com/mattpocockuk/status/1975533606048309573) | Conciseness in global CLAUDE.md |
| 2025-10-01 | [x.com/.../1976313665407099187](https://x.com/mattpocockuk/status/1976313665407099187) | Subagent spawning workflow |
| 2025-10-01 | [x.com/.../1976339286137205015](https://x.com/mattpocockuk/status/1976339286137205015) | Plan mode + concision |
| 2025-10-03 | [x.com/.../1976932157521379574](https://x.com/mattpocockuk/status/1976932157521379574) | Plans in GitHub issues |
| 2025-10-06 | [x.com/.../1977369846162534555](https://x.com/mattpocockuk/status/1977369846162534555) | Plan mode is night and day |
| 2025-10-10 | [x.com/.../1978842333274620398](https://x.com/mattpocockuk/status/1978842333274620398) | Two plan mode improvements |
| 2025-10-17 | [x.com/.../1979865873403007003](https://x.com/mattpocockuk/status/1979865873403007003) | Interactive test case selection UI |
| 2025-10-21 | [x.com/.../1981366406865457276](https://x.com/mattpocockuk/status/1981366406865457276) | 10-min feature implementation video |
| 2025-10-26 | [x.com/.../1983177470431166881](https://x.com/mattpocockuk/status/1983177470431166881) | Perfect statusline |
| 2025-12-31 | [x.com/.../2009611147389829555](https://x.com/mattpocockuk/status/2009611147389829555) | Why You Think AI Coding Sucks |
| 2026-01-05 | [x.com/.../2011092347254182097](https://x.com/mattpocockuk/status/2011092347254182097) | CLAUDE.md additions for plan mode |
| 2026-02-04 | [x.com/.../2022036754648166527](https://x.com/mattpocockuk/status/2022036754648166527) | TDD skill published |
| 2026-02-11 | [x.com/.../2024576093894955369](https://x.com/mattpocockuk/status/2024576093894955369) | "Interview me relentlessly" prompt |
| 2026-02-15 | [x.com/.../2025568938449580342](https://x.com/mattpocockuk/status/2025568938449580342) | Git worktrees for parallel agents |
| 2026-02-15 | [x.com/.../2025893402827489496](https://x.com/mattpocockuk/status/2025893402827489496) | RGR + Claude Code is hard to cheat |

---

*Last compiled: 2026-03-13*
