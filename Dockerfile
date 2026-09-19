# Dockerfile for Webman (MaDong Backend)
FROM php:8.2-cli-alpine

LABEL maintainer="managepro"

ENV TZ=Asia/Shanghai \
    COMPOSER_ALLOW_SUPERUSER=1

# 服务器位于海外（日本节点），Alpine apk 直接使用官方全球 CDN 源 dl-cdn.alpinelinux.org，速度与稳定性更优
RUN apk update \
    && apk add --no-cache \
        bash \
        curl \
        git \
        tzdata \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone

# 使用 install-php-extensions 官方推荐的 ADD 方式
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# 安装 PHP 扩展
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

# 安装 Composer 并配置国内镜像源（方便业务项目更新依赖）
RUN curl -sS https://getcomposer.org/composer-stable.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

WORKDIR /app

EXPOSE 8500

CMD ["php", "start.php", "start"]
