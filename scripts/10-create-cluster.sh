#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="learn-k8s"
KIND_CONFIG="$(cd "$(dirname "$0")/.." && pwd)/kind/kind-cluster.yaml"

if ! command -v kind >/dev/null 2>&1; then
  echo "[ERROR] kind not found. Run scripts/00-bootstrap-macos.sh first."
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "[ERROR] Docker daemon is not reachable. Ensure colima is running."
  exit 1
fi

if kind get clusters | grep -qx "$CLUSTER_NAME"; then
  echo "[INFO] Cluster '$CLUSTER_NAME' already exists. Skipping creation."
else
  kind create cluster --name "$CLUSTER_NAME" --config "$KIND_CONFIG"
fi

kubectl cluster-info
kubectl get nodes -o wide

echo "[OK] Cluster is ready."
