# CC Bible Launch Strategy

> 202 tips. 10 books. 10 commandments. The definitive Claude Code reference.

---

## 1. What's Missing Before Publishing

### Must-Have (Do Before Launch)

**LICENSE file**
Use `CC BY-SA 4.0` (Creative Commons Attribution-ShareAlike). This is the standard for curated knowledge collections — not MIT or GPL, which are for software. It lets anyone share and adapt, requires attribution, and keeps derivatives open. Add a `LICENSE` file and a one-liner in the README footer.

**CONTRIBUTING.md**
Keep it minimal. The CC Bible is curated, not crowdsourced. Suggested structure:
- How to submit a correction (open an issue with the verse number and source link)
- How to suggest a new verse (must include a public source URL)
- How to nominate a new "book" / expert (minimum threshold: 10+ original tips with public sources)
- What will NOT be accepted (promotional content, tools that aren't Claude Code)

**Table of Contents in README**
Add a clickable TOC at the top. GitHub renders anchor links natively. The current README is good but a TOC makes it scannable for first-time visitors.

**Badges in README header**
Add these before the Genesis intro paragraph:
```markdown
![Tips](https://img.shields.io/badge/tips-202-blue)
![Experts](https://img.shields.io/badge/experts-10-orange)
![Books](https://img.shields.io/badge/books-10-purple)
```

**Fix the Validation Report issues**
The VALIDATION_REPORT.md flags several outdated references (Shift+Tab behavior, `/effort` vs `/model`, skills path). Fix these before publishing — the first people to see this will be power users who will catch inaccuracies immediately.

**GitHub Topics**
When creating the repo, add these topics: `claude-code`, `claude`, `ai-coding`, `developer-tools`, `awesome-list`, `tips`, `best-practices`, `anthropic`, `agentic-coding`

**Social Preview Image (og:image)**
Create or commission a simple image: a stone tablet / scroll aesthetic with "The CC Bible" and "202 Tips from 10 Experts" on it. GitHub uses this for social cards when the repo is shared on Twitter/Reddit/Slack. Upload via Settings > Social Preview.

### Nice-to-Have (Can Add After Launch)

- A one-page website (GitHub Pages) with the same content, better typography
- A searchable index: all 202 verses in one flat list with tags (cost, workflow, architecture, etc.)
- A "Quick Start" section: the 10 commandments as a standalone starter for people who won't read everything
- Star history chart embedded in README once you hit 100+ stars

---

## 2. Where to Publish (Ranked by Impact)

### Tier 1 — Primary Launch (Same Day)

| Platform | Action | Why |
|----------|--------|-----|
| **X/Twitter** | Thread (see Section 5 for copy). Tag all 10 experts. | Boris's threads get 8M+ views. If even one expert retweets, it cascades. This is the #1 channel. |
| **Reddit r/ClaudeAI** | Post with a descriptive title, include the 10 Commandments inline. | 96K+ members. This is the core audience. |
| **Reddit r/ClaudeCode** | Cross-post or separate post. | 96K members, 4.2K weekly contributors. Highest-activity Claude Code community. |
| **Reddit r/ChatGPTCoding** | Post framed as "Claude Code tips from 10 experts including the creator." | Multi-tool audience. Many Cursor/Copilot users are Claude-curious. |
| **Hacker News (Show HN)** | `Show HN: The CC Bible – 202 Claude Code tips from 10 experts, organized like scripture` | AI tools + creative framing = HN catnip. Post Tuesday-Thursday, 8-10 AM ET. Write a first comment explaining the backstory. |

### Tier 2 — Amplification (Days 1-3)

| Platform | Action | Why |
|----------|--------|-----|
| **Dev.to** | Full article: "What 10 Claude Code Experts Agree On: The Ten Commandments." Embed the 10 commandments, link to repo for the full text. | Dev.to has strong SEO. Claude Code articles are already trending there. |
| **Hashnode** | Same article, different angle: "I compiled 202 Claude Code tips into a Bible. Here's what I learned." | Hashnode's newsletter feature pushes to subscribers. |
| **awesome-claude-code** | Open a PR to add CC Bible to hesreallyhim/awesome-claude-code (21.6K stars). | Being listed in the main awesome list is a permanent visibility multiplier. |
| **Claude Developers Discord** | Share in the appropriate channel. | Direct access to the most engaged Claude Code users. |

### Tier 3 — Long Tail (Week 1-2)

| Platform | Action | Why |
|----------|--------|-----|
| **Medium** | Republish the Dev.to article (use canonical URL pointing to Dev.to or your site). | Medium's algorithm surfaces AI content aggressively in 2026. |
| **LinkedIn** | Post for the professional developer audience. Frame as "I studied how 10 experts use AI coding tools. Here are the 10 universal truths." | LinkedIn loves numbered lists and "I studied X" framing. |
| **Reddit r/programming** | Only if HN or Reddit r/ClaudeCode gets traction first. Frame as general developer productivity, not Claude-specific. | 6M+ members but aggressive moderation. Need social proof first. |
| **Product Hunt** | Only worth it if you build a website/tool around it. A raw GitHub repo won't perform well on PH. | PH rewards interactive products, not static docs. Consider this if you build a searchable web version. |
| **YouTube/Shorts** | 60-second video: "I read everything 10 Claude Code experts ever posted. Here are the 10 things they all agree on." | Short-form AI content is exploding. Even a simple screen recording with narration works. |

---

## 3. Who to Tag/Notify

### The 10 Experts (Tag on X/Twitter)

These people are the source material. If even one engages, it validates the entire project.

| Expert | Handle | Priority | Why They Might Engage |
|--------|--------|----------|----------------------|
| Boris Cherny | [@bcherny](https://x.com/bcherny) | HIGHEST | Creator of Claude Code. His threads get millions of views. Being cited as the Genesis figure is flattering. |
| Andrej Karpathy | [@karpathy](https://x.com/karpathy) | HIGH | 1.7M followers. Shares developer tools. The "Prophet" archetype will appeal to his audience. |
| Pieter Levels | [@levelsio](https://x.com/levelsio) | HIGH | Loves being called a heretic. Contrarian branding is on-brand for him. Will engage if the framing amuses him. |
| Affaan Mustafa | [@affaanmustafa](https://x.com/affaanmustafa) | HIGH | His work is extensively cited. He's proven he engages with community content. |
| Matt Pocock | [@mattpocockuk](https://x.com/mattpocockuk) | HIGH | Active engager, shares developer tools constantly. The "Craftsman" archetype fits his brand. |
| Alex Albert | [@alexalbert__](https://x.com/alexalbert__) | MEDIUM | Head of Claude Relations at Anthropic. May share officially. |
| Cat Wu | [@_catwu](https://x.com/_catwu) | MEDIUM | PM for Claude Code. May share if the content is accurate and helpful. |
| Thariq Shihipar | [@trq212](https://x.com/trq212) | MEDIUM | Lower profile but deeply respected in the Claude Code community. |
| Matt Shumer | [@mattshumer_](https://x.com/mattshumer_) | MEDIUM | Active on AI Twitter. The "Sorcerer" archetype is memorable. |
| Elvis Saravia | [@omarsar0](https://x.com/omarsar0) | MEDIUM | DAIR.AI audience is highly engaged with practical AI content. |

### Community Accounts to Tag

| Account | Handle | Why |
|---------|--------|-----|
| Claude Code Community | [@claude_code](https://x.com/claude_code) | 38K followers. Community account that shares Claude Code resources. |
| Anthropic | [@AnthropicAI](https://x.com/AnthropicAI) | Official account. Long shot but worth tagging. |
| Claude | [@claudeai](https://x.com/claudeai) | Official Claude account. |

### DM Strategy (Before Public Post)

Send a short, respectful DM to 3-4 of the experts 24-48 hours before launch:

> "Hey [Name], I compiled 202 Claude Code tips from you and 9 other experts into a structured reference called the CC Bible. Your section is the Book of [Name] — [Archetype]. Wanted to give you a heads-up before I publish. Here's the link: [repo]. Let me know if anything needs correction."

This does three things: (1) gives them a chance to flag errors, (2) primes them to see the public post, (3) builds goodwill. Do NOT ask them to retweet.

---

## 4. Timing

### Best Launch Window

**Tuesday or Wednesday, 9:00 AM ET (14:00 UTC)**

Rationale:
- Twitter/X engagement peaks Tuesday-Wednesday, 8-10 AM ET for developer/tech audiences
- Hacker News front page is achievable Tuesday-Thursday, 8-10 AM PT (11 AM ET)
- Reddit developer subreddits peak during US work hours
- Avoids Monday (inbox overload) and Friday (checkout mode)

### Launch Sequence

| Time | Action |
|------|--------|
| T-48h | DM 3-4 experts with preview link |
| T-24h | Final review. Fix any issues flagged by experts. Ensure repo is public. |
| T-0 (9:00 AM ET) | Post Twitter thread. Post to r/ClaudeAI and r/ClaudeCode simultaneously. |
| T+15min | Submit to Hacker News as "Show HN." Write introductory comment immediately. |
| T+1h | Post to r/ChatGPTCoding. |
| T+4h | Publish Dev.to article. |
| T+24h | Post Hashnode article. Submit PR to awesome-claude-code. |
| T+48h | Share on LinkedIn. Post to Claude Developers Discord. |
| T+1 week | Medium republish. Evaluate if Product Hunt / YouTube is worth pursuing. |

---

## 5. Title/Headline Options

### For the GitHub Repo Name

Keep the repo name `cc-bible`. It's short, memorable, and searchable.

### For the GitHub Repo Description (the one-liner under the repo name)

> 202 Claude Code tips from 10 experts — organized like scripture. The Ten Commandments every developer should know.

### For Twitter/X Thread (Pick One)

**Option A — The Authoritative Frame**
> I read everything 10 Claude Code experts ever posted — Boris Cherny, Karpathy, Pieter Levels, and 7 others.
>
> 202 tips. 10 books. 10 commandments.
>
> I organized it like a Bible. Here are the 10 things they all independently agree on:

**Option B — The Curiosity Hook**
> The creator of Claude Code ships 20-30 PRs a day.
> Karpathy went from 80% manual to 80% agent.
> Pieter Levels codes on production from his phone.
>
> I compiled 202 tips from all of them into one reference. The CC Bible.

**Option C — The Contrarian Frame**
> Everyone has Claude Code tips. Nobody organized them.
>
> So I read every tweet, talk, and interview from the 10 biggest Claude Code experts. Extracted 202 concrete tips. Found the 10 things they ALL independently agree on.
>
> The CC Bible is live:

**Option D — The Bible Frame (Lean Into the Metaphor)**
> In the beginning, there was the terminal. And Boris said: "Let there be Claude Code."
>
> 10 experts spoke. 202 verses were written. 10 commandments emerged.
>
> The CC Bible — the collected wisdom of Claude Code's prophets, disciples, and heretics.

**Option E — The Numbers Frame**
> 10 experts. 202 tips. 10 commandments.
>
> Boris (creator), Karpathy (1.7M followers), Pieter Levels (heretic), Affaan (42K+ stars), and 6 more.
>
> Every tip sourced. Every claim linked. The definitive Claude Code reference.

### For Hacker News

> Show HN: The CC Bible – 202 Claude Code tips from 10 experts, organized like scripture

### For Reddit

> I compiled 202 Claude Code tips from Boris Cherny, Karpathy, Pieter Levels, and 7 other experts into a structured reference. Here are the 10 things they all agree on.

### For Dev.to / Hashnode

> What 10 Claude Code Experts Independently Agree On: The Ten Commandments of AI-Assisted Development

---

## 6. What Worked for Similar Projects

### everything-claude-code (Affaan Mustafa) — 50K+ Stars

**What he did:**
- Built genuine credibility first (Anthropic hackathon winner, daily Claude Code user for 10+ months)
- Shared practical, non-hype content — "what actually works after grinding through the learning curve"
- Created a comprehensive, single-stop resource (agents, skills, hooks, commands, rules)
- Let the community discover and share it organically
- Wrote longform guides that got 3M+ combined views across platforms

**Lesson for CC Bible:** Authenticity and comprehensiveness beat marketing. The guide went viral because it was the most useful thing available, not because of clever promotion.

### awesome-claude-code (hesreallyhim) — 21.6K Stars

**What he did:**
- Curated selectively (not everything, just the best)
- Maintained consistent quality standards
- Got listed in meta-lists and cross-referenced by other repos
- Kept the format scannable with emoji indicators for star counts

**Lesson for CC Bible:** Getting listed in awesome-claude-code is a permanent visibility multiplier. Submit a PR in week 1.

### Boris Cherny's Twitter Threads — 8M+ Views

**What he did:**
- Shared from the position of "I built this, here's how I use it"
- Kept tips concrete and actionable (not abstract philosophy)
- The "surprisingly vanilla" angle was counterintuitive and memorable
- Created howborisusesclaudecode.com as a permanent reference from the threads
- VentureBeat and other outlets amplified with "developers are losing their minds" framing

**Lesson for CC Bible:** The experts' names ARE the distribution. Tagging Boris and Karpathy isn't just attribution — it's the primary growth mechanism.

### OpenClaw — 157K Stars in 60 Days (Cautionary Tale)

**What happened:**
- Achieved 34K stars in 48 hours through aggressive community seeding
- Reached 157K stars within 60 days
- Within 3 days of crossing 100K, researchers found 341 malicious "skills" embedded in the collection
- Imploded due to trust collapse

**Lesson for CC Bible:** Quality and trust matter more than speed. Every tip in the CC Bible links to its source — this is a differentiator. Lean into "every claim is verified and sourced" as a trust signal.

### General Patterns from Repos That Went Viral

From research across multiple case studies:

1. **The README IS the product.** For a curated collection, the README is the first and often only thing people see. It needs to communicate value in 5 seconds.

2. **Expect to spend 50% of time on non-code work.** Documentation, social posts, responding to comments, fixing issues reported by early users.

3. **Reddit is the best way to get initial stars.** Find the right niche community (r/ClaudeCode, r/ClaudeAI) rather than spraying to generic subreddits.

4. **HN lifecycle is ~3 days.** Plan your launch to extract maximum value from that window. Be ready to respond to every HN comment for 24 hours.

5. **Stars beget stars.** Once you hit ~50 stars, the social proof effect kicks in. Getting those first 50 is the hardest part — that's where direct outreach to experts matters most.

6. **Post around 9 AM ET.** Research across Twitter, HN, and Reddit consistently points to Tuesday-Wednesday, 8-10 AM ET as the sweet spot for developer content.

7. **Your first comment is everything on HN.** Write a personal, non-promotional explanation of why you built it. HN voters reward authenticity and punish marketing speak.

---

## 7. What Makes the CC Bible Unique (Viral Potential Analysis)

### The Bible Metaphor
This is the single biggest differentiator. Developer tip collections are a dime a dozen. A "Bible" with books, verses, commandments, and archetypes is memorable and shareable. People will talk about "The Book of Karpathy" and "The Book of Levels" — that's word-of-mouth fuel.

**Risk:** Some may find the religious framing tasteless. Mitigate by keeping the tone reverent-but-playful (which the current README already does well). The Genesis opening paragraph is perfect.

### The Expert Archetypes
"The Creator," "The Heretic," "The Prophet," "The Scribe" — these are sticky labels. Pieter Levels being called "The Heretic" who "codes on production" is the kind of thing people screenshot and share. Karpathy as "The Prophet" resonates with his audience.

**Viral mechanic:** Each expert's followers become a distribution channel. When Karpathy sees he's "The Prophet," his 1.7M followers potentially see it too.

### The Ten Commandments
Universal truths that all 10 experts independently agree on. This is the most shareable piece of the project. A single image or thread of the 10 commandments is a self-contained piece of content that drives people to the full repo.

**Tactic:** Make the Ten Commandments the centerpiece of every social post. It's the hook. The 202 verses are the depth that earns stars.

### Cross-Referenced Expert Agreement
The fact that tips are sourced, linked, and cross-referenced is unusual for this type of content. Most "awesome lists" are link dumps. The CC Bible is closer to an annotated bibliography — it synthesizes, compares, and highlights where experts agree and disagree.

### 202 is a Specific, Impressive Number
"200+ tips" is forgettable. "202 tips" is specific enough to be credible. It signals exhaustive research without round-number inflation.

---

## Summary: The 5 Things That Will Matter Most

1. **Tag the experts on Twitter.** If Boris or Karpathy retweets, nothing else matters. This is 80% of the strategy.
2. **Lead with the Ten Commandments everywhere.** It's the hook that's self-contained and shareable.
3. **Post to r/ClaudeCode and r/ClaudeAI on launch day.** Reddit is where the early stars come from.
4. **Submit to Show HN on Tuesday/Wednesday, 9 AM ET.** Write a genuine first comment. Respond to everything.
5. **Get listed in awesome-claude-code.** This is the long-tail play that keeps delivering stars for months.

---

*Strategy compiled 2026-03-13*
