<VirtualHost *:{{HTTP_PORT}}>
    ServerName localhost
    
    # Domainmod
    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    
</VirtualHost>

ServerName localhost