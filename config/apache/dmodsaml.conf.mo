<VirtualHost *:{{HTTP_PORT}}>
    ServerName localhost
    DocumentRoot /var/www

    <Directory />
            Options FollowSymLinks
            AllowOverride None
    </Directory>
    
    <Directory /var/www/>
            Options Indexes FollowSymLinks MultiViews
            AllowOverride None
            Order allow,deny
            allow from all
    </Directory>
</VirtualHost>

ServerName localhost
