FROM php:7.2-apache

RUN apt-get update && apt-get install -y nano libfreetype6-dev libjpeg62-turbo-dev libxml2-dev exim4 \
    libmcrypt-dev libyaml-dev libpq-dev git parallel zlib1g-dev \
    libssl-dev libpcre3 libpcre3-dev memcached \
    && docker-php-ext-install pdo pdo_pgsql opcache soap
RUN pecl install yaml-2.0.0 xdebug && docker-php-ext-enable yaml xdebug

RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo 'xdebug.remote_handler = "dbgp"' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart = 1" >>/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.default_enable = 1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host = "docker.for.mac.host.internal"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo 'xdebug.idekey="lkh"' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_log=/tmp/xdebug.txt" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN apt-get update && apt-get install -y libmemcached-dev zlib1g-dev \
    && pecl install memcached-3.0.4 \
    && docker-php-ext-enable memcached

RUN docker-php-ext-install -j$(nproc) iconv && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd

VOLUME /var/www/html

RUN a2enmod rewrite

COPY Docker-conf/run.sh /usr/bin/run.sh
RUN chmod 755 /usr/bin/run.sh

CMD ["/bin/bash", "-c", "/usr/bin/run.sh"]
