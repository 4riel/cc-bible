# CC Bible Validation Report

> Cross-checked against Claude Code docs as of 2026-03-13

---

## Issues Found

### 0_the_ten_commandments.md — Commandment I — "Shift+Tab twice" to enter plan mode

**Status:** NEEDS UPDATE
**What the bible says:** "Enter plan mode (`Shift+Tab` twice)"
**What the docs say:** `Shift+Tab` cycles through: Default -> Auto-accept -> Plan. So pressing it twice from Default does reach Plan, but there are also direct alternatives: `/plan` command, `--permission-mode plan` CLI flag.
**Recommendation:** Technically correct but incomplete. Add the alternatives (`/plan`, `--permission-mode plan`) since many users don't know about them. Also note that on some platforms (Windows), Plan mode has been reported as missing from the Shift+Tab cycle.

---

### 0_the_ten_commandments.md — Commandment VII — Skills path

**Status:** MINOR
**What the bible says:** "Store them in `.claude/skills/` or `.claude/commands/`, commit to git."
**What the docs say:** Per Thariq 3:3 (and the official docs), skills have subsumed slash commands. `.claude/commands/` still works but is the legacy path. The recommended path is `.claude/skills/<name>/SKILL.md`.
**Recommendation:** Lead with `.claude/skills/` and note that `.claude/commands/` is legacy but still functional.

---

### 1_boris.md — Boris 2:2 — Effort level "High" via /model

**Status:** NEEDS UPDATE
**What the bible says:** "Set effort to **High** via `/model`"
**What the docs say:** Effort levels were simplified to low/medium/high (the "max" level was removed from the standard UI). As of v2.1.68, default effort for Opus 4.6 was changed to **medium** (not high). The `/effort` command is now the primary way to control effort level, not `/model`. The "ultrathink" keyword was restored as a per-turn override to bump to high.
**Recommendation:** Update to mention `/effort` as the correct command. Note that "High" is no longer the default and must be explicitly set.

---

### 1_boris.md — Boris 3:5 — /sandbox command

**Status:** CONFIRMED VALID
**What the bible says:** "Run `/sandbox` to opt into the open-source sandbox runtime... Three modes: sandbox + auto-allow, sandbox + normal permissions, no sandbox."
**What the docs say:** `/sandbox` exists and uses OS-level primitives (macOS Seatbelt, Linux bubblewrap) for filesystem and network isolation. Two sandbox modes are described in docs: auto-allow mode and standard mode. Reduces permission prompts by 84%.
**Recommendation:** Minor: docs describe two modes plus "off", not three distinct named modes. Wording could be more precise.

---

### 1_boris.md — Boris 3:7 — Voice dictation: "hit fn twice on macOS"

**Status:** NEEDS UPDATE
**What the bible says:** "hit `fn` twice on macOS" for voice dictation
**What the docs say:** Hitting `fn` twice activates macOS **system dictation**, which is a separate feature from Claude Code's native voice mode. Claude Code now has native `/voice` mode (hold Space to talk, push-to-talk). The `fn` trick is a macOS-level workaround, not a Claude Code feature.
**Recommendation:** Distinguish between macOS system dictation (`fn` twice) and Claude Code native voice mode (`/voice` + hold Space). Boris 3:9 later covers `/voice` correctly, but 3:7 conflates the two.

---

### 1_boris.md — Boris 3:7 — Output styles via /config

**Status:** NEEDS UPDATE
**What the bible says:** "**Output styles:** `/config` -> 'Explanatory' (for learning new codebases) or 'Learning' (Claude coaches you)"
**What the docs say:** `/output-style` was deprecated in favor of `/config` on March 10, 2026, then **un-deprecated** based on community feedback. The situation is fluid. Currently both `/config` and `/output-style` appear to work.
**Recommendation:** Note that output styles underwent a deprecation/un-deprecation cycle. `/config` is the forward-looking path but `/output-style` still works.

---

### 1_boris.md — Boris 3:9 — Voice mode: "hold Space to talk"

