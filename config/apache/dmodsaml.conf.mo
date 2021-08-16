<VirtualHost *:{{HTTP_PORT}}>
    ServerName localhost
    
    # Domainmod
    DocumentRoot /var/www/html
    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    # SimpleSAMLPHP
    Alias /simplesaml /var/www/simplesamlphp/www
    <Directory /var/www/simplesamlphp>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    <Directory /var/www/simplesamlphp/www>
        <IfModule !mod_authz_core.c>
        Require all granted
        </IfModule>
    </Directory>
</VirtualHost>

ServerName localhost