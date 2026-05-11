ARG WP_TAG
FROM wordpress:${WP_TAG}

RUN apt-get update && apt-get install -y \
    less \
    nano \
    unzip \
    mariadb-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN pecl install redis \
    && docker-php-ext-enable redis

RUN curl -fsSL \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    -o /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp
