#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="demo"
APP_NAME="hello-nginx"

kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

kubectl -n "$NAMESPACE" create deployment "$APP_NAME" --image=nginx:1.27 --dry-run=client -o yaml | kubectl apply -f -
kubectl -n "$NAMESPACE" expose deployment "$APP_NAME" --port=80 --target-port=80 --type=ClusterIP --dry-run=client -o yaml | kubectl apply -f -

cat <<'EOF' | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-ingress
  namespace: demo
spec:
  ingressClassName: nginx
  rules:
    - host: hello.localtest.me
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: hello-nginx
                port:
                  number: 80
EOF

kubectl -n "$NAMESPACE" rollout status deploy/"$APP_NAME" --timeout=120s

echo "[INFO] Test URL: http://hello.localtest.me"
for i in {1..12}; do
  if curl -fsS -o /dev/null --max-time 5 http://hello.localtest.me; then
    echo "[OK] Ingress is reachable (HTTP 200)."
    break
  fi
  echo "[INFO] Waiting for ingress route to be ready... ($i/12)"
  sleep 5
done

if ! curl -fsS -o /dev/null --max-time 5 http://hello.localtest.me; then
  echo "[WARN] Ingress route is not ready yet. Retry in a few seconds: curl -I http://hello.localtest.me"
fi

echo "[OK] Smoke test resources are deployed."
