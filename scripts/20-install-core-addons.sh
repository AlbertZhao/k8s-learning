#!/usr/bin/env bash
set -euo pipefail

# Install ingress-nginx for local ingress testing.
# For kind, we use the official provider manifest.

if ! kubectl cluster-info >/dev/null 2>&1; then
  echo "[ERROR] kubectl cannot reach a cluster."
  exit 1
fi

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

echo "[OK] ingress-nginx installed."
