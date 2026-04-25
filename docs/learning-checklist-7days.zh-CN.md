# Kubernetes 7 天学习清单（本地集群）

目标：每天 60 到 120 分钟，完成从基础到进阶的核心概念闭环。

## Day 1：资源基础

- 完成环境确认：
  - make status
  - make verify
- 理解对象：Namespace、Pod、Deployment、Service
- 动手：
  - kubectl get ns
  - kubectl get pod -A
  - kubectl -n demo describe deploy hello-nginx

## Day 2：网络与流量入口

- 理解 Service 类型与 Ingress
- 动手：
  - kubectl get svc -A
  - kubectl get ingress -A
  - curl -I http://hello.localtest.me
  - curl -I http://web.localtest.me

## Day 3：配置管理

- 理解 ConfigMap 与 Secret 用途
- 动手：
  - make demo
  - kubectl -n lab-app get configmap web-config -o yaml
  - kubectl -n lab-app get secret web-secret -o yaml

## Day 4：发布策略

- 理解滚动升级与回滚
- 动手：
  - kubectl -n lab-app set image deploy/web web=nginx:1.27.1
  - kubectl -n lab-app rollout status deploy/web
  - kubectl -n lab-app rollout undo deploy/web

## Day 5：弹性伸缩

- 理解 HPA 指标驱动扩缩容
- 动手：
  - kubectl -n lab-app get hpa
  - kubectl -n lab-app describe hpa web
  - 使用压测工具触发负载并观察副本变化

## Day 6：故障排查

- 理解 describe、logs、events 排障路径
- 动手：
  - kubectl -n lab-app logs deploy/web
  - kubectl -n lab-app describe pod -l app=web
  - kubectl get events -A --sort-by=.lastTimestamp

## Day 7：环境重建与复盘

- 练习完整重建，验证可重复性
- 动手：
  - make down
  - make cluster
  - make addons
  - make smoke
  - make demo
- 复盘输出：
  - 记录 3 个最熟练命令
  - 记录 3 个最常见错误及排查方式
