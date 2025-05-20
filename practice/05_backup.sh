#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

DIRCTORY() {
    if [ ! -d "$1" ]; then
        echo -e "$R $1 file Does not exit which you given in the promt please check$N"
        exit 1
    fi
}

# Prompt user for input
read -p "Enter the source directory: " SOURCE_DIR
read -p "Enter the destination directory: " DESTINATION_DIR
read -p "Enter number of days (default is 14): " NUM_OF_DAYS
# If user didn't provide days, use default
NUM_OF_DAYS=${NUM_OF_DAYS:-14}

DIRCTORY "$SOURCE_DIR"
DIRCTORY "$DESTINATION_DIR"

# Set variables
source_dir_name=$(basename "$SOURCE_DIR")
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
FILES=$(find "$SOURCE_DIR" -name "*.log" -mtime +$NUM_OF_DAYS)
echo -e "$Y Files $N: $F $FILES $N"

if [ ! -z "$FILES" ]; then
    echo "files are found"
    ZIP_FILE="${DESTINATION_DIR}/${source_dir_name}-${TIMESTAMP}.zip" #in this formate
    find $FILES | zip "$ZIP_FILE" -@
    if [ -f "$ZIP_FILE" ]; then
        echo -e "$G Successfully zipped files older than $NUM_OF_DAYS $N"
        # Delete the original files
        while IFS= read -r file; do
            echo "Deleting file: $file"
            rm -rf "$file"
        done <<<"$FILES"
    else
        echo "Zipping the files failed"
        exit 1
    fi
else
    echo "no files older than $NUM_OF_DAYS"
fi
