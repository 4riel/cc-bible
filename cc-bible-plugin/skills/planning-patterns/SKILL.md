---
name: planning-patterns
description: "Knowledge base for implementation planning. Consulted by plan-reviewer agent and /plan-first command. Contains planning workflows, plan formats, and evaluation criteria from 10 Claude Code experts."
---

# Planning Patterns

## The Planning Workflow (Cat)

Every non-trivial task follows: **Explore → Plan → Implement → Commit**

1. **Explore** — Read relevant files. Understand current architecture before proposing changes. Follow existing patterns.
2. **Plan** — Produce a concise plan. List unresolved questions FIRST. Define success criteria.
3. **Implement** — Execute the plan. Run verification after each change.
4. **Commit** — Clean commit with descriptive message.

## Plan Format (Pocock + Karpathy)

A good plan has:

- **Unresolved questions** (FIRST — these block everything)
- **Objective** in one sentence with declarative success criteria
- **Approach** — what you'll do and WHY this approach over alternatives
- **Files to create/modify** — each with a one-line description
- **Dependencies** — new packages, services, APIs needed
- **Phases** — ordered by dependency, sized as:
  1. Minimum viable (works end-to-end, even if ugly)
  2. Core features (full functionality)
  3. Edge cases (error handling, validation)
  4. Optimization (performance, cleanup)

Keep the plan under 100 lines. If it's longer, the task needs decomposition.

## The Two-Plan Technique (Pocock)

When there are multiple viable approaches:

1. Generate 2 different implementation plans
2. For each: 3-5 sentence description, pros, cons, main risk
3. Compare explicitly
4. Recommend one with reasoning

Agents greedily sample the first plan they think of. Forcing alternatives often produces better architecture.

## Plan Evaluation Criteria

**Must have:**
- Clear, measurable success criteria (not "implement auth" but "user can log in with email, receives JWT, token expires in 24h")
- Dependency ordering (don't build the roof before the walls)
- Test strategy (what gets tested, what doesn't, why)

**Red flags:**
- Plan is over 100 lines (needs decomposition)
- No unresolved questions listed (means you haven't thought hard enough)
- Everything is phase 1 (means nothing is prioritized)
- Vague success criteria ("works correctly", "handles errors")

## Boris's Two-Claude Pattern

For complex tasks: one Claude plans, another reviews. The planner has creative freedom. The reviewer has fresh eyes. This is why `/plan-first` offers to dispatch `plan-reviewer` — it's the two-Claude pattern in practice.
