#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MANIFEST_DIR="$ROOT_DIR/k8s/demo-app"

kubectl apply -f "$MANIFEST_DIR/00-namespace.yaml"
kubectl apply -f "$MANIFEST_DIR/10-configmap.yaml"
kubectl apply -f "$MANIFEST_DIR/20-secret.yaml"
kubectl apply -f "$MANIFEST_DIR/30-deployment.yaml"
kubectl apply -f "$MANIFEST_DIR/40-service.yaml"
kubectl apply -f "$MANIFEST_DIR/50-ingress.yaml"
kubectl apply -f "$MANIFEST_DIR/60-hpa.yaml"

kubectl -n lab-app rollout status deployment/web --timeout=180s

echo "[INFO] Learning app URL: http://web.localtest.me"
for i in {1..12}; do
  if curl -fsS -o /dev/null --max-time 5 http://web.localtest.me; then
    echo "[OK] Learning app is reachable (HTTP 200)."
    exit 0
  fi
  echo "[INFO] Waiting for learning app ingress... ($i/12)"
  sleep 5
done

echo "[WARN] App resources deployed, but ingress route is not ready yet."
echo "[WARN] Retry with: curl -I http://web.localtest.me"
