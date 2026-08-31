# Bench System Builder

Three inspectable Agent Skills for building, operating, and stewarding governed
Bench systems from Claude Code or Claude Cowork. The package contains Markdown
instructions, references, templates, evaluation cases, and one offline read-only
runtime doctor. It contains no hooks, connectors, credentials, network code, or
automatic permission grants.

## Skills

- `building-with-bench` turns a business process into a reviewed system design,
  executable proof plan, Agent home, and controlled-pilot handoff.
- `operating-bench-agents` runs, inspects, changes, learns from, and retires a
  built Agent home from controller evidence.
- `stewarding-bench-platform` installs and governs the runtime, checks,
  identities, connections, effects, budgets, and operating boundary.

In Claude Code, the plugin exposes
`/bench-system-builder:building-with-bench` and
`/bench-system-builder:operating-bench-agents`, and
`/bench-system-builder:stewarding-bench-platform`.

## Install

Claude Code users can add the Agent repository as a marketplace:

```text
/plugin marketplace add patrickyoung/agent
/plugin install bench-system-builder@bench-agent-tools
```

For a one-session trial, download and inspect the plugin ZIP from the guide,
extract it, and run:

```text
unzip bench-system-builder-0.1.0.zip
claude --plugin-dir ./bench-system-builder
```

Cowork users can download the same plugin ZIP, then open
**Customize → Plugins → Upload**. Standalone ZIPs for each skill are also
available from the guide under **Customize → Skills → Create skill → Upload a
skill**.

## Runtime boundary

The skills are a complete, versioned operating manual; users do not need to
clone or read the Bench repositories. Executing Bench still requires either a
compatible pinned suite or a managed Bench integration. If neither is present,
the build skill stays in design-only mode and produces a handoff package instead
of claiming to have run checks or created a working agent.

This release describes Bench suite `0.13.0` and Agent `0.2.1`. The skill checks
the installed runtime before using versioned commands and stops on an unknown or
incompatible version.
