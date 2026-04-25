#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CHART_DIR="$ROOT_DIR/helm/lab-nginx"
RELEASE="lab-nginx"
NAMESPACE="lab-helm"

helm upgrade --install "$RELEASE" "$CHART_DIR" --create-namespace --namespace "$NAMESPACE"
kubectl -n "$NAMESPACE" rollout status deploy/"$RELEASE" --timeout=180s

echo "[INFO] Helm app URL: http://helm.localtest.me"
for i in {1..12}; do
  if curl -fsS -o /dev/null --max-time 5 http://helm.localtest.me; then
    echo "[OK] Helm app is reachable (HTTP 200)."
    exit 0
  fi
  echo "[INFO] Waiting for helm ingress route... ($i/12)"
  sleep 5
done

echo "[WARN] Helm app deployed, but ingress route is not ready yet."
