#!/bin/bash
set -eux

apt-get update -y
apt-get install -y apache2 docker.io git curl unzip openssl

systemctl enable apache2
systemctl start apache2

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

mkdir -p /var/www/www

cat > /var/www/www/index.html <<HTML
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ARM projekat</title>
</head>
<body>
    <h1>ARM projekat - AWS web instanca radi</h1>
    <p>Domena: ${domain_name}</p>
    <p>Ovo je privremena stranica. Kasnije ovdje ide aplikacija iz Web tehnologija.</p>
</body>
</html>
HTML

cat > /etc/apache2/sites-available/www.conf <<CONF
<VirtualHost *:80>
    ServerName ${domain_name}
    ServerAlias www.${domain_name}

    DocumentRoot /var/www/www

    <Directory /var/www/www>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \$${APACHE_LOG_DIR}/arm_error.log
    CustomLog \$${APACHE_LOG_DIR}/arm_access.log combined
</VirtualHost>
CONF

a2dissite 000-default.conf || true
a2ensite www.conf
a2enmod rewrite
a2enmod headers
a2enmod ssl
a2enmod proxy
a2enmod proxy_http

systemctl reload apache2