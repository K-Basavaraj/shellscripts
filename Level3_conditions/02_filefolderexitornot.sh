#!/bin/bash

# Get User Input: Source directory, Destination directory
DIRECTORY=$1
FILE=$2

#2)Validate Input: if the argument is less than 2 it will exit with usage message function.
#if you give include 2 and above 3 Not an issue. $# is How many variables/args passed to the script:
if [ $# -lt 2 ]; then
    exit 1
fi

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
