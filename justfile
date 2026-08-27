check:
    sh -n bin/agent bin/agent-action-shell
    sh bin/agent_test.sh

install:
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p ~/bin
    ln -sfn "$PWD/bin/agent" ~/bin/agent
    ln -sfn "$PWD/bin/agent-action-shell" ~/bin/agent-action-shell
    echo "agent installed. Ensure ~/bin is on PATH."
