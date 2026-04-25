#!/usr/bin/env bash
set -euo pipefail

echo "[Day3] ConfigMap and Secret"
make demo >/dev/null
kubectl -n lab-app get configmap web-config -o yaml
kubectl -n lab-app get secret web-secret -o yaml
kubectl -n lab-app exec deploy/web -- printenv | grep '^APP_' | sort

echo "[OK] Day3 completed."
