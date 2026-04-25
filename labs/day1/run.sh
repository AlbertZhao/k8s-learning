#!/usr/bin/env bash
set -euo pipefail

echo "[Day1] Cluster and base resources overview"
kubectl get ns
kubectl get nodes -o wide
kubectl get deploy,svc,ingress -A
kubectl -n demo describe deploy hello-nginx | sed -n '1,120p'

echo "[OK] Day1 completed."
