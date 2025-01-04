#!/bin/bash

# Get User Input: Source directory, Destination directory
DIRECTORY=$1
FILE=$2

if [ -d $DIRECTORY ]; then
    echo -e "$DIRECTORY Exist.."
else
    echo -e "$DIRECTORY does not exist...Please check"
fi

if [ -f $FILE ]; then
    echo -e "$FILE Exist..."
else
    echo "$FILE does not exist...Please check"
fi

: '
output: 
sh 02_filefolderexitornot.sh /home/ec2-user/myfolder/ /home/ec2-user/myfolder/myfile.txt
/home/ec2-user/myfolder/ Exist..
/home/ec2-user/myfolder/myfile.txt Exist...
'