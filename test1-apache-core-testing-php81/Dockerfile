FROM php:8.1-apache
LABEL org.opencontainers.image.authors="Christian Kuhn <lolli@schwarzbu.ch> and Stefan Bürk <stefan@buerk.tech>"
LABEL org.opencontainers.image.source=https://git.typo3.org/typo3/CI/testing-infrastructure
LABEL org.opencontainers.image.url=https://git.typo3.org/typo3/CI/testing-infrastructure/-/blob/main/docker-images/README.md
LABEL org.opencontainers.image.description="sbuerk/test1-apache-core-testing-php81"

# We use convenient install-php-extensions script to manage additional php extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN apt-get update \
# install additional packages
    && apt-get install -y --no-install-recommends \
        bash \
        file \
        git \
        graphicsmagick \
        grep \
        patch \
        locales \
# ensure the php installation script is executable
    && chmod +x /usr/local/bin/install-php-extensions \
# ensure files are written to layer
    && sync \
# install additional php extensions and tools
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
# enable needed apache2 modules
    && a2enmod \
        actions \
        headers \
        rewrite \
        setenvif \
        headers \
# add overrideable variable for the vhost document root to the apache2 envvar file
    && { \
        echo ''; \
        echo ': ${APACHE_RUN_DOCROOT:=/var/www/html}'; \
        echo 'export APACHE_RUN_DOCROOT'; \
        echo ''; \
      } | tee -a "${APACHE_CONFDIR}/envvars" \
# add variable based directory \
    && { \
# create basic directives retrieved from the original images, except the /var/www/html directory block \
# see: https://github.com/docker-library/php/blob/ec1608d9809155b2df3e1786628825388fd3ce6c/8.1/bookworm/apache/Dockerfile#L93-L107
		echo '<FilesMatch \.php$>'; \
		echo '\tSetHandler application/x-httpd-php'; \
		echo '</FilesMatch>'; \
		echo; \
#		echo 'DirectoryIndex disabled'; \
		echo 'DirectoryIndex index.php index.html'; \
		echo; \
# We create a additional directory directive based on the configurable vhost docroot path
		echo '<Directory ${APACHE_RUN_DOCROOT}>'; \
		echo '\tOptions -Indexes'; \
		echo '\tAllowOverride All'; \
		echo '\tRequire all granted'; \
		echo '</Directory>'; \
	  } | tee "$APACHE_CONFDIR/conf-available/docker-php.conf" \
# Set the document root in default site files to the dynamic APACHE_RUN_DOCROOT value
    && sed -i 's/DocumentRoot.*/DocumentRoot ${APACHE_RUN_DOCROOT}/g' ${APACHE_CONFDIR}/sites-available/000-default.conf \
    && sed -i 's/DocumentRoot.*/DocumentRoot ${APACHE_RUN_DOCROOT}/g' ${APACHE_CONFDIR}/sites-available/default-ssl.conf \
# mitigate "Could not reliably determine the server's fully qualified domain name" \
    && { \
      echo 'ServerName localhost'; \
    } | tee "/etc/apache2/conf-available/servername.conf" \
    && a2enconf servername \
# php settings
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && sed -i s/';phar.readonly = On'/'phar.readonly = Off'/ $PHP_INI_DIR/php.ini \
    && sed -i s/'memory_limit = 128M'/'memory_limit = 2G'/ $PHP_INI_DIR/php.ini \
    && sed -i s/'max_execution_time = 30'/'max_execution_time = 240'/ $PHP_INI_DIR/php.ini \
    && sed -i s/';max_input_vars = 1000'/'max_input_vars = 1500'/ $PHP_INI_DIR/php.ini \
    && echo "xdebug.max_nesting_level = 400" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && echo "apc.enable_cli=1" >> $PHP_INI_DIR/conf.d/docker-php-ext-apcu.ini \
    && echo "apc.slam_defense=0" >> $PHP_INI_DIR/conf.d/docker-php-ext-apcu.ini \
# install some locales - Uncomment en_US.UTF-8 for inclusion in generation
    && sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
    && sed -i 's/^# *\(de_DE.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen \
# apt cleanup
    && rm -rf /var/lib/apt/lists/*

# set multiple env variables in one layer
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8