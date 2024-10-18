#!/bin/bash

ensure_directory() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        echo "Directory created: '$dir'"
    else
        echo "Directory already exists: '$dir'"
    fi
}

backup_directory() {
    # Ensure source directory exists
    ensure_directory "$source"

    # Ensure destination directory exists
    ensure_directory "$destination"

    # Perform the backup
    cp -r "$source/" "$destination"  # Copy contents of source to destination
    echo "Backup of '$source' completed to '$destination'."
}

read -p "Enter the source directory to backup: " source
read -p "Enter the destination directory: " destination

backup_directory
