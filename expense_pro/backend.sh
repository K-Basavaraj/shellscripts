#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/expense-pro/"
mkdir -p $LOGS_FOLDER

SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

USER_ID=$(id -u)

CHECK_ROOT() {
    if [ $USER_ID -ne 0 ]; then
        echo -e "$R please Run the Script with Root priviliges..$N" | tee -a $LOG_FILE
        exit
    fi
}
CHECK_ROOT
echo -e "$G Script started executing at:$N $Y $(date)$N" | tee -a $LOG_FILE

versions() {
    if [ $? -ne 0 ]; then
        echo -e "Name\tStream" && dnf module list nodejs | awk '/^nodejs/ {printf "%-10s %-8s\n", $1, $2}'
        echo "Enter only availible version you want to disable: "
        read version
        dnf module disable nodejs:$version -y &>>$LOG_FILE
    fi
}

dnf module list nodejs &>>$LOG_FILE
versions $? "disabled nodejs:$version"




versions() {
    if [ $? -ne 0 ]; then
        echo -e "Name\tStream" && dnf module list nodejs | awk '/^nodejs/ {printf "%-10s %-8s\n", $1, $2}'
        echo "Enter only available version you want to disable: "
        read version
        dnf module disable nodejs:$version -y &>>$LOG_FILE
        if [ $? -eq 0 ]; then
            echo "Successfully disabled nodejs:$version" >>$LOG_FILE
            validate $? "disabled nodejs:$version"
        else
            echo "Failed to disable nodejs:$version" >>$LOG_FILE
            validate $? "failed to disable nodejs:$version"
        fi
    fi
}

dnf module list nodejs &>>$LOG_FILE
versions $? 

# dnf module disable nodejs -y &>>$LOG_FILE
# validate $? "disabled defult nodejs"

# dnf module enable nodejs:20 -y &>>$LOG_FILE
# validate $? "enabled nodejs:20"

# dnf install nodejs -y &>> $LOG_FILE
# validate $? "insatllation nodejs"
