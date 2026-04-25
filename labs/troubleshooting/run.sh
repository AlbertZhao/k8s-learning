#!/usr/bin/env bash
set -euo pipefail

echo "[Troubleshooting] Inject CrashLoopBackOff"
kubectl apply -f labs/troubleshooting/01-crashloop.yaml
sleep 3
kubectl -n lab-app get pod -l app=crashloop-demo
kubectl -n lab-app describe pod -l app=crashloop-demo | sed -n '1,160p'

echo "[Troubleshooting] Inject probe failure"
kubectl apply -f labs/troubleshooting/02-probe-failure.yaml
sleep 8
kubectl -n lab-app get pod -l app=probe-fail-demo
kubectl -n lab-app describe pod -l app=probe-fail-demo | sed -n '1,180p'

echo "[INFO] Cleanup command: kubectl -n lab-app delete deploy crashloop-demo probe-fail-demo"
