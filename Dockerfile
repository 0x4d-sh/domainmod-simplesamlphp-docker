FROM php:7.4-apache

COPY test/ /var/www/html

EXPOSE 8080