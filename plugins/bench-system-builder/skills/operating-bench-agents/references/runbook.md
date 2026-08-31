# Operator runbook

Use only with the compatible public runtime and an inspected home.

## Run now

```text
agent run -checkpoint NAME HOME -- INPUT
```

Use a checkpoint only when this invocation should continue the named work.
Without a checkpoint, start a distinct run. Keep network off unless a separately
reviewed run envelope requires it. Do not use `-no-cage` as troubleshooting
convenience.

## Wake only when work exists

```text
agent tick HOME -- INPUT
```

`bin/wake` is a cheap controller probe: 0 quiet, 1 wake, another status broken.
Tick spends a model call only on work. It is not a scheduler; an outer system
still decides when to invoke it.

## Specialist

```text
agent specialist PARENT NAME -- INPUT
```

A specialist is a direct child home with its own goal, check, writable state,
and evidence. Do not use a specialist merely to hide a large context or bypass
the parent's authority.

## Inspect history

```text
agent history HOME ls
agent history HOME show SESSION
agent history HOME window -before 4 -after 4 SESSION SEQ
agent history HOME lineage SESSION
agent history HOME check
```

Use bounded windows for diagnosis. History integrity is not business truth.

## Review and execute an effect proposal

```text
agent actions HOME
agent actions HOME PROPOSAL
agent act HOME PROPOSAL SESSION
```

These commands require Agent 0.2.1 from the pinned suite. Inspect the proposal
before the controller invokes Action. A policy decision of review parks through
May. Status 75 is unfinished; status 125 means a possibly-started effect lacks a
trustworthy terminal result. Neither should be retried automatically.

## Learn from a verified recovery

```text
agent learn -why -into SKILL HOME SESSION
agent learn -into SKILL -prepare PROPOSAL HOME SESSION
agent learn -show PROPOSAL HOME
agent learn -admit PROPOSAL HOME
```

The first step is read-only evidence. Prepare exact proposed skill bytes, inspect
them, then admit without another model call. A run that never failed needed no
recovery; a run that never passed proves no lesson.

## Amend governed definition

```text
agent proposals HOME PATCH
agent amend HOME PATCH
```

Inspect the bounded patch and exact May action. Amendment dry-runs and binds the
current definition and patch hashes. Exit 75 is awaiting approval, 3 declined;
only an identical retry after the exact May grant may apply it.

## Terminal handling

- 0: accepted for that command's documented claim.
- 1: negative verdict; inspect component-specific evidence.
- 2: broken or usage depending on the public command; do not reinterpret.
- 3: approval declined.
- 75: valid but parked/unfinished.
- 125: confinement failed or effect outcome unknown; read the exact evidence and
  do not retry automatically.
- 130: interrupted; determine whether any external release occurred before
  deciding next action.

Always follow the component's help contract rather than a generic table when the
status meaning could differ.
