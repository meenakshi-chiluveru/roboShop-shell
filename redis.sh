dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y
dnf install redis -y
sed -i '/^bind/ s/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
sed -i '/protected-mode/ c protected-mode no/' /etc/redis/redis.conf
systemctl enable redis
systemctl restart redis