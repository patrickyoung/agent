---
name: operating-bench-agents
description: Operates, diagnoses, changes, and retires an existing Bench Agent home. Use for pilots, runs, incidents, schedules, learning, amendments, or shutdown.
license: MIT
metadata:
  author: patrickyoung
  version: "0.1.0"
  bench-suite: "0.13.0"
  agent: "0.2.1"
---

# Operating Bench agents

Operate an existing directory-shaped worker from its admitted definition,
public commands, executable verdict, and controller evidence. Keep business
ownership visible. Do not replace recorded state with a chat summary.

## Route the request

Use this skill after an Agent home exists. A request to define a new business
job or create the first home is a build task. A request to install the suite,
provision identities/connectors, approve a production verifier, or configure
organization runtime policy is a platform-steward task.

## Standing rules

- Inspect before running. Never infer readiness from a folder name or prior
  conversation.
- Preserve literal exit statuses and unknown outcomes. Status 125 is never
  permission to retry automatically.
- Do not print secrets or environment values. Report resource, identity, scope,
  and capability presence only.
- Keep the worker away from May, Action policy, connectors, OAuth credentials,
  schedules, and controller evidence except through their public controller
  seams.
- Do not widen network, shell, filesystem, connector, or effect authority from a
  routine run request.
- A correction to one result is not automatically a reusable lesson. A skill
  change requires verified failed-then-passed evidence and exact review.
- Pause new work before incident response, authority changes, or retirement.

## 1. Establish operating state

Read [runtime-and-surfaces.md](references/runtime-and-surfaces.md). Identify the
exact Agent home, accountable owner, skill/runtime versions, execution location,
and intended operation. Run only read-only public inspection:

```text
agent version
agent check HOME
agent show HOME
agent history HOME check
```

Classify:

- **OPERABLE** — compatible runtime, structurally valid home, inspected
  composition, known owner, explicit operation, and required evidence roots.
- **PAUSED** — the home is valid but a human decision, budget, connection,
  schedule, or incident blocks new work.
- **BROKEN** — check, history, definition, confinement, or runtime is invalid.
- **STEWARD-REQUIRED** — runtime, identity, credential, verifier, connector, or
  production control is missing or incompatible.

Do not run in the last three states.

## 2. Select one operation

Read [runbook.md](references/runbook.md). Distinguish:

- **run** — pursue the durable goal now;
- **tick** — run the cheap wake probe and call a model only when work exists;
- **schedule** — an outer system decides when a fresh invocation begins;
- **supervise** — Tend persists process transitions and explicit uncertainty;
- **inspect** — Trail/Agent history reads retained evidence;
- **act** — controller policy and conditional May review execute one proposal;
- **learn/amend** — propose and exactly review a durable definition change;
- **retire** — stop work, reconcile, revoke, retain, and close ownership.

Ask for the smallest missing decision. Do not combine a routine run with an
authority change or a schedule with an effect approval.

## 3. Admit the run envelope

Before a model-backed operation, show:

- Agent home and compiled definition digest when available;
- goal, input fixture or unit of work, and checkpoint semantics;
- model and reasoning policy;
- toolbox, shell, Cage, network, and writable roots;
- time, turn, cycle, output, data, cost, proposal, and effect budgets;
- check command and controller authority;
- behavior for denial, timeout, interruption, broken verifier, and unknown
  effect.

Obtain approval for this run envelope. Approval does not carry into later runs
or widen the standing definition.

## 4. Run and preserve evidence

Use the literal public command appropriate to the operation. Record stdout,
stderr, exit status, terminal reason, evidence path, and next human decision in
the template from `assets/OPERATING-RECORD.md`.

For an accepted run, still review external business measures on the admitted
cadence. For negative, broken, denied, parked, interrupted, or unknown results,
preserve the exact state and stop. Do not paraphrase it into a successful answer.

## 5. Inspect and diagnose

Read [incidents-and-effects.md](references/incidents-and-effects.md). Use Agent
history and Trail rather than searching private storage formats. Classify the
failure layer:

1. outcome/contract;
2. procedure/skill;
3. evidence/source;
4. tool or connection;
5. authority/policy;
6. mutable state/checkpoint;
7. executable check or external oracle;
8. runtime/confinement/supervision.

Write facts, hypotheses, and unknowns separately. Preserve effect uncertainty
until an external observation reconciles it.

## 6. Change only the owning layer

Read [change-and-retirement.md](references/change-and-retirement.md).

- Correct changing facts in their authoritative source, not memory.
- Correct one unit of work in mutable work/state when no durable rule changed.
- Change a procedure only from replay-verified failed-then-passed evidence.
- Change the Agent definition through an exact reviewed patch and May decision.
- Change a verifier, connection, policy, identity, or runtime only through the
  platform steward.

Rerun structural checks, mutation tests, regression cases, withheld cases, and
authority review after the relevant change. Never use the improved run to erase
the original failed evidence.

## 7. Schedule or supervise deliberately

Read [scheduling.md](references/scheduling.md). A schedule is not a heartbeat;
a heartbeat is not crash recovery; a supervisor is not the business cadence.

For Cowork schedules, confirm that every required source, skill, connector,
artifact, and state path is available to a fresh cloud session. A local folder
or host binary is not durable cloud state merely because the original session
could reach it.

## 8. Retire completely

Retirement is an explicit operation:

1. disable schedules, triggers, and new Action proposals;
2. stop or drain supervised work;
3. reconcile pending reviews and every sent/unknown effect;
4. revoke OAuth profiles, connector grants, service identities, browser
   sessions, and shared capabilities used only by this worker;
5. record final definition/version, owner, reason, last accepted verdict, and
   unresolved obligations;
6. retain required controller evidence and archive or delete sensitive
   work/state under policy;
7. obtain final accountable sign-off.

Deleting the folder or editing `HEARTBEAT.md` alone is not retirement.

## User-visible handoff

End with:

- operating classification and exact operation performed or refused;
- evidence and terminal status;
- current authority and outstanding decisions;
- unresolved effects or incidents;
- next safe action and accountable owner.

## Bundled resources

- [OPERATING-RECORD.md](assets/OPERATING-RECORD.md) — one literal operation and
  its status/evidence.
- [INCIDENT.md](assets/INCIDENT.md) — facts, uncertainty, owning layer, and
  recovery closeout.
- [RETIREMENT.md](assets/RETIREMENT.md) — complete shutdown and sign-off.
