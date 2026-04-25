#!/usr/bin/env bash
set -euo pipefail

echo "[Day4] Rolling update and rollback"
kubectl -n lab-app set image deploy/web web=nginx:1.27.1
kubectl -n lab-app rollout status deploy/web --timeout=180s
kubectl -n lab-app rollout history deploy/web
kubectl -n lab-app rollout undo deploy/web
kubectl -n lab-app rollout status deploy/web --timeout=180s

echo "[OK] Day4 completed."
