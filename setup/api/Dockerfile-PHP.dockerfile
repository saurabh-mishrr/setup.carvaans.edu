FROM php:7.2-fpm
WORKDIR /app
ARG carvaans_edu_dir
RUN apt-get update && apt-get install -y git-all vim \
            libzip-dev \
            zip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip

VOLUME [ "/app", "/root/.ssh"]
# https://gist.github.com/chronon/95911d21928cff786e306c23e7d1d3f3
# Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/bin \
    --filename=composer
    
EXPOSE 9000