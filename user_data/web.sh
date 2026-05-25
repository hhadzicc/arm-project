#!/bin/bash
set -eux

export DEBIAN_FRONTEND=noninteractive

cat >/etc/apt/apt.conf.d/99force-ipv4 <<EOF
Acquire::ForceIPv4 "true";
EOF

for i in {1..10}; do
  apt-get update -y && break
  sleep 15
done

for i in {1..10}; do
  apt-get install -y apache2 docker.io git curl unzip openssl && break
  sleep 15
done

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
    <p>Ovo je privremena stranica. Deployment aplikacije ide preko GitHub runner-a ili rucno preko SSH-a.</p>
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

systemctl is-active --quiet apache2
systemctl is-active --quiet docker