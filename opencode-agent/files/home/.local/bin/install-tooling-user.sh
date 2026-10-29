#!/usr/bin/env bash
set -euo pipefail

# Shared agent-user tooling installation (uid 1000). Single source of truth for the
# `user: "1000"` `setup.install` steps that all kit specs reference:
#   - opencode-agent/spec.yaml (mixin, OpenCode/Claude Home)
#   - mammouth-agent/spec.yaml (Mammouth Code)
#   - claude-zurich-agent/spec.yaml (Claude Code Zurich)
#
# The script is bundled into the sandbox via files/home/.local/bin/ (all kits) and
# executed by `setup.install` with user "1000" (~ = /home/agent). It must stay
# identical in all kits — edit one copy, then `cp` it to the others
# (`mammouth-agent/files/home/.local/bin/`, `claude-zurich-agent/files/home/.local/bin/`).
# Renovate bumps tool versions in all copies together (validate-check fails on drift).

export PATH="/usr/local/share/npm-global/bin:/usr/local/bin:/usr/bin:/bin:${PATH}"

# --- Claude Code statusline ---
git clone --depth 1 https://github.com/dboeckli/ai-agent-skills.git /tmp/ai-agent-skills
mkdir -p ~/.claude
cp /tmp/ai-agent-skills/scripts/statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
rm -rf /tmp/ai-agent-skills

