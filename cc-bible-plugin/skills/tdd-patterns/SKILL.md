---
name: tdd-patterns
description: "Knowledge base for test-driven development. Consulted by tdd-guide agent. Contains vertical slicing rules, interface design principles, mocking rules, and testing strategies from Claude Code experts."
---

# TDD Patterns

## Vertical Slicing (Pocock)

The #1 rule of TDD with Claude Code: **ONE test, ONE implementation, repeat.**

Never horizontal slice (write all tests first, then all implementation). This is how LLMs cheat — they write tests that match the implementation they already planned, not tests that drive the design.

Vertical slicing forces:
- Each test to be meaningful on its own
- The implementation to emerge from the tests
- Immediate feedback on whether the design works

## The RED-GREEN-REFACTOR Cycle

**RED:** Write a failing test. It must fail for the RIGHT reason (the behavior doesn't exist yet, not because of a syntax error or wrong import).

**GREEN:** Write the MINIMUM code to pass. No more. Don't anticipate future tests. The simplest thing that could possibly work.

**REFACTOR:** Only when all tests are green. Look for duplication, unclear names, functions doing too many things. Run tests after every refactor.

## Interface Design Principles (Pocock)

Tests should drive you toward good interfaces:

- **Accept dependencies, don't create them:** `processOrder(order, gateway)` not `const gateway = new PaymentGateway()` inside the function
- **Return results, don't produce side effects:** Return the result and let the caller decide what to do with it
- **Small surface area, deep modules:** Few public methods, rich internal behavior
- **Test behavior, not implementation:** If renaming an internal variable breaks tests, those tests are wrong

## Mocking Rules

Mock ONLY at system boundaries:
- External APIs (HTTP calls)
- Databases (queries)
- File system (reads/writes)
- Time (`Date.now()`, timers)
- Randomness (`Math.random()`)

NEVER mock:
- Internal modules
- Utility functions
- Data transformations
- Business logic

If you need to mock an internal module, that's a design smell — the boundary is in the wrong place.

## Test Types and When to Use Them

- **Unit tests:** Always. Test individual functions/components through their public API
- **Integration tests:** Always. Test that components work together correctly
- **E2E tests:** For critical user paths. Login, checkout, data export — the flows that cost money when broken

## Pass@k vs Pass^k (Affaan)

- **Pass@k:** Run the same test k times, pass if ANY run succeeds (flaky-tolerant)
- **Pass^k:** Run the same test k times, pass only if ALL runs succeed (strict)

For CI, you want pass^k. A test that passes 9/10 times has a bug — find it.

## Testing Anti-Patterns

- Testing private methods directly (test through the public API instead)
- Asserting on log output (logs are for humans, not tests)
- Tests that depend on execution order (each test should be independent)
- Testing the framework (don't test that React renders — test what YOUR component renders)
- Snapshot tests as the only tests (they verify that nothing changed, not that it's correct)
