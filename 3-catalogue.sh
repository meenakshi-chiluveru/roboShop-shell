#cp catalogue.service /etc/systemd/system/catalogue.service
#cp mongo.repo /etc/yum.repos.d/mongo.repo

source common.sh
component=catalogue
app_path=/app
nodejs

echo install mondb client
dnf install mongodb-mongosh -y
STAT $?

echo load master data
mongosh --host mongo.dev.daws80.online </app/db/master-data.js
STAT $?
