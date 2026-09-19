# Webman Docker 基础镜像

适用于 [Webman (Workerman)](https://www.workerman.net/doc/webman) 高性能 PHP 常驻内存框架的通用运行与开发环境。

## 特性
- 基于 `php:8.2-cli-alpine`
- 集成 Workerman 核心必需扩展：`pcntl`、`posix`、`event`
- 常用业务扩展：`pdo_mysql`、`redis`、`gd`、`zip`、`bcmath`、`opcache`、`intl`
- 内置 Composer 2.x 并默认配置阿里云镜像源加速
- 默认工作目录 `/app`，暴露端口 `8500`

## 构建方法

### 本地构建

```bash
docker build -t webman:8.2 .
```

### Gitea CI/CD 自动构建

已配置 `.gitea/workflows/build.yaml`。每次推送到 `master` / `main` 或推送 tag（如 `v1.0.0`）时，Gitea Actions 会自动构建并推送到 Gitea 镜像仓库：

- **Registry**: `git.openlocalpdf.com:222/gitea/webman-docker:latest`
- 确保 Gitea 仓库已启用 Actions 且部署有对应 Runner（如 act_runner）。