**Status:** CONFIRMED VALID
**What the bible says:** "`/voice` to toggle on -- hold Space to talk, release to send"
**What the docs say:** Confirmed. `/voice` activates voice mode. Hold spacebar to talk (push-to-talk), release to send. No hands-free/always-listening mode. Rolling out to ~5% of users initially (March 3, 2026) expanding through March.
**Recommendation:** Add note that voice keybinding is now rebindable via `voice:pushToTalk` in `keybindings.json` per the changelog. Also note the gradual rollout -- not all users may have it yet.

---

### 1_boris.md — Boris 5:6 — --teleport direction

**Status:** NEEDS UPDATE
**What the bible says:** "Use `--teleport` to move sessions between local and web"
**What the docs say:** Teleport is **one-way only**: you can pull a web session down to your terminal, but you cannot push a local session up to the web. The bible implies bidirectional movement.
**Recommendation:** Clarify that `--teleport` / `/teleport` pulls web sessions to local. It is not bidirectional. For the reverse direction, use `/remote-control` to expose a local session to the web/mobile.

---

### 2_thariq.md — Thariq 3:2 — Tasks stored at ~/.claude/tasks

**Status:** MINOR
**What the bible says:** "Stored in the filesystem (`~/.claude/tasks`) so multiple subagents or sessions can collaborate on them"
**What the docs say:** Tasks are a filesystem-based primitive, but the exact path may vary. The docs confirm they are file-based and support cross-session collaboration.
**Recommendation:** Verify the exact path. The feature is relatively new and the storage location may have changed since announcement.

---

### 2_thariq.md — Thariq 3:3 — Skills absorbed slash commands

**Status:** CONFIRMED VALID
**What the bible says:** "A file at `.claude/commands/deploy.md` and a skill at `.claude/skills/deploy/SKILL.md` both create `/deploy`"
**What the docs say:** Confirmed. Skills subsume commands. Both paths work and create the same `/deploy` invocation.
**Recommendation:** None needed. This is accurate.

---

### 2_thariq.md — Thariq 4:4 — Plan mode as callable tool (EnterPlanMode/ExitPlanMode)

**Status:** CONFIRMED VALID
**What the bible says:** "Plan mode is implemented as a callable tool (EnterPlanMode/ExitPlanMode) rather than a config toggle"
**What the docs say:** Confirmed. Plan mode uses tool calls to preserve the prompt cache. System prompt repo shows EnterPlanMode/ExitPlanMode tools. There is a known bug where ExitPlanMode fails when combined with `--dangerously-skip-permissions`.
**Recommendation:** None needed.

---

### 3_alex.md — Alex 1:3 — Ctrl+G to edit plan in your editor

