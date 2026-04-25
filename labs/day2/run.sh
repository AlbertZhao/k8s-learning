#!/usr/bin/env bash
set -euo pipefail

echo "[Day2] Networking and ingress"
kubectl get svc -A
kubectl get ingress -A
curl -I --max-time 10 http://hello.localtest.me | head -n 1
curl -I --max-time 10 http://web.localtest.me | head -n 1

echo "[OK] Day2 completed."
