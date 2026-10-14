#!/usr/bin/env bash
# Installs the HyperFrames skills for cloud sessions. Idempotent; never fails the session.
cd "${CLAUDE_PROJECT_DIR:-$(pwd)}" || exit 0
if [ -d .agents/skills/hyperframes ]; then exit 0; fi
timeout 120 npx -y skills add heygen-com/hyperframes -y >/dev/null 2>&1 || echo "HyperFrames skills install failed; check network allowlist" >&2
exit 0
