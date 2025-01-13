#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# Function to check if the directory exists
directory() {
    if [ ! -d "$1" ]; then
        echo -e "$R $1 Does not Exist $N"
        exit 1
    fi
}

# Prompt the user for source directory, destination directory, and number of days
read -p "Enter the source directory, destination directory, and number of days (default is 14): " SOURCE_DIR DESTINATION_DIR NUM_OF_DAYS

# Check if directories exist
directory "$SOURCE_DIR"
directory "$DESTINATION_DIR"

# Default value for NUM_OF_DAYS if left blank
NUM_OF_DAYS=${NUM_OF_DAYS:-14}

# Set variables
DIR_NAME=$(basename "$SOURCE_DIR")
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
FILES=$(find "$SOURCE_DIR" -name "*.log" -mtime +$NUM_OF_DAYS)
echo -e "$Y Files: $FILES $N"

if [ ! -z "$FILES" ]; then
    echo "files are found"
    ZIP_FILE="${DESTINATION_DIR}/${DIR_NAME}-${TIMESTAMP}.zip"
    # Zip the found files
    find $FILES | zip "$ZIP_FILE" -@
    # Check if the zip file was created successfully
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
    echo "no files olderthan $NUM_OF_DAYS"
fi