FROM php:7.4-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring zip gd

# Install Xdebug
RUN pecl install xdebug-3.1.6 \
    && docker-php-ext-enable xdebug

COPY php/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

COPY . .

SHELL ["/bin/bash", "-lc"]

RUN echo "alias ll='ls -l --color=auto'" >> /root/.bashrc

# Expose port 80
EXPOSE 80

# Instructions:
# 1. Place your Yii2 plugin/app files in the container (e.g., via COPY or bind mount).
# 2. Use Composer to install dependencies: `composer install`
# 3. Access the app via http://localhost:80
