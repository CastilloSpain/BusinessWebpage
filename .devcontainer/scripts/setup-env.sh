#!/usr/bin/env bash
set -euo pipefail

# predefined and derived constants
BASH_RC="/root/.bashrc"
BASH_ALIASES="/root/.bash_aliases"
WORKSPACE_DIR="/workspace"
LOGFILE="/tmp/setup-env-debug.log"

# redirect all output to logfile (and still echo to stdout for visibility)
exec > >(tee -a "$LOGFILE") 2>&1

echo "===== setup-env.sh DEBUG LOG START ====="
date
echo "Working directory: $PWD"
uname -a
echo

echo "--- Environment (sorted) ---"
printenv | sort
echo

# ensure /root/.bashrc and /root/.bash_aliases files exist
touch "$BASH_RC"
touch "$BASH_ALIASES"

# post-process /root/.bashrc
if [ -f "$BASH_RC" ]; then
  echo "Patching $BASH_RC (uncommenting colorized LS aliases)"
  sed -i -E 's/^#\s*export\s+/export /' "$BASH_RC" || true
  sed -i -E 's/^#\s*eval\s+/eval /' "$BASH_RC" || true
  sed -i -E 's/^#\s*alias\s+l/alias l/' "$BASH_RC" || true

  if ! grep -q 'bash_aliases' "$BASH_RC" 2>/dev/null; then
    cat >> "$BASH_RC" <<'EOF'
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
EOF
  fi
fi

# write dedicated /root/.bash_aliases entries
if ! grep -q '^export web=' "$BASH_ALIASES" 2>/dev/null; then
  echo 'export web="/workspace"' >> "$BASH_ALIASES"
fi
if ! grep -q '^alias pe=' "$BASH_ALIASES" 2>/dev/null; then
  echo "alias pe='printenv'" >> "$BASH_ALIASES"
fi
if ! grep -q '^alias run-web=' "$BASH_ALIASES" 2>/dev/null; then
  echo "alias run-web='cd \"\$web\" && npm run dev'" >> "$BASH_ALIASES"
fi

on_error() {
  rc=$?
  echo "ERROR: setup-env.sh failed with exit code $rc at line ${BASH_LINENO[0]}"
  echo "Tail of logfile $LOGFILE as follows:";
  tail -n 200 "$LOGFILE" || true
}
trap on_error ERR

# ---- Svelte CLI (`sv`): install globally ----
echo "--- Installing Svelte CLI (sv) globally ---"
if command -v sv >/dev/null 2>&1; then
  echo "sv already available: $(sv --version 2>/dev/null || echo 'version unknown')"
else
  npm install -g sv@latest 2>&1 || echo "sv global install failed (will retry manually)"
  echo "sv version: $(sv --version 2>/dev/null || echo 'not available')"
fi

# ---- Per-app dependencies ----

# app (SvelteKit 2)
echo "--- Installing app dependencies ---"
if [ -f "${WORKSPACE_DIR}/package.json" ]; then
  npm ci --prefix "${WORKSPACE_DIR}" 2>&1 || echo "npm ci failed"
else
  echo "package.json not found — skipping"
fi

echo
echo "===== setup-env.sh DEBUG LOG END ====="
echo

echo "Setup script finished (see $LOGFILE for details). Open a new terminal in VS Code to run ad hoc commands."
