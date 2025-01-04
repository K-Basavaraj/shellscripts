#!/bin/bash

# Get User Input: Source directory, Destination directory
DIRECTORY=$1
FILE=$2

# A usage function in a shell script provides instructions on the script's purpose, required arguments, and optional flags,
#ensuring correct input and to display proper usage instructions. 
USAGE() {
    echo -e "USAGE:: sh <directory > <file> <(optional)>"
}

#2)Validate Input: if the argument is less than 2 it will exit with usage message function.
#if you give include 2 and above 3 Not an issue. $# is How many variables/args passed to the script:
if [ $# -lt 2 ]; then
    USAGE
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
