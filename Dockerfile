# Dockerfile for Webman (MaDong Backend)
FROM php:8.2-cli-alpine

LABEL maintainer="managepro"

ENV TZ=Asia/Shanghai \
    COMPOSER_ALLOW_SUPERUSER=1

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache \
        bash \
        curl \
        git \
        tzdata \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone

# 使用 install-php-extensions 官方推荐的 ADD 方式（支持构建时走代理）
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# 使用国内镜像源极速下载并安装扩展
RUN install-php-extensions \
        pcntl \
        posix \
        event \
        pdo_mysql \
        redis \
        gd \
        zip \
        bcmath \
        opcache \
        intl

# 安装 Composer（直接从国内镜像下载 composer.phar，不需要额外拉取 composer 镜像）
RUN curl -sS https://mirrors.aliyun.com/composer/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

WORKDIR /app

EXPOSE 8500

CMD ["php", "start.php", "start"]
