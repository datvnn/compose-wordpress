ARG PHP_VER
FROM wordpress:php${PHP_VER}-apache

# Install ioncube + phpredis
ARG PHP_VER
RUN set -ex \
    && mkdir /tmp/ioncube_install \
    && cd /tmp/ioncube_install \
    && php_ext_dir="$(php -i | grep extension_dir | head -n1 | awk '{print $3}')" \
    && curl -fSL -o ioncube.tar.gz \
        "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz" \
    && tar zxf ioncube.tar.gz \
    && mv ./ioncube/ioncube_loader_lin_${PHP_VER}.so "${php_ext_dir}/" \
    && rm -rf /tmp/ioncube_install \
    && echo "zend_extension = $php_ext_dir/ioncube_loader_lin_${PHP_VER}.so" \
        > /usr/local/etc/php/conf.d/00-ioncube.ini \
    && pecl install redis && docker-php-ext-enable redis

