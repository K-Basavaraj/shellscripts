#!/bin/bash

# Prompt user for source and destination directories
read -p "Enter the source directory to back up: " source
read -p "Enter the destination directory: " destination

# Check if the source directory exists
if [[ -d "$source" ]]; then
    # Check if the destination directory exists, create it if it doesn't
    if [[ ! -d $destination ]]; then
        mkdir -p "$destination"
        echo "Destination directory created: '$destination'"
    fi
    # Perform the backup
    cp -r "$source" "$destination"
    echo "Backup of '$source' completed to '$destination'."
else
    echo "Source directory does not exist."
fi
