---
name: building-with-bench
description: Designs, builds, and proves a governed Bench system from a business process. Use for a new Bench workflow, Agent home, evaluation, or controlled pilot.
license: MIT
metadata:
  author: patrickyoung
  version: "0.1.0"
  bench-suite: "0.13.0"
  agent: "0.2.1"
---

# Building with Bench

Turn a process the user understands into a reviewed, bounded, independently
checked Bench system. Work in plain business language. Preserve the durable
decisions in files; do not make this conversation the system of record.

This skill contains the operating knowledge needed to design the system. It
does not contain the Bench runtime and does not turn a successful model response
into proof.

## Route the request

Use this skill for a new or substantially redesigned system through controlled
pilot readiness. If the request is primarily about routine runs, incidents,
schedules, learned changes, or retirement of an existing Agent home, identify
it as an operator task. If it is primarily about installing the suite,
provisioning credentials/connectors, validating checks, or production runtime
policy, identify it as a platform-steward task.

## Standing rules

- Preserve the user's outcome and authority. Do not enlarge the job because a
  tool or component exists.
- Begin with a narrow recommendation, read-only analysis, or draft workflow.
  Add effects only after evidence and proof are credible.
- Ask one decision-sized question at a time unless the user supplied a complete
  process pack. Explain why an answer matters when the connection is not obvious.
- Record unknowns as unknowns. Never invent policy, source precedence, expected
  answers, credentials, approvals, or business thresholds.
- Never read or print secret values. Report only whether a credential capability
  exists, its resource, account identity, and scope.
- Do not install software, authenticate, widen permissions, schedule work,
  execute an external effect, or alter an existing agent during preflight.
- Keep withheld cases and their expected answers outside every worker-readable
  root. A hidden label inside the Agent home is not a holdout.
- Treat a toolbox as tool selection, Cage as a current write/network boundary,
  and the Claude surface as an outer interface. None is by itself a complete
  confidentiality, identity, credential, or truth boundary.
- A model may propose work. Only an executable external check and retained
  evidence may accept it.

## 1. Establish the workspace and execution lane

Before creating or changing artifacts, read
[compatibility.md](references/compatibility.md) and
[surface-routing.md](references/surface-routing.md). Perform only their
read-only preflight.

Classify the session exactly:

- **BUILD-READY** — a compatible pinned suite or managed runtime is reachable,
  a dedicated workspace exists, and the user has authorized build work.
- **DESIGN-ONLY** — the skill can create the complete business design and case
  package, but no compatible Bench runtime is reachable.
- **STEWARD-REQUIRED** — execution, credentials, a meaningful verifier, or an
  authority decision requires a named platform/security owner.

State the classification, supporting observations, and claim boundary. Local
files connected to Cowork do not imply access to a host-installed binary.

## 2. Build the business process pack

Read [lifecycle.md](references/lifecycle.md). Copy the relevant templates from
`assets/` into a new `bench-system/` directory; do not overwrite existing work.
Interview the accountable process owner and fill the artifacts in this order:

1. `00-job-brief.md` — trigger, finished result, owner, boundaries, escalation.
2. `01-process-map.md` — decisions, normal path, exceptions, stop conditions.
3. `02-case-library.csv` — teaching, regression, edge, adversarial, and withheld
   case identifiers without exposing withheld answers to the worker.
4. `03-source-register.csv` — resource, owner, authority, freshness, conflict
   order, sensitivity, and failure behavior.
5. `04-authority-register.csv` — read, recommend, draft, propose, affect, and
   forbidden capabilities with approval and uncertainty handling.

Use contrastive examples: ask why one near-neighbor is acceptable and another
is not. Convert adjectives such as “good,” “urgent,” or “appropriate” into
observable rules, examples, or explicit human judgment.

Stop for owner review. Do not proceed while the owner, outcome, source conflict
order, high-risk boundaries, or success evidence is unresolved.

## 3. Design the Bench composition

Read [platform-owners.md](references/platform-owners.md). Fill
`05-system-design.md` by assigning each required guarantee to one named owner.
Use the smallest composition that preserves the guarantees; “full platform”
means no responsibility is silently assigned to the model, not that every
component runs on every turn.

The ordinary promotion path is:

`Bench contract → Draft design → Build → Prove → Agent home → controlled pilot`

Document why every selected component is needed and why every unselected one is
not needed yet. Keep deterministic transformation, model judgment, evidence
retrieval, effect execution, approval, supervision, and acceptance distinct.

## 4. Define proof before model work

Read [evidence-and-proof.md](references/evidence-and-proof.md). Fill
`06-proof-plan.md` with:

