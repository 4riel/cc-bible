# Book of Levels

> The Heretic. Indie maker. Codes on production servers. Ships from his phone. Doesn't believe in deployment pipelines.

> Compiled from [@levelsio](https://x.com/levelsio) X threads and public talks.
> Indie maker behind NomadList, RemoteOK, and PhotoAI -- ships millions in revenue as a solo founder using Claude Code directly on production servers.

---

## Chapter 1: The Core Workflow

### Levels 1:1 — Code Directly on the Server, Skip Deployments Entirely
> "I have Claude ON production now. It's vibecoding on steroids. No deployment, no Git push and pull."

- SSH into your VPS and run Claude Code there -- not on your laptop
- Your code changes are live the instant Claude writes them
- Eliminates the entire build/deploy pipeline as a bottleneck
- Continuously refresh the browser to watch your project evolve in real-time
- This is what he calls "VibeOps" or "raw dogging dev on the server"

**Source:** [x.com/levelsio/status/1951764854580105453](https://x.com/levelsio/status/1951764854580105453)

### Levels 1:2 — Run Claude Code in Permanent Bypass Permissions Mode
> "This week I decided to just permanently switch to running Claude Code on the server mostly on bypass permissions mode: `c() { IS_SANDBOX=1 claude --dangerously-skip-permissions "$@"; }` And for the first time in my life I think I've actually managed to outrun my todo list."

- Create a shell function or alias to skip all permission prompts:
  ```bash
  # Shell function version
  c() { IS_SANDBOX=1 claude --dangerously-skip-permissions "$@"; }

  # Or as a simple alias
  alias cc="IS_SANDBOX=1 claude --dangerously-skip-permissions"
  ```
- `IS_SANDBOX=1` is an informal/undocumented trick, not an official feature. For real sandboxing, use `/sandbox` which provides OS-level filesystem and network isolation
- `--dangerously-skip-permissions` (or `--permission-mode bypassPermissions`) removes all confirmation dialogs
- He was "getting sick of answering endless questions and giving permissions, just do the job already"
- Result: "I'm 100x faster now"
- **WARNING:** He explicitly says "DO NOT RUN ON PRODUCTION!!!! JUST ON YOUR FUN VPS :D" -- though he later admits he does run it on production for his own sites

**Source:** [x.com/levelsio/status/2027566773814403448](https://x.com/levelsio/status/2027566773814403448), [x.com/levelsio/status/1959012607270236619](https://x.com/levelsio/status/1959012607270236619), [x.com/levelsio/status/2025962414085210559](https://x.com/levelsio/status/2025962414085210559)

### Levels 1:3 — The Bottleneck Is Now You, Not the Code
> "The real bottleneck is becoming myself and my creativity, not how fast I can ship."

- After switching to bypass mode, he "blasted through" his entire to-do list of features and bugs
- "Claude Code almost made no mistakes, and when it did they were tiny that weren't fatal"
- His feature/bug board (where users submit requests) was empty for the first time ever
- He fixed numerous small bugs on Nomads and RemoteOK that he "never got to because they weren't worth spending a day on, but Claude Code could fix in 1 minute"
- Shift your mindset: you are the creative director, Claude is the executor

**Source:** [x.com/levelsio/status/2027566773814403448](https://x.com/levelsio/status/2027566773814403448)

---

## Chapter 2: VPS Setup & Infrastructure

### Levels 2:1 — The $5 VPS Setup (Step by Step)
> "You pay Hetzner or DigitalOcean $5 and you have a VPS. You SSH into the server, then follow the instructions how to install Claude Code."

- Get a VPS from Hetzner ($5/mo) or DigitalOcean ($5/mo)
- SSH into it (he uses Termius as his SSH client)
- Install Claude Code:
  ```bash
  apt install npm
  npm install -g @anthropic-ai/claude-code
  claude
  ```
- Ask Claude to install Nginx: `"install an Nginx server and uninstall Apache"`
- Open your server's IP in Chrome -- you now have a live web server
- Ask Claude to build whatever you want -- it will pick the right stack
- "Treat it like a fun hobby server"

**Source:** [x.com/levelsio/status/1953022273595506910](https://x.com/levelsio/status/1953022273595506910), [x.com/levelsio/status/1957518592284717558](https://x.com/levelsio/status/1957518592284717558)

### Levels 2:2 — Secure Your Raw Dog VPS
> "HOW TO SECURE YOUR RAW DOG VPS SERVER"

- Disable password auth, use only key-based SSH auth (Hetzner/DO do this by default)
- Install fail2ban on SSH
- Enable unattended-upgrades with auto reboot
- Enable firewall in Hetzner/DO dashboard -- allow only ports 80 (HTTP), 443 (HTTPS), 22 (SSH)
- Use LetsEncrypt for SSL
- Optionally change SSH port from 22
- Use Cloudflare in front to avoid exposing the server's IP
- He runs a custom provisioning script on each new server to secure it

**Source:** [x.com/levelsio/status/1957526292045393976](https://x.com/levelsio/status/1957526292045393976)

### Levels 2:3 — Use Tailscale for Private Network Access
> "An easy way to keep your VPS secure is Tailscale. It creates a private network with just you and your servers in the cloud. Nobody else can access that."

- Install Tailscale on your laptop and your server
- Log in and add your server to the Tailscale network
- Get the server's Tailscale IP and SSH via that IP
- Creates a VPN-like mesh network -- only your devices can access the server
- Recommended security layers: Tailscale firewall for SSH, Cloudflare firewall for HTTPS

**Source:** [x.com/levelsio/status/1953440287163887639](https://x.com/levelsio/status/1953440287163887639)

---

## Chapter 3: Productivity Multipliers

### Levels 3:1 — Chat with Your Sites via Telegram
> "A dream I had finally came true: I can now chat directly with my sites to build any feature or fix any bug just via Telegram."

- Each of his sites runs on its own Hetzner VPS
- He installed `claude-code-telegram` as a system daemon on each server
- The daemon starts on boot and auto-restarts if it crashes
- When a Telegram message comes in, it opens a Claude Code session, resumes the previous session, processes the message, and sends the response back
- He can reply to server errors with "Ok fix this" and Claude Code on production will fix them
- He initially tried OpenClaw but found it less secure (Marc Kohlbrugge was able to hack it via social engineering)

**Source:** [x.com/levelsio/status/2023960543959101938](https://x.com/levelsio/status/2023960543959101938), [x.com/levelsio/status/2024507875356279026](https://x.com/levelsio/status/2024507875356279026)

### Levels 3:2 — Code from Your Phone
> "Finally can code on phone while gf is shopping!"

- Run Termius on iOS to SSH into your server
- Install Mosh for persistent connections that survive disconnects
- Mosh gives you a "perpetual tmux-style screen that stays alive even if you log out and log back in"
- Combine with Tailscale for secure mobile access to your VPS

**Source:** [x.com/levelsio/status/1951957270989783501](https://x.com/levelsio/status/1951957270989783501)

### Levels 3:3 — Let Claude Code Run in the Background with Notifications
> "Oh this is very smart. Let Claude Code run in background and message you on Telegram when it needs you."

- Don't sit and watch Claude Code -- let it work autonomously
- Set up Telegram notifications so it pings you when it needs input or finishes a task
- This frees you to work on other things while Claude ships features

**Source:** [x.com/levelsio/status/1955935964913611045](https://x.com/levelsio/status/1955935964913611045)

### Levels 3:4 — Connect Error Logs and Feature Boards to Claude Code
> "What if we connect my PHP, JS and server error logs AND the bug and feature request board to an AI that then writes the code and does pull requests that I then approve or reject?"

- His vision: a fully autonomous bug-fixing pipeline
- Error logs feed into Claude Code, which generates PRs
- Feature requests from users go directly to Claude Code
- He then just approves or rejects the resulting pull requests
- This is the logical endpoint of his "VibeOps" philosophy

**Source:** [x.com/levelsio/status/2027817837083955440](https://x.com/levelsio/status/2027817837083955440)

---

## Chapter 4: Why Claude Code Over Cursor

### Levels 4:1 — Claude Code Handles Big Files Better
> "Cursor was just too buggy the last few months and couldn't handle my big files. Claude Code never asks and almost never makes a bug."

- His codebases are famously large single files (e.g. the flight sim is 10,000+ lines in one file)
- Cursor would "lose understanding of what's going on" with big files
- Claude Code handles these monolithic files without complaint
- Note: he is an investor in Cursor but says "I'll use whatever works"

**Source:** [x.com/levelsio/status/1951024995309629718](https://x.com/levelsio/status/1951024995309629718), [x.com/levelsio/status/1920295482695561717](https://x.com/levelsio/status/1920295482695561717)

### Levels 4:2 — One-Shot Complex Features
> "I asked it to make this inpaint editor for Photo AI... it one shotted this glowing JS code for canvas."

- Claude Code can build entire features from a single prompt
- He built an inpaint editor with holographic brush strokes in one shot
- Built a custom cancel flow for Photo AI that dropped churn from 40% to 13-14%
- Built a UGC talking video feature for Photo AI
- Added voice upload feature -- "about 10 mins in Claude Code"
- Not every feature is a one-shot, but many are surprisingly close

**Source:** [x.com/levelsio/status/1945074345186824417](https://x.com/levelsio/status/1945074345186824417), [x.com/levelsio/status/1949861989322314094](https://x.com/levelsio/status/1949861989322314094), [x.com/levelsio/status/2026124907122143254](https://x.com/levelsio/status/2026124907122143254)

### Levels 4:3 — Claude Code Can Do Anything on the Server
> "I asked Claude Code 'can you write code to make you email as me' and it did in less than a minute (in Python). And then it sent me an email introducing itself!"

- Claude Code has full server access -- it can install packages, write daemons, send emails, configure services
- It is not just a code editor -- it is a full system administrator
- Ask it to set up monitoring, configure Nginx, install SSL, write cron jobs
- Example: he built UptimeCanary (an Uptimerobot clone) in ~5 hours, fully raw-dogged on a fresh $5 VPS

**Source:** [x.com/levelsio/status/1952131016052662443](https://x.com/levelsio/status/1952131016052662443), [x.com/levelsio/status/1959742279318491399](https://x.com/levelsio/status/1959742279318491399)

---

## Chapter 5: Levels's Creed

### Levels 5:1 — The "Deployments Are the Bottleneck" Thesis
> "AI lets us dev extremely fast and the bottleneck now is slow deployments many of us (not me) still have."

- Traditional CI/CD pipelines are too slow for AI-assisted development
- His workflow: SSH -> Claude Code -> code is live -> refresh browser -> done
- No Git, no PR reviews, no staging environments, no Docker, no Kubernetes
- This is deliberately anti-enterprise and only works for solo/small teams
- "I think that's where it's going" -- he sees this as the future of development

**Source:** [x.com/levelsio/status/2030495348972503160](https://x.com/levelsio/status/2030495348972503160)

### Levels 5:2 — Know When NOT to Use This Approach
> "Don't use it for anything sensitive. This is rawdog vibecoding chaos-style software development."

- He only uses this approach on pieter.com and new projects built from scratch
- His critical production sites (NomadList, RemoteOK, PhotoAI) are handled differently
- "If you DO go into production with something, hire a security auditor to check your code first"
- AI agents default to the most common patterns, not the most secure
- He uses one VPS per site -- isolation as a security strategy

**Source:** [x.com/levelsio/status/1957518592284717558](https://x.com/levelsio/status/1957518592284717558)

### Levels 5:3 — The Simplicity Stack
> "The tech stack is HTML CSS JS PHP all in one file."

- His famous approach: everything in a single PHP file, no frameworks, no libraries
- jQuery over React, SQLite over Postgres, PHP over Python
- This simplicity is what makes AI coding so effective -- fewer abstractions to confuse the model
- AI works best when the codebase is simple and self-contained
- "If you wanna know how overengineering in web dev is going: someone asked me how I built my startup and I made up an extremely convoluted tech stack. While in fact it's built with just PHP and jQuery."

**Source:** [x.com/levelsio/status/1200829430093901824](https://x.com/levelsio/status/1200829430093901824), [x.com/levelsio/status/1787437493807112379](https://x.com/levelsio/status/1787437493807112379)

### Levels 5:4 — Feature Request: "Just Go Mode"
> "My #1 feature request for Claude Code: stop asking me every time for confirmation by default, like 'can I check this folder', yes brother you can do anything you want. Add some [just go] mode."

- Even with "accept edits on," Claude Code still asks permission for non-edit operations
- He wants zero friction between intent and execution
- This frustration is what led him to adopt `--dangerously-skip-permissions`
- *Update: this wish was largely granted through `/sandbox` with auto-allow mode (reduces permission prompts by 84%) and the `bypassPermissions` permission mode*

**Source:** [x.com/levelsio/status/2011129631001170244](https://x.com/levelsio/status/2011129631001170244)

---

## Products Built or Enhanced with Claude Code

| Product | What Claude Code Did |
|---------|---------------------|
| Photo AI | Inpaint editor, UGC talking videos, cancel flow (churn 40% -> 13%), voice upload feature |
| pieter.com | 3D computer project, flight simulator enhancements |
| UptimeCanary | Built from scratch in ~5 hours on a $5 VPS |
| NomadList | City comparison feature (on todo list for 10+ years, done with Claude Code), small bug fixes |
| RemoteOK | Small bug fixes that "weren't worth spending a day on" |

---

## Source Threads

| Date | Thread | Topic |
|------|--------|-------|
| 2025-01-02 | [status/1945074345186824417](https://x.com/levelsio/status/1945074345186824417) | First Claude Code experience, Photo AI inpaint editor |
| 2025-01-20 | [status/1951764854580105453](https://x.com/levelsio/status/1951764854580105453) | "Claude ON production" -- vibecoding on steroids |
| 2025-01-20 | [status/1951703992263692503](https://x.com/levelsio/status/1951703992263692503) | What is a VPS, how to SSH and start Claude Code |
| 2025-01-20 | [status/1951957270989783501](https://x.com/levelsio/status/1951957270989783501) | Coding from phone with Termius + Mosh |
| 2025-01-20 | [status/1951024995309629718](https://x.com/levelsio/status/1951024995309629718) | Claude Code vs Cursor -- "never makes a bug" |
| 2025-01-21 | [status/1952131016052662443](https://x.com/levelsio/status/1952131016052662443) | Claude Code writing email-sending Python code |
| 2025-01-22 | [status/1953022273595506910](https://x.com/levelsio/status/1953022273595506910) | $5 VPS setup guide, install npm + Claude Code |
| 2025-01-22 | [status/1953026392301465709](https://x.com/levelsio/status/1953026392301465709) | Nginx setup for beginners |
| 2025-01-22 | [status/1953440287163887639](https://x.com/levelsio/status/1953440287163887639) | Tailscale for secure VPS access |
| 2025-01-25 | [status/1949861989322314094](https://x.com/levelsio/status/1949861989322314094) | Custom cancel flow for Photo AI |
| 2025-01-28 | [status/1950986615658070523](https://x.com/levelsio/status/1950986615658070523) | UGC talking video feature on Photo AI |
| 2025-02-02 | [status/1955935964913611045](https://x.com/levelsio/status/1955935964913611045) | Claude Code background + Telegram notifications |
| 2025-07-28 | [status/1957518592284717558](https://x.com/levelsio/status/1957518592284717558) | "HOW TO RAW DOG DEV ON THE SERVER" full guide |
| 2025-07-28 | [status/1957526292045393976](https://x.com/levelsio/status/1957526292045393976) | "HOW TO SECURE YOUR RAW DOG VPS SERVER" |
| 2025-08-01 | [status/1959012607270236619](https://x.com/levelsio/status/1959012607270236619) | IS_SANDBOX=1 + dangerously-skip-permissions tip |
| 2025-08-02 | [status/1959742279318491399](https://x.com/levelsio/status/1959742279318491399) | UptimeCanary built in 5 hours |
| 2026-01-19 | [status/2011129631001170244](https://x.com/levelsio/status/2011129631001170244) | "Just go mode" feature request |
| 2026-02-12 | [status/2023960543959101938](https://x.com/levelsio/status/2023960543959101938) | Telegram integration -- chat with your sites |
| 2026-02-13 | [status/2024507875356279026](https://x.com/levelsio/status/2024507875356279026) | claude-code-telegram as system daemon |
| 2026-02-16 | [status/2025962414085210559](https://x.com/levelsio/status/2025962414085210559) | Bash alias for permanent bypass mode |
| 2026-02-18 | [status/2026124907122143254](https://x.com/levelsio/status/2026124907122143254) | Voice upload feature in 10 mins |
| 2026-02-20 | [status/2020327472047247621](https://x.com/levelsio/status/2020327472047247621) | NomadList city comparison (10-year todo item done) |
| 2026-02-28 | [status/2027566773814403448](https://x.com/levelsio/status/2027566773814403448) | Bypass mode + "outrun my todo list" |
| 2026-02-28 | [status/2027817837083955440](https://x.com/levelsio/status/2027817837083955440) | Vision: error logs + feature board -> Claude Code -> PRs |
| 2026-03-08 | [status/2030495348972503160](https://x.com/levelsio/status/2030495348972503160) | Production workflow diagram -- deployments are the bottleneck |

---

*Last compiled: 2026-03-13*
