#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

# Create a file structure /var/log/shell-script/installredirecttologs-<timestamp>.log
LOGS_FOLDER="/var/log/shell-script/"
mkdir -p $LOGS_FOLDER
SCRIPT_NAME=$(echo $0 | cut -d "." -f1) 
# Extracts the script name before the first dot. For example, if the script is named 'installation_history_logs.sh', this will extract 'installation_history_logs'.
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

USER_ID=$(id -u)
CHECK_ROOT() {
    if [ $USER_ID -ne 0 ]; then
        echo -e "$R please run the script with root privilages.. $N" &>>$LOG_FILE
        exit 1
    fi
}
CHECK_ROOT

usage() {
    echo -e "$R USAGE:: $N sudo sh 07_installaion_history_logs.sh package1 package2 ..." | tee -a $LOG_FILE
    exit 1
}
if [ $# -eq 0 ]; then #here $# count the arguments example: GIt nginx etc..
    usage
fi

echo "Script started executing at: $(date)" | tee -a $LOG_FILE

validate_list() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 $R is not installed..$N $Y going to installe it.. $N" | tee -a $LOG_FILE
    else
        echo -e "$2 $G is already installed..nothing to do.. $N" | tee -a $LOG_FILE
    fi
}

installing() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 $R is FAILED...Please check it.. $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 $G is SUCESSFULY INSTALLED.. $N" | tee -a $LOG_FILE
    fi
}

for package in $@; do
    dnf list installed $package &>>$LOG_FILE
    validate_list $? "$package"

    dnf install $package -y  &>>$LOG_FILE
    installing $? "$package"
done

: '
sudo sh 07_installation_history_logs.sh mysql nginx

outut: 
Script started executing at: Thu Jan  9 17:11:09 UTC 2025
mysql  is not installed..  going to installe it..
mysql  is SUCESSFULY INSTALLED..
nginx  is not installed..  going to installe it..
nginx  is SUCESSFULY INSTALLED..

logfiles:
/var/log/shell-script ]$ ls -l
total 12
-rw-r--r-- 1 root root 5115 Jan  9 17:11 07_installation_history_logs-2025-01-09-17-11-09.log
-rw-r--r-- 1 root root  429 Jan  9 17:11 07_installation_history_logs-2025-01-09-17-11-48.log
'
