#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

: '
Display top 5 frequntly repeated words
Write a script that reads a text file and counts the occurrences of each word, display the top 5 most frequent 
words along with their counts.
'

# which directory
SOURCE_DIR=/home/ec2-user/applog

# is that directory exists?
if [ -d $SOURCE_DIR ]; then
    echo -e "$SOURCE_DIR $G Exist $N"
else
    echo -e "$SOURCE_DIR $R Does not Exist $N"
    exit 1
fi

# find the files
FILES=$(find "$SOURCE_DIR" -name "*.txt")
echo "Files: $FILES"

# Loop through each file found
for file in $FILES; do

tr -c '[:alnum:]' '[\n*]' < "$file" | tr '[:upper:]' '[:lower:]' 

done

#   # Process the file and get the top 5 most frequent words
# # tr -c '[:alnum:]' '[\n*]' < "$FILES" |   # Replace non-alphanumeric characters with newlines
# # tr '[:upper:]' '[:lower:]' |                # Convert to lowercase
# # grep -v '^$' |                               # Remove empty lines
# # sort |                                       # Sort words
# uniq -c |                                    # Count occurrences
# sort -nr |                                   # Sort numerically in reverse
# head -n 5                                    # Display top 5
# done
