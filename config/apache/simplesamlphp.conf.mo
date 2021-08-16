<VirtualHost *:{{HTTP_PORT}}>
    ServerName localhost
    DocumentRoot /var/www/html
    Alias /simplesaml /var/www/simplesamlphp/www

   <Directory /var/www/simplesamlphp>
        RewriteEngine On
        RewriteBase /simplesamlphp/
    </Directory>

    <Directory /var/www/simplesamlphp/www>
        <IfModule !mod_authz_core.c>
        Require all granted
        </IfModule>
    </Directory>
</VirtualHost>

ServerName localhost
