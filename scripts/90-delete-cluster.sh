#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="learn-k8s"

if kind get clusters | grep -qx "$CLUSTER_NAME"; then
  kind delete cluster --name "$CLUSTER_NAME"
  echo "[OK] Cluster '$CLUSTER_NAME' deleted."
else
  echo "[INFO] Cluster '$CLUSTER_NAME' does not exist."
fi