**Status:** NEEDS UPDATE
**What the bible says:** "Press `Ctrl+G` to edit the plan in your editor before proceeding"
**What the docs say:** `Ctrl+G` does open prompts/plans in an external editor (configured via `VISUAL` or `EDITOR` env var). However, there is a known bug (issue #10861) where modifications made via Ctrl+G are **not always passed back to Claude** -- Claude may use the pre-edit version.
**Recommendation:** Add a warning that Ctrl+G editing has a known reliability issue. Users should verify Claude acknowledges their edits.

---

### 4_cat.md — Cat 2:2 — Thinking token budgets

**Status:** OUTDATED
**What the bible says:** `"think"` = 4K tokens, `"think hard"` = 10K tokens, `"think harder"` = more tokens, `"ultrathink"` = 31,999 tokens (max budget)
**What the docs say:** Ultrathink was deprecated in January 2026 (thinking became on by default at max budget), then **restored** in v2.1.68 (March 2026) as a per-turn override. The specific token counts (4K, 10K, etc.) for the intermediate keywords are no longer documented and may not be accurate. The current system uses `/effort` with low/medium/high levels. "ultrathink" in a prompt bumps that single turn to high effort. Extended thinking is on by default with a 31,999 token budget.
**Recommendation:** Replace the specific token counts with the current system: `/effort` controls thinking depth (low/medium/high). "ultrathink" is a per-turn keyword that bumps to high effort. The precise token allocation per keyword is no longer specified in docs.

---

### 4_cat.md — Cat 2:4 — "Opus for plan mode" model option

**Status:** NEEDS UPDATE
**What the bible says:** "Claude Opus 4.1 for plan mode and Claude Sonnet 4 for all other work"
**What the docs say:** The default Opus model on all platforms was changed to **Opus 4.6** (not 4.1). The "Opus for plan mode" feature still exists, but the model referenced is outdated.
**Recommendation:** Update model references to current versions (Opus 4.6, Sonnet 4.x). The concept is valid; the specific model versions are stale.

---

### 4_cat.md — Cat 3:1 — Ctrl+B to run agents in background

**Status:** CONFIRMED VALID
**What the bible says:** "Press `Ctrl+B` to run agents in the background"
**What the docs say:** Confirmed. When Claude spawns a sub-agent, press Ctrl+B to move it to the background. Also: Ctrl+F kills background agents (with two-press confirmation), agent frontmatter supports `background: true` to always run as background.
**Recommendation:** None needed. Could optionally add the Ctrl+F kill shortcut.

---

### 4_cat.md — Cat 4:1 — Shift+Tab cycles: Default -> Auto-accept -> Plan Mode

**Status:** CONFIRMED VALID
**What the bible says:** "`Shift+Tab` cycles through: Default -> Auto-accept -> Plan Mode"
**What the docs say:** Confirmed for CLI. Note: Windows had a reported bug where Plan mode was missing from the cycle (issue #17344). `bypassPermissions` is intentionally excluded from the cycle.
**Recommendation:** None needed for the core claim. Optional: note platform-specific caveats.

---

### 4_cat.md — Cat 4:4 — /remote-control

**Status:** CONFIRMED VALID
**What the bible says:** "Use `/remote-control` to continue local sessions from your phone"
**What the docs say:** Confirmed. `/remote-control` (or `/rc`) was launched February 25, 2026. Exposes a local session to web/mobile. Works with claude.ai/code and Claude mobile app. One remote session per instance.
**Recommendation:** None needed.

---

### 5_andrej.md — Karpathy 2:3 — Three-tier: Cursor / Claude Code / GPT-5 Pro

**Status:** MINOR
**What the bible says:** "Use Cursor in favorable situations, Claude Code in difficult ones, GPT-5 Pro in desperate ones."
**What the docs say:** This is Karpathy's personal workflow opinion, not a Claude Code doc claim. Still valid as his stated preference. However, Opus 4.6 has shipped since this was written, which may change the calculus.
**Recommendation:** Note that model capabilities have evolved (Opus 4.6 release). Karpathy's own later tweets suggest he may have updated this hierarchy.

---

### 6_matt_s.md — Shumer 3:3 — "Opus 4.5 is the best model for agentic coding"

**Status:** OUTDATED
**What the bible says:** "For agentic, multi-step, autonomous coding tasks, Opus 4.5 outperforms all competitors"
**What the docs say:** Opus 4.6 has since shipped and is described by Boris as "our best model yet -- more agentic, more intelligent, runs for longer, and is more careful and exhaustive." Opus 4.5 is superseded.
**Recommendation:** Add a note that Opus 4.6 has since shipped and is the current recommended model. The general principle (Opus for agentic tasks) remains valid.

---

### 7_elvis.md — Elvis 1:2 — enable_tool_search setting

**Status:** NEEDS UPDATE
**What the bible says:** "Enable `enable_tool_search: true` in settings -- MCP tools drop from ~25% to ~14% of context window."
**What the docs say:** The setting is an **environment variable** `ENABLE_TOOL_SEARCH`, not a settings.json key. It can be set as `ENABLE_TOOL_SEARCH=auto:5` for custom thresholds or `ENABLE_TOOL_SEARCH=false` to disable. Tool Search automatically activates when MCP tools exceed 10% of context. The correct config in settings.json would be in the `"env"` block, not as a top-level key.
**Recommendation:** Fix the setting name and location. It's `ENABLE_TOOL_SEARCH` as an environment variable, not `enable_tool_search: true` in settings.

---

### 8_pieter.md — Levels 1:2 — IS_SANDBOX=1 environment variable

**Status:** NEEDS UPDATE
**What the bible says:** `IS_SANDBOX=1 claude --dangerously-skip-permissions` where "IS_SANDBOX=1 tells Claude it is in a sandboxed environment"
**What the docs say:** Claude Code now has native sandboxing via `/sandbox` using OS-level primitives (Seatbelt, bubblewrap). `IS_SANDBOX=1` is not documented as an official environment variable in current docs. The `--dangerously-skip-permissions` flag (or `--permission-mode bypassPermissions`) is still valid but `IS_SANDBOX=1` appears to be an informal/undocumented trick, not an official feature.
**Recommendation:** Note that `IS_SANDBOX=1` is not an official environment variable. For real sandboxing, use `/sandbox`. For skipping permissions, use `--permission-mode bypassPermissions` or `--dangerously-skip-permissions`.

---

### 8_pieter.md — Levels 5:4 — "Just Go Mode" feature request

**Status:** NEEDS UPDATE
**What the bible says:** Levels requested a "just go" mode where Claude doesn't ask for confirmation at all.
**What the docs say:** This has been substantially addressed by: (1) `/sandbox` with auto-allow mode (reduces prompts by 84%), (2) `dontAsk` permission mode (denies everything not pre-approved -- SDK only), (3) `bypassPermissions` mode (approves everything). The feature request is essentially fulfilled.
**Recommendation:** Add a note that this wish was largely granted through sandbox auto-allow mode and the permission modes system.

---

### 9_matt_p.md — Pocock 1:1 — "/plan" as a way to enter plan mode

**Status:** CONFIRMED VALID
**What the bible says:** "Enter plan mode with `Shift+Tab` (cycles to plan mode), `--permission-mode plan`, or `/plan`"
**What the docs say:** All three methods confirmed: Shift+Tab cycling, `--permission-mode plan` CLI flag, and `/plan` slash command.
**Recommendation:** None needed.

---

### 10_affaan.md — Affaan 1:2 — settings.json with "model" and env vars

**Status:** NEEDS UPDATE
**What the bible says:** Settings example includes `"model": "sonnet"` and `"CLAUDE_CODE_SUBAGENT_MODEL": "haiku"` as recommended cost-cutting config.
**What the docs say:** `CLAUDE_CODE_SUBAGENT_MODEL` only affects agents **without** an explicit model defined. It does not override built-in agents' model settings (e.g., the built-in Explore agent has a hardcoded model). Also, `MAX_THINKING_TOKENS` as an env var may not be current -- the recommended approach is now `/effort` or the `effort` setting.
**Recommendation:** Add caveats: (1) `CLAUDE_CODE_SUBAGENT_MODEL` doesn't override built-in agents, (2) thinking control is now via `/effort`, not just `MAX_THINKING_TOKENS`.

---

### 10_affaan.md — Affaan 2:3 — --system-prompt flag

**Status:** NEEDS UPDATE
**What the bible says:** `claude --system-prompt "$(cat ~/.claude/contexts/dev.md)"` for dynamic context injection
**What the docs say:** The `--system-prompt` flag exists but is primarily for headless/SDK usage. For interactive sessions, the recommended approach is CLAUDE.md hierarchy (global, project, directory) plus `.claude/rules/` for modular rules, plus skills for on-demand context. Using `--system-prompt` in interactive sessions may interfere with the built-in system prompt and caching.
**Recommendation:** Clarify that `--system-prompt` is best for headless/`-p` mode. For interactive sessions, use the CLAUDE.md hierarchy and rules system instead.

---

### 10_affaan.md — Affaan 4:2 — Hook types list

**Status:** NEEDS UPDATE
**What the bible says:** Lists 5 hook types: PreToolUse, PostToolUse, UserPromptSubmit, Stop, PreCompact
**What the docs say:** The docs confirm PreToolUse, PostToolUse, Stop hooks. The docs also mention a `SessionStart` hook (with a `compact` matcher). UserPromptSubmit and PreCompact need verification -- the naming may have changed.
**Recommendation:** Cross-check the exact hook event names against current docs. The `SessionStart` hook with matchers is documented but not mentioned in the bible.

---

### 10_affaan.md — Affaan 5:7 — "!" as bash command prefix

**Status:** NEEDS UPDATE
**What the bible says:** "`!` -- bash command prefix"
**What the docs say:** The `!` prefix for bash commands has been replaced/supplemented by the standard `$` prefix in recent versions. Users should verify which prefix their version supports.
**Recommendation:** Verify current bash prefix. The `!` prefix may be outdated.

---

### 1_boris.md — Boris 3:4 — --permission-mode=dontAsk

**Status:** NEEDS UPDATE
**What the bible says:** "For sandboxed environments: `--permission-mode=dontAsk` lets Claude cook without being blocked"
**What the docs say:** `dontAsk` mode actually **denies** all tool usage unless explicitly pre-approved through allow rules. It does NOT "let Claude cook" -- it's the opposite of permissive. It auto-denies everything not whitelisted. The bible description is functionally wrong. For "let Claude cook", the correct mode is `bypassPermissions`.
**Recommendation:** Fix the description. `dontAsk` = deny-by-default (only pre-approved tools work). `bypassPermissions` = approve everything. The bible has these reversed.

---

## No Issues (Confirmed Valid)

The following major claims were verified as still correct:

- **CLAUDE.md file hierarchy** (global `~/.claude/CLAUDE.md`, project root, child dirs, `.claude/rules/`) -- confirmed in current docs
- **Plan mode workflow** (explore -> plan -> implement -> commit) -- confirmed
- **Shift+Tab cycling** through Default -> Auto-accept -> Plan -- confirmed for CLI
- **Git worktrees** with `claude --worktree` (or `-w`) for parallel sessions -- confirmed, shipped v2.1.49+
- **Subagents** run in separate context windows and report summaries -- confirmed
- **Skills** as the primary abstraction (subsuming commands) -- confirmed
- **`/compact` and `/clear`** for context management -- confirmed
- **Hooks** (PreToolUse, PostToolUse, Stop) for deterministic automation -- confirmed
- **Permission modes**: default, acceptEdits, plan, dontAsk, bypassPermissions -- confirmed
- **settings.json** with `permissions.allow` / `permissions.deny` arrays and wildcard patterns -- confirmed
- **Prompt caching architecture** (static prefix, cache-aware design, cache misses as SEVs) -- confirmed
- **`/btw`** for side-chain conversations without context pollution -- confirmed
- **`/simplify`** and **`/batch`** skills -- confirmed
- **`/loop`** for recurring tasks -- confirmed
- **`/remote-control`** for mobile session access -- confirmed
- **`/voice`** with push-to-talk (hold Space) -- confirmed
- **Plan acceptance clears context** (with opt-out) -- confirmed
- **MCP Tool Search** dynamically loads tools when >10% of context -- confirmed
- **Auto-memory** across sessions -- confirmed
- **`/insights`** for usage analysis -- confirmed
- **`/rewind`** with ESC+ESC -- confirmed
- **AskUserQuestionTool** for interview pattern -- confirmed
- **Custom agents** in `.claude/agents/` with frontmatter (name, color, tools, model, isolation) -- confirmed
- **Keybindings** customizable via `~/.claude/keybindings.json` -- confirmed
- **Statusline** via `/statusline` -- confirmed
- **`#` key** to add memories on the fly -- confirmed
- **`/init`** to generate starter CLAUDE.md -- confirmed
- **Organization-wide CLAUDE.md** at `/Library/Application Support/ClaudeCode/CLAUDE.md` on macOS -- confirmed

---

## Summary

| Severity | Count |
|----------|-------|
| OUTDATED | 3 |
| NEEDS UPDATE | 12 |
| WRONG | 1 |
| MINOR | 3 |
| CONFIRMED VALID | 30+ |

### Critical Fix Required

The most important fix is **Boris 3:4** where `dontAsk` is described as permissive ("lets Claude cook") when it is actually the opposite (deny-by-default). This could lead users to misconfigure their permissions in a way that blocks all tool usage.

### Recurring Theme

Several claims reference **specific model versions** (Opus 4.1, Opus 4.5, Sonnet 4) that are now superseded by Opus 4.6. The general advice remains valid but version numbers need updating.

The **thinking/effort system** has undergone multiple changes (ultrathink deprecated, then restored; effort levels simplified; default changed to medium). The specific token counts per keyword are no longer reliable.

---

*Generated 2026-03-13 by cross-referencing all 11 CC Bible files against Claude Code official documentation, changelog, GitHub issues, and web sources.*
