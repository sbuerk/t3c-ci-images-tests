FROM php:8.1-fpm-alpine
LABEL org.opencontainers.image.authors="Christian Kuhn <lolli@schwarzbu.ch> and Stefan Bürk <stefan@buerk.tech>"
LABEL org.opencontainers.image.source=https://git.typo3.org/typo3/CI/testing-infrastructure
LABEL org.opencontainers.image.url=https://git.typo3.org/typo3/CI/testing-infrastructure/-/blob/main/docker-images/README.md
LABEL org.opencontainers.image.description="sbuerk/test1-fpm-core-testing-php81"

# We use convenient install-php-extensions script to manage additional php extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

ARG T3C_FULLVERSION="unset"
ENV T3C_FULLVERSION=$T3C_FULLVERSION

RUN apk add --no-cache \
    bash \
    file \
    git \
    graphicsmagick \
    grep \
    patch \
    && chmod +x /usr/local/bin/install-php-extensions \
    && sync \
    && install-php-extensions \
        apcu \
        bcmath \
        bz2 \
        @composer-2 \
        gd \
        gettext \
        gmp \
        intl \
        memcached \
        mysqli \
        opcache \
        pdo_mysql \
        pdo_pgsql \
        pdo_sqlsrv \
        pgsql \
        pspell \
        redis \
        soap \
        sqlsrv \
        sysvsem \
        xdebug \
        zip \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && sed -i s/';phar.readonly = On'/'phar.readonly = Off'/ $PHP_INI_DIR/php.ini \
    && sed -i s/'memory_limit = 128M'/'memory_limit = 2G'/ $PHP_INI_DIR/php.ini \
    && sed -i s/'max_execution_time = 30'/'max_execution_time = 240'/ $PHP_INI_DIR/php.ini \
    && sed -i s/';max_input_vars = 1000'/'max_input_vars = 1500'/ $PHP_INI_DIR/php.ini \
    && echo "xdebug.max_nesting_level = 400" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
#    && echo "xdebug.remote_enable = 1" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
#    && echo "xdebug.client_host = host.docker.internal" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
#    && echo "xdebug.mode = debug" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request = yes" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && echo "apc.enable_cli=1" >> $PHP_INI_DIR/conf.d/docker-php-ext-apcu.ini \
    && echo "apc.slam_defense=0" >> $PHP_INI_DIR/conf.d/docker-php-ext-apcu.ini \
    && echo "opcache.enable=0" >> $PHP_INI_DIR/conf.d/docker-php-ext-opcache.ini \
    && echo "sbuerk/test1-fpm-core-testing-php81 ${T3C_FULLVERSION}" >>/etc/t3c_version \
    && rm -rf /var/cache/apk/*
