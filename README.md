# agent

Compile a directory-shaped digital worker and run its standing goal through
the existing Bench tools.

```sh
agent new support-chief
$EDITOR support-chief/AGENTS.md support-chief/GOAL.md support-chief/bin/check
agent check support-chief
agent show support-chief
agent run support-chief
agent tick support-chief
```

An agent home separates authored definition, mutable data, and evidence:

```text
support-chief/
  AGENTS.md       operating instructions (required)
  GOAL.md         durable outcome and constraints (required)
  SOUL.md         optional persona and tone
  PLAN.md         optional standing strategy
  MEMORY.md       optional curated facts; never automatic learning
  HEARTBEAT.md    recurring watch instructions; schedule stays external
  skills/         ordinary Brief-readable Agent Skills
  agents/         nested specialist homes with isolated runs and evidence
  tools/          agent-specific programs
  bin/check       executable completion verdict (required)
  bin/wake        cheap tick probe: 0 quiet, 1 wake, other broken
  work/           mutable deliverables and working directory
  state/          mutable durable state, not injected into context
    kv/           file-shaped key/value state for simple durable facts
  .agent/runs/    replayable Ask sessions and Ply verifier receipts
  .agent/learning/ Hone wording sessions for explicitly admitted lessons
```

`agent run` defaults to full shell access inside Cage, with writes limited to
`work/`, `state/`, and the process temporary directory and with network denied.
Use `-net` when the work genuinely needs network access. Use `-no-cage` only
when you deliberately want the ordinary Ply host boundary. Neither choice can
be made by a Markdown file.

The agent-specific `tools/` directory is prepended even in full-shell mode, so
small domain programs are discovered beside ordinary host tools. Agent Skills
under `skills/` are selected by Brief from the standing goal. The skill path
is agent-local by default: ambient host skills are not silently inherited.
Empty skill and tool directories are fine.

The required `bin/check` runs from `work/` before the first model turn and
after every candidate completion. Exit 0 accepts, exit 1 rejects and returns
feedback to the worker, and any other status means the verifier is broken.
This is Ply's existing contract; `agent` does not reinterpret it.

## Commands

```text
agent new DIR [description ...]
agent check [DIR]
agent show [DIR]
agent run [-net] [-no-cage] [-m MODEL] [-effort NAME] [DIR] [-- input ...]
agent tick [-net] [-no-cage] [-m MODEL] [-effort NAME] [DIR] [-- input ...]
agent specialist PARENT NAME [run flags] [-- input ...]
agent learn -into SKILL [-m MODEL] [-n COUNT] [-N] [-why] [-q] HOME SESSION
agent help
agent version
```

Additional CLI words and piped stdin are appended as invocation context to
the active goal (`GOAL.md` for `run`, `HEARTBEAT.md` for `tick`). They do not
rewrite either definition file.

`agent tick` reads `HEARTBEAT.md` but leaves cadence to cron, launchd, CI, or
another external scheduler. It runs `bin/wake` before resolving Ply or calling
a model. Exit 0 is quiet and creates no Ask session; exit 1 starts a normal
confined run with the probe's stdout as initial evidence; any other status is
broken. An empty heartbeat is also quiet.

`agent specialist` runs one direct child beneath `PARENT/agents/` in the
foreground. The child gets its own instructions, goal, mutable roots, check,
skills, authority flags, and `.agent/runs`; it receives only the explicit
invocation task, never the parent's conversation. This is an external
controller operation rather than an escape from a network-denied parent Cage.
Nested work remains visible as ordinary repeated invocations.

`agent learn` is the only learning path. It requires an explicit local skill
name and a regular session beneath that home's `.agent/runs/`, then composes
Hone with `BRIEF_PATH` scoped to the home. Hone still decides mechanically
whether the session failed and later passed; exit 1 means nothing trustworthy
was learned. `-N` previews without writing, and `.agent/learning/` keeps the
model calls that word accepted lessons. There is no automatic `MEMORY.md`
rewrite.

## Dependencies

`run` needs `ply`, `brief`, and (by default) `cage` on `PATH`. Environment
overrides `AGENT_PLY`, `AGENT_BRIEF`, `AGENT_CAGE`, and `AGENT_HONE` are
available for a pinned suite and offline tests. `check` only needs Brief when
`skills/` contains a skill.

`just install` links `agent` and its Cage action wrapper into `~/.local/bin`,
beside the other standalone Bench filters.

See `SECURITY.md` before running downloaded or adversarial homes. Cage limits
writes and networking; it does not hide host-readable files, environment
values, credentials, or programs from the worker.

## Status

The implemented vertical slices scaffold, validate, inspect, run, cheaply
tick, invoke direct specialists, and explicitly learn from verified recovery.
Pinned-suite packaging and the Bench UI remain follow-on slices.
