#!/usr/bin/env bash
set -euo pipefail

# Ensure Homebrew is discoverable even in fresh shells.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Install required tools on macOS using Homebrew.
# Tools:
# - colima + docker: local container runtime for kind
# - kubectl: Kubernetes CLI
# - kind: local Kubernetes cluster in Docker containers
# - helm: package manager for Kubernetes
# - k9s (optional but recommended): terminal UI for Kubernetes

if ! command -v brew >/dev/null 2>&1; then
  echo "[ERROR] Homebrew is not installed."
  echo "Install Homebrew first: https://brew.sh"
  exit 1
fi

brew update
brew install colima docker kubectl kind helm k9s

if ! colima status >/dev/null 2>&1; then
  echo "[INFO] Starting colima (cpu=4, memory=8GiB, disk=60GiB)..."
  colima start --cpu 4 --memory 8 --disk 60
else
  echo "[INFO] Colima already running or available."
fi

# Verify Docker daemon is reachable.
docker version >/dev/null

echo "[OK] Bootstrap completed."
