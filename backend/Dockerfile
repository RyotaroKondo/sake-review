FROM php:latest
EXPOSE 8000
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer 
WORKDIR /root/sake-review
CMD [ "php", "artisan", "serve", "--host=0.0.0.0" ]


    