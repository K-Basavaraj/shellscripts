#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# Create a file structure /var/log/shell-script/installredirecttologs-<timestamp>.log
LOG_FOLDER="/var/log/expense-pro"
mkdir -p $LOG_FOLDER

SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

#Root user permission
USER_ID=$(id -u)
CHECK_ROOT() {
    if [ $USER_ID -ne 0 ]; then
        echo -e "$R PLEASE RUN THE SCRIPT WITH ROOT PRIVIEGES..$N $Y eg: sudo <script_name>$N" | tee -a $LOG_FILE
        exit 1
    fi
}

echo -e "$Y script started executing at:$N $G $(date)$N" | tee -a $LOG_FILE

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$R $2 is FAILLED.. PLEASE CHECKIT..$N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$G $2 is SUCESSFULL...$N" | tee -a $LOG_FILE
    fi
}

dnf module disable nodejs -y &>>$LOG_FILE
VALIDATE $? "Disable defult nodesjs"

dnf module enable nodejs:22 -y &>>$LOG_FILE
VALIDATE $? "Enabled nodejs:22"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "installing nodejs"

id expense &>>$LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$R expense user not exit.. $Y CREATING $N" | tee -a $LOG_FILE
    useradd expense
    VALIDATE $? "creating expense user"
else
    echo -e "$R user expense already exist$N $Y..SKIPPING..$N" | tee -a $LOG_FILE
fi

mkdir -p /app 
VALIDATE $? "creating /app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG_FILE
VALIDATE $? "Downloading backend application code"

cd /app
rm -rf /app/* # remove the existing code
unzip /tmp/backend.zip &>>$LOG_FILE
VALIDATE $? "Extracting backend application code"

# For AWS Tier-2 instances:
# 1. `dnf install npm -y`: Installs the npm tool globally on the system and sets up its configurations. 
#    This is required for systems where npm isn't preinstalled or is improperly configured.
# 2. `npm install`: Installs project-specific dependencies listed in package.json in the current directory.
#    Requires npm to be globally installed first.
dnf install npm -y  &>>$LOG_FILE
VALIDATE $? "npm installation"

npm install  &>>$LOG_FILE