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

### GitHub Actions 自动构建与发布

已配置 `.github/workflows/build.yml`。采用**混合原生双架构矩阵构建**：
- **`linux/amd64`**：由 GitHub 云端 `ubuntu-latest` 原生构建
- **`linux/arm64`**：由组织 Self-Hosted ARM Runner 原生硬件全速构建
- 自动合并生成多架构 Manifest 并发布到 GitHub Container Registry (GHCR)：

- **Registry**: `ghcr.io/ai567-com/webman-docker:latest`（或对应 tag 如 `:v1.0.0`）
- 无论是在 x86_64 服务器、云主机还是本地 Apple Silicon / ARM 设备上，Docker 都会自动拉取匹配本机架构的镜像运行。
