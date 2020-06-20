FROM php:7.2-fpm
WORKDIR /app
VOLUME [ "/app"]
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-dev \
        libmcrypt-dev \
        openssl \
        vim \
        wget \
        unzip \
        curl
    
# https://gist.github.com/chronon/95911d21928cff786e306c23e7d1d3f3

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/bin \
    --filename=composer
EXPOSE 9000
# RUN composer create-project --prefer-dist laravel/laravel="7.*" .