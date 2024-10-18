#!/bin/bash

# Disk Space Checker
# Task: Create a script that checks disk usage and warns if it exceeds a certain percentage.

: '
# check_disk_usage
df / | grep / | awk '{ print $5 }' | sed 's/%//g'

df: This command displays the disk space usage of file systems. The output typically includes columns for filesystem,
 size, used space, available space, percentage used, and mount point.

| grep /: This part of the command uses a pipe (|) to take the output of the df command and filters it using grep.
 The grep / part means it will only show lines that contain a /, which usually corresponds to mounted filesystems 
 (excluding special filesystems like tmpfs).

| awk '{ print $5 }': This further processes the output. awk is a text processing tool that can manipulate columns of data.
 Here, { print $5 } means it will print the fifth column of the filtered output, which corresponds to the percentage of disk 
 space used.

| sed 's/%//g': Finally, this part uses sed, a stream editor, to remove the percentage sign (%) from the output, 
 #so you just get the numeric value.
'

usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
threshold=20

if [[ $usage > $threshold ]]; then
    echo "Warning: Disk usage is at ${usage}% which exceeds the threshold of ${threshold}%."
else
    echo "Disk usage is at ${usage}%, which is within the limit."
fi
