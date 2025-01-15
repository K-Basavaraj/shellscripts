#!/bin/bash

# Define the directory and the strings to be replaced
DIR="/home/ec2-user/user_folder/"
search_string="Hyderabad"
replace_string="Banglore"


# Use find to get all text files in the directory
find "$DIR" -type f -name "*.txt" | while read file; do
    # Use sed to replace the old string with the new string in each file
    sed -i "s/$search_string/$replace_string/g" "$file"
    echo "Replaced '$search_string' with '$replace_string' in $file"
done

