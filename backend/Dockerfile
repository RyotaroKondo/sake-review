FROM php:latest
WORKDIR /root/sake-review
COPY ./src /root/sake-review
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y zip unzip && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer install
CMD [ "php", "artisan", "serve", "--host=0.0.0.0" ]