#!/bin/bash
set -eux

apt-get update -y
apt-get install -y docker.io curl

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

docker pull mysql:8.0

docker run -d \
  --name arm-db \
  --restart unless-stopped \
  -e MYSQL_DATABASE="${db_name}" \
  -e MYSQL_USER="${db_user}" \
  -e MYSQL_PASSWORD="${db_password}" \
  -e MYSQL_ROOT_PASSWORD="${db_root_password}" \
  -p ${db_port}:3306 \
  mysql:8.0