FROM php:7.2-fpm
WORKDIR /app
ARG PROJECT_DIR
RUN apt-get update && apt-get install -y vim \
            libzip-dev \
            zip \
            unzip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip

RUN pecl install -o -f redis \
  &&  rm -rf /tmp/pear \
  &&  docker-php-ext-enable redis


VOLUME [ "/app", "/root/.ssh"]

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/bin \
    --filename=composer

EXPOSE 9000
