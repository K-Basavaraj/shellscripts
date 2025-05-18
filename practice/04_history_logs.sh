#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#create logfile to store the output in the /var/log/folder_name/script_name-timestamp.log

#create log folder called schell script name in the log path
LOG_FOLDER="/var/log/shell_scripts"
mkdir -p $LOG_FOLDER

#create which your curremt running script name
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)

#create time stamp
TIMESTAMP=$(data +%Y-%m-%d-%H-%M-%S)

#Now we need log file in the given formate by using above varaibles
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

USER_ID=$(id -u)

CHECK_ROOT() {
    if [ $USER_ID -ne 0 ]; then
        echo -e "$R pease run the script with root privilege..$N" | tee -a $LOG_FILE
        exit 1
    fi
}

USAGE() {
    echo -e "$R usage:: run the script with arguments package1 package2.. to insatll it $N" | tee -a $LOG_FILE
    exit
}
if [ $# -eq 0 ]; then
    USAGE
fi

echo -e "$Y script started executing at $N: $G $(data)$N" | tee -a $LOG_FILE

vALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$Y $2 $N $R is FAILED..PLEASE CHECK.." | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$Y $2 $N $R IS SUCESSFULL.." | tee -a $LOG_FILE
    fi
}

for package in $@; do
    dnf list installed $package &>> $LOG_FILE
    if [ $? -ne 0 ]; then
        echo -e "$R $package is not installed..going to install it..$N" | tee -a $LOG_FILE
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "$package"
    else
        echo -e "$Y $package $N $G is already installed nothing to do..$N" | tee -a $LOG_FILE
    fi
done
