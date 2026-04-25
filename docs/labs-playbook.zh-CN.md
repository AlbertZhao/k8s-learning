# Kubernetes 实验手册（课程化）

本手册用于把本地集群变成可重复的实验环境。

## 1. 准备

```bash
make up
make demo
```

## 2. 每日实验入口

```bash
make lab-day1
make lab-day2
make lab-day3
make lab-day4
make lab-day5
make lab-day6
make lab-day7
```

## 3. 故障注入与排障

注入故障：

```bash
make lab-trouble
```

清理故障资源：

```bash
kubectl -n lab-app delete deploy crashloop-demo probe-fail-demo
```

## 4. Helm 实验

安装：

```bash
make helm-lab
```

升级并回滚：

```bash
make helm-upgrade-rollback
```

清理：

```bash
make helm-clean
```

## 5. 常用检查

```bash
make verify
kubectl get hpa -A
kubectl get ingress -A
```
