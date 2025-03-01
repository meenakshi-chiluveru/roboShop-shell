source common.sh
component=frontend
app_path=/usr/share/nginx/html

print disable nodejs default version
dnf module disable nginx -y &>>log_file
STAR $?

print enable node js new version
dnf module enable nginx:1.24 -y &>>log_file
STAR $?

print install ngix
dnf install nginx -y &>>log_file
STAR $?

print copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf &>>log_file
STAR $?



print enable nginx
systemctl enable nginx &>>log_file
STAR $?

print restrat nginx
systemctl restart nginx &>>log_file
STAR $?