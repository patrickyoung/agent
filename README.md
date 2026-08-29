# agent

Compile a directory-shaped digital worker and run its standing goal through
the existing Bench tools.

For the architecture at a glance, open the
[one-page visual explainer](https://patrickyoung.github.io/agent/).

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
    proposals/    model-authored unified diffs awaiting human review
  state/          mutable durable state, not injected into context
    kv/           file-shaped key/value state for simple durable facts
  .agent/runs/    replayable Ask sessions and Ply verifier receipts
  .agent/checkpoints/ home-scoped conversation checkpoint pointers
  .agent/learning/ Hone wording sessions and reviewed proposal evidence
    proposals/     exact user-named lesson artifacts awaiting admission
  .agent/amendments/ controller receipts for approved definition patches
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
agent run [-net] [-no-cage] [-m MODEL] [-effort NAME] [-checkpoint NAME] [DIR] [-- input ...]
agent tick [-net] [-no-cage] [-m MODEL] [-effort NAME] [-checkpoint NAME] [DIR] [-- input ...]
agent specialist PARENT NAME [run flags] [-- input ...]
agent learn -into SKILL [-m MODEL] [-n COUNT] [-N] [-why] [-prepare PROPOSAL] [-q] HOME SESSION
agent learn -show PROPOSAL HOME
agent learn -admit PROPOSAL HOME
agent history HOME [ls|find|show|window|lineage|check ...]
agent proposals HOME [PATCH]
agent amend HOME PATCH
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

`-checkpoint NAME` gives a run one portable, home-scoped conversation
checkpoint under `.agent/checkpoints/`. Running the same command again resumes
the current Ask session, including the session selected by Ply compaction. Ply
holds a nonblocking whole-run lock, so concurrent use fails instead of
interleaving two loops. The work tree and `bin/check` remain authoritative:
the checkpoint is not a filesystem snapshot, and a process killed during an
external effect still requires inspection before retry.

```sh
agent run -checkpoint release support-chief
agent run -checkpoint release support-chief   # continue after interruption
```

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

Use `-why` to inspect the replay-verified goal, passing check, and failed-then-
successful evidence without calling a model or changing a skill. `-N` goes
further and asks a model to word possible lessons without writing them, but it
is not an exact preview token: a later ordinary `learn` call generates wording
again. Controllers must not present `-N` followed by `learn` as admission of
the same reviewed bytes.

For exact review, `-prepare NAME.json` accepts one verified home session and
writes a new artifact beneath `.agent/learning/proposals/`, never the skill.
It binds the source and wording sessions, current destination, and literal
final `SKILL.md` bytes. `learn -show NAME.json HOME` is read-only and invokes
Hone's no-call `show`. `learn -admit NAME.json HOME` invokes Hone's model-free
admission: both provenance sessions replay, every hash and destination path is
rechecked, the allowed append/scaffold delta is reconstructed, and only the
exact reviewed bytes are atomically written. Portable direct-child names,
regular files, and single links are required; existing proposal files are
never overwritten. This is an explicit operator path, not automatic learning
or a proposal index.

`agent history` is the read-only evidence browser. It composes Trail over the
home's `.agent/runs/` archive and returns Trail's JSONL and exit status
unchanged. `ls` is the default; `find QUERY`, `show SESSION`, bounded `window`,
`lineage SESSION`, and replay `check` mirror Trail's public commands. Session
commands accept only regular non-symlinked evidence files beneath that home;
`check` delegates replay integrity to Ask through Trail.

`agent amend` is the reviewed definition-change path. `PATCH` must be a
regular, non-symlinked direct child of `HOME/work/proposals/`, have a portable
`.patch` filename, and be a conventional unified diff that changes exactly one
existing root definition file. Before requesting approval, inspect one patch
or the bounded catalogue without side effects:

```sh
agent proposals support-chief
agent proposals support-chief tighten-checking.patch
```

The review output contains the literal patch bytes, current definition and
proposal hashes, target, stable May job, and the exact May action including
its final newline. It never invokes May or changes the home. At most 16 patches
and 64 KiB of aggregate proposal bytes are shown per catalogue invocation.

Agent then parses and dry-runs it with Git, binds the physical home, current
definition hash, target, proposal path, and proposal hash into one exact May
request, and exits 75 without changing the definition while that request is
parked. Review and decide the digest from a separate terminal, then retry the
identical command:

```sh
agent amend support-chief tighten-checking.patch  # exits 75; prints JSON
may pending
may decide DIGEST
agent amend support-chief tighten-checking.patch  # spends grant and applies
```

After approval, Agent rechecks both hashes and patch applicability, stages a
receipt, applies the patch, and reruns the complete home check. A rejected
home is restored byte-for-byte and exits 2. A successful change records its
before/after hashes and May result under `.agent/amendments/`. The model can
propose words, but only a human can authorize these exact bytes; the May path
is scrubbed before Ply starts.

## Dependencies

`run` needs `ply`, `brief`, `ask`, and (by default) `cage` on `PATH`. Agent
resolves Ask itself and pins it into Ply, so a relocatable suite does not
depend on its `bin` directory remaining on `PATH`. Learning needs Hone and
Brief; evidence review, preparation, and admission also pin Ask for replay or
wording, while `learn -show` calls only Hone. `history` needs Trail, and its
`check` command also needs Ask.
`proposals` needs Git; `amend` needs Git and May.
Environment overrides `AGENT_PLY`, `AGENT_BRIEF`, `AGENT_CAGE`, `AGENT_HONE`,
`AGENT_TRAIL`, `AGENT_ASK`, and `AGENT_MAY` are available for a pinned suite
and offline tests. `check` only needs Brief when `skills/` contains a skill.

`just install` links `agent` and its Cage action wrapper into `~/.local/bin`,
beside the other standalone Bench filters.

The Bench `0.9.0` suite also ships Tend as an independent local process
supervisor. It is not an Agent dependency: compose it outside an exact
`agent run -checkpoint NAME HOME` invocation when the whole process needs
durable submission, waits, output evidence, and conservative crash recovery.
Ply's `contrib/mcpbox` provides the MCP edge in the same style by compiling a
server's discovered tools into one allowlisted Unix program per capability.

`just eval` runs the frozen representative-home corpus in `eval/corpus/`.
It proves already-complete re-entry makes no model call, quiet heartbeats stop
before resolving Ply, broken wake protocols return 2, nested homes validate
recursively, and a tiny real Ask archive replay-checks through Trail. The TSV
report also exposes definition and compiled-view byte counts without turning
them into a synthetic quality score.

See `SECURITY.md` before running downloaded or adversarial homes. Cage limits
writes and networking; it does not hide host-readable files, environment
values, credentials, or programs from the worker.

## Status

The implemented vertical slices scaffold, validate, inspect, run, cheaply
tick, invoke direct specialists, explicitly learn from verified recovery,
prepare/show/admit exact reviewed lesson bytes, browse replay history without
writing it, and apply one exact human-approved definition patch with rollback
and evidence. Proposal bytes and approval actions are also inspectable through
a bounded, read-only public command.
Bench suite `0.9.0` pins Agent, Ply's checkpoint support, Tend, and the other
public filters as one tested install. Bench has a core interactive home view
and exposes every Agent command through its headless boundary.
