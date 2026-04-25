#!/usr/bin/env bash
set -euo pipefail

echo "[Day7] Rebuild and verification"
make down
make cluster
make addons
make smoke
make demo
make verify

echo "[OK] Day7 completed."
