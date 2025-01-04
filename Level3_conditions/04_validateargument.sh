#!/bin/bash

DIRECTORY=$1   # Assigning the first command-line argument to DIRECTORY (directory path)
FILE=$2        # Assigning the second command-line argument to FILE (file path)

# Argument validation input if the argument is less than 2 it will exit with message. if you give include 2 and above 3 Not an issue.

if [ $# -lt 2 ]; then                             # $# is a special varible How many variables/args passed to the script
    echo "Error: You must provide both a directory and a file as arguments."
    echo "Usage: $0 <directory> <file>"           #$0 is a special varible it present your script name 
    exit 1
fi

if [ ! -d $DIRECTORY ]; then
   echo -e "$DIRECTORY does not exist...Please check"
else
   echo -e "$DIRECTORY Exist.."
fi

if [ ! -f $FILE ]; then
   echo "$FILE does not exist...Please check"
else
   echo -e "$FILE Exist..."
fi
