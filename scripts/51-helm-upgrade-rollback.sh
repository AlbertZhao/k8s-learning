#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CHART_DIR="$ROOT_DIR/helm/lab-nginx"
RELEASE="lab-nginx"
NAMESPACE="lab-helm"

echo "[INFO] Upgrade release with new image tag"
helm upgrade "$RELEASE" "$CHART_DIR" --namespace "$NAMESPACE" --set image.tag=1.27.1
kubectl -n "$NAMESPACE" rollout status deploy/"$RELEASE" --timeout=180s
helm history "$RELEASE" -n "$NAMESPACE"

echo "[INFO] Rollback to previous revision"
PREV_REVISION=$(helm history "$RELEASE" -n "$NAMESPACE" -o json | awk 'BEGIN{RS="}";FS=","} /"revision":/ {for(i=1;i<=NF;i++) if($i ~ /"revision":/) {gsub(/[^0-9]/,"",$i); if($i!="") r[++c]=$i}} END{if(c>=2) print r[c-1]; else print ""}')
if [[ -n "$PREV_REVISION" ]]; then
  helm rollback "$RELEASE" "$PREV_REVISION" -n "$NAMESPACE"
  kubectl -n "$NAMESPACE" rollout status deploy/"$RELEASE" --timeout=180s
else
  echo "[WARN] No previous revision found to rollback."
fi
