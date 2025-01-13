#!/bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

# Get User Input: Source directory, Destination directory, Number of days (optional)
SOURCE_DIR=$1
DESTINATION_DIR=$2
NUM_OF_DAYS=${3:-14} #if $3 is empty then by defult it will take 14.
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

#1)#check the source and destination are provided if they are not providing, show them usage and exit If no parameters are provided, display usage instructions and exit the script.
USAGE() {
    echo -e "$R USAGE:: $N sh backup.sh <source> <destination> <days(optional)>"
}
#2)Validate Input: if the argument is less than 2 it will exit with usage message function. if you give include 2 and above 3 Not an issue.
if [ $# -lt 2 ]; then
    USAGE
    exit 1
fi

#1) Check if the source directory  and  destination directory exists:, If it doesn’t exist, exit the script with an error message.
: '
example: ! -d $SOURCE_DIR
case 1:
:  Directory Exists (e.g., you have a folder named test):
SOURCE_DIR is test.
if [ ! -d test ] evaluates to false (because test exists). ! it will make it as false 
Result: The code inside the then block does not run. Nothing is printed.

case2: 
Directory Does Not Exist (e.g., you specify nonexistent_folder):
SOURCE_DIR is nonexistent_folder.
if [ ! -d nonexistent_folder ] evaluates to true (because it doesnt exist).
Result: The code inside the then block runs. It prints the message saying the directory does not exist.
'
if [ ! -d $SOURCE_DIR]; then
    echo "$SOURCE_DIR does not exist...Please check"
fi

if [ ! -d $DESTINATION_DIR]; then
    echo "$DESTINATION_DIR does not exist...Please check"
fi

#if directory exist, find the files more than 14 days,
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$NUM_OF_DAYS)
echo "Files: $FILES"

if [ ! -z $FILES ]; then #true if Files is empty, ! makes it false
    echo "Files are found"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find ${SOURCE_DIR} -name "*.log" -mtime +$DAYS | zip "$ZIP_FILE" -@

    #check if zip file is successfully created or not
    if [ -f $ZIP_FILE ]; then
        echo "Successfully zippped files older than $DAYS"
        #remove the files after zipping
        while IFS= read -r file; do #IFS,internal field seperatpor, empty it will ignore while space.-r is for not to ingore special charecters like /
            echo "Deleting file: $file"
            rm -rf $file
        done <<<$FILES
    else
        echo "Zipping the files is failed"
        exit 1
    fi
else
    echo "No files older than $NUM_OF_DAYS"
fi
