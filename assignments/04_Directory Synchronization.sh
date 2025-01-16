#!/bin/bash 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

: '
Write a script that synchronizes two directories, ensuring that any new or updated files in the source directory are copied to the
destination directory. Include error handling for cases where files are locked or cannot be copied.
'

# Function to check if the directory exists
directory() {
    if [ ! -d "$1" ]; then
        echo -e "$R $1 Does not Exist $N"
        exit 1
    fi
}

read -p "Enter the source directory: " SOURCE_DIR
read -p "Enter the destination directory: " DEST_DIR

directory "$SOURCE_DIR"
directory "$DEST_DIR"

# Loop through all files in the source directory
for file in "$SOURCE_DIR"/*; do
    # Check if it's a file (ignoring subdirectories or special files)
    if [ -f "$file" ]; then
        # Construct the destination file path
        DEST_FILE="$DEST_DIR/$(basename "$file")"

        # Check if the file is new or updated
        if [ ! -f "$DEST_FILE" ] || [ "$file" -nt "$DEST_FILE" ]; then
            # Copy the file to the destination directory
            cp -u "$file" "$DEST_FILE" 2>/dev/null
            
            # Error handling for the cp command
            if [ $? -eq 0 ]; then
                echo -e "${G}Successfully copied $file to $DEST_DIR.${N}"
            else
                echo -e "${R}Failed to copy $file. The file may be locked or inaccessible.${N}"
            fi
        else
            # Message for up-to-date files
            echo -e "${Y}$file is already up-to-date in $DEST_DIR.${N}"
        fi
    fi
done


# Added: Final message for synchronization
echo -e "${Y}Directory synchronization complete.${N}"