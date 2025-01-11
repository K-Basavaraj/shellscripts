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

dnf module disable nodejs -y &>> $LOG_FILE
VALIDATE $? "Disable defult nodesjs" 


dnf module enable nodejs -y &>> $LOG_FILE
VALIDATE $? "Enabled nodejs:22" 

dnf install nodejs -y &>> $LOG_FILE
VALIDATE $? "installing nodejs" 

useradd expense 
VALIDATE $? "creating expense user"