- mechanical invariants and the exact checker that owns each one;
- withheld business cases and their external oracle;
- calibrated human-review rubric for judgment that cannot be mechanical;
- false-success, escalation, stale/conflicting-source, prompt-injection, and
  mutation cases;
- pass thresholds, budgets, stop rules, and regression policy;
- what each check proves and what it does not prove.

Reject constant checks, checks controlled by the worker, placeholder goals,
structure-only checks presented as business quality, and evaluation on examples
the worker can read. The author of a candidate result must not be its sole judge.

## 5. Review the contract and authority

Read [authority-and-effects.md](references/authority-and-effects.md). Present a
plain-language review containing:

- what the system owes and explicitly does not own;
- the evidence it may trust and how conflicts fail;
- what it can read, write, propose, and affect;
- where human decisions remain mandatory;
- budgets for time, turns, cost, and effect count;
- behavior for denied, timed-out, interrupted, and effect-unknown work.

Record the approved result in `05-system-design.md`. A conversational “yes” is
not permission to install, authenticate, publish, pay, delete, schedule, or
widen authority.

## 6. Materialize only in a build-ready lane

If the lane is not **BUILD-READY**, read
[steward-handoff.md](references/steward-handoff.md), create
`bench-system/STEWARD-HANDOFF.md`, and stop after the design package. Say
precisely which claim remains unproved.

If it is **BUILD-READY**, read [suite-commands.md](references/suite-commands.md)
before running anything. Use the compatible runtime's public commands; never
read source as an undocumented substitute. Show the user the proposed build
sequence and obtain approval before writes or model-backed work.

Materialize in gates:

1. Negotiate and admit the exact Bench contract in Review mode.
2. Create and review the Draft `DESIGN.md` and its executable check.
3. Run `draft check`, explicitly admit the verifier, then build.
4. Run `draft prove` and inspect what the check fails to detect.
5. Create the Agent home and keep governed definition, mutable work/state,
   executable check, and controller evidence in separate write domains.
6. Run `agent check` and inspect `agent show` before the first model-backed run.
7. Exercise fixtures with network off and no external effects.

Record commands, versions, exit statuses, and evidence paths in
`BUILD-REPORT.md`. Do not translate a nonzero or unknown result into success.

## 7. Evaluate and prepare a controlled pilot

Run the external case harness, not the Agent's self-description. Compare results
with the withheld oracle outside worker-readable roots. Record every case as
pass, fail, or unknown with evidence.

Fill `07-pilot-plan.md`. Begin with simulation, shadow, or draft-only work. Set a
bounded population, volume, duration, review cadence, escalation threshold,
pause rule, rollback, owner, and retirement path. Widen one authority boundary
at a time only after rerunning the complete regression set.

End with one readiness state:

- **DESIGN COMPLETE** — business artifacts are reviewed; runtime proof absent.
- **STRUCTURE VALID** — a scaffold and offline structural checks pass.
- **CHECK PROVED** — Draft mutation work demonstrates meaningful detection.
- **PILOT READY** — withheld outcomes, authority review, and operating controls
  meet their admitted thresholds.

Never use “production ready” for a scaffold or a passing structure check.

## User-visible handoff

Summarize:

1. the current lane and readiness state;
2. the exact artifacts created or reviewed;
3. the strongest evidence and largest unknown;
4. granted and explicitly absent authority;
5. the smallest next decision and its accountable owner.

## Additional references

- [worked-example.md](references/worked-example.md) — use only when the user
  needs a concrete invoice-exception example.
- [steward-handoff.md](references/steward-handoff.md) — required format when the
  build cannot continue safely.

## Bundled resources

- [doctor.sh](scripts/doctor.sh) — inspect before running; offline, read-only
  public command/version and Cage-status preflight.
- [00-job-brief.md](assets/00-job-brief.md) and
  [01-process-map.md](assets/01-process-map.md) — owner interview artifacts.
- [02-case-library.csv](assets/02-case-library.csv),
  [03-source-register.csv](assets/03-source-register.csv), and
  [04-authority-register.csv](assets/04-authority-register.csv) — case,
  evidence, and capability registers.
- [05-system-design.md](assets/05-system-design.md),
  [06-proof-plan.md](assets/06-proof-plan.md), and
  [07-pilot-plan.md](assets/07-pilot-plan.md) — reviewed architecture, proof,
  and pilot templates.
- [BUILD-REPORT.md](assets/BUILD-REPORT.md) and
  [STEWARD-HANDOFF.md](assets/STEWARD-HANDOFF.md) — terminal build or blocked
  handoff records.
