#!/bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

# Get User Input: Source directory, Destination directory, Number of days (optional)
SOURCE_DIR=$1
DES_DIR=$2
NUM_DAYS=${3:-14} # Defaults to 14 days if not specified

# Function to display usage instructions
USAGE() {
    echo -e "$R USAGE:: $N sh backup.sh <source> <destination> <days(optional)>"
}

# Validate Input, If less than 2 arguments are provided, show usage and exit
if [ $# -lt 2 ]; then #$# is a special var How many variables/args passed to the script
    USAGE
    exit 1
fi

#Check if the source directory  and  destination directory exists:, If it doesn’t exist, exit the script with an error message.
if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R $SOURCE_DIR: does not exist...Please check $N"
    exit 1
fi

if [ ! -d $DES_DIR ]; then
    echo -e "$R $DES_DIR: does not exist...Please check $N"
    exit 1
fi

# Find files in the source directory older than the specified number of days
FILES=$(find $SOURCE_DIR -name "*.log" -mtime $NUM_DAYS)
echo -e "$Y Files: $FILES $N" # Output the found files

# Check if any files were found
if [ ! -z "$FILES" ]; then # here -z bydefult its true if Files is empty, ! makes it false
    echo -e "$G Files are found $N" # Inform if no old files were found
else
    echo -e "$R No files older than $NUM_DAYS $N"
fi
