#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# Create a file structure /var/log/<folder_name>/<script_name>-<timestamp>.log
LOGS_FOLDER="/var/log/expense-pro/"
mkdir -p $LOGS_FOLDER

SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%s-%H-%M-%S)

LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

USER_ID=$(id -u)
CHECK_ROOT() {
    if [ $USER_ID -ne 0 ]; then
        echo -e "$R PLEASE RUN THE SCRIPT WITH ROOT PRIVILEGES..$N $Y USING sudo sh <SCRIPT NAME>$N" | tee -a $LOG_FILE
        exit 1
    fi
}

CHECK_ROOT
echo -e "$G script started executing at:$N $Y $(date)$N" | tee -a $LOG_FILE

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$R $2 is FAILED...PLEASE CHECK IT..$N" | tee -a $LOG_FILE
    else
        echo -e "$G $2 is SUCESSFULL..$N" | tee -a $LOG_FILE
    fi
}

dnf install nginx -y  &>> $LOG_FILE
VALIDATE $? "Install nginx"

systemctl enable nginx &>> $LOG_FILE
VALIDATE $? "enable nginx"

systemctl start nginx &>> $LOG_FILE
VALIDATE $? "nginx start"

rm -rf /usr/share/nginx/html/*
VALIDATE $? "removing defult website"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>> $LOG_FILE
VALIDATE $? "Downloding frontend code"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> $LOG_FILE
VALIDATE $? "Extract frontend code"

cp /home/ec2-user/practice/shellscripts/expense_pro/expense.conf /etc/nginx/default.d/expense.conf
VALIDATE $? "Copied expense conf"

systemctl restart nginx &>>$LOG_FILE
VALIDATE $? "Restarted Nginx"