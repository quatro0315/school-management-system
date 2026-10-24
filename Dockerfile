FROM php:8.3-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pdo_mysql mysqli gd \
    && rm -rf /var/lib/apt/lists/*
RUN a2enmod rewrite headers \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && (getent group 1000 || groupadd -g 1000 rendersecrets) \
    && usermod -aG 1000 www-data
COPY . /var/www/html/
RUN mkdir -p /var/www/html/images/users /var/www/html/uploads/instructors \
    && chown -R www-data:www-data /var/www/html/images/users /var/www/html/uploads
COPY render-php.ini /usr/local/etc/php/conf.d/render-custom.ini
EXPOSE 80
CMD ["apache2-foreground"]
