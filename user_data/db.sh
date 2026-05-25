#!/bin/bash
set -eux

export DEBIAN_FRONTEND=noninteractive

# Force IPv4 because some EC2 boots try IPv6 first and fail.
cat >/etc/apt/apt.conf.d/99force-ipv4 <<EOF
Acquire::ForceIPv4 "true";
EOF

for i in {1..10}; do
  apt-get update -y && break
  sleep 15
done

for i in {1..10}; do
  apt-get install -y docker.io curl && break
  sleep 15
done

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

for i in {1..20}; do
  docker pull mysql:8.0 && break
  sleep 20
done

docker rm -f arm-db || true

docker run -d \
  --name arm-db \
  --restart unless-stopped \
  -e MYSQL_DATABASE="${db_name}" \
  -e MYSQL_USER="${db_user}" \
  -e MYSQL_PASSWORD="${db_password}" \
  -e MYSQL_ROOT_PASSWORD="${db_root_password}" \
  -p ${db_port}:3306 \
  mysql:8.0

for i in {1..60}; do
  docker exec arm-db mysqladmin ping -h 127.0.0.1 -u"${db_user}" -p"${db_password}" --silent && exit 0
  sleep 5
done

docker logs arm-db
exit 1