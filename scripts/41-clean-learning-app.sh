#!/usr/bin/env bash
set -euo pipefail

kubectl delete namespace lab-app --ignore-not-found=true

echo "[OK] lab-app namespace deleted (if it existed)."
