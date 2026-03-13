---
description: "Test-driven development with vertical slicing. ONE test, ONE implementation, repeat. Dispatch tdd-guide agent."
allowed-tools: "Read, Write, Edit, Bash, Grep, Agent"
argument-hint: "[feature to build]"
---

# Commandment II (TDD): Test-Driven Development

Dispatch the `tdd-guide` agent to enforce strict RED-GREEN-REFACTOR with vertical slicing.

The agent will:
1. Ask which behavior to test first
2. Write ONE failing test (RED)
3. Run it — verify it fails for the right reason
4. Write minimal code to pass (GREEN)
5. Run it — verify it passes
6. Refactor only when all tests pass (REFACTOR)
7. Repeat with next behavior

**Feature to build:** $ARGUMENTS
