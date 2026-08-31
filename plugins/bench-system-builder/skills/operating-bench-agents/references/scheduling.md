# Scheduling and supervision

## Distinct responsibilities

- `bin/wake` decides cheaply whether useful work exists.
- `agent tick` runs that probe and invokes the worker only when it wakes.
- An external scheduler decides when to call tick or run.
- Tend persists local process transitions, signals, timers, retries after
  observed failure, and explicit unknown-effect resolution.
- The business owner defines cadence, freshness, quiet behavior, and escalation.

Do not call one of these a substitute for the others.

## Cowork scheduled tasks

Cowork scheduled work starts a fresh cloud session. Before scheduling, prove
that the skill/plugin, sources, connectors, managed Bench runtime, Agent home,
controller evidence, identities, and output destination are available to that
fresh session without a host-only path or the original conversation.

Define:

- exact prompt and job scope;
- timezone and cadence;
- no-work behavior;
- maximum duration/cost/effects;
- permission and approval behavior;
- artifact and evidence destination;
- failure and unknown-effect notification;
- pause, update, and retirement owner.

Do not schedule a design-only Cowork skill and describe it as a persistent Bench
Agent runtime.

## Tend

Use Tend when a local process needs crash-durable supervision. Submit one exact
command with explicit state root and bounds. Inspect immutable events. Retry only
an observed failure. Resolve an effect-unknown attempt only after external
reconciliation. Tend supervision does not authorize the child or certify its
business output.
