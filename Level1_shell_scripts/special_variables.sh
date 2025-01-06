#!/bin/bash

echo "all the variables passed to the script: $@"
echo "How many variables/args passed to the script: $#"

echo "your script name is: $0"

echo "you current working dirctory is: $PWD"

echo "Home directory of current user: $HOME"

echo "PID of script which is executing now: $$"

sleep 100 &
echo "PID of last background command: $!"