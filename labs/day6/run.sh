#!/usr/bin/env bash
set -euo pipefail

echo "[Day6] Troubleshooting practice"
kubectl -n lab-app logs deploy/web --tail=50
kubectl -n lab-app describe pod -l app=web | sed -n '1,180p'
kubectl get events -A --sort-by=.lastTimestamp | tail -n 40

echo "[OK] Day6 completed."
