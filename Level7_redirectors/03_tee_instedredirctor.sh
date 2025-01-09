#!/bin/bash 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#tee command is used when you want to save the logs output in a file and display important messages/logs on the terminal.  
LOGS_FOLDER="/var/log/shell-script/" 

mkdir -p $LOGS_FOLDER

SCRIPT_NAME=$(echo $0 | cut -d "." -f1)

TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

echo -e "$R Script started executing at:$N $(date)" | tee -a $LOG_FILE # Displays the script start time both on the terminal and in the log file.

echo -e "$Y Its done.. Check in the log file $N"  | tee -a $LOG_FILE # Outputs the message to both the terminal and the log file to indicate completion.

echo -e "The Ip is: $G 18.9.19.76 $N"  &>> $LOG_FILE ## Logs the IP to the log file only. The `&>>` ensures this line does not display on the terminal.

echo -e "$G Your Ip has recived Thank you..! $N"  | tee -a $LOG_FILE ## Outputs a confirmation message to both the terminal and the log file.

: '
Explanation of Output Differences:
1. IP (`18.9.19.76`) is logged to the file but **not displayed on the terminal**, using `&>>`.
2. Messages like "Script started executing" and "Your IP has been received" are displayed on both the terminal and the 
log file using `tee -a`.

Example Output:
Terminal:
 sudo sh 03_tee_instedredirctor.sh
 Script started executing at: Thu Jan  9 06:33:53 UTC 2025
 Its done.. Check in the log file
 Your IP has been received. Thank you..!

Log File (`/var/log/shell-script/03_tee_instedredirctor-2025-01-09-06-33-53.log`):
 Script started executing at: Thu Jan  9 06:33:53 UTC 2025
 Its done.. Check in the log file
 The IP is:  18.9.19.76
 Your IP has been received. Thank you..!
'