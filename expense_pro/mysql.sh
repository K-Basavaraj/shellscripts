#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# Create a file structure /var/log/shell-script/installredirecttologs-<timestamp>.log
LOGS_FOLDER="/var/log/expense-pro/"
mkdir -p $LOGS_FOLDER

SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

USER_ID=$(id -u)

CHECK_ROOT() {
    if [ $USER_ID -ne 0 ]; then
        echo -e "$R Please Run the script with root privileges..$N" &>>$LOG_FILE
        exit 1
    fi
}

CHECK_ROOT
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

list() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 $R is not installed..$N $Y going to installe it.. $N" | tee -a $LOG_FILE
    else
        echo -e "$2 $G is already installed..nothing to do.. $N" | tee -a $LOG_FILE
    fi
}

validate() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 $R is FAILED.. PLEASE CHECKIT..$N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 $G is SUCESSFULL..$N" | tee -a $LOG_FILE
    fi
}

dnf list installed mysql-server &>>$LOG_FILE
list $? "mysql-server"

dnf install mysql-server -y &>>$LOG_FILE
validate $? "Installing mysql server.."

systemctl enable mysqld &>>$LOG_FILE
validate $? "enables mysql server.."

systemctl start mysqld &>>$LOG_FILE
validate $? "started mysql server.."

mysql -h mysql.basavadevops81s.online -u root -pExpenseApp@1 -e 'show databases;' &>>$LOG_FILE #command to connect mysql server 
if [ $? -ne 0 ]; then
    echo -e "$Y MYSQL root password is not setup, setting now $N" &>>$LOG_FILE
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG_FILE  # default root password in order to start using the database service
    validate $? "setting up root password.."
else
    echo -e "$G MYSQL ROOT PASSWORD IS ALREADY SETUP..$Y SKIPPING $N" | tee -a $LOG_FILE
fi


