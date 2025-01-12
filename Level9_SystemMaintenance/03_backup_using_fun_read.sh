#!/bin/bash
R="/e[31m"
G="/e[32m"
Y="/e[33m"
N="/e[0m"

# Function to check if the directory exists
directory() {
    if [ -d "$1" ]; then
        echo -e "$G $1  Exists $N"
    else
        echo -e "$R $1 Does not Exist $N"
        exit 1
    fi
}
# Prompt the user for source directory, destination directory, and number of days
read -p "Enter the source directory, destination directory, and number of days (default is 14): " SOURCE_DIR DESTINATION_DIR NUM_OF_DAYS

# Check if the source directory exists
directory "$SOURCE_DIR"

# Check if the destination directory exists
directory "$DESTINATION_DIR"

# Set default for NUM_OF_DAYS if left blank
NUM_OF_DAYS=${NUM_OF_DAYS:-14}

# Inform the user about the chosen value for number of days
echo "Number of days to consider: $NUM_OF_DAYS"

# Find files in the source directory older than the specified number of days
FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +$NUM_OF_DAYS)
echo -e "$Y Files: $FILES $N"

if [ ! -z $FILES ]; then
    echo "files are found"
else
    echo "no files olderthan $NUM_OF_DAYS"
fi
