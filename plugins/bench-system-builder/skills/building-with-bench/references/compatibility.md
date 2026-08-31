# Compatibility snapshot

This reference is intentionally versioned. Read it before invoking Bench
commands. Do not silently combine it with a different suite.

## Skill release

- Skill: `building-with-bench` 0.1.0
- Reviewed: 2026-08-31
- Bench suite: 0.13.0
- Agent: 0.2.1
- Supported suite hosts: macOS and Linux, `amd64` and `arm64`

The compatible suite is a checksummed binary distribution. A user does not need
to clone or read any source repository. The official release is:

`https://github.com/patrickyoung/bench/releases/tag/v0.13.0`

It publishes one archive and checksum per supported platform plus a consolidated
`bench-suite-0.13.0-SHA256SUMS` file. Prefer that consolidated checksum or the
sidecar checksum downloaded independently from the archive.

## Read-only version doctor

Run only commands that exist; missing commands are observations, not permission
to install:

```text
bench version
draft version
agent version
brief version
ply version
ask version
```

Also report the execution operating system and architecture. Do not print the
environment, tokens, cookies, headers, or credential values.

Classify:

- Exact suite and Agent versions: compatible.
- Missing runtime: design-only until a steward provides it.
- Newer or older runtime: do not use the versioned command runbook. Read the
  installed public `help` output, ask the user whether to update this skill or
  use an explicitly compatible suite, and stop before build work.
- Independently installed commands with mismatched versions: incompatible until
  a steward replaces them with one pinned suite or proves the composition.

## Release boundary

The suite contains the fourteen-component core and four edge commands:

`bench`, `ask`, `brief`, `ply`, `context`, `action`, `cite`, `hone`, `trail`,
`agent`, `tend`, `draft`, `may`, `cage`, `mcp`, `mcpbox`, `mcpserve`, and
`oauth`.

The release manifest and checksums are authoritative. Prose from a moving branch
is not a compatibility contract.
