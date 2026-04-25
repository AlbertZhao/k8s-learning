#!/usr/bin/env bash
set -euo pipefail

echo "[Day5] HPA and scaling baseline"
kubectl -n lab-app get hpa web
kubectl -n lab-app describe hpa web | sed -n '1,120p'
kubectl -n lab-app get deploy web -o wide

echo "[INFO] Optional load test command:"
echo "kubectl -n lab-app run load --rm -it --image=busybox:1.36 -- /bin/sh -c \"while true; do wget -q -O- http://web; done\""

echo "[OK] Day5 completed."
