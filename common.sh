log_file=/tmp/robosp.log
rm -f $log_file

print(){
  echo &>>$log_file
  echo &>>$log_file
  echo " ############# $* #############" &>>$log_file
}

STAT(){
  if [ $1 -eq 0 ]; then
    echo -e "\e[32msuccess\e[0m"
  else
    echo -e "\e[31mfailure\e[0m"
    echo "refer the logfile for more info: file path: ${log_file}"
    exit $1
  fi
}
APP_PREREQ(){
  print remove old content
  rm -rf ${app_path} &>>log_file
  STAR $?

  print create app directory
  mkdir ${app_path} &>>log_file
  STAT $?

  print download application
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>log_file
  STAR $?

  print extract application content
  cd ${app_path}
  unzip /tmp/${component}.zip &>>log_file
  STAR $?
}
nodejs(){
  print disable nodejs default version
  dnf module disable nodejs -y &>>log_file
  STAT $?

 print enable nodejs
  dnf module enable nodejs:20 -y &>>$log_file
  STAT $?

  print install nodejs
  dnf install nodejs -y &>>$log_file
   STAT $?

  print add user
  id roboshop &>>$log_file
  if [ $? -ne 0 ]; then
    useradd roboshop &>>$log_file
  fi
  STAT $?

  print create directory
  mkdir /app &>>$log_file
  STAT $?

  print download catalogue application
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$log_file
  STAT $?

  print change directory
  cd /app &>>$log_file
  STAT $?

  print extract application
  unzip /tmp/${component}.zip &>>$log_file
  STAT $?

  print change directory
  cd /app &>>$log_file
  STAT $?

  print install node packages
  npm install &>>$log_file
  STAT $?

  print deamon reload
  systemctl daemon-reload &>>$log_file
  STAT $?

  print enable component
  systemctl enable ${component} &>>$log_file
  STAT $?

 print start component
  systemctl start ${component} &>>$log_file
  STAT $?
}