# Source-free Bench suite installation

This skill release targets Bench suite 0.13.0, published 2026-08-30. The release
contains one tested composition, licenses, suite manifest, internal file
checksums, installer, and public commands. Source checkout is not required.

Release page:

`https://github.com/patrickyoung/bench/releases/tag/v0.13.0`

## Archive selection

Observe the target using `uname -s` and `uname -m`. Map only:

| OS | Architecture | Archive | SHA-256 |
| --- | --- | --- | --- |
| Darwin | x86_64 | `bench-suite-0.13.0-darwin-amd64.tar.gz` | `d9f46e17bf8ed722ef2d635332e0513f6fc158a3bcff63f20ec8555b3da86b04` |
| Darwin | arm64 | `bench-suite-0.13.0-darwin-arm64.tar.gz` | `8c5b66085523410171ea13e5f813745292f88bc7513bca8d2769b9800c6c6ba6` |
| Linux | x86_64 | `bench-suite-0.13.0-linux-amd64.tar.gz` | `0fef42246115fc84cc14cef029f46f8347fb6f1737548eadf0da15b1ce9af9d4` |
| Linux | aarch64/arm64 | `bench-suite-0.13.0-linux-arm64.tar.gz` | `6621771d68d1c52dc7939b6db1d994de0a11d186cc2757a8b0edace3a6983965` |

If the observed platform is not in the table, stop. Do not select a “close”
archive or build from source without a separate approved engineering workflow.

## Safe sequence

1. Resolve an explicit temporary download directory and install prefix.
2. Download the archive and its `.sha256` sidecar, or the consolidated
   `bench-suite-0.13.0-SHA256SUMS`, from the release page.
3. Verify SHA-256 before extraction. A mismatch is terminal.
4. Extract into a new directory; inspect `INSTALL.md`, `suite.json`,
   `SHA256SUMS`, and licenses.
5. Run the archive's own checksum verification and installer only after the user
   approves the prefix.
6. Ensure the selected prefix's `bin` directory is reached deliberately; do not
   overwrite unrelated commands.
7. Verify versions and offline checks.
8. Record archive URL, hash, suite manifest, prefix, host, install owner, date,
   and rollback directory.

Never use `curl | sh`, unverified archives, mutable “latest” URLs, or a mix of
independent component releases.

## Pinned versions

| Component | Version | Public command(s) |
| --- | ---: | --- |
| Bench | 0.7.0 | `bench` |
| Ask | 0.2.0 | `ask` |
| Brief | 0.1.1 | `brief` |
| Ply | 0.1.2 | `ply` |
| Context | 0.1.0 | `context` |
| Action | 0.1.0 | `action` |
| Cite | 0.1.0 | `cite` |
| Cage | 0.1.0 | `cage` |
| May | 0.1.0 | `may` |
| Hone | 0.2.0 | `hone` |
| Trail | 0.1.0 | `trail` |
| Agent | 0.2.1 | `agent` |
| Tend | 0.1.2 | `tend` |
| Draft | 1.0.0 | `draft` |
| MCP | 0.3.0 | `mcp`, `mcpbox`, `mcpserve` |
| OAuth | 0.1.1 | `oauth` |

The emitted suite manifest and release checksums are authoritative. A moving
README or branch is not.

## Offline verification

- Every public command returns its exact expected `version`.
- `cage status` reports a supported confinement backend.
- `may check`, `tend check`, and other controller checks use isolated test state,
  not production state.
- An extracted-suite smoke test reaches adjacent companions with a minimal PATH.
- A disposable Agent scaffold can run `agent check`, an accepted pre-check with
  zero model calls, and history verification.

Model provider credentials and production connections are not an installation
test.
