#!/usr/bin/env bash
set -euo pipefail

helm uninstall lab-nginx -n lab-helm || true
kubectl delete namespace lab-helm --ignore-not-found=true

echo "[OK] Helm lab cleaned."
