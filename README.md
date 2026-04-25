# 本地 Kubernetes 学习环境（macOS）

这套工程用于在 MacBook 本地快速、可重复地搭建 Kubernetes 学习环境。

技术选型：
- Runtime: Colima + Docker
- Cluster: kind（Kubernetes in Docker）
- CLI: kubectl / helm / k9s

## 1. 快速开始

```bash
cd /Users/albert/Documents/DevTools/K8S
chmod +x scripts/*.sh
./scripts/00-bootstrap-macos.sh
./scripts/10-create-cluster.sh
./scripts/20-install-core-addons.sh
./scripts/30-smoke-test.sh
```

验证访问：
- 浏览器打开 `http://hello.localtest.me`

或使用一键命令：

```bash
make up
```

## 2. 一键清理

```bash
./scripts/90-delete-cluster.sh
```

## 3. 文档

- 详细配置手册：`docs/mac-k8s-setup-handbook.zh-CN.md`
- 使用方法手册：`docs/k8s-usage-guide.zh-CN.md`
- 7 天学习清单：`docs/learning-checklist-7days.zh-CN.md`
- 课程化实验手册：`docs/labs-playbook.zh-CN.md`

## 4. Makefile 常用命令

```bash
make up          # 安装依赖 + 建集群 + 装插件 + 烟雾测试
make demo        # 部署进阶学习应用（ConfigMap/Secret/HPA）
make verify      # 查看节点、Pod、Ingress
make reset       # 重建集群并恢复基础测试应用
make down        # 删除集群
make stop        # 停止 colima 节省资源
make start       # 启动 colima
make lab-day1    # Day1 实验
make lab-day2    # Day2 实验
make lab-day3    # Day3 实验
make lab-day4    # Day4 实验
make lab-day5    # Day5 实验
make lab-day6    # Day6 实验
make lab-day7    # Day7 实验
make lab-trouble # 故障注入与排障实验
make helm-lab    # Helm 安装实验
make helm-upgrade-rollback # Helm 升级回滚实验
make helm-clean  # Helm 实验清理
```

## 5. 目录说明

- `kind/kind-cluster.yaml`：集群拓扑（1 控制平面 + 2 工作节点）
- `scripts/00-bootstrap-macos.sh`：安装依赖并启动本地 runtime
- `scripts/10-create-cluster.sh`：创建 Kind 集群
- `scripts/20-install-core-addons.sh`：安装 ingress-nginx
- `scripts/30-smoke-test.sh`：部署 demo 应用并生成 Ingress
- `scripts/40-deploy-learning-app.sh`：部署进阶学习应用
- `scripts/41-clean-learning-app.sh`：清理进阶学习应用
- `scripts/50-helm-lab.sh`：Helm 安装实验
- `scripts/51-helm-upgrade-rollback.sh`：Helm 升级与回滚实验
- `scripts/52-helm-clean.sh`：Helm 实验清理
- `scripts/90-delete-cluster.sh`：删除集群
- `k8s/demo-app/`：进阶学习应用的 Kubernetes 资源清单
- `labs/`：Day1-Day7 课程化实验与故障注入
- `helm/lab-nginx/`：最小 Helm Chart 模板
