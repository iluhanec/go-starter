# AGENTS.md

This file defines how automated coding agents should work in this Go repository.
Follow these instructions unless the user explicitly overrides them.

## Priority order (when instructions conflict)

1. The user’s current request (most important)
2. This AGENTS.md
3. Existing repository conventions (code patterns, docs, CI rules, lint config)

---

## Core principles

- **Smallest safe change:** Make the minimal set of changes required to achieve the goal.
  - Avoid drive-by refactors, renames, reformatting, or “while I’m here” cleanups.
  - Refactor only when necessary for correctness/design, or when explicitly requested.
- **Match existing conventions:** Prefer the repo’s established patterns over inventing new ones.
- **No surprise scope:** If the work expands beyond the request, stop and explain why.

---

## Workflow

### 1) Orient first (before writing code)

- Read the relevant packages, existing tests, and any related docs/tech specs.
- Check the Makefile targets and existing CI/lint expectations.
- Identify the smallest end-to-end slice that proves the requested behavior.

### 2) Plan (and confirm when appropriate)

- For **non-trivial** work (new behavior, API changes, touching multiple packages, migrations, new dependencies),
  propose a short plan (bullets) and **ask for confirmation** before implementation.
- For **trivial** work (small bugfix, typo, localized test fix), state a 1–2 line plan and proceed.

A good plan includes:

- What will change (key files/packages)
- What tests will be added/updated
- Any risks or compatibility concerns
- Documentation updates (if any)

### 3) Implement with TDD (red → green → refactor)

- Use **outside-in** TDD:
  1. Start with the simplest high-level test that validates user-visible behavior (app/module/function from the caller’s perspective).
     Examples: CLI exits successfully, HTTP handler returns expected status/body for the simplest route, etc.
  2. After finishing each test:
     1. Run `make fmt-check` and fix formatting issues
     2. Run `make lint` and fix linting issues
     3. Run `make test` and check that the test you created fails with expected error
     4. Ask the user if he wants to proceed and wait for an answer
  3. After finishing implementation that satisfies a failed test from step 2:
     1. Run `make fmt-check` and fix formatting issues
     2. Run `make lint` and fix linting issues
     3. Run `make test` and check that the test you created suceeds
     4. Ask the user if he wants to proceed and wait for an answer
  4. Then work inward with more focused tests (package/unit) as needed to drive design and edge cases.
- Keep tests **clear, fast, and deterministic**.

### 4) TDD as a design tool (mandatory reflection step)

After writing each test, evaluate:

- Was the test easy to write and easy to read?
- Is the API/abstraction pleasant to use from the caller’s perspective?

Write answers to these questions explicitly, so the user can check that you do the design evaluation.

If the test requires awkward setup, excessive mocking, or unclear flows:

- Propose a design/API change that improves usability.
- Wait for the user to answer to your proposal before proceeding.
- Update the relevant tech spec to reflect the decision.

---

## Documentation (living tech specs)

Maintain Markdown tech specs under `docs/tech-spec/`.

- A tech spec is a **living document** for a subsystem or meaningful change. It captures:
  - Requirements and constraints
  - Architecture and design
  - Key decisions and trade-offs
  - Diagrams (UML/sequence/component) as Mermaid in Markdown
  - Testing strategy and rollout/migration notes (if applicable)
  - Security/observability considerations (if applicable)

### When to update vs create

- **Update an existing spec** when evolving an existing subsystem/feature.
- **Create a new spec** for a new subsystem or a major change that introduces new architecture or public surface.

### Naming

- `docs/tech-spec/001-feature-abc.md` (3-digit prefix, short descriptive slug)

### Recommended sections (adapt as needed)

- Context
- Goals / Non-goals
- Proposed design
- Alternatives considered
- Decisions (what we chose and why)
- Testing strategy
- Rollout / migration (if applicable)
- Observability & security notes (if applicable)
- Open questions

---

## Tooling and verification

This repository uses a Makefile to automate common tasks.

### Quick local loop (during development)

Run the fastest checks that give feedback:

- `make fmt-check`
- `make lint`
- `make test` (or the smallest relevant subset, if available)

### Before final handoff

Run the full verification set:

- `make fmt-check`
- `make lint`
- `make test`
- `make build`

---

## Handoff expectations (what to report back)

When you finish, provide:

- A brief summary of what changed and why
- List of key files/packages touched
- What tests were added/updated
- Which verification commands were run (and their results)
- Any follow-ups, risks, or open questions
