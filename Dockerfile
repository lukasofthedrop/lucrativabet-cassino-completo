FROM composer:latest as build

# Set working directory
WORKDIR /app

# Copy composer files
COPY composer.json composer.lock ./

# Install dependencies
RUN composer install --no-dev --no-interaction --no-scripts --optimize-autoloader

# Copy application files
COPY . .

# Copy .env if exists
COPY .env.example .env

# Generate key
RUN php artisan key:generate

# Build assets
RUN npm install && npm run build

# Final stage
FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libcurl4-ssl-dev \
    pgsql \
    postgresql-client \
    nodejs \
    npm \
    curl \
    git \
    && docker-php-ext-install pdo_pgsql pgsql \
    && docker-php-ext-install pdo_mysql mysqli \
    && docker-php-ext-install curl \
    && docker-php-ext-install zip \
    && docker-php-ext-install intl \
    && docker-php-ext-install bcmath \
    && docker-php-ext-enable opcache

# Enable Apache modules
RUN a2enmod rewrite

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set working directory
WORKDIR /var/www/html

# Copy application from build stage
COPY --from=build /app .

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage \
    && chmod -R 775 /var/www/html/storage \
    && chown -R www-data:www-data /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/bootstrap/cache

# Configure Apache document root
RUN sed -i 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf

EXPOSE 8080

# Start script
CMD php artisan config:cache && php artisan route:cache && php artisan view:cache && php artisan migrate --force && apache2-foreground