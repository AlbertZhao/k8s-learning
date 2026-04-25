# macOS 本地 Kubernetes 搭建手册（可重复使用）

本手册目标：
- 在本地 MacBook 上搭建一个稳定、可重复的 Kubernetes 学习环境。
- 形成标准化流程，后续换机器或重装后可以直接复用。

## 1. 方案设计

### 1.1 为什么选择 kind + Colima

- kind 轻量、启动快，适合学习和功能验证。
- Colima 在 macOS 上体验好，替代 Docker Desktop 也可运行。
- 全链路开源，迁移和自动化成本低。

### 1.2 环境目标

- 节点拓扑：1 control-plane + 2 worker
- Ingress：ingress-nginx
- 管理工具：kubectl、helm、k9s

### 1.3 最低硬件建议

- CPU: 4 核及以上
- 内存: 16GB（8GB 也可跑，但并发实验会吃紧）
- 磁盘: 至少 30GB 可用空间

## 2. 前置要求

- macOS（Intel/Apple Silicon 均可）
- 网络可访问以下资源：
  - github.com
  - raw.githubusercontent.com
  - registry.k8s.io
- 已安装 Homebrew（https://brew.sh）

## 3. 一次性安装与初始化

在项目根目录执行：

```bash
cd ~/Documents/DevTools/K8S
chmod +x scripts/*.sh
./scripts/00-bootstrap-macos.sh
```

此脚本会执行：
- `brew install colima docker kubectl kind helm k9s`
- `colima start --cpu 4 --memory 8 --disk 60`
- `docker version` 连通性检测

## 4. 创建集群

```bash
./scripts/10-create-cluster.sh
```

集群配置文件位置：
- `kind/kind-cluster.yaml`

关键配置说明：
- 集群名：`learn-k8s`
- API Server 端口映射到宿主机 `6443`
- 将宿主机 `80/443` 映射到控制平面节点，方便本地 Ingress 访问

## 5. 安装核心插件

```bash
./scripts/20-install-core-addons.sh
```

该脚本安装 ingress-nginx，并等待控制器 Pod Ready。

## 6. 部署烟雾测试应用

```bash
./scripts/30-smoke-test.sh
```

部署内容：
- Namespace: `demo`
- Deployment: `hello-nginx`
- Service: `hello-nginx` (ClusterIP)
- Ingress Host: `hello.localtest.me`

访问：
- 浏览器打开 `http://hello.localtest.me`

说明：`localtest.me` 自动解析到 `127.0.0.1`，无需改 hosts。

## 7. 验证检查清单

```bash
kubectl get nodes -o wide
kubectl get pod -A
kubectl get ingress -A
kubectl -n ingress-nginx get pod
```

预期：
- 3 个节点均为 Ready
- ingress-nginx controller 为 Running
- demo 命名空间应用已就绪

## 8. 重建与清理

删除集群：

```bash
./scripts/90-delete-cluster.sh
```

重建流程：

```bash
./scripts/10-create-cluster.sh
./scripts/20-install-core-addons.sh
./scripts/30-smoke-test.sh
```

## 9. 常见问题排查

### 9.1 `docker info` 失败

可能原因：Colima 未运行。

处理：
```bash
colima start --cpu 4 --memory 8 --disk 60
```

### 9.2 Ingress 无法访问

排查顺序：

```bash
kubectl -n ingress-nginx get pod
kubectl get ingress -A
kubectl -n demo describe ingress hello-ingress
```

并确认 80 端口未被本机其他程序占用。

### 9.3 镜像拉取慢或失败

- 重试脚本
- 检查网络代理设置
- 必要时使用镜像加速（企业网络内常见）

## 10. 进阶建议（学习路线）

- Day 1-2：Pod / Deployment / Service / Ingress
- Day 3-4：ConfigMap / Secret / Volume / Probe
- Day 5-6：Helm 部署开源应用
- Day 7：RBAC / NetworkPolicy 入门

可增加工具：
- `kubectx` / `kubens`（快速切换上下文和命名空间）
- `stern`（多 Pod 日志追踪）

## 11. 一键命令入口（Makefile）

```bash
make up
make demo
make verify
make reset
make down
```

说明：
- `make up`：安装依赖 + 建集群 + 装 Ingress + 烟雾测试
- `make demo`：部署进阶学习应用（ConfigMap / Secret / HPA）
- `make reset`：删除并重建集群

## 12. 进阶学习应用

资源目录：
- `k8s/demo-app/`

访问地址：
- `http://web.localtest.me`

清理方式：

```bash
make demo-clean
```
