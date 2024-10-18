#!/bin/bash

# Create a file structure /var/log/shell-script/installredirecttologs-<timestamp>.log

LOGS_FOLDER="/var/log/shell-script/" #folder path shell-script created  in  /var/log

SCRIPT_NAME=$(echo $0 | cut -d "." -f1) #created scriptname with removing .sh here $0 redirctors which will give script name.

TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S) # creating time stamp

LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log" #here creating strutured logfile

mkdir -p $LOGS_FOLDER #we dont have shell-script folder so for that we are creating

USER_ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

CHECK_ROOT() {
    if [ $USER_ID -ne 0 ]; then
        # here tee command will append the result in logfile before | (pipe) it will print on the terminal also
        #if your using tee command the no need of &>>
        echo -e "$R please run the script with root privilages $N" | tee -a $LOG_FILE 
        exit 1
    fi
}

validate() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 is $R not success.. Check it.$N" | tee -a $LOG_FILE
    else
        echo -e "$2 is $G Sucessfull...$N"  | tee -a $LOG_FILE
    fi
}

usage() {
    echo -e "$R USAGE:: $N sudo sh 16-redirectors.sh package1 package2 ..."
    exit 1
}

echo "Script started executing at: $(date)" | tee -a $LOG_FILE
CHECK_ROOT
if [ $# -eq 0 ]; then #here$# count the arguments if 0
    usage
fi

for package in $@; do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]; then
        echo -e "$R $package is not installed..$N  $Y going to install it..$N" | tee -a $LOG_FILE
        dnf install $package -y &>>$LOG_FILE
        validate $? "Installing $package"
    else
        echo -e "$G $package is already$N $Y installed nothing to do..$N" | tee -a $LOG_FILE
    fi
done
