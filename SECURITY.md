# Security

An agent home is code and model input. Inspect it with `agent show` and
validate it with `agent check` before running it.

## What the default run confines

Model-authored command blocks run through Cage. On a supported backend they
may persist filesystem writes only beneath `work/`, `state/`, and Cage's
private temporary directory. Host networking is denied unless the caller
passes `-net`. Backend setup failure returns 125 and never falls back to an
unconfined action.

`agent check` and the action wrapper conservatively refuse every regular file
with more than one hard link under `work/` or `state/`. Hard links alias
inodes, so pathname-only write policy cannot safely distinguish an outside
name. Copy such files to fresh inodes before running the home.

Definition files and `.agent/` evidence are outside Cage's writable roots.
The home cannot grant itself network access, choose `-no-cage`, select a
model, or change its action boundary through Markdown.

`agent specialist` is a new foreground controller invocation, not a process
escape offered to a running parent. Each child receives caller-selected
authority and writes only its own work, state, and run evidence.

`agent learn` deliberately runs outside Cage because it may amend a local
skill definition. It requires an explicit portable skill name, accepts only a
regular non-symlinked session beneath the same home's `.agent/runs/`, rejects
symlinked skill directories, and delegates the fail-then-pass verdict to Hone.
Treat it as a controller-authorized definition amendment, never an automatic
end-of-run hook.

`agent history` is read-only and delegates archive parsing to Trail. The
wrapper scopes archive operations and session paths to the selected home's
`.agent/runs/`, refuses symlinked or outside session files, and delegates
replay checking to Ask. Session output is sensitive and is not redacted.

## What it does not confine

Cage is not a confidentiality, identity, CPU, memory, process-count, syscall,
or credential boundary. The model action can read files and inherited
environment values available to the current operating-system identity and,
with `-sh`, can invoke the host's programs. Run under an appropriately narrow
identity and environment; use a container or virtual machine when reads or
secrets must be isolated.

`-net` permits host networking generally; it is not a destination allowlist.
`-no-cage` deliberately restores ordinary host write and network reach.

## The verifier is controller-authority code

`bin/check` runs outside the model-action Cage so the worker cannot rewrite
its judge. If the check executes scripts, binaries, build hooks, or other code
from `work/` or `state/`, that code executes with the controller's authority.
Keep checks operator-owned, inspect their transitive execution, or run the
whole controller under a stronger outer boundary for adversarial work.

Ask sessions and Ply verifier receipts under `.agent/runs/` are evidence of
the exact conversation and verdict. They prove replay integrity and the
recorded check outcome, not that the model, home, or external data was
trustworthy.
