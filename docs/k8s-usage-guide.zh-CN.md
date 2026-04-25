# Kubernetes 使用方法手册（本地学习集群）

本手册对应集群：`learn-k8s`

## 1. 日常启动顺序

```bash
colima start
kubectl cluster-info
kubectl get nodes
```

如果集群不存在，则创建：

```bash
./scripts/10-create-cluster.sh
./scripts/20-install-core-addons.sh
```

推荐一键方式：

```bash
make up
```

## 2. 常用命令清单

查看集群与节点：

```bash
kubectl config get-contexts
kubectl cluster-info
kubectl get nodes -o wide
```

查看业务资源：

```bash
kubectl get ns
kubectl get pod -A
kubectl get deploy -A
kubectl get svc -A
kubectl get ingress -A
```

查看日志与排障：

```bash
kubectl -n demo logs deploy/hello-nginx
kubectl -n demo describe pod -l app=hello-nginx
kubectl -n ingress-nginx logs deploy/ingress-nginx-controller
```

## 3. 典型学习动作

### 3.1 扩缩容

```bash
kubectl -n demo scale deploy/hello-nginx --replicas=3
kubectl -n demo get pod -w
```

### 3.2 滚动升级

```bash
kubectl -n demo set image deploy/hello-nginx nginx=nginx:1.27.1
kubectl -n demo rollout status deploy/hello-nginx
kubectl -n demo rollout history deploy/hello-nginx
```

### 3.3 回滚

```bash
kubectl -n demo rollout undo deploy/hello-nginx
kubectl -n demo rollout status deploy/hello-nginx
```

## 4. Helm 快速使用

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo nginx
```

示例安装（仅学习）：

```bash
helm install my-nginx bitnami/nginx --namespace demo --create-namespace
helm list -A
helm uninstall my-nginx -n demo
```

## 5. k9s 使用

```bash
k9s
```

常用快捷键：
- `:ns` 切换命名空间
- `d` describe
- `l` logs
- `s` shell

## 6. 环境重置策略

轻度重置（仅业务资源）：

```bash
kubectl delete ns demo
./scripts/30-smoke-test.sh
```

完全重置（含集群）：

```bash
./scripts/90-delete-cluster.sh
./scripts/10-create-cluster.sh
./scripts/20-install-core-addons.sh
./scripts/30-smoke-test.sh
```

等效一键命令：

```bash
make reset
```

部署进阶学习应用：

```bash
make demo
curl -I http://web.localtest.me
```

## 7. 学习完成后关机省资源

```bash
colima stop
```

再次学习时：

```bash
colima start
kubectl get nodes
```

## 8. 课程化实验

按天执行：

```bash
make lab-day1
make lab-day2
make lab-day3
make lab-day4
make lab-day5
make lab-day6
make lab-day7
```

故障注入：

```bash
make lab-trouble
```

## 9. Helm 实验

```bash
make helm-lab
make helm-upgrade-rollback
make helm-clean
```
