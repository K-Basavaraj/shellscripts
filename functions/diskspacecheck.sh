#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

read -p "please enter the threshold value you want to check: " threshold
usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

check_disk_usage(){
  if [[ $usage > $threshold ]]; then
    echo -e "$R Warning $N : Disk usage is at $R ${usage}% $N which exceeds the threshold of $Y ${threshold}%.$N"
else
    echo -e "Disk usage is at $G ${usage}%, which is within the limit.$N"
fi
}

check_disk_usage $1 $2

: '
     sh diskspacecheck.sh
 please enter the threshold value you want to check: 20
 Warning  : Disk usage is at  30%  which exceeds the threshold of  20%.

    sh diskspacecheck.sh
 please enter the threshold value you want to check: 30
 Disk usage is at  30%, which is within the limit.

'