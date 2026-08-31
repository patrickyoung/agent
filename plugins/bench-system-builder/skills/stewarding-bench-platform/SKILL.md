---
name: stewarding-bench-platform
description: Installs and governs the Bench runtime, checks, identities, connections, effects, and operations. Use when a Bench build needs platform, IT, or security ownership.
license: MIT
metadata:
  author: patrickyoung
  version: "0.1.0"
  bench-suite: "0.13.0"
  agent: "0.2.1"
---

# Stewarding the Bench platform

Provide the smallest reviewed execution, evidence, identity, effect, and
operating boundary needed by an approved Bench system design. Use public release
artifacts and public command contracts; consumers do not need the source
repositories.

## Route and authority

Use this skill for a named platform, IT, security, data, or integration owner.
Do not use it to invent the business outcome or approve business risk on the
owner's behalf. A design handoff is a request for decisions, not authorization
to install, authenticate, expose a service, widen egress, schedule, or execute
an effect.

## Standing rules

- Verify exact targets, identities, versions, checksums, roots, and scopes before
  changing anything.
- Never print or store tokens, cookies, secrets, headers, or credential values in
  chat, Agent homes, skill files, argv, ordinary environment variables, or logs.
- Use one pinned suite. Independently resolving current components is not a
  compatible release.
- Prefer a toolbox and no network. Full shell, egress, computer use, connectors,
  and effects are explicit reviewed grants.
- Keep controller state, checks, expected labels, policies, credentials,
  schedules, and receipts outside worker write authority.
- A Claude permission prompt is not a Bench Action/May receipt. Cage is not a
  complete confidentiality, identity, secret, or resource boundary.
- Stop on checksum failure, version mismatch, missing owner, verifier ambiguity,
  changed connector digest, confinement failure, effect uncertainty, or an
  authority request beyond the approved design.

## 1. Review the handoff

Require a `STEWARD-HANDOFF.md` or equivalent containing:

- accountable business owner and admitted outcome;
- Claude surface and execution location;
- desired suite version and observed runtime;
- workspace, worker roots, and external controller-evidence root;
- source resources, identities, scopes, sensitivity, and revocation owners;
- proposed effects, policy, review, receipts, and unknown handling;
- check owner, case oracle, budgets, schedule, incident, and retirement plan.

Return missing decisions to their owner. Do not fill them with platform defaults
when they change the business obligation or risk.

## 2. Choose the execution path

Read [source-free-install.md](references/source-free-install.md) for a local
Claude Code or managed-host installation. Read
[cowork-integration.md](references/cowork-integration.md) for Cowork.

Select one:

- **LOCAL-PINNED-SUITE** — compatible macOS/Linux host, explicit install prefix,
  narrow OS identity, dedicated workspace, and external state roots.
- **MANAGED-BENCH-RUNTIME** — a versioned service or connector exposes typed
  high-level Bench operations and returns literal artifacts, statuses, and
  evidence.
- **DESIGN-ONLY** — no execution bridge; accept business artifacts but make no
  build or run claim.

Document why the path preserves the required guarantees.

## 3. Install and verify the suite

For a local install, use the checksummed release archive. Never clone source as
an undocumented prerequisite, never use `@latest`, and never pipe a download to
a shell. Obtain explicit approval for the prefix and operating identity.

After installation, verify all eighteen public commands and their pinned
versions, run the suite's offline checks, inspect `cage status`, and record the
release checksum, suite manifest, host OS/architecture, prefix, and rollback
path. A mixed or missing command set is not usable.

## 4. Establish write domains and identities

Create separate ownership for:

- governed Agent definition and procedures;
- worker-writable `work/`, `state/`, and temporary space;
- executable check, fixtures, and external holdout oracle;
- controller sessions, run receipts, Action policy, May state, Tend state, and
  schedules;
- connector definitions and OAuth credentials.

Use a narrow workload or OS identity. Remove ambient credentials and readable
sensitive paths. For high-stakes unattended work, require a sealed task runtime,
workload identity, credential/effect proxy, quotas, and signed capability policy
rather than treating Cage or interface isolation as the complete boundary.

## 5. Review the verifier

Read [checks-and-security.md](references/checks-and-security.md). Independently
review the check's code, interpreter, dependencies, read/write reach, timeout,
output bound, determinism, negative cases, mutation coverage, and claim limits.

Admit the exact verifier only after review. Preserve its digest and authority.
The worker must not modify the check, its expected answers, or controller
receipts.

## 6. Provision evidence connections

Read [connections-and-effects.md](references/connections-and-effects.md). Begin
with sanitized fixtures, then add read-only resources one at a time.

For each connection record resource, account/workload identity, exact scopes,
freshness, sensitivity, egress, descriptor digest, owner, rotation, revocation,
and prompt-injection exposure. Discovery does not admit a capability.

Use Context for normalized read connectors; digest-admitted MCP capabilities for
reviewed protocol edges; OAuth for one resource-bound credential passed to one
exact child. Keep tokens out of the home and model environment.

## 7. Provision effects separately

Do not put an effectful MCP tool, browser action, full shell, or connector in the
worker's direct toolbox by convenience. Compile a reviewed Action connector.
Define deterministic policy with allow, deny, or May review. Bind one human
decision to one exact action and job, execute once, and retain attempt/sent/result
receipts.

Require idempotency or reconciliation keys. Define who investigates status 125
and prohibit automatic retry while effect state is unknown.

## 8. Set budgets, operation, and retirement

Read [operations.md](references/operations.md). Admit finite time, turn, cycle,
output, data, cost, proposal, effect, retry, and supervision budgets.

Keep business cadence, Agent wake behavior, external scheduling, and Tend
supervision distinct. For Cowork schedules, prove every dependency is available
to a fresh cloud session. Configure monitoring around public statuses and
controller evidence, not private file formats or persuasive model summaries.

Test pause, incident, reconciliation, rollback, credential revocation, evidence
retention, and retirement before a production pilot.

## 9. Issue a readiness decision

Fill `assets/PLATFORM-READINESS.md` with `pass`, `fail`, or `unknown` and exact
evidence for every gate. Return one state:

- **DESIGN-SUPPORTED** — artifacts can be produced; execution absent.
- **BUILD-RUNTIME-READY** — compatible suite/integration, roots, verifier, and
  fixture-only build boundary are ready.
- **CONTROLLED-PILOT-READY** — approved read connections, budgets, monitoring,
  incident, and retirement controls are also ready.
- **EFFECT-PILOT-READY** — each effect has typed proposal, policy, conditional
  exact review, credentialed connector, receipts, and uncertainty response.

Do not issue “production ready” or “unattended safe” from these gates.

## User-visible handoff

Report the readiness state, exact release/integration, evidence paths, admitted
roots and identities, present/absent capabilities, failed or unknown gates,
rollback and revocation path, and smallest next decision with its owner.

## Bundled resources

- [PLATFORM-READINESS.md](assets/PLATFORM-READINESS.md) — evidence-backed gate
  decision.
- [CONNECTION-REVIEW.csv](assets/CONNECTION-REVIEW.csv) — resource, identity,
  scope, credential, and revocation register.
- [CHECK-REVIEW.md](assets/CHECK-REVIEW.md) — verifier authority and claim
  boundary review.
