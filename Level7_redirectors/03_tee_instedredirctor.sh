#!/bin/bash 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#tee command is used when you want to save the logsoutput in a file and write imp messages logs on the terminal. 
LOGS_FOLDER="/var/log/shell-script/" 

mkdir -p $LOGS_FOLDER

SCRIPT_NAME=$(echo $0 | cut -d "." -f1)

TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

echo -e "$R Script started executing at:$N $(date)" | tee -a $LOG_FILE #this should be know to user as well in logfile we need in both case.

echo -e "$Y Its done.. Check in the log file $N"  | tee -a $LOG_FILE

echo -e "The Ip is: $G 18.9.19.76 $N"  &>> $LOG_FILE #If this ip should not dispalay on terminal only in logfile it should be saved.

echo -e "$G Your Ip has recived Thank you..! $N"  | tee -a $LOG_FILE #this is the message you can pint on both