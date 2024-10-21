#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
read -p "enter the threshold value to check health: " DISK_THRESHOLD

   while IFS= read -r file; do
        echo $line
        done <<<$DISK_USAGE

        # USAGE=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
        #     rm -rf $file