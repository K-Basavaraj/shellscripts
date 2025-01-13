#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

DISK_USAGE=$(df -hT | grep xfs)
read -p "enter the threshold value to check health: " DISK_THRESHOLD

while IFS= read -r line; do #used in shell scripts to read lines from a file or standard input.
    USAGE=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | grep xfs | awk -F " " '{print $NF}')
    if [ $USAGE -ge $DISK_THRESHOLD ]; then
        echo -e "$R $PARTITION is more than $DISK_THRESHOLD $N, $Y current value: $USAGE. Please check $N"
    fi
done <<<$DISK_USAGE
