#!/bin/sh
set -eu

# Offline, read-only Bench suite compatibility check for skill release 0.1.0.
# It performs command lookup, public version calls, uname, and Cage status only.

missing=0
mismatch=0

printf 'surface=local-shell\n'
if command -v uname >/dev/null 2>&1; then
  printf 'os=%s\n' "$(uname -s 2>/dev/null || printf unknown)"
  printf 'arch=%s\n' "$(uname -m 2>/dev/null || printf unknown)"
else
  printf 'os=unknown\narch=unknown\n'
fi

while IFS=' ' read -r command_name expected_version; do
  [ -n "$command_name" ] || continue
  if ! command_path=$(command -v "$command_name" 2>/dev/null); then
    printf 'command=%s status=missing expected=%s\n' "$command_name" "$expected_version"
    missing=1
    continue
  fi

  if ! version_output=$($command_name version 2>&1); then
    printf 'command=%s status=broken expected=%s path=%s\n' \
      "$command_name" "$expected_version" "$command_path"
    mismatch=1
    continue
  fi

  actual_version=${version_output##* }
  if [ "$actual_version" = "$expected_version" ]; then
    command_status=exact
  else
    command_status=mismatch
    mismatch=1
  fi
  printf 'command=%s status=%s expected=%s actual=%s path=%s\n' \
    "$command_name" "$command_status" "$expected_version" \
    "$actual_version" "$command_path"
done <<'VERSIONS'
bench 0.7.0
ask 0.2.0
brief 0.1.1
ply 0.1.2
context 0.1.0
action 0.1.0
cite 0.1.0
cage 0.1.0
may 0.1.0
hone 0.2.0
trail 0.1.0
agent 0.2.1
tend 0.1.2
draft 1.0.0
mcp 0.3.0
mcpbox 0.3.0
mcpserve 0.3.0
oauth 0.1.1
VERSIONS

if command -v cage >/dev/null 2>&1; then
  if cage_output=$(cage status 2>&1); then
    printf 'cage-status=available detail=%s\n' "$cage_output"
  else
    printf 'cage-status=unavailable\n'
  fi
else
  printf 'cage-status=missing\n'
fi

if [ "$mismatch" -ne 0 ]; then
  printf 'runtime=version-mismatch\n'
  exit 1
fi
if [ "$missing" -ne 0 ]; then
  printf 'runtime=missing\n'
  exit 1
fi

printf 'runtime=compatible\n'
