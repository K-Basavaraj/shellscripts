#!/bin/bash 

echo "checking the server health"

#check cpu usage 
top -bn1 | grep "Cpu(s)" | awk '{print "used: " $2"%, Idle; " $8"%"}'

#check memory usage 
echo "Memory Usage: " 
free -h | awk 'NR==2{print "Used: "$3 ", Free: $4}'

#check disk usage 
echo "Disk usage:"
df -h --output=source,pcent | grep '^/dev/'