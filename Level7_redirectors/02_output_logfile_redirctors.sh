#!/bin/bash 

# Create a file structure /var/log/shell-script/redirecttologs-<timestamp>.log

LOGS_FOLDER="/var/log/shell-script/" #folder path shell-script created  in  /var/log

mkdir -p $LOGS_FOLDER #we dont have shell-script folder so for that we are creating

SCRIPT_NAME=$(echo $0 | cut -d "." -f1 )

TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S) # creating time stamp

LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log" #here creating strutured logfile


echo "Hello How are you?" &>  $LOG_FILE
ls -l /home/ec2-user/ &>>  $LOG_FILE
echo "Script started executing at: $(date)" &>>  $LOG_FILE