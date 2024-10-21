#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
read -p "enter the threshold value to check health: " DISK_THRESHOLD

while IFS= read -r line; do #used in shell scripts to read lines from a file or standard input.
    USAGE=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | grep xfs | awk -F " " '{print $NF}')
    if [ $USAGE -ge $DISK_THRESHOLD ]; then
        echo "$PARTITION is more than $DISK_THRESHOLD, current value: $USAGE. Please check"
    fi
done <<<$DISK_USAGE
