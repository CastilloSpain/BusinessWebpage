#!/usr/bin/env bash
set -euo pipefail

# cleanup.sh -- destroy the Docker resources created by .devcontainer/devcontainer.json:
# the dev container, the image built for it, and the named cache volumes.
# Run from the host, NOT from inside of container.

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# the named volumes declared under "mounts" in devcontainer.json
volumes=(
  # Node caches
  castillo-real-estate_npm-cache
  castillo-real-estate_nvm-global
  castillo-real-estate_npm-global
  castillo-real-estate_npm-bin
  # UI app dependencies
  castillo-real-estate_ui-node-modules
  # CLI auth/state persistence
  castillo-real-estate_gh-config
  castillo-real-estate_claude-config
  castillo-real-estate_codex-config
)

# container -- the name declared under "runArgs" in devcontainer.json; the filter
# is a regex, anchored here so it matches that name and nothing else
container="$(docker ps --all --quiet --filter "name=^/?castillo-real-estate-dev-env$")"
if [ -n "$container" ]; then
  docker rm --force --volumes "$container"
fi

# images -- the Dev Containers CLI tags its builds "vsc-<folder>-<hash>[-features|-uid]";
# the positional REPOSITORY[:TAG] form of `docker images` does exact matching only, so
# the wildcard must go through --filter=reference, which is the form that actually globs
images="$(docker images --quiet --filter "reference=vsc-$(basename "$script_dir" | tr '[:upper:]' '[:lower:]')*")"
if [ -n "$images" ]; then
  docker rmi --force $images
fi

# volumes -- flag `--force` keeps this quiet when a volume is already gone
docker volume rm --force "${volumes[@]}"
