---
description: "Auto-detect and run project verification. Find tests, linters, build scripts. Run all, iterate on failures up to 3x."
allowed-tools: "Bash, Read, Glob"
---

# Commandment II: Give Claude a Feedback Loop

Detect and run ALL available verification for this project. Iterate on failures.

## Step 1: Detect Stack

Look for these in order:

**Build:**
- `package.json` → check `scripts.build`
- `go.mod` → `go build ./...`
- `Cargo.toml` → `cargo build`
- `Makefile` → `make`
- `pyproject.toml` / `setup.py` → check for build commands

**Lint:**
- `biome.json` / `biome.jsonc` → `npx biome check`
- `.eslintrc*` / `eslint.config.*` → `npx eslint .`
- `.flake8` / `ruff.toml` → `ruff check` or `flake8`
- `.golangci.yml` → `golangci-lint run`
- `Cargo.toml` → `cargo clippy`

**Test:**
- `package.json` → check `scripts.test` (jest, vitest, mocha, etc.)
- `pytest.ini` / `conftest.py` → `pytest`
- `go.mod` → `go test ./...`
- `Cargo.toml` → `cargo test`

**Type check:**
- `tsconfig.json` → `npx tsc --noEmit`

## Step 2: Run Verification

Run in order: **build → lint → typecheck → test**

On each step:
- If it passes, move to the next
- If it fails, read the error output, fix the issue, re-run (max 3 iterations per step)
- After 3 failed attempts on the same step, report the remaining failures and move on

## Step 3: Report

Print a final status table:

```
Build:     PASS/FAIL
Lint:      PASS/FAIL
Typecheck: PASS/FAIL (or N/A)
Tests:     PASS/FAIL (X passed, Y failed)
```

If everything passes, say so. If failures remain, list them concisely.
